package smd.server.proto.lib.db;

/**
 * ...
 * @author Jonas Nyström
 */

typedef TUserBox =
{
	userid		: String,
	box			: TBox,
	info		: String,
	start		: Date,
	stop		: Date,
	activation	: Date,
}