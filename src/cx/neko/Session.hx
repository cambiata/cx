package cx.neko;
import cx.FileTools;
import haxe.Serializer;
import haxe.Unserializer;
import neko.FileSystem;

class Session {
	private static var sessionData : Hash<Dynamic>;
	private static var started:Bool;
	private static var dirty:Bool;
	private static var SID : String = 'NEKOSESSIONID';
	
	public static var sessionName(default, setName) : String;
	public static function setName(name : String) {
		if (started) throw "Can't set name after Session start.";
		sessionName = name;
		return name;
	}

	
	private static var sessionExpire:Int = 1; // Minutes
	public static function setSessionExpire(mins:Int):Int {
		return sessionExpire = mins;
	}
	
	private static var id:String = null; // neko.Sys.getEnv('COMPUTERNAME');
	public static function getId() : String return id
    public static function setId(value : String) : String{
		if( started ) throw "Can't set id after Session.start";
		id = value;
		return id;
    }

	private static var savePath:String = 'session/';
    public static function getSavePath() : String return savePath
    public static function setSavePath(path : String) : String {
        if(started) throw "You can't set the save path while the session is already in use";
        savePath = path;
        return path;
    }
  
	public static function getSessionAge():Float {
		if (!FileSystem.exists(getFilename())) return -1 ;
		var filestat = FileSystem.stat(getFilename());
		return ((Date.now().getTime() - filestat.atime.getTime()) / 1000) / 60;
	}
	
    public static function get(name : String) : Dynamic {
        start();
        return sessionData.get(name); 
    }    
    public static function set(name : String, value : Dynamic) {        
		start();
        dirty = true;
        sessionData.set(name, value);
		//trace(sessionData);
    }	
	
	private static function start() {
		if (started) return;		
		if (sessionName == null) sessionName = SID;
		if (sessionExpire == null) sessionExpire = 60;
		if (sessionData == null) sessionData = new Hash<Dynamic>();

		
		
		if (id == null) {
			var cookies = Web.getCookies();
			id = cookies.get(sessionName);
		}		
		
		if (id == null) {
			var params = Web.getParams();
			id = params.get(sessionName);
		}		
		

		
		if (id != null) {
			//-----------------------------------------------------------
			// Remove session file if too old
			if (FileSystem.exists(getFilename())) {
				if (getSessionAge() > sessionExpire) {
					//trace('delete ' + getFilename());
					FileSystem.deleteFile(getFilename());				
				}
			}
			
			//-----------------------------------------------------------
			// Load session data
			if (FileSystem.exists(getFilename())) {			
				loadSessionData();
			}
		}
		
		if( id==null )
		{
			//trace("no id found, creating a new session.");
			sessionData = new Hash<Dynamic>();
			
			id = getUniqueId();
			
			// TODO: Set cookie path to application path, right now it's global.
			Web.setCookie(SID, id);
			//Web.setCookie(SID, id, null, null, '/');
			
			started = true;
			saveSessionData();
		}		
		started = true;
	}
	
	static private function getFilename() {
		return savePath + id + '.session';	
	}
	
	private static function saveSessionData(){
		if( !started ) return;
		//trace(sessionData);
		FileTools.putContent(getFilename(), Serializer.run(sessionData));				
	}
	
	private static function loadSessionData() {
		sessionData = Unserializer.run(FileTools.getContent(getFilename()));
		//trace(sessionData);
	}
	
    public static function close() {
		if (dirty) saveSessionData();
        started = false;
    }	
	
	public static function clear() {
		if (FileSystem.exists(getFilename())) FileSystem.deleteFile(getFilename());
		started = false;
	}
	
	private static function getUniqueId():String {
		var filename:String;
		do {
			var id = haxe.Md5.encode(Std.string(Math.random() + Math.random()));
			 filename = savePath + id + '.session';
		} while(neko.FileSystem.exists(filename));		
		return id;
	}
	
  
}
