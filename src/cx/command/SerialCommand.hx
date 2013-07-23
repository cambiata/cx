/**
* ...
* @author Jonas Nyström
*/

package cx.command;

import cx.command.Command;
import nme.events.Event;

class SerialCommand extends Command
{
	private var commands:Array<Command>;
	public function new(commands:Iterable<Command>) {
		super();
		this.commands = Lambda.array(commands);
	}
	
	private var completeCount:Int;

	override private function execute() {
		this.completeCount = 0;
		this.commands[0].addEventListener(Event.COMPLETE, onSubcommandComplete);
		this.commands[0].start();
		onProgress(this.completeCount+1, this.commands.length);
	}
	
	private function onSubcommandComplete(e:Event):Void {
		cast(e.target, Command).removeEventListener(Event.COMPLETE, onSubcommandComplete);
		this.completeCount++;
		if (this.completeCount == this.commands.length) {
			onProgress(this.commands.length, this.commands.length);
			this.complete();
		} else {
			this.commands[this.completeCount].addEventListener(Event.COMPLETE, onSubcommandComplete);
			onProgress(this.completeCount+1, this.commands.length);
			this.commands[this.completeCount].start();		
		}
	}
	
	dynamic public function onProgress(done:Int, total:Int)
	{
		trace([done, total]);
	}
	
}