package karin.db;
import cx.RandomTools;
import sys.db.Connection;
import sys.db.Object;
import sys.db.Sqlite;
import sys.db.TableCreate;
import sys.db.Types;
import sys.FileSystem;
import haxe.EnumFlags;

/**
 * ...
 * @author Jonas Nyström
 */

class KarinDB 
{
	static public function test() 
	{
		var sqlite = 'karin.sqlite';
		var cnx = KarinDB.getCnx(sqlite);
		KarinDB.removeTables(cnx);
		KarinDB.createTables();
		KarinDBDefaultdata.createUsersAndGroups();
		KarinDBDefaultdata.createMediaAndBoxes();
	}	
	
	static public function getCnx(filename:String):Connection {
		var cnx = Sqlite.open(filename);
		sys.db.Manager.cnx = cnx;				
		sys.db.Manager.initialize();
		return cnx;
	}	
	
	static public function createTables() {
		if (!TableCreate.exists( User.manager)) 			TableCreate.create(	User.manager);		
		if (!TableCreate.exists( Group.manager)) 			TableCreate.create(	Group.manager);		
		if (!TableCreate.exists( UserGroup.manager)) 		TableCreate.create(	UserGroup.manager);				
		if (!TableCreate.exists( Coursedef.manager)) 		TableCreate.create(	Coursedef.manager);				
		
		if (!TableCreate.exists( Media.manager	)) 			TableCreate.create( Media.manager	);				
		if (!TableCreate.exists( Mediaslot.manager	)) 		TableCreate.create( Mediaslot.manager	);				
		if (!TableCreate.exists( Boxdef.manager	)) 			TableCreate.create( Boxdef.manager	);				
		if (!TableCreate.exists( BoxdefMedia.manager)) 		TableCreate.create( BoxdefMedia.manager	);				
		if (!TableCreate.exists( BoxdefMediaslot.manager)) 	TableCreate.create( BoxdefMediaslot.manager	);				
		if (!TableCreate.exists( Box.manager)) 				TableCreate.create( Box.manager	);				
		if (!TableCreate.exists( BoxUser.manager)) 			TableCreate.create( BoxUser.manager	);				
	}
	
	static public function removeTables(cnx:Connection) {
		cnx.request('DROP TABLE IF EXISTS "User"');
		cnx.request('DROP TABLE IF EXISTS "Group"');
		cnx.request('DROP TABLE IF EXISTS "UserGroup"');
		cnx.request('DROP TABLE IF EXISTS "Coursedef"');
		cnx.request('DROP TABLE IF EXISTS "Media"');
		cnx.request('DROP TABLE IF EXISTS "Mediaslot"');
		cnx.request('DROP TABLE IF EXISTS "Boxdef"');
		cnx.request('DROP TABLE IF EXISTS "BoxdefMedia"');
		cnx.request('DROP TABLE IF EXISTS "BoxdefMediaslot"');
		cnx.request('DROP TABLE IF EXISTS "Box"');
		cnx.request('DROP TABLE IF EXISTS "BoxUser"');
	}
}

class User extends Object {
	public var id:SId;
	public var ssnr:SString<13>;
	public var firstname:SString<32>;
	public var lastname:SString<32>;
	public var email:SString<32>;	
}

class Group extends Object {
	public var id:SId;
	public var name:SString<32>;
	public var info:SNull<SText>;	
}

@:id(groupId, userId)
class UserGroup extends Object {
    @:relation(userId) public var user : User;
    @:relation(groupId) public var group : Group;	
	public var memertype: SEnum<Groupmembertype>;
}

enum Groupmembertype {
	Member;
	Leader;
}

class Coursedef extends Object {
	public var id:SId;
	public var label:SString<12>;
	public var minPeriods:SInt;
	public var maxPeriods:SInt;
	public var courseVolume:SFloat;
	public var organizer:SData<Organization>;
}

