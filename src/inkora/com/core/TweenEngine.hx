/**
 * TweenCube v1.25 by inkora Jan 12, 2010
 * 
 * Visit blog.inkora.com for documentation, updates and more free code.
 *
 *
 * Copyright (c) 2010 inkora
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 **/


package inkora.com.core;
import nme.display.Shape;
import nme.events.Event;
import nme.Lib;
import nme.ObjectHash;
 
class BoolTools {
	static public function toInt(bool:Bool) {
		return (bool)  ? 1 : 0;
	}
	
	static public function toBool(int:Int) {
		return (int == 0) ? false : true;
	}

	static public function floatToBool(float:Float) {
		return (float == 0) ? false : true;
	}
	
}
 
using inkora.com.core.TweenEngine.BoolTools;
class TweenEngine 
{

	
	public static var version:Float = 1.25;
	
	private static var shape:Shape;
	
	private static var tickerTweenList:ObjectHash<TweenEngine, Dynamic> = new ObjectHash<TweenEngine, Dynamic>();
	
	
	public static var tweenList:ObjectHash<TweenEngine, Array<TweenEngine>>= new ObjectHash<TweenEngine, Array<TweenEngine>>();
	
	private static var GCframeCount:Float = 0;
	
	private static var pauseAllTweens:Bool= false;
	
	private var garbageCollect:Bool;
	
	private var time:Float;
				
	private var _paused:Bool;
	
	private var _delay:Float;
	
	private var _currentPosition:Float;
	
	private var frameratio:Float;
	
	private var _loop:Int;
	
	private  var _framerate:Float;
	
	private var tweenProps:Dynamic;
	
	private var playedTime:Float;
	
	private var tweenTime:Float;
	
	private var ended:Bool;
	/**
	 * The length of the tween in seconds.
	 **/
	public var duration:Float;
	/**
	 * The easing function to use for calculating the tween. Default value is <code>linear</code>
	 **/
	public var ease:Float->Float->Float->Float->Float;
	/**
	 * If true, changes can be set in frames. If false, they are specified in seconds.
	 **/
	public var useFrames:Bool;
	/**
	 * Allows you to scale the time for a tween. For example, a tween with a duration of 3 seconds, and a timeScale of 2 will complete in 1.5 seconds.
	 * With a timeScale of 0.5 the same tween would complete in 6 seconds.
	 **/
	public var timeScale:Float;
	
	public var ratio:Float;
	/**
	 *  If yoyo is set to true, then the tween will play backwards on every other loop.
	 **/
	public var yoyo:Bool;
	
	public var data:Dynamic;
	
	/** Indicates whether the tween is active. The tween is active when it begins to play and it is inactive when it is finished**/
	public var active:Bool;	

	
	
	
	public function new(duration:Float= 1, tweenprops:Dynamic = null)
	{
		if (!StartedEngine) StartEngine();
		
		this.duration = duration;
		this.tweenProps = (tweenprops != null) ? tweenprops : {};
		
		this._delay = (tweenProps.delay != null) ? tweenProps.delay : 0;
		this.useFrames = (tweenProps.useFrames != null) ? tweenProps.useFrames : false;
		this.timeScale = (tweenProps.timeScale != null) ? tweenProps.timeScale : 1;
		this.ease = (tweenProps.ease != null) ? tweenProps.ease : linear;
		this._loop = (tweenProps.loop != null) ? tweenProps.loop : 1;
		this.yoyo = (tweenProps.yoyo != null) ? tweenProps.yoyo : false;
		this.playedTime = (this._delay == 0) ? 0 : -this._delay;
		this.active = false;
		//this.tickerTweenList = new ObjectHash<Dynamic, Dynamic>();
	}	
	
	public function play() {
		//trace('play');
		tickerTweenList.set(this, true);
		this.time = Lib.getTimer() * 0.001;
		this._paused = false;
		this.active = true;
	}	
	
	public function pause() {
		//delete(TickerTweenList[this]);
		//trace('pause');
		tickerTweenList.remove(this);
		this._paused = true;
	}	
	
	public function resume() {
		//trace('resume');
		if (_loop != 0 && playedTime >= _loop * duration) {	reset(); }
		tickerTweenList.set(this, true);
		time = Lib.getTimer() * 0.001;
		_paused = false;
	}
		
