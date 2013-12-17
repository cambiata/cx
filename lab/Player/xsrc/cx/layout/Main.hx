package cx.layout.stablexui;

import cx.layout.LayoutHorizontal;
import cx.layout.LayoutManager;
import cx.layout.LayoutSprite;
import cx.layout.LayoutVertical;
import cx.layout.LayoutWidget;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.HBox;
import ru.stablex.ui.widgets.Text;
import ru.stablex.ui.widgets.Widget;

/**
 * ...
 * @author 
 */

class Main extends Sprite 
{
	var inited:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		var manager:LayoutManager = new LayoutManager();
		UIBuilder.init();
		
		// (your code here)
		
		var w:HBox = UIBuilder.create(HBox);
		w.top = 0;
		w.left = 0;
		w.w = 100;
		w.h = 100;
		
		var skin:Paint = new Paint();
		skin.color = 0xFF0000;
		skin.apply(w);
		
		w.skin = skin;		
		this.addChild(w);
		
		var w2:Text = UIBuilder.create(Text);
		w2.text = "Hello";
		w.addChild(w2);

		new LayoutWidget(manager, w, LayoutHorizontal.RIGHT_MARGIN(100), LayoutVertical.STRETCH_MARGIN(100, 5));
		
		var s:Sprite = new Sprite();
		s.graphics.beginFill(0x00FF00);
		s.graphics.drawRect(0, 0, 100, 100);
		this.addChild(s);
		new LayoutSprite(manager, s, LayoutHorizontal.STRETCH_MARGIN(20, 50), LayoutVertical.BOTTOM_MARGIN(10));
		manager.resize();		
	}

	/* SETUP */

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
		Lib.current.addChild(new Main());
	}
}
