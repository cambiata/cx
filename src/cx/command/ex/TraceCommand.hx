package cx.command.ex;
/**
* ...
* @author Jonas Nyström
*/

import cx.command.Command;
import nme.events.Event;

class TraceCommand extends Command {

	private var msg:String;
	
	public function new(msg:String) {
		super();
		this.msg = msg;
	}
	
	override private function execute() {
		trace(this.msg);
		complete();
	}
}