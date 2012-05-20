package cx.display;
/**
 * ...
 * @author Jonas Nyström
 */

import nme.display.Sprite;
import nme.events.MouseEvent;

class Handle extends Sprite {
	private var size:Float;
	private var dSize:Float;
	private var colorOut:Int;
	private var colorOver:Int;
	public var mouseDown:Bool;
	
	public function new(size:Float=4.0, colorOut:Int=0x00FF00, colorOver:Int=0xFF0000) {
		super();
		this.size = size;
		this.dSize = size * 2;
		this.colorOut = colorOut;
		this.colorOver = colorOver;
		
		this.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
		this.addEventListener(MouseEvent.ROLL_OUT, onRollOut);	
		
		this.repaint(colorOut);
	}
	
	private function onRollOver(event:MouseEvent) {
		this.repaint(this.colorOver);
	}
	
	private function onRollOut(event:MouseEvent) {
		this.repaint(this.colorOut);
	}
	
	private function repaint(color:Int) {
		this.graphics.lineStyle(1, 0x000000);
		this.graphics.beginFill(color);
		this.graphics.drawRect( -size, -size, dSize, dSize);		
	}
}