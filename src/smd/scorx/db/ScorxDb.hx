package smd.scorx.db;
import cx.SqliteTools;
import neko.db.Sqlite;
import neko.FileSystem;
import neko.Utf8;
import smd.scorx.db.type.TAlternative;
import smd.scorx.db.type.TAlternatives;
import smd.scorx.db.type.TCategories;
import smd.scorx.db.type.TCategory;
import smd.scorx.db.type.TChannelBase;
import smd.scorx.db.type.TChannelsBase;
import smd.scorx.db.type.TExample;
import smd.scorx.db.type.TInformation;
import smd.scorx.db.type.TOriginator;
import smd.scorx.db.type.TOriginatorItem;
import smd.scorx.db.type.TOriginatorItems;
import smd.scorx.db.type.TOriginators;
import smd.scorx.db.type.TPageBase;
import smd.scorx.db.type.TPagesBase;

/**
 * ...
 * @author Jonas Nyström
 */
class ScorxDb {
	static public function createNew(filename:String) {
		SqliteTools.createSqlite(filename);
		SqliteTools.execute(filename, 'CREATE TABLE "categories" ("type" varchar, "value" VARCHAR)');
		SqliteTools.execute(filename, 'CREATE TABLE "categoriesdyn" ("type" varchar, "value" varchar)  ');
		SqliteTools.execute(filename, 'CREATE TABLE "channels" ("id" varchar, "name" varchar, "data" blob)  ');
		SqliteTools.execute(filename, 'CREATE TABLE "files" ("ext" varchar, "name" varchar, "data" blob)  ');
		SqliteTools.execute(filename, 'CREATE TABLE "grid" ("pos" float ,"type" varchar,"page" int,"xAbs" int,"yAbs" int,"widthAbs" int,"heightAbs" int, "x" float, "y" float, "width" float, "height" float)  ');
		SqliteTools.execute(filename, 'CREATE TABLE "information" ("type" varchar, "value" varchar)  ');
		SqliteTools.execute(filename, 'CREATE TABLE "notes" ("type" varchar NOT NULL ,"value" text)  ');
		SqliteTools.execute(filename, 'CREATE TABLE "originators" ("type" VARCHAR NOT NULL , "firstname" VARCHAR, "lastname" varchar, "birth" varchar, "death" VARCHAR, "originator_id" int)  ');
		SqliteTools.execute(filename, 'CREATE TABLE "pages" ("id" varchar PRIMARY KEY  NOT NULL , "data" blob)  ');
		SqliteTools.execute(filename, 'CREATE TABLE "quickstarts" ("name" varchar, "start" float, "stop" float, "label" varchar, "tooltip" varchar, "type" varchar)  ');		
		SqliteTools.execute(filename, "INSERT INTO 'information' VALUES('id','')  ");
		SqliteTools.execute(filename, "INSERT INTO 'information' VALUES('title','')   ");
		SqliteTools.execute(filename, "INSERT INTO 'information' VALUES('subtitle','')   ");
		SqliteTools.execute(filename, "INSERT INTO 'information' VALUES('distributor_id','SKA')   ");
		SqliteTools.execute(filename, "INSERT INTO 'information' VALUES('mediaformat_id','SCX')   ");
		SqliteTools.execute(filename, "INSERT INTO 'information' VALUES('published','0')   ");
		SqliteTools.execute(filename, "INSERT INTO 'information' VALUES('updated','')   ");
		SqliteTools.execute(filename, "INSERT INTO 'information' VALUES('added','')   ");
	}
	
	static public function getChannels(filename:String):TChannelsBase {
		var sql = 'SELECT * FROM channels ORDER BY id';
		var cnx = Sqlite.open(filename);	
		var items = cnx.request(sql).results();
		cnx.close();				
		var datas = new TChannelsBase();
		for (item in items) {
			var data:TChannelBase = item;
			datas.push(data);
		}
		return datas;
	}
	
