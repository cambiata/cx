/**
 * ...
 * @author Andreas Söderlund
 */
package neko;

import haxe.Serializer;
import haxe.Unserializer;
import neko.FileSystem;
import neko.io.File;
import neko.Web;

using StringTools;

class Session
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
	
	static var sessionData : Hash<Dynamic>;
	static var needCommit : Bool;

	static function __init__()
	{
		gcStartChance = 0.01;
		gcMaxLifeTime = 60 * 60 * 24;
		
		started = false;
		sessionName = 'NEKOSESSIONID';
	}

	public static function setSavePath(path:String) : Void
	{
		path = path.replace("\\", "/");
		if (path.endsWith("/"))
		{
			path = path.substr(0, path.length - 1);
		}
		savePath = path;
	}
	
	public static function get(name:String) : Dynamic
	{
		start();
		return sessionData.get(name);
	}

	public static function set(name : String, value : Dynamic)
	{
		start();
		needCommit = true;
		sessionData.set(name, value);
	}

	public static function exists(name : String)
	{
		start();
		return sessionData.exists(name);
	}

	public static function remove(name : String)
	{
		start();
		needCommit = true;
		sessionData.remove(name);
	}

	public static function start()
	{
		if (started) return;
		
		needCommit = false;
		
		if (savePath == null)
		{
			savePath = Web.getCwd().replace("\\", "/");
			if (!savePath.endsWith("/")) savePath += "/";
			savePath += 'temp/sessions';
		}

		if (!FileSystem.exists(savePath))
		{
			throw 'Neko session savepath not found: ' + savePath;
		}
		
		if (Math.random() < gcStartChance)
		{
			collectGarbage();
		}
		
		id = Web.getCookies().get(sessionName);

		if (id != null)
		{
			if (~/^[a-zA-Z0-9]+$/.match(id))
			{
				var file = savePath + "/" + id + ".sess";
				if (!FileSystem.exists(file))
				{
					id = null;
				}
				else
				{
					var fileData = try File.getContent(file) catch ( e:Dynamic ) null;
					if (fileData == null)
					{
						id = null;
						try FileSystem.deleteFile(file) catch( e:Dynamic ) null;
					}
					else
					{
						sessionData = Unserializer.run(fileData);
					}
				}
			}
			else 
			{
				id = null;	
			}
		}
		
		if (id == null)
		{
			sessionData = new Hash<Dynamic>();
			
			while (true)
			{
				id = haxe.Md5.encode(Std.string(Math.random()) + Std.string(Math.random()));
				if (!FileSystem.exists(savePath + "/" + id + ".sess")) break;
			}
			
			Web.setCookie(sessionName, id, null, null, '/');
			
			started = true;
			commit();
		}
		
		started = true;
	}

	public static function clear()
	{
		sessionData = new Hash<Dynamic>();
	}
	
	public static function close()
	{
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
		if (!started) return;
		
		try
		{
			var w = File.write(savePath +"/" + id + ".sess", true);
			w.writeString(Serializer.run(sessionData));
			w.close();
		}
		catch (e:Dynamic)
		{
			// Session is gone, ignore it.
		}
	}
	
	static function collectGarbage()
	{
		var nowTime = Date.now().getTime();
		var maxLifeTimeMS = gcMaxLifeTime * 1000;
		
		for (file in FileSystem.readDirectory(savePath))
		{
			if (nowTime - FileSystem.stat(savePath + "/" + file).mtime.getTime() > maxLifeTimeMS)
			{
				FileSystem.deleteFile(savePath + "/" + file);
			}
		}
	}
}

