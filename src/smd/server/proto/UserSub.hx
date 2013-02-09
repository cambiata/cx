package smd.server.proto;

import smd.server.proto.User.UserCategory;
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