	static public function getPages(filename:String):TPagesBase {
		var sql = 'SELECT * FROM pages ORDER BY id';
		var cnx = Sqlite.open(filename);	
		var items = cnx.request(sql).results();
		cnx.close();		
		
		var datas = new TPagesBase();
		for (item in items) {
			var data:TPageBase = item;
			datas.push(data);
		}
		return datas;
	}	
	
	static public function getCategories(filename:String):TAlternatives {
		var sql = 'SELECT * FROM categories';
		var cnx = Sqlite.open(filename);	
		var items = cnx.request(sql).results();
		var datas = new TAlternatives();
		for (item in items) {
			var data:TAlternative = {categoryId:item.type, value:item.value};
			datas.push(data);
		}
		cnx.close();		
		return datas;		
	}
	
	static public function insertCategory(filename:String, alternative:TAlternative) {
		if (!FileSystem.exists(filename)) {
			throw "File " + filename + " doesn't exist!";
			return;
		}
		var sql = 'INSERT INTO categories (type, value) VALUES ('
		+ '"' + alternative.categoryId + '", '
		+ '"' + alternative.value + '" '
		+ ') ';
		var cnx = Sqlite.open(filename);	
		cnx.request(sql);
		cnx.close();
	}
	
	static public function getCategoriesDyn(filename:String):TAlternatives {
		var sql = 'SELECT * FROM categoriesdyn';
		var cnx = Sqlite.open(filename);	
		var items = cnx.request(sql).results();
		var datas = new TAlternatives();
		for (item in items) {
			var data:TAlternative = {categoryId:item.type, value:item.value};
			datas.push(data);
		}
		cnx.close();		
		return datas;		
	}	

	static public function insertCategoryDyn(filename:String, alternative:TAlternative) {
		if (!FileSystem.exists(filename)) {
			throw "File " + filename + " doesn't exist!";
			return;
		}
		
		var sql = 'INSERT INTO categoriesdyn (type, value) VALUES ('
		+ '"' + alternative.categoryId + '", '
		+ '"' + alternative.value + '" '
		+ ') ';
		
		var cnx = Sqlite.open(filename);	
		cnx.request(sql);
		cnx.close();
	}	
	
	//---------------------------------------------------------------------------------

	// data/categories.sqlite
	static public function getCategoryTypes(filename:String, ?type:String=''):TCategories {
		var sql = 'SELECT * FROM categories '; 
		
		if (type != '') sql += ' WHERE type = "' + type + '" ';
		
		sql += 'order by sort';
		
		
		var cnx = Sqlite.open(filename);	
		var items = cnx.request(sql).results();
		var datas = new TCategories();
		for (item in items) {
			var data:TCategory = {
				distributorId: item.distributorId,
				id: item.id,
				maxcount: item.maxcount,
				name: item.name,
				sort: item.sort,
				type: item.type
			}
			datas.push(data);
		}
		cnx.close();		
		return datas;		
	}
	
	static public function getMaxcountForCategory(filename:String, categoryId:String):Int {
		var sql = 'SELECT * FROM categories where id = "' + categoryId + '"';
		var cnx = Sqlite.open(filename);	
		var items = cnx.request(sql).results();
		
		if (items.length != 1) {
			trace('Something is wrong with categoryId ' + categoryId);
		}
		
		var categories = new TCategories();
		for (item in items) {
			var category:TCategory = item;
			categories.push(category);
		}
		var cat = categories[0];
		cat.maxcount;
		trace('found maxcount for category ' + categoryId + ': ' + cat.maxcount);
		
		return cat.maxcount;
	}
	
	static public function getTitleCountCategory(filename:String, categoryId:String):Int {
		var sql = 'SELECT * FROM categories where type = "' + categoryId + '"';		
		var cnx = Sqlite.open(filename);	
		var items = cnx.request(sql).results();
		return items.length;		
	}	
	
	// data/alternatives.sqlite
	static public function getAlternatives(filename:String):TAlternatives {
		var sql = 'SELECT * FROM alternatives order by categoryId, value';
		var cnx = Sqlite.open(filename);	
		var items = cnx.request(sql).results();
		var datas = new TAlternatives();
		for (item in items) {
			var data:TAlternative = {categoryId:item.categoryId, value:item.value};
			datas.push(data);
		}
		cnx.close();		
		return datas;		
	}	
		
