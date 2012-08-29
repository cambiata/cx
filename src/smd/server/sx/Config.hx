package smd.server.sx;

/**
 * ...
 * @author Jonas Nyström
 */



class Config 
{

	static public var filesDir:String			= '../files/';
	static public var configFile:String 		= filesDir + 'main.conf'; 
	static public var test:String 				= 'DEFAULT TESTVALUE!';
	static public var templatesDir:String	= filesDir + 'templates/';
	static public var secretKey:String		= 'xyz';
	static public var guser = 'scorxmedia'; 
	static public var gpass = 'cambiata'; 
	
	static public var homedomain = 'scorx.xe';
	
	static public var authSqliteFile = 'data/access.sqlite';
	static public var loginSqliteFile = 'data/logins.sqlite';
	
	
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