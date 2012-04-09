package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class NmeTools {	
	static public function spriteToPngTest() {
		var sprite = new nme.display.Sprite();
		sprite.graphics.beginFill(0x0000FF);
		sprite.graphics.drawCircle(20, 10, 8);
		sprite.graphics.drawCircle(220, 210, 8);
		spriteToPng(sprite, 'nmeToolsTestSprite.png');		
	}
	
	static public function spriteToPng(source : nme.display.Sprite, pngFileName:String, ?width=0.0, ?height=0.0) {		
		if (width == 0) {
			width = source.width;
			height = source.height;
		}
		var bitmapData = new nme.display.BitmapData(Std.int(width), Std.int(height), false);
		bitmapData.draw(source);
		var byteArray = bitmapData.encode('png');
		FileTools.putContentBinary(pngFileName, byteArray.asString());
	}
}	

//-------------------------------------------------------------------------------------------------

class Input 
{
	private var _lookup:Hash<Int>;
	private var _map:Array<Key>;
	private var _total:Int;
	
	public function new() 
	{
		_total = 256;
		_lookup = new Hash<Int>();
		_map = new Array<Key>();
		for (i in 0..._total)
		{
			_map[i] = null;
		}
	}
	
	public function Update():Void
	{
		var i:Int = 0;
		while (i < _total)
		{
			var o:Key = _map[i];
			i++;
			if (o == null)
			{
				continue;
			}
			if ((o.Last == -1) && (o.Current == -1))
			{
				o.Current = 0;
			}
			else if ((o.Last == 2) && (o.Current == 2))
			{
				o.Current = 1;
			}
			o.Last = o.Current;
		}
	}
	
	public function Reset():Void
	{
		var i:Int = 0;
		while (i < _total)
		{
			var o:Key = _map[i];
			i++;
			if (o == null)
			{
				continue;
			}
			Reflect.setField(this, o.Name, false);
			o.Current = 0;
			o.Last = 0;
		}
	}
	
	public function Pressed(freshPressed:String):Bool
	{
		return Reflect.field(this, freshPressed);
	}
	
	public function JustPressed(freshPressed:String):Bool
	{
		return _map[_lookup.get(freshPressed)].Current == 2;
	}
	
	public function JustReleased(freshReleased:String):Bool
	{
		return _map[_lookup.get(freshReleased)].Current == -1;
	}
	
	public function GetKeyCode(freshName:String):Int
	{
		return _lookup.get(freshName);
	}
	
	public function Any():Bool
	{
		var i:Int = 0;
		while (i < _total)
		{
			var o:Key = _map[i];
			i++;
			if ((o != null) && (o.Current > 0))
			{
				return true;
			}
		}
		return false;
	}
	
	public function AddKey(freshName:String, freshCode:Int):Void
	{
		_lookup.set(freshName, freshCode);
		_map[freshCode] = new Key(freshName, 0, 0);
	}
	
	public function Destroy():Void
	{
		_lookup = null;
		_map = null;
	}
}
//------------------------------------------------------------------------------------------------
class Key 
{
	private var _keyName:String;
	private var _current:Int;
	private var _last:Int;
	
	public function new(freshName:String, freshCurrent:Int, freshLast:Int)
	{
		_keyName = freshName;
		_current = freshCurrent;
		_last = freshLast;
	}
	
	public var Name(getName, null):String;
	private function getName():String
	{
		return _keyName;
	}
	
	public var Current(getCurrent, setCurrent):Int;
	private function getCurrent():Int
	{
		return _current;
	}
	private function setCurrent(freshCurrent:Int):Int
	{
		_current = freshCurrent;
		return _current;
	}
	
	public var Last(getLast, setLast):Int;
	private function getLast():Int
	{
		return _last;
	}
	private function setLast(freshLast:Int):Int
	{
		_last = freshLast;
		return _last;
	}
}
	
//-------------------------------------------------------------------------------------------------

import nme.events.KeyboardEvent;

