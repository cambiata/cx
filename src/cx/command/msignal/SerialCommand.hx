package cx.command.msignal;
import cx.command.msignal.Command;

/**
 * ...
 * @author Jonas Nyström
 */
class SerialCommand extends Command
{
	private var commands:Array<Command>;
	public function new(commands:Array<Command>) {
		super();
		this.commands = commands;
	}

	private var completeCount:Int = 0;

	override private function execute() 
	{
		this.commands[0].addOnce(onSubcommandComplete);
		this.commands[0].start();
	}

	private function onSubcommandComplete() 
	{
		//trace('Parallell Subcommand idx ${this.completeCount} complete');
		this.completeCount++;
		if (this.completeCount == this.commands.length) 
		{
			this.complete();
		} else 
		{
			this.commands[this.completeCount].addOnce(onSubcommandComplete);
			this.commands[this.completeCount].start();						
		}
	}
}

