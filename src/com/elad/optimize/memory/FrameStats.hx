/*
Copyright (c) 2009 Elad Elrom.  Elrom LLC. All rights reserved. 

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

@author  Elad Elrom
*/
package com.elad.optimize.memory;

 import flash.display.MovieClip;
 import flash.display.Shape;
 import flash.display.Sprite;
 import flash.events.Event;
 import flash.events.MouseEvent;
 import flash.events.TimerEvent;
 import flash.system.System;
 import flash.text.TextField;
 import flash.text.TextFormat;
 import flash.utils.Timer;
 import flash.Lib;
  
 //using primevc.utils.FloatUtil;
  using StringTools;


class FrameStats extends Sprite
{
	private static inline var LINE_GRAPH_STARTING_POINT_X:Int = 85;
	public static inline var WIDTH:Int = 200; 
	public static inline var HEIGHT:Int = 100;
	
	private var isShowCounters:Bool;
	private var isForceInvalidateAndUpdateAfterEvent:Bool;
	private var countSecondsSinceStart:Int;
	
	private var main:Sprite;
	
	// Enter frame
	private var frameActionsExecuted:Float;
	private var enterFrameCounter:Int;
	private var enterFrameTime:Float;
	
	// Enter frame constructed
	private var constructorCodeExecuted:Float;
	private var enterFrameConstructedCounter:Int;
	private var enterFrameConstructedTime:Float;
	
	// exit frame
	private var exitFrameCounter:Int;
	private var exitFrameTime:Float;
	
	// rendering
	private var playerRendersChangesDisplayList:Float;
	private var renderingCounter:Int;
	private var renderingTime:Float;
	
	// final code exec
	private var finalUserCodeExecuted:Float;
	private var isFinalUserCodeFirstTime:Bool;
	private var finalUserCodeTime:Float;
	private var firstFinalUserCodeTime:Float;
	
	// timer
	private var startTime:Float;
	private var timer:Timer;
	private var mouseEventCounter:Int;
	
	// charts colors
	private var colors:flash.Vector<Int>;
	
	// texts
	private var format:TextFormat;
	private var pieText:TextField;
	private var globalText:TextField;
	
	// graphs
	private var lineGraphCounter:Int;
	private var lineGraphs:flash.Vector<Sprite>;
	private var pieGraph:MovieClip;
	
	private var drawBackground (getDrawBackground, null)	: Sprite;
	
	
	// charts data provider
	private var dataProvider:flash.Vector<TimerVO>;

	public function new( main:Sprite, isShowCounters:Bool = false, 
								isForceInvalidateAndUpdateAfterEvent:Bool = false )
	{
		super();
		startTime = Lib.getTimer();
		timer = new Timer(1000);
		countSecondsSinceStart		= 0;
		isFinalUserCodeFirstTime	= false;
		colors				= new flash.Vector();
		lineGraphs			= new flash.Vector<Sprite>();
		lineGraphCounter	= 0;
		pieText				= new TextField();
		globalText			= new TextField();
		
		this.main = main;
		this.isShowCounters = isShowCounters;
		this.isForceInvalidateAndUpdateAfterEvent = isForceInvalidateAndUpdateAfterEvent;
		
		colors.push(0xe48701);
		colors.push(0xa5bc4e);
		colors.push(0x1b95d9);
		colors.push(0xcaca9e);
		
		addEventListener(Event.ENTER_FRAME, updateDisplay);
		
		setStyles();
		addChild( drawBackground );
		addChild( pieText );
		addChild( globalText );
		drawLineGraph();
		drawRects();
		
		timer.addEventListener( TimerEvent.TIMER, showResults );
		timer.start();
		synthesizesFrameRate();			
	}
	
	private inline function getDrawBackground():Sprite
	{
		var sprite:Sprite = new Sprite();
		sprite.graphics.beginFill(0x000025);
		sprite.graphics.drawRect(0, 0, WIDTH, HEIGHT);
		sprite.graphics.endFill();	
		
		return sprite;
	}
	
	private inline function drawRects():Void
	{
		var rectangle:Shape;
		var startY:Float = 66.5;
		
		for (color in colors) {
			startY += 6.1;
			rectangle = new Shape();
			rectangle.graphics.beginFill(color);
			rectangle.graphics.drawRect(0, 0, 5, 5);
			rectangle.graphics.endFill();
			rectangle.x = 0;
			rectangle.y = startY;
			
			addChild(rectangle);				
		}
	}
	
