package ex;

import haxe.crypto.Md5;
import haxe.ds.StringMap.StringMap;
import haxe.Log;
import haxe.web.Dispatch;
import haxe.web.Request;
import sys.db.TableCreate;

import neko.Lib;
import neko.Web;
import sys.db.Manager.Manager;
import sys.db.Object;
import sys.db.Sqlite;
import sys.db.Types;


class SessionManager
{
	public static var session	: Session;
	public static var sessions	: StringMap<Session>;

	static var debug = "";
	
	public static var COOKIE_NAME = "cxtest";	
	public static var DEFAULT_LANG = "fr";
	
	static public function init()
	{
		Manager.cnx	= Sqlite.open('test3.sqlite');
		Manager.initialize();
		
		try
		{
			sessions = Session.all();
		}
		catch ( e : Dynamic ) 
		{
			sys.db.TableCreate.create(User.manager);
			sys.db.TableCreate.create(Session.manager);
			TableCreate.create(Log.manager);
			
			var u = new User();
			u.login	= "jonas";
			u.pass	= Md5.encode( 'jonas' ); 
			u.level	= 1;
			u.insert();			
			
			var u = new User();
			u.login	= "admin";
			u.pass	= Md5.encode( 'admin' ); 
			u.level	= 10;
			u.insert();
			sessions	= new StringMap();
		}	
	}

	static public function current()
	{
		var sid	= Web.getCookies().get( COOKIE_NAME );
		if ( sid == null ) 
		{
			sid	= Md5.encode( Std.string( Math.floor( Math.random() * 100000 ) ) );
			session			= new Session( sid );
			session.lang	= DEFAULT_LANG;
			sessions.set( sid, session );
			debug += "1:" + Std.string(session.history);
			Session.commit( session );
			var log = new Log();
			log.data = 'Cookie not found, Session created ' + sid;
			log.insert();
		} 
		else 
		{
			session	= sessions.get( sid );
			
			debug += "2:" + sid;
			if ( session == null ) {
				debug += "3:" + 'null';
				sid	= Md5.encode( Std.string( Math.floor( Math.random() * 100000 ) ) );
			
				session			= new Session( sid );
				session.lang	= DEFAULT_LANG;
				sessions.set( sid, session );
				Session.commit( session );

				var log = new Log();
				log.data = 'Cookie found but not session. New session created ' + sid;
				log.insert();			
				
			} else {
				var log = new Log();
				log.data = 'Cookie found and Session found ' + sid;
				log.insert();			
				
			}
			
		}

		Web.setCookie( COOKIE_NAME, sid, null, null, "/" );
		//session.history.push( { date : Date.now().getTime(), uri : uri, params : params } );
		
	}

	static public function close()
	{
		Manager.cnx.close();		
	}
	
	static public function commit()
	{
		Session.commit(session);
	}
	
}

class Main
{

	/*
	public static var session	: Session;
	public static var sessions	: StringMap<Session>;

	public static var COOKIE_NAME = "cxtest";	
	public static var DEFAULT_LANG		= "fr";
	*/
	
