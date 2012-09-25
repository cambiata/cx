package smd.server.sxjs;

import cx.ArrayTools;
import cx.TimerTools;
import dtx.Tools;
import haxe.Firebug;
import haxe.Http;
import haxe.Log;
import haxe.Timer;
import haxe.TimerQueue;
import haxe.Unserializer;
import js.Dom;
import js.Lib;
import smd.server.sxjs.controller.AlertController;
import smd.server.sxjs.controller.ScorxlistController;
import smd.server.sxjs.controller.ScorxplayerController;
import smd.server.sxjs.widget.alert.Alert;
import smd.server.sxjs.widget.scorx.Scorxitem;
import sx.type.TListExamples;

using Detox;
class MainController
{
	private var ulScorxlist:DOMCollection;
	private var inputSearch:DOMCollection;
	private var searchTitle:String = '';
	private var listexamples:TListExamples;
	
	static function main() 
	{
		Log.trace = trace;
		var main = new MainController();
		Tools.window.onload = main.run;
	}

	public function new() {}
	
	
	private var scorxplayerController:ScorxplayerController;
	private var scorxlistController:ScorxlistController;
	
	private function run(e)
	{
		if ("#scorxlist".exists()) this.scorxlistController = new ScorxlistController(this);
		if ("#scorxplayer".exists() != null) this.scorxplayerController = new ScorxplayerController(this);		
	}
	
	public function testfunction(id:Int) {
		//trace(id);
		if (this.scorxplayerController != null) {
			this.scorxplayerController.loadPlayer(id);
		} else {
			Lib.alert('No ScorxplayerController');
		}
	}
	
	public function addLike(id:Int) {
		this.scorxlistController.addLike(id);
	}
	
	public static function trace(v : Dynamic, ?inf : haxe.PosInfos ) {
		var type = if( inf != null && inf.customParams != null ) inf.customParams[0] else null;
		if( type != "warn" && type != "info" && type != "debug" && type != "error" )
			type = if( inf == null ) "error" else "log";
		Lib.alert(inf.fileName + ":" + inf.lineNumber + " : " + Std.string(v));
	}	
	
	
	

}