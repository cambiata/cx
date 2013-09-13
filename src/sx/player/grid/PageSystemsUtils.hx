package sx.player.grid;
import flash.display.Sprite;
import flash.geom.Rectangle;
import sx.player.grid.PageBars;

/**
 * ...
 * @author Jonas Nyström
 */
class PageSystemsUtils
{
	var target:Sprite;
	var pointer:Sprite;
	var orgTarget:Sprite;
	
	public function new() {}
	
	public function init(target:Sprite, orgTarget:Sprite)
	{
		this.target = target;		
		while (this.target.numChildren > 0) this.target.removeChildAt(0);		
		this.pointer = new Sprite();
		this.target.addChild(pointer);
		this.createPointer({x:10, y:10, height:100, pageIdx:0});
		this.orgTarget = orgTarget;		
		this.orgTarget.graphics.clear();
		this.orgTarget.graphics.beginFill(0x00FF00);
	}
	
	public function drawPageBars(pageBars:PageBars)
	{		
		clear(this.target);
		
		this.target.graphics.lineStyle(1, 0xAAAAAA);
		for (pageBar in pageBars)
		{
			var r = pageBar.rect.clone();
			r.inflate(1, 1);
			this.target.graphics.drawRect(r.x, r.y, r.width, r.height);			
		}
	}
	
	public function clear(target:Sprite)
	{
		this.target.graphics.clear();		
	}
	
	public function createPointer(pointerPosition:PointerPosition)
	{
		this.pointer.graphics.lineStyle(2, 0xFF0000, 0.5);
		this.pointer.graphics.moveTo(0, 0);
		this.pointer.graphics.lineTo(0, 100);
	}
	
	public function updatePointerPosition(x:Float, y:Float, height:Float) 
	{
		//this.target.graphics.moveTo(pointerPosition.x, pointerPosition.y);
		//this.target.graphics.lineTo(pointerPosition.x, pointerPosition.y + pointerPosition.height);
		this.pointer.x = x;
		this.pointer.y = y;		
		this.pointer.scaleY = height / 100;
	}
	
	private var currentNotPageIdx:Int = -2;
	public function drawOrgMasks(pageBars:PageBars, notPageIdx:Int, pageCoordinates:Map<Int, Rectangle>) 
	{
		//if (currentNotPageIdx == notPageIdx) return;
		this.currentNotPageIdx = notPageIdx;
						
		this.orgTarget.graphics.clear();
		this.orgTarget.graphics.beginFill(0xFF0000);		
		
		var keys = pageCoordinates.keys();
		for (key in keys)
		{
			if (key == notPageIdx) continue;
			var pageRect = pageCoordinates.get(key).clone();
			var radius = pageRect.width / 5;
			this.orgTarget.graphics.drawCircle(pageRect.x + (pageRect.width / 2), pageRect.y + (pageRect.height / 2), radius);
		}

	}
	
}