	static public var debug:Array<String> = [];
	public static var ctx		: Dynamic;
	
	
	static function main()
	{
		SessionManager.init();
		SessionManager.current();
	
		var uri		= Request.getURI().split( 'index.n' ).join( '' );
		var params	= Request.getParams();		
		
		ctx = {
			BASE_DIR	: Web.getCwd(),
			URI			: uri,
			SESSION		: SessionManager.session,
			PARAMS		: params,
			DATE		: {
				fromTime	: Date.fromTime,
			},
			DATE_TOOLS	: {
				format	: DateTools.format,
			}
		}

		// Get previous context
		if ( SessionManager.session.ctx != null ) {
			for ( key in Reflect.fields( SessionManager.session.ctx ) ) {
				Reflect.setField( ctx, key, Reflect.getProperty( SessionManager.session.ctx, key ) );
			}
			SessionManager.session.ctx	= null;
			SessionManager.commit();
		}		
		
		
		
		var wd	= new Dispatch( uri, Request.getParams() );
		try {
			wd.onMeta = function( meta : String, mparams : Array<Dynamic> ) 
			{
				debug.push('meta ' + meta);
				switch( meta ) 
				{			
					case "validPattern"	:
						var errors	= [];
						for ( mparam in mparams ) {
							var r	= new EReg( mparam.pattern, mparam.opt );
							if ( !r.match( params.get( mparam.arg ) ) ) {
								errors.push( mparam.arg );
							}
						}
						if ( errors.length > 0 )	throw( AEValidPattern( errors ) );
						
					case "level"	:
						if ( SessionManager.session.user != null && SessionManager.session.user.level >= Std.parseInt( mparams[ 0 ] ) ) {
							
						}else {
							throw AELevel;
						}
					
				}
			}
			wd.dispatch( new Api() );
		} 
		catch ( e : ApiError ) {
			switch( e ) {
				case AELevel	:
					SessionManager.session.ctx	= { INFO : { css : "error", text : "no authorization" } };
					//redirect();
					debug.push('no auth');
					
				case AEValidPattern( args )	: 
					SessionManager.session.ctx	= {
						INFO	: { css : "error", text : "invalidData" },
						PARAMS	: Web.getParams()
					}
					for ( arg in args ) {
						var upperCase	= arg.toUpperCase();
						Reflect.setField( SessionManager.session.ctx, upperCase + "_ERROR", true );
					}
					//redirect();
					debug.push('invalid data');
			}
		}catch ( e : DispatchError ) {
			switch( e ) {
				case DENotFound(_), DETooManyValues, DEMissing, DEInvalidValue	:
					
					SessionManager.session.ctx	= { INFO : { css : "error", text : "warning404" } };
					debug.push('warning404');
					redirect();
					
				case DEMissingParam(_)	:
					SessionManager.session.ctx	= { INFO : { css : "error", text : "invalidData" } };
					debug.push('invalidData');
					//redirect();
			}
		}	
		
		//trace(SessionManager.session.ctx);
		
		SessionManager.close();
		
	}
	
	public static function redirect( ?uri : String ) {
		if( uri == null )	uri	= Web.getClientHeader( "referer" );
		if ( uri == null )	uri	= "/";
		//Session.commit( SessionManager.session );
		//trace(SessionManager.session.ctx);
		SessionManager.commit();
		Web.redirect( uri );
	}		

			
	
}


class Mainx 
{
	public static var BASE_DIR			= Web.getCwd();
	public static var COOKIE_NAME		= "haxite_sid";
	public static var DB_NAME			= "haxite";
	public static var DEFAULT_LANG		= "fr";
	public static var SESSION_DELAY		= 3600;
	
	public static var sessions	: StringMap<Session>;
	public static var session	: Session;
	public static var ctx		: Dynamic;

	static function main() 
	{
		var debug = "";
		var uri		= Request.getURI().split( 'index.n' ).join( '' );
		var params	= Request.getParams();
		
		Manager.cnx	= Sqlite.open('test.sqlite');
		Manager.initialize();

		try
		{
			sessions	= Session.all();
		}
		catch ( e : Dynamic ) 
		{
			sys.db.TableCreate.create(User.manager);
			sys.db.TableCreate.create(Session.manager);
			var u = new User();
			u.login	= "admin";
			u.pass	= "21232f297a57a5a743894a0e4a801fc3"; // MD5 for "admin"
			u.level	= 10;
			u.insert();
			sessions	= new StringMap();
			Web.logMessage( "[haxite] database's tables and default admin account created (pass=admin)" );		
		}
		
		var sid	= Web.getCookies().get( COOKIE_NAME );
		if ( sid == null ) 
		{
			sid	= Md5.encode( Std.string( Math.floor( Math.random() * 100000 ) ) );
			session			= new Session( sid );
			//session.lang	= DEFAULT_LANG;
			sessions.set( sid, session );
			debug += "1:" + Std.string(session.history);
			
		} else {
			session	= sessions.get( sid );
			debug += "2:" + sid;
			if ( session == null ) {
				debug += "3:" + 'null';
				sid	= Md5.encode( Std.string( Math.floor( Math.random() * 100000 ) ) );
				session			= new Session( sid );
				
				//session.lang	= DEFAULT_LANG;
				sessions.set( sid, session );
			}
		}
		Web.setCookie( COOKIE_NAME, sid, null, null, "/" );
		//session.history.push( { date : Date.now().getTime(), uri : uri, params : params } );
		Session.commit( session );
		
		ctx = {
			BASE_DIR	: BASE_DIR,
			URI			: uri,
			SESSION		: session,
			PARAMS		: params,
			DATE		: {
				fromTime	: Date.fromTime,
			},
			DATE_TOOLS	: {
				format	: DateTools.format,
			}
		}

		// Get previous context
		if ( session.ctx != null ) {
			for ( key in Reflect.fields( session.ctx ) ) {
				Reflect.setField( ctx, key, Reflect.getProperty( session.ctx, key ) );
			}
			session.ctx	= null;
			Session.commit( session );
		}

		var wd	= new Dispatch( uri, Request.getParams() );
		try {
			wd.onMeta = function( meta : String, mparams : Array<Dynamic> ) {
			}
			wd.dispatch( new Api() );
		} 
		catch ( e : ApiError ) 
		{
			trace("api error");
		}
		catch ( e : DispatchError ) 
		{
			trace("dispatch error");
		}
			
		// Cleanup
		Manager.cnx.close();		
	}
	
