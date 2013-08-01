package scorx.controller;

/**
 * ...
 * @author 
 */
 
 import scorx.model.Debug;
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
	@inject public var debug:Debug;

	override public function execute():Void
	{
		debug.log('StopCommand execute');
		this.model.stop();
	}
}