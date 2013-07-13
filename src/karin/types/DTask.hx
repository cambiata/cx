/**
 * ...
 * @author Jonas Nyström
 */

package karin.types;

typedef DTask = {
	subject:String,
	title:String,
	info:String,
	status:String,
	prio:Int,
	date:String,
	sign:String,
	comments:Array<DTaskComment>,
}