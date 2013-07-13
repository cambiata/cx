package cx3;

import haxe.Timer;
#if neko
	import neko.vm.Thread;
#end
/**
 * ...
 * @author Jonas Nyström
 */

class TimerTools 
{
	#if neko
	static private var timerThread:Thread;
	static private var stamp:Float = Timer.stamp();
	static public function timeout(cb:Void->Void, ms:Int = 500) {
		stamp = Timer.stamp();
		timerThread = neko.vm.Thread.create(function() {
		   neko.Sys.sleep(ms / 1000);
		   var age = (Timer.stamp() - stamp) * 1000;
		   trace(age);
		   if (age >= ms) {
			   cb();			   			   
		   }
	   });
	}	
	#else
	static private var _timer:Timer = null;
	static public function timeout(cb:Void->Void, ms:Int = 500) {		
		if (_timer != null) _timer.stop();		
		_timer = Timer.delay(cb, ms);
	}
	#end
}