package sx.mvc.controller.command;

import mmvc.impl.Command;
import msignal.Signal.Signal0;
/**
 * ...
 * @author 
 */
class AsynCommand extends Command
{

	public var next:Signal0;
	
	public function new() 
	{
		this.next = new Signal0();
	}
	
}