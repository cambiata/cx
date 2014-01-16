package nx3.elements;

/**
 * ...
 * @author Jonas Nyström
 */

class BProcessor_3Eights extends BProcessorBase implements BProcessor 
{	
	
	public function doBeaming(dVoice:DVoice, ?forceDirection:EDirectionUAD = null) 
	{
		this.beam(dVoice, this.valuePattern, forceDirection);		
	}

	public function new() 
	{
		this.valuePattern = [ENoteValue.Nv4dot];
	}
}