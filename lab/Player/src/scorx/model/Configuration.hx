package scorx.model;
import msignal.Signal.Signal0;

/**
 * ...
 * @author 
 */
class Configuration
{
	public function new()
	{
		this.updated = new Signal0();
	}
	
	public var host(default, null):String = "http://scorxdev.azurewebsites.net/";	
	public var productId(default, null):Int = 0;
	public var userId(default, null):Int = 0;	
	
	public function setValues(productId:Null<Int> = null, userId:Null<Int> = null, host:Null<String> = null)
	{
		if (productId != null) this.productId = productId;
		if (userId != null) this.userId = userId;
		if (host != null) this.host = host;
		
		this.updated.dispatch();
	}
	
	public var updated:Signal0;
}