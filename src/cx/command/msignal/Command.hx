package cx.command.msignal;

import  msignal.Signal;
/**
 * ...
 * @author Jonas Nyström
 */
class Command extends Signal0
{
	public function new() 
	{
		super();
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
		this.dispatch();
	}
}
