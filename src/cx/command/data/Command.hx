package cx.command.data;

import msignal.Signal;

/**
 * ...
 * @author Jonas Nyström
 */
class Command extends Signal1<CommandResult>
{
	var result:CommandResult;
	
	public function new() 
	{
		super();
		this.result = new CommandResult(); // { data:this.data, error:this.error, message:this.message };
	}

	public function start() 
	{
		this.execute();		
	}
	
	private function execute() 
	{
		throw "Command.execute should be overridden, and .complete() should be called when execute tasks are finished.";
	}
	
	private function complete() 
	{
		this.dispatch(result);
	}
	
	public function onComplete(fn: CommandResult->Void)
	{
		this.addOnce(fn);
	}
}
