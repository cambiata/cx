package inkora.com;
import cx.KeyboardTools;
import inkora.com.core.TweenEngine;
import inkora.com.easing.Back;
import inkora.com.easing.Bounce;
import inkora.com.easing.Elastic;
import inkora.com.easing.Exponential;
import inkora.com.easing.Linear;
import inkora.com.tween.TweenCube;
import inkora.com.tween.TweenCubeTimeline;
import nme.display.Shape;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.Lib;

/**
 * ...
 * @author Jonas Nyström
 */

class UsageExample 
{

	static public function example() {
		
		var tl = new TweenCubeTimeline();
		
		Lib.stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e) {
			var keyCode = KeyboardTools.getKeyCode(e);
			trace(keyCode);			
			switch(keyCode) {
				case 65: tl.pauseTimeline();
				case 83: tl.resumeTimeline();
				case 68: tl.restartTimeline();
				case 70: tl.gotoAndPlay(0);
				case 71: tl.gotoAndStop(1);
				case 72: tl.gotoAndPlay(4);
			}
		});
		
		var s:Sprite = new Sprite();
		s.graphics.beginFill(0xFF0000);
		s.graphics.drawRect(0, 0, 30, 30);		
		s.x = 10;
		s.y = 20;
		Lib.current.addChild(s);
		
		var s2:Sprite = new Sprite();
		s2.graphics.beginFill(0x0000FF);
		s2.graphics.drawRect(0, 0, 30, 30);
		s2.x = 150;
		s2.y = 80;		
		Lib.current.addChild(s2);			
		 
		tl.addTween(0, TweenCube.to(s, 2, { x:50, y:100 }, { reverse:false,  ease:Exponential.easeInOut} ));
		tl.addTween(1, TweenCube.to(s2, 4, { x:10, y:10 }, { reverse:false,  } ));
		tl.onComplete = function(params) {
			trace('timeline complete!');
			trace(params);
		}
		tl.play();		
		
		/*
		TweenCube.to(s, 2, { x: 200, y:100 }, { delay: 0, reverse: false, ease:Linear.ease, loop:1, yoyo:false, timeScale:1, onComplete:function(params) {			
			trace(params);
		}, onCompleteParams: {name:'Jonas', age:45}} );
		*/
		//TweenCube.to(s2, 3, { x:10, y:10 }, {reverse: false } );
		/*
		TweenCube.timedCall(1, function(p) { 
			trace('-- timed call'); 
			trace(p);
		} );
		*/		
		
		
	}		

	
}