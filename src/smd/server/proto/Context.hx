package smd.server.proto;
import cx.WebTools;
import smd.server.proto.base.Message;
import smd.server.proto.ContextTransfer.ContextTransferTool;
import smd.server.proto.lib.user.User;

/**
 * ...
 * @author Jonas Nyström
 */

class Context 
{	
	static public var user:User;
	static public var transferData:String;
	static public var transferDataTag:String = ContextTransferTool.transferDataTag;
	static public var test:String = "TEST";
	static public var domaintag:String = WebTools.domaintag;
	static public var traces:Array<Message> = [];
}