package scorx.data;

import msignal.Signal.Signal1;

/**
 * ...
 * @author Jonas Nyström
 */
class Errors
{

	public var status:msignal.Signal.Signal1<ErrorStatus>;
	
	
	var errors:Array<String>;
	
	public function new() 
	{
		this.errors = new Array<String>();
		this.status = new Signal1<ErrorStatus>();
	}
	
	public function addError(msg:String)
	{
		trace('add');
		this.errors.push(msg);		
		this.status.dispatch(ErrorStatus.Added(msg, this.errors));
	}
	
	public function clear()
	{
		trace('clear');
		this.errors = [];
		this.status.dispatch(ErrorStatus.None);
	}
	
	
}

enum ErrorStatus 
{
	None;
	Added(message:String, messages:Array<String>);
}