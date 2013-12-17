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
	PrintSelect;
	PrintProcess(pageNr:Int, nrOfPages:Int, action:String);	
	PrintDone;	
	PrintAborted;
	
	Default;
}