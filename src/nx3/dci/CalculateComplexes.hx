package nx3.dci;
import dci.Context;
import nx3.elements.DPart;
import nx3.elements.DVoice;

/**
 * ...
 * @author Jonas Nyström
 */
class CalculateComplexes implements Context
{
	
	// Create DComplexes
	// Calculate rectangles
	// Calculate distances
	
	
	public function execute()
	{
		this.part.createVoiceBeams();
	}
	
	@role var part = {
		var roleInterface: DPart;
		
		function createVoiceBeams()
		{
			for (dvoice in self.dvoices)
			{
				// new GenerateBeamGroups().execute();
			}
			
		}
		
	}
	
	@role var voices = {
		var roleInterface: Array<DVoice>;
	}
	
	public function new(dpart: DPart) 
	{
		this.part = dpart;
		this.voices = dpart.dvoices;
		
	}
	
}