package cx;
import haxe.Timer;

/**
 * ...
 * @author Jonas Nyström
 */

class TimerTools 
{

	static private var _timer:Timer = null;
	
	static public function timeout(cb:Void->Void, ms:Int = 500) {		
		if (_timer != null) _timer.stop();		
		_timer = Timer.delay(cb, ms);
	}

	
}