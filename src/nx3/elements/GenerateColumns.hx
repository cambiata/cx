package nx3.elements;


/**
 * ...
 * @author Jonas Nyström
 */
class GenerateColumns
{
	var dbar:DBar;
	var allotator:Allotator;
	
	public function new(dbar:DBar, allotator:Allotator=null) 
	{
		this.dbar = dbar;
		this.allotator = (allotator == null) new Allotator(EAllotment.Logaritmic): allotator;
	}
	
	public function execute():Array<DColumn>
	{
		return null;
	}
	
}