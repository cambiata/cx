package cx;

import haxe.Timer;

/**
 * ...
 * @author Jonas Nyström
 */

class TimerTools 
{
	
	#if neko
	
	static private var timerThread:neko.vm.Thread;
	static private var stamp:Float = Timer.stamp();
	static public function timeout(func:Void->Void, milliSeconds:Int = 500) 
	{
		stamp = Timer.stamp();
		timerThread = neko.vm.Thread.create(function() 
		{
			Sys.sleep(milliSeconds / 1000);
			var age = (Timer.stamp() - stamp) * 1000;
			trace(age);
			if (age >= milliSeconds) 
			{
				func();			   			   
			}
			else
			{
				trace('IMPORTANT Error! Time not reached!');
			}
	   });
	}
	 
	 #else // Flash, Js, NME...
	
	static private var _timer:Timer = null; 
	static public function timeout(func:Void->Void, milliSeconds:Int = 500) 
	{
		if (_timer != null) _timer.stop();		
		 _timer = Timer.delay(func, milliSeconds);
	}
	 
	 #end
	
	 //----------------------------------------------------------------------------------------------------------------
	 
	static public function delay(func:Void->Void, milliSeconds:Int = 500) 
	{
		#if neko
			neko.vm.Thread.create(function() 
			{
				Sys.sleep(milliSeconds / 1000);
				func();
			});
		#else
			Timer.delay(func, milliSeconds);
		#end
	}
	
	
}