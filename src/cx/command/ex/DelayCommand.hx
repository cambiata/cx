package cx.command.ex;
import nme.events.TimerEvent;
import nme.utils.Timer;

/**
 * ...
 * @author Jonas Nyström
 */

class DelayCommand extends Command
{
	private var ms:Float;
	private var timer:Timer;
	private var debug:Bool;

	public function new(ms:Float, debug:Bool=false) 
	{
		super();
		this.debug = debug;
		this.ms = ms;
		timer = new Timer(ms);
		timer.addEventListener(TimerEvent.TIMER, onTimer);
	}
	
	override private function execute() {
		timer.start();	
		if (debug) trace('Delay command ' + this.ms + ' ms start...');
	}
	
	private function onTimer(e:TimerEvent):Void 
	{
		if (debug) trace('Delay command stop!');
		this.complete();
		timer.stop();
		timer.removeEventListener(TimerEvent.TIMER, onTimer);
	}
	
}