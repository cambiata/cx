package karin.client.controller;
import haxe.remoting.HttpAsyncConnection;
import js.Lib;
import js.JQuery;
import micromvc.client.JQController;

import smd.server.proto.lib.user.User;

/**
 * ...
 * @author Jonas Nyström
 */
class UserController extends RemotingController {	

	@id private var button1:JQuery; 
	
	private var user:User;
	
	public function new() {
		super();
		trace('UserController');
		if (this.button1 != null)
		this.button1.click(function(e) {			
			Lib.alert('click');
		}); 		
		
		this.cnx.Server.getUser.call([], function(user:User) { 
			this.user = user;
			trace(this.user);
		} );							
		
	}     	
}