package cx.nme.keyboard;

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
	
	public var name(getName, null):String;
	private function getName():String
	{
		return _keyName;
	}
	
	public var current(getCurrent, setCurrent):Int;
	private function getCurrent():Int
	{
		return _current;
	}
	private function setCurrent(freshCurrent:Int):Int
	{
		_current = freshCurrent;
		return _current;
	}
	
	public var last(getLast, setLast):Int;
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