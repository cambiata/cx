package cx.nme.keyboard;

class Input 
{
	private var lookup:Hash<Int>;
	private var map:Array<Key>;
	private var total:Int;
	
	public function new() 
	{
		total = 256;
		lookup = new Hash<Int>();
		map = new Array<Key>();
		for (i in 0...total)
		{
			map[i] = null;
		}
	}
	
	public function update():Void
	{
		var i:Int = 0;
		while (i < total)
		{
			var o:Key = map[i];
			i++;
			if (o == null)
			{
				continue;
			}
			if ((o.last == -1) && (o.current == -1))
			{
				o.current = 0;
			}
			else if ((o.last == 2) && (o.current == 2))
			{
				o.current = 1;
			}
			o.last = o.current;
		}
	}
	
	public function reset():Void
	{
		var i:Int = 0;
		while (i < total)
		{
			var o:Key = map[i];
			i++;
			if (o == null)
			{
				continue;
			}
			Reflect.setField(this, o.name, false);
			o.current = 0;
			o.last = 0;
		}
	}
	
	public function pressed(freshPressed:String):Bool
	{
		return Reflect.field(this, freshPressed);
	}
	
	public function justPressed(freshPressed:String):Bool
	{
		return map[lookup.get(freshPressed)].current == 2;
	}
	
	public function justReleased(freshReleased:String):Bool
	{
		return map[lookup.get(freshReleased)].current == -1;
	}
	
	public function getKeyCode(freshName:String):Int
	{
		return lookup.get(freshName);
	}
	
	public function any():Bool
	{
		var i:Int = 0;
		while (i < total)
		{
			var o:Key = map[i];
			i++;
			if ((o != null) && (o.current > 0))
			{
				return true;
			}
		}
		return false;
	}
	
	public function addKey(freshName:String, freshCode:Int):Void
	{
		lookup.set(freshName, freshCode);
		map[freshCode] = new Key(freshName, 0, 0);
	}
	
	public function destroy():Void
	{
		lookup = null;
		map = null;
	}
}