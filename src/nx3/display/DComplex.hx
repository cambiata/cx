package nx3.display;
import nx3.display.tools.SignsTools;
import nx3.types.TSigns;

/**
 * ...
 * @author 
 */
class DComplex
{

	public var dnotes(default, null):Array<DNote>;
	public var signs(default, null):TSigns;

	public function new(dnotes:Array<DNote>) 
	{
		this.dnotes = dnotes;
		this.signs = getSigns(dnotes);
	}
	
	function getSigns(dnotes:Array<DNote>) :TSigns
	{
		var signs:TSigns = new TSigns();
		for (dnote in dnotes)
		{
			for (head in dnote.heads)
			{
				signs.push( { sign:head.sign, level:head.level, position: 0 } );
			}		
		}
		
		return SignsTools.adjustPositions(signs);
	}
	
	
}