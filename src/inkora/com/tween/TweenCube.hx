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

 
package inkora.com.tween;
import inkora.com.core.TweenEngine;
import nme.display.Sprite;

using inkora.com.core.TweenEngine.BoolTools;

class TweenCube extends TweenEngine
{

	public static var useAutoGC:Bool = false;
	public static var Framerate:Float = 30;
	public static var TRUE:Int = 1;
	public static var FALSE:Int = 2;
	public static var NONE:Int = 0;
	public static var REMOVEALL:Int = 1;
	public static var INTERRUPT:Int = 3;
	public static var COMPLETE:Int = 4;
	public static var SEQUENCE:Int = 5;
	public static var OverwriteMode:Int = NONE;
	public static var autoStartTweens:Int = NONE;
	
	private var inited:Bool;
	private var targetProps:Dynamic;
	private var _reverse:Bool = false;
	private var _reset:Bool = false;
	private var propertyList: Hash<Tweenable>;
	private var queueTween:TweenCube;
	private var lastqueuedTween:Bool = false;
	public var target:Dynamic;	
	public var autoStart:Bool;
	public var overwrite:Int;
	
	public var onComplete: Dynamic->Void;
	public var onCompleteParams: Dynamic;
	
	public function new(target:Dynamic = null, duration:Float=1, targetprops:Dynamic = null, tweenprops:Dynamic=null)
	{
		this.target = target;
		inited = false;
		_reset = true;
		super(duration, tweenprops);
		_reverse = (tweenProps.reverse)? tweenProps.reverse : false;
		autoStart = (tweenProps.autoStart != null) ? tweenProps.autoStart : true;
		if (TweenCube.autoStartTweens != TweenCube.NONE) {
			autoStart = (TweenCube.autoStartTweens == TweenCube.TRUE)? true:false;
		}
		
		this.onComplete = (tweenProps.onComplete) ? tweenProps.onComplete : null;		
		this.onCompleteParams = (tweenProps.onCompleteParams) ? tweenProps.onCompleteParams : {};
		
		this.setFramerate(Framerate);
		this.overwrite = (tweenProps.overwrite)? tweenProps.overwrite:TweenCube.OverwriteMode;
		checkOverwrite(this.target);
		this.targetProps = (targetprops != null) ? targetprops : { };
		if (autoStart) { this.play(); };
	}
	
	override public function renderTween(ratio:Float, finished:Bool) {
		if (!inited) { 
			init(); 
		}
		
		var value:Float = 0;
		for (prop in propertyList.keys()) {
			value = propertyList.get(prop).initVal + (propertyList.get(prop).rangeVal * ratio);
			var target:Dynamic = propertyList.get(prop).target;
			Reflect.setProperty(target, prop, value);
		}
		//if (this.tweenProps.onChange != null) {	this.tweenProps.onChange.apply(null,this.tweenProps.onChangeParams);}
	}
	
	override public function tweenEnd() {
		/*
		if (useAutoGC) {this.garbageCollect = true;}else{delete(TickerTweenList[this]);}
		*/
		if (this.tweenProps.onComplete != null){
			this.onCompleteParams.tween = this;
			this.onComplete(this.onCompleteParams);
		}
		
		TweenEngine.tickerTweenList.remove(this);
		
		if (this.queueTween != null){
			this.queueTween.invalidate();
			this.queueTween.play();
		}
	}	
	
	private function init() {
		if (_reset) {
			propertyList = new Hash<Tweenable>();
			_reset = false;
		}
		
		for (prop in Reflect.fields(this.targetProps)){
			var propVal = Reflect.getProperty(this.target, prop);
			var propsVal = Reflect.getProperty(targetProps, prop);
			var tweenable:Tweenable = getTweenable(this.target, prop, propVal, propsVal - propVal);
			propertyList.set(prop, tweenable); 
		}
		
		/// priority...
		
		/*
		var pr:Array = [];
		for (var props:String in propertyList){
			pr.push(propertyList[props]);
		}
		pr.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
		var t:Int = pr.length,i:Int = 0;
		propertyList = {};
		while(i < t){
			propertyList[pr[i].property] = pr[i];
			i++;
		}
		pr = null;
		*/
		
		/// reverse
		
		if (_reverse){
			for (prop in this.propertyList.keys()) {
				propertyList.get(prop).initVal += propertyList.get(prop).rangeVal;
				propertyList.get(prop).rangeVal = -propertyList.get(prop).rangeVal;				
				inited = true;
				renderTween(0, false);			
				trace([propertyList.get(prop).initVal, propertyList.get(prop).rangeVal]);
			}
		}
	 
		/*
		if (this.tweenProps.onInit != null){
			this.tweenProps.onInit.apply(null,this.tweenProps.onInitParams);
		}
		*/
		
		inited = true;
	}
	
	override public function invalidate()  {
		if (active){ this.pause(); }
		_reset = true;
		init();
		super.invalidate();
		if (active) { 
			this.resume();
		} else {
			this.play();
		}
	}	
	
