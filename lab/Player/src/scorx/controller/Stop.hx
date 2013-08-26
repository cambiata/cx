package scorx.controller;

/**
 * ...
 * @author 
 */
 
 import scorx.model.TimerModel;

 import msignal.Signal.Signal0;
import mmvc.impl.Command;

/**
 * ...
 * @author 
 */
class Stop extends Signal0 {}

class StopCommand extends Command
{
	@inject public var model:TimerModel;


	override public function execute():Void
	{
		this.model.stop();
	}
}