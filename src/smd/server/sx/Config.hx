package smd.server.sx;
import neko.Web;

/**
 * ...
 * @author Jonas Nyström
 */



class Config 
{

	static public var test:String 				= 'DEFAULT TESTVALUE!';

	static public var homedomain 			= 'scorx.xe';

	static public var filesDir:String			= Web.getCwd() + '../files/';
	
	static public var tmpDir:String			= Web.getCwd() + 'tmp/';
	
	
	static public var configFile:String 		= filesDir + 'main.conf'; 
	static public var dataDir:String			= filesDir + 'data/';
	static public var smdDir:String			= filesDir + 'smd/';
	static public var templatesDir:String	= filesDir + 'templates/';
	static public var contentDir:String		= filesDir + 'content/';
	static public var documentDir:String	= filesDir + 'documents/';
	

	static public var scorxDir:String 		= filesDir + 'scorx/';
	
	
	static public var authSqliteFile 			= dataDir + 'access.sqlite';
	static public var loginSqliteFile 			= dataDir + 'logins.sqlite';	
	
	static public var authFile					= smdDir + 'auth.list';
	static public var loginFile					= smdDir + 'login.list';
	
	static public var secretKey:String		= 'xyz';
	
	static public var guser 						= 'scorxmedia'; 
	static public var gpass 					= 'cambiata'; 
	
	
	static public var indexPage: String 	= Config.templatesDir + 'index.html'; 	
	static public var scorxlistPage: String= Config.templatesDir + 'scorxlist.html'; 	
	
	static public var likesFile					= smdDir + 'likes.txt';
	static public var commentsFile			= smdDir + 'comments.txt';
	static public var commentsDateFile	= smdDir + 'commentsdate.txt';
	
	/*
	static public var authFile:String 		= '../files/auth/auth.dat';

	static public var cacheDir:String 		= '../files/cache/';
	static public var sessionDir:String 		= '../files/session/';
	static public var docsDir:String 			= '../files/_docs/';
	static public var templateDir:String	= '../files/tpl/';
	
	static public var scorxroot:String 		= 'D:/test';
	static public var scorxdirs:String 		= '';	
	static public var scorxlistFilename:String = 'scorxlist.dat';	
	*/
	
	//static public var authFilename:String = 'autentisering.dat';
}