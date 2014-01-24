package cx;


import tea.TEA;


/**
 * ...
 * 
 * @author Jonas Nyström
 */

using cx.StrTools;
class CryptTools 
{

	static public function crypt(str:String):String {		
		var key = Std.string(Math.random() % Date.now().getTime()).substr(2, 4);
		var keyLeft = StrTools.numToStr(key.substr(0, 2), 97);		
		var keyRight = StrTools.numToStr(key.substr(2, 2), 97);
		setTeaKey(Std.parseInt(key));
		return keyLeft + TEA.crypt(str) + keyRight; 
	}
	
	static public function decrypt(str:String):String {
		var keyLeft = StrTools.strToNum(str.substr(0, 2), 97);
		var keyRight = StrTools.strToNum(str.substr(str.length - 2, 2), 97);
		var key = keyLeft + keyRight;		
		var str = str.substr(2,  str.length - 4);
		setTeaKey(Std.parseInt(key));
		return TEA.uncrypt(str);
		
	}
	
	static private function setTeaKey(keyInt:Int) {
		TEA.key = [1, 2, 3, keyInt];
	}
	
}


/*
class TEA
{
    static public var base = haxe.io.Bytes.ofString("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ=.");
    //static public var key = [Int32.ofInt(1), Int32.ofInt(2), Int32.ofInt(3), Int32.ofInt(4)];
    static public var key = [1, 2, 3, 4]; // Int32.ofInt(2), Int32.ofInt(3), Int32.ofInt(4)];

    static private function encrypt (v:Array<Int32>, k:Array<Int>):Array<Int>
    {
        var v0 = v[0];
        var v1 = v[1];
        var sum:Int32 = Int32.ofInt(0);
        var delta:Int32 = Int32.ofInt(0x9e37).shl(16).add(Int32.ofInt(0x79b9));
        var k0 = k[0], k1 = k[1], k2 = k[2], k3 = k[3];
        for (i in 0...32)
        {
            sum = sum.add(delta);

            v0 = v0.add(((v1.shl(4)).add(k0)).xor(v1.add(sum)).xor((v1.shr(5)).add(k1)));
            v1 = v1.add(((v0.shl(4)).add(k2)).xor(v0.add(sum)).xor((v0.shr(5)).add(k3)));
        }
        v[0] = v0;
        v[1] = v1;

        return v;
    }

    static private function decrypt (v:Array<Int32>, k:Array<Int>):Array<Int>
    {
        var v0 = v[0];
        var v1 = v[1];

        var sum = Int32.ofInt(0xC6EF).shl(16).add(Int32.ofInt(0x3720));
		
        var delta:Int32 = Int32.ofInt(0x9e37).shl(16).add(Int32.ofInt(0x79b9));
        var k0 = k[0], k1 = k[1], k2 = k[2], k3 = k[3];

        for (i in 0...32)
        {
            v1 = v1.sub(((v0.shl(4)).add(k2)).xor(v0.add(sum)).xor((v0.shr(5)).add(k3)));
            v0 = v0.sub(((v1.shl(4)).add(k0)).xor(v1.add(sum)).xor((v1.shr(5)).add(k1)));
            sum = sum.sub(delta);
        }

        v[0]=v0;
        v[1]=v1;

        return v;
    }

    static public function crypt(str:String):String
    {
        var out:Array<Int32> = [];

        var index = 0;

        for (i in 0...Math.ceil(str.length / 4))
        {
            var c0 = getCharCode(str, index++);
            var c1 = getCharCode(str, index++);
            var c2 = getCharCode(str, index++);
            var c3 = getCharCode(str, index++);
            var c4 = getCharCode(str, index++);
            var c5 = getCharCode(str, index++);
            var c6 = getCharCode(str, index++);
            var c7 = getCharCode(str, index++);

            var b0 = Int32.ofInt(c0).add(Int32.ofInt(c1).shl(8)).add(Int32.ofInt(c2).shl(16)).add(Int32.ofInt(c3).shl(24));
            var b1 = Int32.ofInt(c4).add(Int32.ofInt(c5).shl(8)).add(Int32.ofInt(c6).shl(16)).add(Int32.ofInt(c7).shl(24));

            var o = encrypt([b0, b1], key);
            out.push(o[0]);
            out.push(o[1]);
        }

        var b = new haxe.io.BytesOutput();
        for (i in 0...out.length)
        {
            b.writeInt32(out[i]);
        }

        var baseCode = new haxe.BaseCode(base);

        return baseCode.encodeBytes(b.getBytes()).toString();
    }

    static public function getCharCode(str:String, index:Int)
    {
        if (str.length > index)
            return str.charCodeAt(index);

        return 0;
    }

    static public function uncrypt(str:String):String
    {
        var arr:Array<Int32> = [];

        var baseCode = new haxe.BaseCode(base);

        var bytes = baseCode.decodeBytes(haxe.io.Bytes.ofString(str));
        var b = new haxe.io.BytesInput(bytes);

        for (i in 0...Std.int(bytes.length / 4))
        {
            arr.push(b.readInt32());
        }

        var out = "";

        var mask = Int32.ofInt(0xFF);

        for (i in 0...Std.int(arr.length / 2))
        {
            var decrypted = decrypt([arr[i * 2], arr[i * 2 + 1]], key);
            out += String.fromCharCode(decrypted[0].and(mask).toInt());
            out += String.fromCharCode(decrypted[0].shr(8).and(mask).toInt());
            out += String.fromCharCode(decrypted[0].shr(16).and(mask).toInt());
            out += String.fromCharCode(decrypted[0].shr(24).and(mask).toInt());
            out += String.fromCharCode(decrypted[1].and(mask).toInt());
            out += String.fromCharCode(decrypted[1].shr(8).and(mask).toInt());
            out += String.fromCharCode(decrypted[1].shr(16).and(mask).toInt());
            out += String.fromCharCode(decrypted[1].shr(24).and(mask).toInt());
        }

        //Filter out trailing \0s
        var final = "";
        for (i in 0...out.length)
        {
            if (out.charCodeAt(i) == 0)
                return final;

            final += out.charAt(i);
        }

        return final;
    }

    //Usage exemple :
    static public function main()
    {
        //Change key to something you want to
        TEA.key = [Int32.ofInt(1), Int32.ofInt(2), Int32.ofInt(3), Int32.ofInt(4)];

        var toCrypt = "1234567890";

        //Crypt values
        var r = TEA.crypt(toCrypt);

        var base = TEA.uncrypt(r);

        if (base != toCrypt)
            throw "Not working !";

        trace("Crypted and decrypted "+toCrypt+" successfully.");
    }
}
*/