	public static function redirect( ?uri : String ) {
		if( uri == null )	uri	= Web.getClientHeader( "referer" );
		if ( uri == null )	uri	= "/";
		SessionManager.commit();
		Web.redirect( uri );
	}	

	
	
}


typedef Stamp = {
	public var date		: Float;
	public var uri		: String;
	public var params	: StringMap<String>;
}

class Session extends Object{
	
	public var id		: SId;
	public var sid		: SString<32>;
	public var ip		: SString<15>;
	@:relation( uid )
	public var user		: SNull<User>;
	public var lang		: SString<2>;
	public var ctx		: SNull<SData<Dynamic>>;
	public var history	: SData<Array<Stamp>>;
	
	public static function all( lock = true ) {
		var h	= new StringMap();
		for ( sess in manager.all( lock ) ) {
			h.set( sess.sid, sess );
		}
		return h;
	}
	
	public static function commit( session : Session ) {

		if ( session.id != null ) {
			session.update();
		}else {
			session.insert();
		}
	}
	
	public function new( sid : String ) {
		super();
		this.sid 	= sid;
		ip			= Web.getClientIP();
		history		= [];
		// needed to initialize default serialized data value "null"
		ctx			= null;
	}
}

class User extends Object
{
	
	public var id		: SId;
	public var login	: SString<32>;
	public var pass		: SString<32>;
	public var level	: SInt;
			
	public function new() {
		super();
		level	= 0;
	}
	
}

class Log extends Object
{
	public var id:SId;
	public var data:SString<64>;
}

enum ApiError {
	AELevel;
	AEValidPattern( args : Array<String> );
}

class Api
{
	public function new()
	{
		
	}
	
	public function doDefault( d : Dispatch ) {
		var part = d.parts[ 0 ];
		switch( part ) {
			case ""	:
				doHome();
			default	:
				throw DENotFound( part );
		}
	}
	
	public function doHome() {
		trace('<hr/>');
		trace("home");
		trace(SessionManager.session.user);
		trace(SessionManager.session.ctx);
		
		for (str in Main.debug) Lib.println(str + '<br/>');
	}
	
	
	
	@validPattern( 
		{ arg : "login", pattern : ".{4,}", opt : "" },
		{ arg : "pass", pattern : ".+", opt : "" }
	)
	public function doLogin( args : { login : String, pass : String } ) {
		
		var user	= User.manager.select( $login == $ { args.login } && $pass == $ { Md5.encode( args.pass ) } );
		//trace(user);
		if ( user != null ) {
			//trace(user.login);
			SessionManager.session.user	= user;
			//trace(user.login);
			//Main.redirect( "/admin" );
			Main.redirect();
		}else {
			//trace('user = null');
			SessionManager.session.ctx	= { 
				INFO 	: {	css	: "error", text	: "Wrong login" },
				PARAMS	: Web.getParams()
			};
			Main.redirect();
			//trace('wroing');
		}
		
		trace('Login');
		
	
	}
	
	public function doLogout() {
		
		SessionManager.session.user	= null;
		Main.redirect( "/home" );
		
		//trace('Logout');
	}
	
	
	
}
