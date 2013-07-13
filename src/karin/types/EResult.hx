/**
 * ...
 * @author Jonas Nyström
 */

package karin.types;

enum EResult 
{
	Insert;
	Update;
	Delete;
	Complete;
	Success(data:Dynamic, ?data2:Dynamic, ?data3:Dynamic);
	Error(msg:String);	
	void;
}