package nx3.elements;

/**
 * ...
 * @author Jonas Nyström
 */

 class GenerateBeaming
{
	var dnotes:Array<DNote>;
	var pattern:Array<ENoteValue>;
	
	public function new(dnotes:Array<DNote>, pattern Array<ENoteValue>) 
	{
		this.dnotes = dnotes;
		this.pattern = pattern;
	}
	
	public function execute():Array<BItem>
	{
		return null;
	}
}