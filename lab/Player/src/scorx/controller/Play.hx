package scorx.controller;

import scorx.model.Debug;
import scorx.model.TimerModel;

import msignal.Signal.Signal1;
import mmvc.impl.Command;

/**
 * ...
 * @author 
 */
class Play extends Signal1<Int> 
{
	public function new() super(Int);
}

class PlayCommand extends Command
{
	@inject public var debug:Debug;
	@inject public  var model:TimerModel;	
	@inject public var play:Play;
	@inject public var position:Int;
	
	override public function execute():Void
	{
		debug.log('PlayCommand execute');				
		debug.log(position);
		this.model.start(this.position);
	}
}