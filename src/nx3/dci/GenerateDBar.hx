package nx3.dci;
import dci.Context;
import nx3.Constants;
import nx3.elements.EAllotment;
import nx3.elements.DBar;
import nx3.elements.DColumn;
import nx3.elements.NBar;

/**
 * ...
 * @author Jonas Nyström
 */
class GenerateDBar implements Context
{
	
	@role var bar = {
			var roleInterface:NBar;
			
			function generate():DBar
			{
				var dbar =  new DBar(self);
				
				new GenerateColumns(dbar).execute();
				return dbar;
			}
	}
	
	

	public function new(nbar:NBar) 
	{
		this.bar = nbar;
	}
	
	public function execute():DBar
	{
		return this.bar.generate();
	}
	
}



