package cx.nme.keyboard;

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
			addKey(String.fromCharCode(letter - 32), letter);
		}
		#else
		for (letter in 65...91)
		{
			addKey(String.fromCharCode(letter), letter);
		}
		#end
		
		//Numbers
		addKey("ZERO", 48);
		addKey("ONE", 49);
		addKey("TWO", 50);
		addKey("THREE", 51);
		addKey("FOUR", 52);
		addKey("FIVE", 53);
		addKey("SIX", 54);
		addKey("SEVEN", 55);
		addKey("EIGHT", 56);
		addKey("NINE", 57);
		
		addKey("PAGEUP", 33);
		addKey("PAGEDOWN", 34);
		addKey("HOME", 36);
		addKey("END", 35);
		addKey("INSERT", 45);
		
		//Special Keys + Punctuation
		addKey("ESCAPE", 27);
		addKey("MINUS", 189);
		addKey("PLUS", 187);
		addKey("DELETE", 46);
		addKey("BACKSPACE", 8);
		addKey("LBRACKET", 219);
		addKey("RBRACKET", 221);
		addKey("BACKSLASH", 220);
		addKey("CAPSLOCK", 20);
		addKey("SEMICOLON", 186);
		addKey("QUOTE", 222);
		addKey("ENTER", 13);
		addKey("SHIFT", 16);
		addKey("COMMA", 188);
		addKey("PERIOD", 190);
		addKey("SLASH", 191);
		addKey("CONTROL", 17);
		addKey("ALT", 18);
		addKey("SPACE", 32);
		addKey("UP", 38);
		addKey("DOWN", 40);
		addKey("LEFT", 37);
		addKey("RIGHT", 39);
		addKey("TAB", 9);
	}
	
	public function onKeyDown(freshEvent:KeyboardEvent):Void
	{
		var keyObject:Key = map[freshEvent.keyCode];
		if (keyObject == null)
		{
			return;
		}
		if (keyObject.current > 0)
		{
			keyObject.current = 1;
		} else {
			keyObject.current = 2;
		}
		Reflect.setField(this, keyObject.name, true);
	}
	
	public function onKeyUp(freshEvent:KeyboardEvent):Void
	{
		var keyObject:Key = map[freshEvent.keyCode];
		if (keyObject == null)
		{
			return;
		}
		if (keyObject.current > 0)
		{
			keyObject.current = -1;
		} else {
			keyObject.current = 0;
		}
		Reflect.setField(this, keyObject.name, false);
	}
}