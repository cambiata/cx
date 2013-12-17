package cx.command.msignal;

/**
 * ...
 * @author 
 */
class CallbackCommand extends Command
{
	var executeCallback:Void -> Void;
	public function new(executeCallback:Void->Void:) 
	{
		super();
		this.executeCallback = executeCallback;		
	}	
	override public function execute() this.executeCallback();		
}