package cx.command.msignal;

/**
 * ...
 * @author Jonas Nyström
 */

 class ParallellCommand extends Command
{
	private var commands:Array<Command>;
	public function new(commands:Array<Command>) {
		super();
		this.commands = commands;
	}

	private var completeCount:Int = 0;
	
	override private function execute() 
	{
		for (command in this.commands) 
		{
			command.addOnce(onSubcommandComplete);
			command.start();
		}
	}
	
	private function onSubcommandComplete() 
	{
		//trace('Parallell Subcommand idx ${this.completeCount} complete');
		this.completeCount++;
		if (this.completeCount == this.commands.length) {
			this.complete();
		} 
	}
	
}