	static public function setInformationField(filename:String, field:String, value:String) {
		var sql = 'UPDATE information SET value = "' + value + '" WHERE  type = "' + field + '"';
		trace(sql);
		SqliteTools.execute(filename, sql);
	}
	
	static public function getOriginators(filename:String):TOriginators {
		//trace('get...');
		var sql = 'SELECT * FROM originators';
		var cnx = Sqlite.open(filename);	
		var items = cnx.request(sql).results();
		var originators = new TOriginators();
		for (item in items) {
			var originator:TOriginator = {lastname: item.lastname, firstname: item.firstname, birth:item.birth, death:item.death};
			originators.push(originator);
		}
		cnx.close();		
		return originators;
	}
	
	static public function insertOriginator(filename:String, originator:TOriginator) {
			var sql = "INSERT INTO originators (firstname, lastname, birth, death) VALUES ('" 
			+ originator.firstname + "','"
			+ originator.lastname + "','"
			+ originator.birth + "','"
			+ originator.death 
			+ "');";				
			//trace(sql);
			var cnx = Sqlite.open(filename);	
			cnx.request(sql);
			cnx.close();
	}
	
	static public function insertOriginatorType(filename:String, originator:TOriginator, type:String) {
		if (!FileSystem.exists(filename)) {
			throw "File " + filename + " doesn't exist!";
			return;
		}		
		var sql = 'INSERT INTO originators (type, firstname, lastname, birth, death) VALUES ('
		+ '"' + type + '", '
		+ '"' + originator.firstname + '", '
		+ '"' + originator.lastname + '", '
		+ '"' + originator.birth + '", '
		+ '"' + originator.death + '" '
		+ ') ';		
		trace(sql);
		var cnx = Sqlite.open(filename);	
		cnx.request(sql);
		cnx.close();		
	}	
	
	static public function getAll(filename:String): TExample {
		var r:TExample = {
			information:getInformation(filename),
			originatorItems:getOriginatorItems(filename),
		}		
		return r;		
	}
	
	static public function getInformation(filename:String): TInformation {
		if (!FileSystem.exists(filename)) throw "Can't find file " + filename;		
		try {
			var cnx = Sqlite.open(filename);			
			var results = cnx.request("SELECT * FROM information").results();
			var dynResults = translateResultsToDynamic(results);
			
			var addedDate = (dynResults.added > '') ? Date.fromString(dynResults.added) : null;
			var updatedDate = (dynResults.updated > '') ? Date.fromString(dynResults.updated) : null;
			
			var r:TInformation = {
				id: Std.parseInt(dynResults.id),
				title: dynResults.title,
				subtitle: dynResults.subtitle,
				distributorId: Utf8.decode(dynResults.distributor_id),
				mediaformatId: Utf8.decode(dynResults.mediaformat_id),
				published: Std.parseInt(dynResults.published),
				added: addedDate, 
				updated: updatedDate,
			}
			return r;
		} catch (msg:String) {
			throw 'getInformation error for file ' + filename;
		}
		return null;
	}
	
	static public function getOriginatorItems(filename:String): TOriginatorItems {
		if (!FileSystem.exists(filename)) throw "Can't find file " + filename;
		
		try {		
			var cnx = Sqlite.open(filename);			
			var results = cnx.request("SELECT * FROM originators").results();
			var ois = new TOriginatorItems();
			for (item in results) {
				var oi:TOriginatorItem = {
					type: item.type,
					originator: {
						firstname: item.firstname,
						lastname: item.lastname,
						birth: item.birth,
						death: item.death,
					}
				}
				ois.push(oi);
			}
			//trace(ois);
			return ois;
		} catch (msg:String) {
			throw 'getInformation error for file ' + filename;
		}
		
		return null;
	}

	static private function translateResultsToDynamic(results:List<Dynamic>):Dynamic {		
		var r = {};
		for (data in results) {
			var type = data.type;
			var value = Std.string(data.value);
			Reflect.setField(r, type, value);
		}
		return r;
	}		
	
	
	
}