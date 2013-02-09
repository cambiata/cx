package smd.server.proto.service;
import haxe.Serializer;

/**
 * ...
 * @author Jonas Nyström
 */

class ServiceTool 
{
	static public function toResult(info:String, data:String, code:Int=0, error:String = null, data2:String=null, data3:String=null ) :ServiceResult
	{
		return ({
			code:code,
			info:info,
			data:data,
			data2:data2,
			data3:data3,
			date:Date.now(),
			error:error,			
		});
	}
	
}