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
import inkora.com.tween.TweenCube;
import nme.ObjectHash;

using inkora.com.core.TweenEngine.BoolTools;

class TweenCubeTimeline extends TweenEngine
{
	
	private var timelineTweens:ObjectHash<TweenEngine, Bool>;
	private var timelineObjAry:Array<TweensObj>;
	private var _repeatTimeline:Int;
	private var _reflect:Bool;
	private var framelabels:Dynamic;
	public var onStart:Dynamic->Void;
	//public var onChange:Dynamic->Void;
	public var onComplete:Dynamic->Void;
	public var onCompleteParams: Dynamic;
	
	public function new() {
		this.timelineTweens =  new ObjectHash<TweenEngine, Bool>();
		super(1, { autostart:false } );
		this.setFramerate(30);
		this.framelabels = { };
		timelineObjAry = [];
	}
	
	
	override private function updateTime(diffTime:Float) {	
		var isfinished:Bool;
		var diff:Float;
		playedTime += diffTime;
		
		var totalDuration:Float = (_loop << yoyo.toInt()) * duration;
		isfinished = (playedTime >= totalDuration && _loop > 0);
		
		if (isfinished){
			playedTime = totalDuration;
			tweenTime = (yoyo && !(_loop&1).toBool()) ? 0 : duration;
		}else{
			//playedTime < 0 means ==> delay     playedTime % duration ==>  0<= tweenTime <=duration; 
			tweenTime = (playedTime < 0) ? 0: playedTime % duration;
			if (yoyo && (Std.int(playedTime/duration)&1).toBool()) {tweenTime = duration - tweenTime;}
		}

		///
		
		for (tweenObj in timelineObjAry) {
			diff = this.tweenTime - tweenObj.startPos;

			if (diff >= 0) {
				
				diff = (diff>tweenObj.tween.duration)? tweenObj.tween.duration:diff;
				
				if (!tweenObj.timeline){	
					tweenObj.tween.renderTween(tweenObj.tween.ease(diff,0,1,tweenObj.tween.duration),false);
				} else {
					/*
					if (tweenObj.standalone){
					   if (!tweenObj.triggered) {
						  
						tweenObj.tween.playTimeline();
						tweenObj.triggered = true;
					   }
					}else{  
						tweenObj.tween.renderSubTimeline(diff);
					}
					*/
			   }
		   }			
			
		}
		
		//if (onChange != null) Reflect.callMethod(this, onChange, {});
		
		if (isfinished) { 
			active = false;
			tweenEnd();
		}
	}		
	
	override public function tweenEnd(){
		if (this.onComplete != null) {
			if (this.onCompleteParams == null) this.onCompleteParams = { };
			this.onCompleteParams.tween = this;
			this.onComplete(this.onCompleteParams);
		}			
	}
	
	public function renderSubTimeline(pTime:Float){
		this.playedTime = pTime;
		this.updateTime(0);			
	}
	
	public function playTimeline() {
		if (onStart != null) this.onStart( { } );
		this.play();
	}
	
	public function pauseTimeline() {
		this.pause();
	}

	public function resumeTimeline() {
		this.resume();
	}

	public function stopTimeline() {
		this.stop();
	}
	
	public function restartTimeline() {
		this.restart();
	}

	public function getRepeatTimeline():Int {
		  return _repeatTimeline;
	}
		
	public function setRepeatTimeline(val:Int) {
		this.setLoop(val);
		_repeatTimeline = val;
	}

	public function getReflect():Bool {
		return _reflect;
	}
	
	public function setReflect(val:Bool) {
		this.yoyo = val;
		_reflect = val;
	}

	public function setTimelineFrameRate(val:Float) {
		this.setFramerate(val);
	}

	public function setTimelineUseFrames(val:Bool) {
		this.useFrames = val;
	}	
	
	public function addTween(timelinePosition:Float, tween:TweenCube):TweenCube {
		if (tween == null) return null;
		var dur:Float = timelinePosition + tween.duration;
		tween.gotoBeginning();
		tween.setLoop(1);
		if (dur > this.duration) {
			this.duration = dur;
		}
		var tweensObj:TweensObj = {startPos:0, tween:null, timeline:false, triggered:false, standalone:false};
		tweensObj.startPos = timelinePosition;
		tweensObj.tween=tween;
		tweensObj.timeline = false;
		tweensObj.triggered = false;
		timelineObjAry.push(tweensObj);
		timelineObjAry.sort(function(a, b) { return Reflect.compare(a.startPos, b.startPos); } );			
		return tween;
	}		
	
	public function gotoAndPlay(pos:Float) {
		goto(pos);
		this.updateTime(0);
		if (!active) {
			this.play();
		} else {
			if (_paused) {
				this.resume();
			}
		};
	}

	public function gotoAndStop(pos:Float) {
		goto(pos);
		this.updateTime(0);
		//if (active) {
			this.stop();
		//}			
	}

	public function goto(pos:Float) {
		this.playedTime = pos;
	}		
	
}

typedef TweensObj = {
	startPos:	Float,
	tween: 		TweenCube,
	timeline: 	Bool,
	triggered: 	Bool,	
	standalone: Bool,
}