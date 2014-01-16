package nx3.test;
import nx3.elements.EDirectionUAD;
import nx3.elements.ENoteValue;
import nx3.elements.NHead;
import nx3.elements.NNote;
import nx3.elements.NVoice;
import nx3.test.QVoice.QVoiceDown;
import nx3.test.QVoice.QVoiceUp;
/**
 * ...
 * @author Jonas Nyström
 */
class ExVoices
{
	//static public var t
	//static public var v3eights = { new NVoice( [ for (i in 0...3) new NNote([new NHead(0)], ENoteValue.Nv8) ] ); };
	/*
	static public var v6eights = new NVoice( [ for (i in 0...6) new NNote([new NHead(0)], ENoteValue.Nv8) ] );
	static public var v12sixteenths = new NVoice( [ for (i in 0...12) new NNote([new NHead(0)], ENoteValue.Nv16) ] );	
	*/
	
	//static public function v3Eights() return new NVoice( [ for (i in 0...3) new NNote([new NHead(0)], ENoteValue.Nv8) ] );
	static public function v3Eights() return new QVoice(8, [0, 0, 0]);
	static public function v6Eights() return new QVoice(8, [0, 0, 0, 0, 0, 0]);
	static public function v6EightsUp() return new QVoiceUp(8, [0, 0, 0, 0, 0, 0]);
	static public function v6EightsDown() return new QVoiceDown(8, [0, 0, 0, 0, 0, 0]);
	static public function v12Sixteenths() return new QVoice(16, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
	
	
	
	static public function v488() return new NVoice([
		new QNote(),
	]);
	
	
}