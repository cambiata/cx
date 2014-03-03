package nx3.xamples.main.openfl;

import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import haxe.unit.TestRunner;
import nx3.elements.NBar;
import nx3.elements.NPart;
import nx3.elements.VTree;
import nx3.render.scaling.Scaling;
import nx3.render.scaling.TScaling;
import nx3.test.QVoice;
import nx3.test.TestN;
import nx3.test.TestQ;
import nx3.test.TestV;
import nx3.test.TestVRender;
import nx3.test.TestVRender.DevRenderer;



/**
 * ...
 * @author Jonas Nyström
 */

class Main extends OpenFlMain 
{
	
	override function start()
	{
		
		var renderer = new DevRenderer(this, Scaling.BIG);		
		
		var npart0 = new NPart([
			new QVoice([2], [-2]),
			new QVoice([.4, 8], [2, 2]),
		]);
		var npart1 = new NPart([
			new QVoice([8, .4], [-2, -2]),
			new QVoice([4, 4], [2, 2])
		]);
		
		var vbar = new VBar(new NBar([npart0, npart1]));
		
		//this.assertEquals(positionsColumns.keys().keysToArray().toString(), [0, 1512, 3024, 4536].toString());
		renderer.setDefaultXY(200, 80);
		renderer.drawVBarNotelines(vbar, 400, -30);
		renderer.drawVBarColumns(vbar);
		renderer.drawVBarComplexes(vbar);
		renderer.drawVBarVoices(vbar);	
	}
	
	static public function mainx() 
	{
		var runner = new  TestRunner(); 
		runner.add(new TestQ());
		runner.add(new TestN());
		runner.add(new TestV());
		runner.add(new TestVRender());
		var success = runner.run();
	}
	
}

class OpenFlMain extends Sprite
{
	var inited:Bool;
	
	function resize(e) 
	{
		if (!inited) init();
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		start();
	}
	
	function start()
	{
		throw "Should be overridden!";
	}

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new OpenFlMain());
	}	
	
	
}
