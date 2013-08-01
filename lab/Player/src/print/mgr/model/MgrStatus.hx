package print.mgr.model;

/**
 * ...
 * @author 
 */
enum MgrStatus
{
	Startup;
	Installed;
	PrintLoad(productId:Int, userId:Int, host:String, type:String);
	PrintStart;
	PrintAbort;
	PrintDone;	
	
	Default;
}