class Course extends Object {
	public var id:SId;
	public var name:SString<32>;
	@:relation(coursedefId) public var coursedef:Coursedef;	
	public var startDate:SDate;
	public var endDate:SDate;
}

enum Organization {
	Sensus;
	Mellansel;
}

class Media extends Object {
	public var id:SId;
	public var extId:SInt;
	public var label:SString<48>;
	public var type:SEnum<Mediatype>;
	public var data:SNull<SText>;
}

class Mediaslot extends Object {
	public var id:SId;	
	public var label:SString<64>;
	public var restriction:SData<Slotrestrict>;
}

class MediaslotUser extends Object {
	public var id:SId;
	@:relation(mediaslotId) public var mediaslot:Mediaslot;
	@:relation(userId) public var user : User;
	public var datetime:SDateTime;
	public var info:SString<64>;
}

typedef Slotrestrict = {
	public var mediatypes:Array<Mediatype>;
	public var boxIds:Array<Int>;
	public var mediaIds:Array<Int>;
}

enum Mediatype {
	Scorx;
	Video;
	Mp3;
}

class Boxdef extends Object {
	public var id:SId;
	public var label:SString<12>;		
}

@:id(boxdefId, mediaId)
class BoxdefMedia extends Object {
	@:relation(boxdefId) public var boxdef:Boxdef;
	@:relation(mediaId) public var media:Media;
}

@:id(boxdefId, mediaslotId)
class BoxdefMediaslot extends Object {
	@:relation(boxdefId) public var boxdef:Boxdef;
	@:relation(mediaslotId) public var mediaslot:Mediaslot;	
}

class Box extends Object {
	public var id:SId;
	@:relation(boxdefId) public var boxdef:Boxdef;
	@:relation(courseId) public var course:Course;
	@:relation(groupId) public var group:Group;
	@:relation(confUserId) public var user:User;
}

class BoxUser extends Object {
	public var id:SId;
	@:relation(userId) public var user:User;
	@:relation(confUserId) public var confUser:User;	
}



//-----------------------------------------------------------------------------------------------

class KarinDBDefaultdata {

