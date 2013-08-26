package print.mgr.model;
import pgr.gconsole.GameConsole;

/**
 * ...
 * @author 
 */
class Status
{
	
	
	public var updated:msignal.Signal.Signal1<MgrStatus>;
	
	public function new()
	{
		this.updated = new msignal.Signal.Signal1<MgrStatus>();
	}
	
	public var status(default, null):MgrStatus;
		
	public function setStatus(status:MgrStatus):Void
	{
		GameConsole.log(status);
		this.status = status;
		this.updated.dispatch(this.status);
	}

	
}