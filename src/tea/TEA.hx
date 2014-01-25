package tea;

class TEA
{
    static public var base = haxe.io.Bytes.ofString("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ=.");
    static public var key = [1, 2, 3, 4];

    static public function encrypt(v:Array<Int>, k:Array<Int>):Array<Int>
    {
        var v0 = v[0];
        var v1 = v[1];
        var sum = 0;
        var delta = 0x9e3779b9;
        var k0 = k[0], k1 = k[1], k2 = k[2], k3 = k[3];

        for (i in 0...32)
        {
            sum += delta;

            v0 += ((v1<<4) + k0) ^ (v1 + sum) ^ ((v1>>5) + k1);
            v1 += ((v0<<4) + k2) ^ (v0 + sum) ^ ((v0>>5) + k3);
        }

        v[0] = v0;
        v[1] = v1;

        return v;
    }

    static public function decrypt(v:Array<Int>, k:Array<Int>):Array<Int>
    {
        var v0 = v[0];
        var v1 = v[1];

        var sum = 0xC6EF3720;
        var delta = 0x9e3779b9;

        var k0 = k[0], k1 = k[1], k2 = k[2], k3 = k[3];

        for (i in 0...32)
        {
            v1 -= ((v0<<4) + k2) ^ (v0 + sum) ^ ((v0>>5) + k3);
            v0 -= ((v1<<4) + k0) ^ (v1 + sum) ^ ((v1>>5) + k1);
            sum -= delta;
        }

        v[0] = v0;
        v[1] = v1;

        return v;
    }

    static public function crypt(str:String):String
    {
        var out:Array<Int> = [];

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

            var b0 = c0 + (c1 << 8) + (c2 << 16) + (c3 << 24);
            var b1 = c4 + (c5 << 8) + (c6 << 16) + (c7 << 24);

            var o = encrypt([b0, b1], key);
            out.push(o[0]);
            out.push(o[1]);
        }

        var b = new haxe.io.BytesOutput();
        for (i in 0...out.length)
        {
            b.writeInt32(out[i]);
        }

        var baseCode = new haxe.crypto.BaseCode(base);

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
        var arr:Array<Int> = [];

        var baseCode = new haxe.crypto.BaseCode(base);

        var bytes = baseCode.decodeBytes(haxe.io.Bytes.ofString(str));
        var b = new haxe.io.BytesInput(bytes);

        for (i in 0...Std.int(bytes.length / 4))
        {
            arr.push(b.readInt32());
        }

        var out = "";

        var mask = 0xFF;

        for (i in 0...Std.int(arr.length / 2))
        {
            var decrypted = decrypt([arr[i * 2], arr[i * 2 + 1]], key);
            out += String.fromCharCode(decrypted[0] & mask);
            out += String.fromCharCode((decrypted[0] >> 8) & mask);
            out += String.fromCharCode((decrypted[0] >> 16) & mask);
            out += String.fromCharCode((decrypted[0] >> 24) & mask);
            out += String.fromCharCode(decrypted[1] & mask);
            out += String.fromCharCode((decrypted[1] >> 8) & mask);
            out += String.fromCharCode((decrypted[1] >> 16) & mask);
            out += String.fromCharCode((decrypted[1] >> 24) & mask);
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
        TEA.key = [1, 2, 3, 4];

        var toCrypt = "1234567890";

        //Crypt values
        var r = TEA.crypt(toCrypt);

        var base = TEA.uncrypt(r);

        if (base != toCrypt)
            throw "Not working !";

        trace("Crypted and decrypted "+toCrypt+" successfully.");
    }
}