	public function restart(widthdelay:Bool=false) {
		garbageCollect = false;
		playedTime = (widthdelay) ? -_delay:0;
		play();
	}

	public function stop() {
		//delete(TickerTweenList[this]);
		tickerTweenList.remove(this);
		active = false;
	}

			
	private function reset() {   
		tweenTime = ratio = 0;
		playedTime = -_delay;
	}	
	
	//private var updateTime(default, set_updateTime) :Float;
	private function updateTime(diffTime:Float) {	
		
		//trace('haxe update time');
		if (garbageCollect || pauseAllTweens){return; }
		
		var isfinished:Bool;
		playedTime += diffTime;
		
		var totalDuration:Float = (_loop << yoyo.toInt()) * duration;
		//trace('haxe totalDuration' + totalDuration);
		
		isfinished = (playedTime >= totalDuration && _loop > 0);
		
		//trace('haxe isfinished ' + isfinished);
		
		if (isfinished){
			playedTime = totalDuration;
			tweenTime = (yoyo && !(_loop&1).toBool()) ? 0 : duration;
		}else{
			//playedTime < 0 means ==> delay     playedTime % duration ==>  0<= tweenTime <=duration; 
			tweenTime = (playedTime < 0) ? 0: playedTime % duration;
			if (yoyo && (Std.int(playedTime/duration)&1).toBool()) {tweenTime = duration - tweenTime;}
		}
		
		ratio = (duration == 0 && playedTime >= 0) ? 1 : ease(tweenTime, 0, 1, duration);
		
		renderTween(ratio,isfinished);
		if (isfinished) { 
			active = false;
			ended = true;
			tweenEnd();
		}
	}	
	
	public function renderTween(ratio:Float, finished:Bool) {
		//Main time handling override extending class
	}

	public function tweenEnd() {
		//Tween end handling override extending class
	}	

	private function invalidate() {
		if (playedTime > 0) { playedTime = 0; }
		garbageCollect = false;
	}	
	
	public function getFramerate():Float
	{
		return _framerate;
	}

	public function setFramerate(val:Float)
	{
		frameratio = 0.03/(30/val);
		_framerate = val;
	}
	

	public function getDelay():Float {
		return _delay;
	}
	public function setDelay(value:Float) {
		if (playedTime <= 0) {
			playedTime = -value;
		}
		_delay = value;
	}
	public function getLoop():Int {
		return _loop;
	}
	public function setLoop (val:Int) {
		_loop = val;
	}	

	public function gotoBeginning()  {
		playedTime = 0;
		pause();
	}

	public function gotoEnd()  {
		playedTime = (_loop > 0) ? _loop * duration : duration;
	}
	
	
	public static function linear(t:Float, b:Float, c:Float, d:Float):Float {
		return t/d;
	}	
	
	private static var StartedEngine:Bool = false;
	
	private static function StartEngine() {
		//trace('startEngine');
		shape = new Shape();
		#if (!flash)
		Lib.current.addChild(shape);
		#end
		shape.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		
	}
	
	private static function onEnterFrame (evt:Event) {
		//trace('onEnterFrame');
		GCframeCount++;
		var newtime:Float = Lib.getTimer() * 0.001;
		var tween:TweenEngine;
		var diff:Float;
		
		for (tween in tickerTweenList.keys()) {
			diff = newtime - tween.time;
			tween.time = newtime; 
			
			/// HMMM... this.active ?
			if (tween.active) 			
				tween.updateTime ((tween.useFrames ? tween.frameratio : diff) * tween.timeScale);			
		}
		
		
		/*
		if (GCframeCount % 60==0) {
			var tar:Object;
			var tweens:Array, j:int;
			for (tar in tweenList) {
				tweens = tweenList[tar];
				j = tweens.length;
				j = tweens.length;
				while (--j > -1) {if (TweenEngine(tweens[j]).garbageCollect) {delete(TickerTweenList[tweens[j]]);tweens.splice(j, 1);}
					if (tweens.length == 0) {delete tweenList[tar];}
				}
		
			}
		}
		*/
		
	}	
	
}
