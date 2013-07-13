/**
 * ...
 * @author Andreas Söderlund
 * @author Jonas Nysröm (SQLite adaption)
 */
package neko;

#if haxe3 

#else 

#end


import cx.SqliteTools;
//import haxe.CallStack;
#if haxe3 
import haxe.crypto.Md5; 
#else 
import haxe.Md5;
#end

import haxe.Serializer;
import haxe.Unserializer;
import sys.FileSystem;
import sys.io.File;
import neko.Web;
import sys.db.Connection;
import sys.db.Sqlite;

/*
 * CREATE TABLE "sessions" ("id" VARCHAR PRIMARY KEY  NOT NULL  UNIQUE , "data" VARCHAR, "datetime" DATETIME)
 * 
 */ 



using StringTools;
class SQLiteSession
{
	/**
	 * Chance to start garbage collection on session start. Between 0 and 1.
	 * Default is 0.01.
	 */
	public static var gcStartChance : Float;
	
	/**
	 * Max session file life time in seconds.
	 * Default is 1 day.
	 */
	public static var gcMaxLifeTime : Int;
	
	static var savePath : String;
	
	static var started : Bool;
	static var sessionName : String;
	
	static var id : String;
	
	





	static var sessionData :#if haxe3  Map<String, Dynamic>; #else Hash<Dynamic>; #end
	
	static var needCommit : Bool;

	static function __init__()
	{
		//Lib.println('init');
		gcStartChance = 0.01;
		gcMaxLifeTime = 60 * 60 * 24;
		
		started = false;
		sessionName = 'APPLICATION_SESSIONS';
	}

	static var cnx:Connection;
	
	public static function setSavePath(path:String) : Void
	{
		path = path.replace("\\", "/");
		if (path.endsWith("/"))
		{
			path = path.substr(0, path.length - 1);
		}
		savePath = path;		
		dbCreateConnection(savePath);
		
	}
	
	public static function get(name:String) : Dynamic
	{
		start();
		//Lib.println(['get', name]);
		return sessionData.get(name);
	}

	public static function set(name : String, value : Dynamic)
	{
		start();
		//Lib.println(['set', name, value]);
		needCommit = true;
		sessionData.set(name, value);
	}

	public static function exists(name : String)
	{
		start();
		//Lib.println(['exists', name]);
		return sessionData.exists(name);
	}

	public static function remove(name : String)
	{
		start();
		//Lib.println(['remove', name]);
		needCommit = true;
		sessionData.remove(name);
	}

