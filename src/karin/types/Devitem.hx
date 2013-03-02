/**
 * ...
 * @author Jonas Nyström
 */

package karin.types;
import karin.db.Devtaskprio;
import karin.db.Devtaskstatus;
import karin.db.Devtasksubject;

typedef Devitem =
{
	id: 		Int,
	prio:		Devtaskprio,
	subject:	Devtasksubject,
	label:		String,
	info:		String,
	started:	Date,
	finished:	Date,
	status:		Devtaskstatus,
	comment:	String,
}