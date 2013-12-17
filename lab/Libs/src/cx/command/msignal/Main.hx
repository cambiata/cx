package cx.command.msignal;

import cx.TimerTools;
import haxe.Http;
import haxe.Timer;
import neko.Lib;
import sys.io.File;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{
	
	static function main() 
	{
		var url = 'https://maps.google.com/';
		var c:HttpCommand = new HttpCommand(url, function(data:String) { trace('Got some data! Length: ${data.length}'); }, function(msg:String) { trace('ERROR: ' + msg);} );
		c.addOnce(everythingComplete);
		c.start();
		
		/*
		//var c :SerialCommand = new SerialCommand([
		var c :ParallellCommand = new ParallellCommand([
			new ParameterCommand("TestABC"), 
			new ParameterCommand("Test123"),
			new DelayCommand(2000), 
			new DelayCommand(3000), 
			new DelayCommand(1000),
		]);
		c.addOnce(everythingComplete);
		c.start();
		*/
		
		Sys.stdin().readLine();
	}
	
	static private function everythingComplete() 
	{
		trace('***********************************************');
		trace('Everything complete');
	}
}

class ParameterCommand extends Command
{
	var param:String;
	public function new(param:String) { this.param = param; super(); }
	
	override public function execute()
	{
		trace('- ParameterCommand is executed with parameter "${this.param}"...');
		// so something...
		trace('- ParameterCommand completed!');
		this.complete();
	}
}

class DelayCommand extends Command
{
	private var delay:Int;
	public function new(delay:Int = 1000) { this.delay = delay;  super(); }
	
	override public function execute()
	{
		trace('* DelayCommand ($delay milliseconds delay) is executed...');
		TimerTools.delay(function() { 
			trace('* DelayCommand ($delay milliseconds delay) completed!'); 
			this.complete();  
		}, this.delay);
	}
}

class HttpCommand extends Command
{
	private var http:Http;
	private var callbackOnData:String -> Void;
	public function new(url:String, callbackOnData:String->Void, callbackOnError: String->Void) 
	{
		super();
		this.http = new Http(url);
		this.http.onData = this.onData;
		this.http.onError = callbackOnError;
		this.callbackOnData = callbackOnData;
	}
	
	private function onData(data:String)
	{
		this.callbackOnData(data);
		this.complete();
	}
	
	override public function execute()
	{
		this.http.request();
	}	
}