	public static function start()
	{
		//Lib.println('start...');
		if (started) return;
		//Lib.println('START!');
		
		needCommit = false;
		
		//-----------------------------------------------------------------------
		// default save path
		if (savePath == null)
		{
			savePath = Web.getCwd().replace("\\", "/");
			if (!savePath.endsWith("/")) savePath += "/";
			savePath += 'temp/sessions';
			dbCreateConnection(savePath);
		}

		if (!FileSystem.exists(savePath))
		{
			throw 'Neko session savepath not found: ' + savePath;
		}
		
		
		//-----------------------------------------------------------------------
		if (Math.random() < gcStartChance)
		{
			collectGarbage();
		}

		
		//-----------------------------------------------------------------------		
		id = Web.getCookies().get(sessionName);
		//Lib.println('Pröva hämta id från cookie - sessionName ' + sessionName + ' : id ' + id);
		
		//-----------------------------------------------------------------------
		
		if (id != null)
		{
			//Lib.println(['id finns: ', id]);
			
			if (~/^[a-zA-Z0-9]+$/.match(id))
			{
				//Lib.println('id matchar...');
				var sql = "select * from sessions where id = '" + id + "'";
				//Lib.println('# sql: ' + sql);
				var dbResult = cnx.request(sql).results();
				//Lib.println('# dbResult: ' + dbResult.length);

				//================================================
				// db session
				if (dbResult.length != 1)
				{
					//Lib.println (' - dbResult existerar INTE och id sätts till null!');
					id = null;
				}
				else
				{
					//Lib.println(' - dbResult existerar! Hämta data');
					
					//var fileData = try File.getContent(file) catch ( e:Dynamic ) null;
					var dbRow = dbResult.first();
					//Lib.println('# dbRow: ' + dbRow);
					var dbData = dbRow.data;
					//Lib.println('# dbData: ' + dbData);
					
					
					if (dbData == null)
					{
						//Lib.println('# fildata existerar INTE: id sätts till null!');
						//Lib.println('# pröva ta bort posten från databasen');						
						var sql = "DELETE FROM sessions WHERE id='" + id + "'";
						//Lib.println(sql);
						cnx.request(sql);
						id = null;
					}
					else
					{
						sessionData = Unserializer.run(dbData);
						//Lib.println(' - dbData EXISTERAR och unserialiseras till ' + sessionData);
					}
					
				}				
			}
			else 
			{
				//Lib.println('id matchar INTE regexp, id sätts till null');			
				id = null;	
			}
		}
		
		//------------------------------------------------------
		
		if (id == null)
		{
			#if haxe3
			sessionData = new Map<String, Dynamic>();
			#else
			sessionData = new Hash<Dynamic>();
			#end
			// Generera nytt unikt id...
			while (true)
			{		
				
				id = Md5.encode(Std.string(Math.random()) + Std.string(Math.random()));
				//Lib.println(' - generera nytt id: ' + id);

				var sql = "select * from sessions where id = '" + id + "'";
				//Lib.println('# sql: ' + sql);
				var dbResult = cnx.request(sql).results();
				//Lib.println('# dbResult: ' + dbResult.length);
				
				var dbExists = (dbResult.length > 0);
				//Lib.println(' - check dbExists: ' + dbExists);
				
				///if (!fileExists && !dbExists) break;
				if (!dbExists) break;
				
			}
			
			//Lib.println(' - spara cookie med sessionName ' + sessionName + ' och id ' + id);
			Web.setCookie(sessionName, id, null, null, '/');
			
			started = true;
			commit();
		}
		
		started = true;
	}

	public static function clear()
	{
		//Lib.println('clear');
		#if haxe3
		sessionData = new Map<String, Dynamic>();
		#else
		sessionData = new Hash<Dynamic>();
		#end
	}
	
	public static function close()
	{
		//Lib.println('close');
		if (started)
		{
			if (needCommit)
			{
				commit();
			}
			started = false;
		}
	}
	
	static function commit()
	{
		//Lib.println('commit...');
		if (!started) return;
		//Lib.println('commit!');
		
		
		try
		{
			/*
			var w = File.write(savePath +"/" + id + ".sess", true);
			//Lib.println('Commit - write sessionData to file ' + sessionData);
			w.writeString(Serializer.run(sessionData));
			w.close();
			*/
			
			var sql = "DELETE FROM sessions WHERE id='" + id + "'";
			//Lib.println(sql);
			cnx.request(sql);
			
			var sql = SqliteTools.getInsertStatement( { id:id, data:Serializer.run(sessionData), datetime:Date.now()}, 'sessions');
			//Lib.println(sql);
			cnx.request(sql);
			
			
		}
		catch (e:Dynamic)
		{
			//Lib.println('Session is gone, ignore it.');
		}
	}
	
	static function collectGarbage()
	{
		//Lib.println('collect');
		
		var nowTime = Date.now().getTime();
		var maxLifeTimeMS = gcMaxLifeTime * 1000;
		
		/*
		for (file in FileSystem.readDirectory(savePath))
		{
			if (nowTime - FileSystem.stat(savePath + "/" + file).mtime.getTime() > maxLifeTimeMS)
			{
				FileSystem.deleteFile(savePath + "/" + file);
			}
		}
		*/
	}
	
	//---------------------------------------------------------------------------
	//---------------------------------------------------------------------------
	
	static private function dbCreateConnection(savePath:String) {
		var filename = savePath + '/' + sessionName + '.sqlite';
		cnx = Sqlite.open(filename);
	}
}

