package smd.server.proto;
import cx.WebTools;
import smd.server.proto.base.Message;

/**
 * ...
 * @author Jonas Nyström
 */

class Context 
{	
	static public var user:User;
	static public var userTransferData:String;
	static public var test:String = "TEST";
	static public var domaintag:String = WebTools.domaintag;
	static public var traces:Array<Message> = [];
}