class Keyboard extends Input
{
	public var ESCAPE:Bool;
	public var ONE:Bool;
	public var TWO:Bool;
	public var THREE:Bool;
	public var FOUR:Bool;
	public var FIVE:Bool;
	public var SIX:Bool;
	public var SEVEN:Bool;
	public var EIGHT:Bool;
	public var NINE:Bool;
	public var ZERO:Bool;
	public var PAGEUP:Bool;
	public var PAGEDOWN:Bool;
	public var HOME:Bool;
	public var END:Bool;
	public var INSERT:Bool;
	public var MINUS:Bool;
	public var PLUS:Bool;
	public var DELETE:Bool;
	public var BACKSPACE:Bool;
	public var TAB:Bool;
	public var Q:Bool;
	public var W:Bool;
	public var E:Bool;
	public var R:Bool;
	public var T:Bool;
	public var Y:Bool;
	public var U:Bool;
	public var I:Bool;
	public var O:Bool;
	public var P:Bool;
	public var LBRACKET:Bool;
	public var RBRACKET:Bool;
	public var BACKSLASH:Bool;
	public var CAPSLOCK:Bool;
	public var A:Bool;
	public var S:Bool;
	public var D:Bool;
	public var F:Bool;
	public var G:Bool;
	public var H:Bool;
	public var J:Bool;
	public var K:Bool;
	public var L:Bool;
	public var SEMICOLON:Bool;
	public var QUOTE:Bool;
	public var ENTER:Bool;
	public var SHIFT:Bool;
	public var Z:Bool;
	public var X:Bool;
	public var C:Bool;
	public var V:Bool;
	public var B:Bool;
	public var N:Bool;
	public var M:Bool;
	public var COMMA:Bool;
	public var PERIOD:Bool;
	public var SLASH:Bool;
	public var CONTROL:Bool;
	public var ALT:Bool;
	public var SPACE:Bool;
	public var UP:Bool;
	public var DOWN:Bool;
	public var LEFT:Bool;
	public var RIGHT:Bool;
	
	public function new() 
	{
		super();
		//Letters
		#if cpp
		for (letter in 97...123)
		{
			AddKey(String.fromCharCode(letter - 32), letter);
		}
		#else
		for (letter in 65...91)
		{
			AddKey(String.fromCharCode(letter), letter);
		}
		#end
		
		//Numbers
		AddKey("ZERO", 48);
		AddKey("ONE", 49);
		AddKey("TWO", 50);
		AddKey("THREE", 51);
		AddKey("FOUR", 52);
		AddKey("FIVE", 53);
		AddKey("SIX", 54);
		AddKey("SEVEN", 55);
		AddKey("EIGHT", 56);
		AddKey("NINE", 57);
		
		AddKey("PAGEUP", 33);
		AddKey("PAGEDOWN", 34);
		AddKey("HOME", 36);
		AddKey("END", 35);
		AddKey("INSERT", 45);
		
		//Special Keys + Punctuation
		AddKey("ESCAPE", 27);
		AddKey("MINUS", 189);
		AddKey("PLUS", 187);
		AddKey("DELETE", 46);
		AddKey("BACKSPACE", 8);
		AddKey("LBRACKET", 219);
		AddKey("RBRACKET", 221);
		AddKey("BACKSLASH", 220);
		AddKey("CAPSLOCK", 20);
		AddKey("SEMICOLON", 186);
		AddKey("QUOTE", 222);
		AddKey("ENTER", 13);
		AddKey("SHIFT", 16);
		AddKey("COMMA", 188);
		AddKey("PERIOD", 190);
		AddKey("SLASH", 191);
		AddKey("CONTROL", 17);
		AddKey("ALT", 18);
		AddKey("SPACE", 32);
		AddKey("UP", 38);
		AddKey("DOWN", 40);
		AddKey("LEFT", 37);
		AddKey("RIGHT", 39);
		AddKey("TAB", 9);
	}
	
	public function HandleKeyDown(freshEvent:KeyboardEvent):Void
	{
		var keyObject:Key = _map[freshEvent.keyCode];
		if (keyObject == null)
		{
			return;
		}
		if (keyObject.Current > 0)
		{
			keyObject.Current = 1;
		} else {
			keyObject.Current = 2;
		}
		Reflect.setField(this, keyObject.Name, true);
	}
	
	public function HandleKeyUp(freshEvent:KeyboardEvent):Void
	{
		var keyObject:Key = _map[freshEvent.keyCode];
		if (keyObject == null)
		{
			return;
		}
		if (keyObject.Current > 0)
		{
			keyObject.Current = -1;
		} else {
			keyObject.Current = 0;
		}
		Reflect.setField(this, keyObject.Name, false);
	}
}