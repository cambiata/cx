package scorx.model;

import haxe.Timer;
import msignal.Signal;
/**
 * ...
 * @author Jonas Nyström
 */

class TimerModel 
{	
	
	private var timer:Timer;
	public var update:Signal1<Int>;
	
	private var position:Int = 0;
	
	public function new () 
	{		
		this.update = new Signal1<Int>();
	}	
	
	private function onUpdate() 
	{
		this.position++;
		Debug.log('onUpdate ' + this.position);
		this.update.dispatch(position);
	}
	
	public function start(position:Int=0) 
	{
		stop();
		this.position = position;
		this.timer = new haxe.Timer(1000);
		this.timer.run = this.onUpdate;
	}
	
	public function stop() {
		if (this.timer != null) this.timer.stop();
	}
	
}