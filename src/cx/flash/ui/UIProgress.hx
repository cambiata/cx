package cx.flash.ui;
import cx.TimerTools;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.Point;
import haxe.Timer;

/**
 * ...
 * @author 
 */

 using cx.flash.graphic.GraphicTools;
 
class UIProgress extends Sprite
{
	public function new(x:Float, y:Float, width:Float, height:Float, backColor:UInt = 0x555555, frontColor:UInt = 0xFF0000, initValue:Float = 0, lineThickness:Float = 6 ) 
	{
		super();
		
		this.w = width;
		this.h = height;

		this.lineThickness = lineThickness;
		this.backColor = backColor;
		this.frontColor = frontColor;		
		
		
		this.drawBack();
		
		this.frontSprite = new Sprite();
		this.frontSprite.rotation = GraphicTools.CIRCLE_SEGMENT_ROTATE;
		this.addChild(this.frontSprite);
		
		this.frontSprite.graphics.lineStyle(lineThickness, frontColor);				
		
		segmentPoint =  new Point(0, 0);
		segmentRadius = width / 2;
		
		this.value = 0;
		this.spin();
		
		this.frontSprite.x = width / 2;
		this.frontSprite.y = height / 2;
		this.x = x;
		this.y = y;
	}	
	
	private function drawBack()
	{
		this.graphics.lineStyle(lineThickness, backColor);
		this.graphics.endFill();
		this.graphics.drawEllipse(0, 0, this.w, this.h);						
	}
	
	public var value(get, set):Float;
	private var value_:Float = 0;
	var frontSprite:Sprite;
	static var SEGMENT_MAX = 6.3;
	var segmentPoint:Point;
	var segmentRadius:Float;
	var lineThickness:Float;
	var backColor:UInt;
	var frontColor:UInt;
	var w:Float;
	var h:Float;	
	
	
	private function get_value():Float
	{
		return this.value_;
	}
	
	private function set_value(val:Float):Float
	{
		
		this.frontSprite.graphics.clear();		
		
		if (val > 1) val = val % 1;
		//trace(val);
		var segValue:Float =val * GraphicTools.CIRCLE_SEGMENT_MAX;		
		//trace(segValue);
		
		this.frontSprite.graphics.lineStyle(lineThickness, frontColor);		
		this.frontSprite.graphics.drawCircleSegment(segmentPoint, 0, segValue, segmentRadius);
		
		this.value_ = val;		
		return this.value_;		
	}
	
	var v:Float = 0;
	var spinTimer:Timer;
	public function spin(ms:Int=20)
	{
		this.spinStop();
		this.show();
		this.spinTimer = TimerTools.timer(function() {
			v += 0.03;
			if (v > 1) 
			{
				var c = this.frontColor;
				this.frontColor = this.backColor;
				this.backColor = c;
				this.drawBack();
				v = 0;
			}
			this.value = v;
		}, ms);
	}
	
	public function hide()
	{		
		this.spinStop();
		this.value = 0;
		this.frontSprite.graphics.clear;
		this.graphics.clear;
	}
	
	public function show(val:Float=0)
	{
		this.drawBack();
		this.value = val;
	}
	
	public function spinStop()
	 {
		 if (this.spinTimer != null) 
		 {
			 this.spinTimer.stop();
		 }
	 }
	
	
}