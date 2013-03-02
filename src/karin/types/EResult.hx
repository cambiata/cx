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
	Error(msg:String);	
	void;
}