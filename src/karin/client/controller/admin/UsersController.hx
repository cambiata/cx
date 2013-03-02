package karin.client.controller.admin;
import cx3.TimerTools;
import karin.tools.UserTools;
import micromvc.client.JQController;

import smd.server.proto.lib.user.User;
import js.Lib;
import js.JQuery;
import smd.server.proto.lib.user.Users;

/**
 * ...
 * @author Jonas Nyström
 */
using Lambda;
 
@uri('/admin/users')  
class UsersController extends RemotingController {	

	@id private var button1:JQuery; 	
	//private var user:User;
	@id private var tableUsers:JQuery;
	@id private var tableStatus:JQuery;
	
	@id private var searchEmail:JQuery;
	@id private var searchLastname:JQuery;
	@id private var searchFirstname:JQuery;
	@id private var searchId:JQuery;
	@id private var searchCat:JQuery;

	private var users:Users;
	
	private var sFirstname:String;
	private var sLastname:String;
	private var sId:String;
	private var sEmail:String;
	private var sCat:String;
	
	public function new() {
		super();
		trace('AdminController');
		
		this.button1.click(function(e) {			
			Lib.alert('click');
		}); 	
		
		this.searchId.keyup(function(e) {			
			this.sId = this.searchId.val();
			TimerTools.timeout(function() this.updateTableUsers(), 500);			
		});		
		
		this.searchLastname.keyup(function(e) {			
			this.sLastname = this.searchLastname.val();
			TimerTools.timeout(function() this.updateTableUsers(), 500);
		});
		
		this.searchFirstname.keyup(function(e) {			
			this.sFirstname = this.searchFirstname.val();
			TimerTools.timeout(function() this.updateTableUsers(), 500);
		});	
		
		this.searchEmail.keyup(function(e) {			
			this.sEmail = this.searchEmail.val();
			TimerTools.timeout(function() this.updateTableUsers(), 500);
		});	
		
		this.searchCat.keyup(function(e) {			
			this.sCat = this.searchCat.val();
			TimerTools.timeout(function() this.updateTableUsers(), 500);
		});		
				
		this.adminGetAllUsers();
	}     	
	
	public function adminGetAllUsers() {
		this.tableStatus.text('Användardata hämtas. Vänligen vänta...');
		this.cnx.Server.adminGetAllUsers.call(['abc'], function(users:Users) {
			this.users = users;
			updateTableUsers();
		});		
	}
	
	public function updateTableUsers():Void {	
		this.tableStatus.text('Uppdaterar listan. Vänligen vänta...');
		this.tableUsers.html('<tr><td>Loading...</td></tr>');
		var users = this.users;
		var html = '';		
		users = filterUsers(users, sFirstname, sLastname, sEmail, sId, sCat);		
		users = sortUsers(users);
		
		
		for (user in users) {
			var pnr = UserTools.personidToNr(user.id);
			html += Std.format('<tr><td>${pnr}</td><td><b>${user.lastname}</b></td><td><b>${user.firstname}</b></td><td>${user.user}</td><td>${user.category}</td></tr>');
		}
		this.tableUsers.html(html);
		this.tableStatus.text('Visar ' + Std.string(users.length) + ' av ' + Std.string(this.users.length));
	}
	
	private function filterUsers(users:Users, firstname:String='', lastname:String='', email:String='', id:String='', cat=''):Users {		
		if (firstname != '') {
			users = users.filter(function(a) { 
				return (a.firstname.toLowerCase().indexOf(firstname.toLowerCase()) > -1);
			} ).array();
		}		

		if (lastname != '') {
			users = users.filter(function(a) { 
				return (a.lastname.toLowerCase().indexOf(lastname.toLowerCase()) > -1);
			} ).array();
		}			
		
		if (email != '') {
			users = users.filter(function(a) { 
				return (a.user.toLowerCase().indexOf(email.toLowerCase()) > -1);
			} ).array();
		}
		
		if (id != '') {
			users = users.filter(function(a) { 
				var nr = UserTools.personidToNr(a.id);				
				return (nr.indexOf(id) > -1);
			} ).array();
		}
		
		if (cat != '') {
			users = users.filter(function(a) { 
				var aCat = Std.string(a.category).toLowerCase();
				return (aCat.indexOf(cat.toLowerCase()) > -1);
			} ).array();
		}			
		
		return users;
	}
	
	private function sortUsers(users:Users): Users {
		users.sort(function(a, b) { 
			var comp1 = Reflect.compare(a.lastname, b.lastname);
			if (comp1 == 0) return Reflect.compare(a.firstname, b.firstname);
			return comp1;
			
		} );
		
		return users;
	}
	
}