	public function setProperty(pname:String, pval:Float) {
		/*
		this.targetProps[pname] = pval;
		this.invalidate();
		*/
	}	
	
	public function setProperties(pvals:Dynamic) {
		/*
		for (var prop:String in pvals){this.targetProps[prop] = pvals[prop];}
		this.invalidate();
		*/
	}	
	
	private function checkOverwrite(target:Dynamic) {
		var tweens:Array<TweenEngine>;
		var ret:Bool = false;
		
		if (!TweenEngine.tweenList.exists(target)) { TweenEngine.tweenList.set(this, []); return;  };
		
		var i:Int = 0;
		tweens = TweenEngine.tweenList.get(target);

		for (tween in TweenEngine.tweenList.keys()) {
			var tweenCube = cast(tween, TweenCube);
			switch (overwrite) {
				case TweenCube.INTERRUPT :
					tweenCube.stop();
					tweenCube.destroyTween();
				case TweenCube.COMPLETE :
					tweenCube.stop();
					tweenCube.gotoEnd();
					tweenCube.destroyTween();
				case TweenCube.SEQUENCE :
					if (tweenCube.queueTween == null) {
						tweenCube.queueTween = this;
						this.autoStart = false;
					}
				case TweenCube.REMOVEALL :
					tweenCube.stop();
					tweenCube.destroyTween();
				case TweenCube.NONE :
					if (tweenCube.ended) {
						tweenCube.destroyTween();
					}
			}
			if (!TweenEngine.tweenList.exists(target)) {
				TweenEngine.tweenList.set(target, [this]);
			} else {
				TweenEngine.tweenList.get(target).push(this);
			}
		}
	}	
	
	public function getTweenable(tgt:Dynamic,prop:String, initV:Float, rangeV:Float, prio:Int=0, isPlg:Bool = false, pType:String =""):Tweenable {
		return {target:tgt,property:prop,initVal:initV,rangeVal:rangeV,priority:prio,isPlugin:isPlg,propType:pType};
	}	
	
	
	private function destroyTween() 
	{
		var tgt:TweenEngine = this.target;
		var tweens:Array<TweenEngine>;
		tweens = TweenEngine.tweenList.get(tgt);
		var j = tweens.length;
		
		/*
		while (--j > -1) {
			
			if (TweenCube(tweens[j]) == this) { 
				delete(TickerTweenList[this]); 
				tweens.splice(j, 1); break; 
			}
		}	
		
		if (tweens.length == 0){delete(tweenList[tgt]);}
		*/
	}
	
	//------------------------------------------------------------------------------------------------------------------
	
	public static function to (target:Dynamic, duration:Float, targetprops:Dynamic, tweenprops:Dynamic=null):TweenCube {
		return new TweenCube(target, duration, targetprops, tweenprops);
	}
	 
	public static function from (target:Dynamic, duration:Float, targetprops:Dynamic, tweenprops:Dynamic=null):TweenCube {
		if (tweenprops == null) {tweenprops = {};}
		tweenprops.reverse = 1;
		return new TweenCube(target, duration, targetprops, tweenprops);
	}
	
	public static function timedCall (waitsecond:Float, onCompleteCallback:Dynamic->Void, onCompleteParams:Dynamic=null) {		
		var obj:Dynamic = {}; obj.x = 1; 
		new TweenCube(obj, waitsecond, {x:100},{onComplete:onCompleteCallback,onCompleteParams:onCompleteParams});		
	}
	
	public static function pauseAllTweens() {
		TweenEngine.pauseAllTweens = true;
	}

	public static function resumeAllTweens() {
		TweenEngine.pauseAllTweens = false;
	}

	public static function destroyTweensOf(target:Dynamic,complete:Bool=true) { 
		
		/*
		var tweens:Array;
		tweens = tweenList[target];
		if (!tweens) return;
		var i:Int = tweens.length;
		while ( --i > -1){
			if (TweenCube(tweens[i]).active){
			  if (complete){
				 TweenCube(tweens[i]).gotoEnd();
			  }else{
				  TweenCube(tweens[i]).stop(); 
			  }		
		} 
		TweenCube(tweens[i]).garbageCollect = true;
		TweenCube(tweens[i]).destroyTween();
			
		}
		*/
	}

	public static function destroyAllTweens(complete:Bool = true) {
		
		/*
		for (var key:Dynamic in tweenList){
			var tweens:Array;
			tweens = tweenList[key];
			var i:Int = tweens.length;
			while ( --i > -1){
				if (TweenCube(tweens[i]).active){
				  if (complete){
					TweenCube(tweens[i]).gotoEnd();
				  }else{
					TweenCube(tweens[i]).stop();   
				  }
				}
				TweenCube(tweens[i]).garbageCollect = true;
				TweenCube(tweens[i]).destroyTween();
				
			}
		}
		*/
	}
	
}


typedef Tweenable = {
	target:Dynamic,
	property:String,
	initVal:Float,
	rangeVal:Float,
	priority:Int,
	isPlugin:Bool,
	propType:String,
}