package smd.server.proto.lib.user;

import smd.server.proto.lib.user.UserCategory;
/**
 * ...
 * @author Jonas Nyström
 */

typedef UserSub = {
	id:String,
	category:UserCategory,
	firstname:String,
	lastname:String,
	user:String,
}