package scorx.data;

/**
 * ...
 * @author 
 */
class JobData
{
	public var productId(default, null):Int;
	public var userId(default, null):Int;
	public var host(default, null):String;
	public var type(default, null):String;
	
	public function new(productId:Int, userId:Int, host:String, type:String) 
	{
		this.productId = productId;
		this.userId = userId;
		this.host = host;
		this.type = type;
	}	
}