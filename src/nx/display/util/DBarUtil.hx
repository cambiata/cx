package nx.display.util;
import nx.display.beam.BeamingProcessor_4;
import nx.display.beam.BeamingProcessor_4dot;
import nx.display.beam.IBeamingProcessor;
import nx.display.DBar;
import nx.enums.ETime;

/**
 * ...
 * @author Jonas Nyström
 */

class DBarUtil 
{

	static public var beamProcessor4:BProcessor;
	static public var beamProcessor4dot:BProcessor;

	static public function getDefaultBeamProcessor(dbar:DBar):BProcessor {
		var time:ETime = dbar.bar.time;
		
		if (time == null) {
			if (beamProcessor4 == null) beamProcessor4 = new BeamingProcessor_4();
			return beamProcessor4;
		}
		
		switch (time) {
			case ETime.Time12_8, ETime.Time9_8, ETime.Time6_8, ETime.Time3_8:
				if (beamProcessor4dot == null) beamProcessor4dot = new BeamingProcessor_4dot();
				return beamProcessor4dot;
			default :
				if (beamProcessor4 == null) beamProcessor4 = new BeamingProcessor_4();
				return beamProcessor4;
		}
		return beamProcessor4;
	}
	
}