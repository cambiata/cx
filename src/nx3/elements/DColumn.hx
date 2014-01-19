package nx3.elements;


/**
 * ...
 * @author 
 */
class DColumn
{
	
	public var position(default, default):			Int;
	
	public var distance(default, default):			Float;
	
	public var value(default, null): 					Int;
	public var allotedValue(default, default): 	Int;
	
	public var complexes(default, default): 		Array<DComplex>;
	
	public function new(value:Int)
	{
		this.value = value;
	}
}