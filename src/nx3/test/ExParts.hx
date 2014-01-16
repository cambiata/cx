package nx3.test;
import nx3.elements.NPart;

/**
 * ...
 * @author Jonas Nyström
 */
class ExParts
{

	static public function pV6EigthsUpV6EightsDown() :NPart
	{
		return new NPart([ExVoices.v6EightsUp(), ExVoices.v6EightsDown()]);
	}
	
}