	private inline function drawLineGraph():Void
	{
		var item:Sprite;
		
		for (i in 0...4)
		{
			item = new Sprite();
			item.graphics.lineStyle( 1, colors[i] );
			item.graphics.moveTo( LINE_GRAPH_STARTING_POINT_X, 0 );
			
			lineGraphs.push( item );
			addChild( item );
		}
	}
	
	private inline function setTextProp( text:TextField, x:Int, y:Int, width:Int, height:Int ):Void
	{
		text.mouseEnabled = false;
		text.condenseWhite = true;
		text.selectable = false;
		text.multiline	= true;
		text.x = x;
		text.y = y;
		text.width = width;
		text.height = height;
		text.setTextFormat( format );
		text.defaultTextFormat = format;
	}
	
	private inline function updateDisplay( event:Event ):Void
	{
		if (dataProvider == null)
			return;
		
		var total:Float = 0;
		++lineGraphCounter;
		
		for (timerVO in dataProvider)
			total += timerVO.time;

		drawGraph( 25, dataProvider, total );
		updateLabels( dataProvider );
	}
	
	
	private inline function synthesizesFrameRate():Void
	{
		main.addEventListener(MouseEvent.MOUSE_MOVE,	mouseMoveHandler );
		main.addEventListener(Event.ENTER_FRAME,		enterFrameHandler );
		main.addEventListener(Event.FRAME_CONSTRUCTED,	frameConstructedHandler );
		main.addEventListener(Event.EXIT_FRAME,			exitFrameHandler);		
		main.addEventListener(Event.RENDER,				renderHandler);
	}	
	
	private inline function showResults(?event):Void 
	{
		++countSecondsSinceStart;

#if (debug && debugFrameStats)	
		trace("-------------- " + countSecondsSinceStart + " second ---------------");
		
		if (isShowCounters)
		{
			trace("------ counters -----");
			trace("enterFrameCounter: " + enterFrameCounter );
			trace("renderingCounter: "  + renderingCounter );
			trace("mouseEventCounter: "  + mouseEventCounter );
		}
#end
		
		enterFrameCounter = 0;
		mouseEventCounter = 0;
		renderingCounter = 0;
	}
	
	
	private inline function setNewDataProvider():Void
	{
		var total = constructorCodeExecuted + frameActionsExecuted + finalUserCodeExecuted + playerRendersChangesDisplayList;
		
		dataProvider = new flash.Vector<TimerVO>();
		dataProvider.push( new TimerVO("Constructor code executed",				(constructorCodeExecuted / total * 100 ).round(2) ));
		dataProvider.push( new TimerVO("frame actions executed",				(frameActionsExecuted / total * 100 ).round(2) ));
		dataProvider.push( new TimerVO("Final user code executed", 				(finalUserCodeExecuted / total * 100 ).round(2) ));
		dataProvider.push( new TimerVO("Player renders changes display list",	(playerRendersChangesDisplayList / total * 100 ).round(2) ));
	}		
	
	private inline function drawGraph( radius:Int, dataProvider:flash.Vector<TimerVO>, total:Float ):Void
	{
		if (pieGraph != null)
			removeChild( pieGraph );
			
		addChild( pieGraph = new MovieClip() );
		
		var numOfRadians:Float = 0;
		pieGraph.x = 30;
		pieGraph.y = 46;
		
		pieGraph.graphics.lineStyle( 1, 0x000000 );
		var radian:Float;
		var title:String;
		var index:Int = 0;
		
		for (timerVO in dataProvider)
		{
			// draw line graph
			if ( lineGraphCounter > WIDTH - LINE_GRAPH_STARTING_POINT_X )
				resetLineGraph();
				
			lineGraphs[index].graphics.lineTo( LINE_GRAPH_STARTING_POINT_X + lineGraphCounter , ( 100-dataProvider[index].time ) );
			
			// draw pie
			radian = timerVO.time / total * 2;
			title = timerVO.name;
			
			pieGraph.graphics.beginFill( colors[index] );
			pieGraph.graphics.moveTo( 0,0 );
			pieGraph.graphics.lineTo( Math.sin( numOfRadians * Math.PI ) * radius, Math.cos( numOfRadians * Math.PI ) * radius );
			
			var n:Float = 0;
			while (n <= radian) {
				pieGraph.graphics.lineTo( Math.sin( ( numOfRadians+n ) * Math.PI ) * radius, Math.cos( ( numOfRadians+n ) * Math.PI ) * radius );
				n += 0.0001;
			}
			
			numOfRadians += radian;
			pieGraph.graphics.lineTo( 0,0 );
			pieGraph.graphics.endFill();
			index++;
		}
	}
	
