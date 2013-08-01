package print.mgr.model;

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
		this.status = status;
		this.updated.dispatch(this.status);
	}

	
}