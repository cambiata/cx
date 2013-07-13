package smd.server.proto.lib.db;
import smd.server.proto.lib.user.User;
/**
 * ...
 * @author Jonas Nyström
 */

typedef TUserBox =
{
	user		: User,
	box			: TBox,
	info		: String,
	start		: Date,
	stop		: Date,
	activation	: Date,
}