package scorx.controller;
import cx.TimerTools;
import msignal.Signal.Signal0;
import msignal.Signal.Signal1;
import mmvc.impl.Command;

/**
 * ...
 * @author 
 */
class Load extends Signal1<String>
{
	public var completed:Signal0;
	public var failed:Signal1<Dynamic>;

	public function new() 
	{
		super(String);
		completed = new Signal0();
		failed = new Signal1<Dynamic>(Dynamic);
	}
}

class LoadCommand extends Command
{	
	@inject public var load:Load;
	@inject public var url:String;	
	public function new() super();	
	
	override public function execute():Void
	{
		trace('Execute() $url - wait 2000 ms...');
		TimerTools.delay(function() {
			trace('Complete()!');
			this.load.completed.dispatch();
		}, 2000);
	}
}
