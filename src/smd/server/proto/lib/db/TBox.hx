package smd.server.proto.lib.db;
/**
 * ...
 * @author Jonas Nyström
 */

typedef TBox =
{
	id			: Int,
	label		: String,
	info		: String,
	ids			: Array<Int>,
	category	: EBoxType,	
	org			: String,
	ccode		: String,
}