	static public function createMediaAndBoxes() {
		
		var bd:Boxdef = new Boxdef();
		bd.label = 'Mozarts Requiem';
		bd.insert();
		for (i in 1...9) {
			var m = new Media();
			m.label = 'Mozart Requiem $i';
			m.extId = 110 + i;
			m.type = Mediatype.Scorx;
			m.insert();
			var bm:BoxdefMedia = new BoxdefMedia();
			bm.media = m;
			bm.boxdef = bd;
			bm.insert();
		}
		
		//--------------------------------------------------
		
		var bd:Boxdef = new Boxdef();
		bd.label = 'Fauré Requiem';
		bd.insert();
		for (i in 1...7) {
			var m = new Media();
			m.label = 'Fauré Requiem $i';
			m.extId = 170 + i;
			m.type = Mediatype.Scorx;
			m.insert();
			var bm:BoxdefMedia = new BoxdefMedia();
			bm.media = m;
			bm.boxdef = bd;
			bm.insert();			
		}
		
		//--------------------------------------------------
	
		var bd:Boxdef = new Boxdef();
		bd.label = 'Larsson Förklädd Gud';
		bd.insert();
		for (i in 1...8) {
			var m = new Media();
			m.label = 'Larsson Förklädd Gud $i';
			m.extId = 220 + i;
			m.type = Mediatype.Scorx;
			m.insert();
			var bm:BoxdefMedia = new BoxdefMedia();
			bm.media = m;
			bm.boxdef = bd;
			bm.insert();			
		}	
		
		//--------------------------------------------------
		
		var bd:Boxdef = new Boxdef();
		bd.label = 'Folkbildningsrådet 30 Fria';
		bd.insert();	
		for (i in 1...30) {
			var m = new Media();
			m.label = 'Folkbildningsrådet Fria nr $i';
			m.extId = 30 + i;
			m.type = Mediatype.Scorx;
			m.insert();
			var bm:BoxdefMedia = new BoxdefMedia();
			bm.media = m;
			bm.boxdef = bd;
			bm.insert();			
		}	
		
		//--------------------------------------------------
		
		var bd:Boxdef = new Boxdef();
		bd.label = '5 st valbara';
		bd.insert();		
		for (i in 1...6) {
			var ms = new Mediaslot();
			ms.label = 'Valbart Scorxexempel nr $1';
			ms.restriction = { mediatypes:[Mediatype.Scorx], boxIds:null, mediaIds:null };
			ms.insert();			
			var bms:BoxdefMediaslot = new BoxdefMediaslot();
			bms.mediaslot = ms;
			bms.boxdef = bd;		
			bms.insert();
		}
		
		//--------------------------------------------------
		
		var bd:Boxdef = new Boxdef();
		bd.label = '2 Folkbildning & 2 Valbara';
		bd.insert();
		
		var m = Media.manager.search( { extId:31 } ).first();
		var bm:BoxdefMedia = new BoxdefMedia();
		bm.media = m;
		bm.boxdef = bd;
		bm.insert();
		
		var m = Media.manager.search( { extId:32 } ).first();
		var bm:BoxdefMedia = new BoxdefMedia();
		bm.media = m;
		bm.boxdef = bd;
		bm.insert();
		
		var ms = new Mediaslot();
		ms.label = 'Valbart Scorxexempel A';
		ms.restriction = { mediatypes:[Mediatype.Scorx], boxIds:null, mediaIds:null };
		ms.insert();			
		var bms:BoxdefMediaslot = new BoxdefMediaslot();
		bms.mediaslot = ms;
		bms.boxdef = bd;		
		bms.insert();		

		var ms = new Mediaslot();
		ms.label = 'Valbart Scorxexempel B';
		ms.restriction = { mediatypes:[Mediatype.Scorx], boxIds:null, mediaIds:null };
		ms.insert();			
		var bms:BoxdefMediaslot = new BoxdefMediaslot();
		bms.mediaslot = ms;
		bms.boxdef = bd;		
		bms.insert();		
	}
	
	static public function newUser(first:String, last:String):User {
		var user = new User();
		user.firstname = first;
		user.lastname = last;
		user.email = '$first.$last@se'.toLowerCase();		
		user.ssnr = RandomTools.fullSsnrStr();
		return user;		
	}
	
	static public function createUsersAndGroups() {
		for (i in 0...10) newUser('A$i', 'Aaa').insert();
		for (i in 0...10) newUser('B$i', 'Bbb').insert();
		for (i in 0...10) newUser('C$i', 'Ccc').insert();
		
		var group = new Group();
		group.name = 'A-kören';
		group.insert();
		for (i in 0...10) {			
			var user = User.manager.search( { firstname: 'A' + i } ).first();
			trace(user);
			var userGroup = new UserGroup();
			userGroup.user = user;
			userGroup.group = group;
			userGroup.memertype = (i==0) ? Groupmembertype.Leader : Groupmembertype.Member;
			userGroup.insert();			
		}
		
		var group = new Group();
		group.name = 'B-kören';
		group.insert();
		for (i in 0...10) {			
			var user = User.manager.search( { firstname: 'B' + i } ).first();
			trace(user);
			var userGroup = new UserGroup();
			userGroup.user = user;
			userGroup.group = group;
			userGroup.memertype = (i==0) ? Groupmembertype.Leader : Groupmembertype.Member;
			userGroup.insert();			
		}		
		
		var group = new Group();
		group.name = 'C-kören';
		group.insert();
		for (i in 0...10) {			
			var user = User.manager.search( { firstname: 'C' + i } ).first();
			trace(user);
			var userGroup = new UserGroup();
			userGroup.user = user;
			userGroup.group = group;
			userGroup.memertype = (i==0) ? Groupmembertype.Leader : Groupmembertype.Member;
			userGroup.insert();			
		}			
		
	}
	
	
}
