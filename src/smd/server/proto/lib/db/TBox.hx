package smd.server.proto.lib.db;
/**
 * ...
 * @author Jonas Nyström
 */

typedef TBox =
{
	id			: String,
	label		: String,
	info		: String,
	ids			: Array<Int>,
	category	: EBoxType,	
	org			: String,
	ccode		: String,
}