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
	Success(data:Dynamic);
	Error(msg:String);	
	void;
}