	private inline function resetLineGraph():Void
	{
		lineGraphCounter = 0;
		
		var index = 0;
		for (item in lineGraphs) {
			item.graphics.clear();
			item.graphics.lineStyle(1, colors[index]);
			item.graphics.moveTo(LINE_GRAPH_STARTING_POINT_X, 0);
			index++;
		}
	}
	
	private inline function setStyles():Void
	{
		format = new TextFormat("_sans", 7);
		format.leading = -2;
		setTextProp( globalText, 4, -2, 70, 30 );
		setTextProp( pieText, 4, 70, LINE_GRAPH_STARTING_POINT_X, 30 );
	}		
	
	private inline function updateLabels(dataProvider:flash.Vector<TimerVO>):Void
	{
		var pieTexts = [];
		pieTexts.push( '<font color="#'+colors[0].hex()+'">Constructor 2: '+ dataProvider[0].time + '</font>' );
		pieTexts.push( '<font color="#'+colors[1].hex()+'">Frame Actions: '+ dataProvider[1].time + '</font>' );
		pieTexts.push( '<font color="#'+colors[2].hex()+'">Final UserCode: '+ dataProvider[2].time + '</font>' );
		pieTexts.push( '<font color="#'+colors[3].hex()+'">Display changes: '+ dataProvider[3].time + '</font>' );
		
		var globalTexts = [];
		globalTexts.push( '<font color="#ffffff">FPS:  '+ stage.frameRate + '</font>' );
		globalTexts.push( '<font color="#ffffff">MEM:  '+ ( System.totalMemory * 0.000000954 ).round(2) + '</font>' );
		globalTexts.push( '<font color="#ffffff">TIME: '+ countSecondsSinceStart + '</font>' );
		
		globalText.htmlText	= globalTexts.join("\n<br>");
		pieText.htmlText	= pieTexts.join("\n<br>");
	}
	
	
	
	
	
	
	
	private function mouseMoveHandler (event) {
		mouseEventCounter++;
		finalUserCodeTime = Lib.getTimer() - startTime;
		
		if ( renderingTime != 0 && isFinalUserCodeFirstTime )
		{
			isFinalUserCodeFirstTime = false;
			firstFinalUserCodeTime = Lib.getTimer()-startTime;
		}

#if (debug && debugFrameStats)
		trace("MouseEvent.MOUSE_MOVE");
#end
		
		if (isForceInvalidateAndUpdateAfterEvent)
		{
			stage.invalidate();
			event.updateAfterEvent();					
		}
	}
	
	private function enterFrameHandler (event) {
		isFinalUserCodeFirstTime = true;
		
		enterFrameCounter++;
		enterFrameTime = Lib.getTimer() - startTime;
		
		finalUserCodeExecuted = finalUserCodeTime-firstFinalUserCodeTime;
		playerRendersChangesDisplayList = enterFrameTime-finalUserCodeTime;					
		
#if (debug && debugFrameStats)
		trace("Final user code executed: " + String( finalUserCodeExecuted ) );
		trace("Player renders changes display list: " + String( playerRendersChangesDisplayList ) );
		trace("Event.ENTER_FRAME");
#end
		
		setNewDataProvider();
	}
	
	private function frameConstructedHandler (event) {
		enterFrameConstructedCounter++;
		enterFrameConstructedTime = Lib.getTimer() - startTime;
		constructorCodeExecuted = enterFrameConstructedTime-enterFrameTime;
		
#if (debug && debugFrameStats)
		trace("Constructor code of children executed: " + String( constructorCodeExecuted ) );
#end
	}
	
	private function exitFrameHandler (event) {
		exitFrameCounter++;
		exitFrameTime = Lib.getTimer() - startTime;
		frameActionsExecuted = exitFrameTime-enterFrameConstructedTime;	

#if (debug && debugFrameStats)
		trace("frame actions & children executed: " + String( frameActionsExecuted ) );
#end
	}
	
	private function renderHandler (event) {
		renderingCounter++;
		renderingTime = Lib.getTimer() - startTime;
#if (debug && debugFrameStats)
		trace("Event.RENDER");
#end
	}
}


class TimerVO
{
	public var name	: String;
	public var time	: Float;
	
	
	public function new (name, time) {
		this.name = name;
		this.time = time;
	}
}