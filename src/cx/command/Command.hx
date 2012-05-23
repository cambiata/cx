package cx.command;
import nme.events.Event;
import nme.events.EventDispatcher;

/**
 * ...
 * @author Jonas Nyström
 */

class Command extends EventDispatcher {
	
	
	public function new() {
		super();
	}
	
	
	public function start(event:Event=null) {
		this.execute();		
	}
	
	private function execute() {
		throw "Should be overridden";
	}
	
	private function complete(event:Event = null) {
		this.dispatchEvent(new Event(Event.COMPLETE));
	}
	
	
}