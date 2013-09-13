package scorx.model;
import cx.TimerTools;
import flash.geom.Rectangle;
import scorx.data.GridProc;
import sx.player.grid.PageBar;
import sx.player.grid.PageSystemsUtils;
import msignal.Signal.Signal1;

/**
 * ...
 * @author Jonas Nyström
 */

 class PlayPositionInfo
 {
	public var pos:Float;
	public var sender:Dynamic;
	public var pageIdx:Int;
	 
	public function new(pos:Float, sender:Dynamic, pageIdx:Int)
	{
		this.pos = pos;
		this.sender = sender;
		this.pageIdx = pageIdx;
	}
	 
	 
 }
 
 
class PlayPosition
{

	@inject public var gridProc:GridProc;
	@inject public var pageSystemUtils:PageSystemsUtils;
	
	public var positionSignal:Signal1<PlayPositionInfo>;
	private var sender:Dynamic;
	
	public function new() 
	{
		this.positionSignal = new Signal1<PlayPositionInfo>();
		
		TimerTools.timer(function()
		{
			if (this.pageBar == null) return;
			if (this.currentPos != this.prevPos) this.positionSignal.dispatch(new PlayPositionInfo(this.currentPos, this.sender, this.pageBar.pageIdx));
			this.prevPos = this.currentPos;			
		}, 1000) ;
	}
	
	private var prevPageIdx:Int = 0;
	private var prevSysIdx:Int = 0;
	private var prevBarIdx:Int = 0;
	private var pageBar:PageBar;
	private var currentPos:Float = 0;
	private var prevPos:Float = 0;
	
	public function setPosition(currentPos:Float, sender:Dynamic) 
	{		
		if (this.gridProc.pageBars == null) return;
		this.sender = sender;
		this.currentPos = currentPos;
		this.pageBar = gridProc.findPageBarFromPos(currentPos);		
		pageSystemUtils.updatePointerPosition(pageBar.deltaX, pageBar.rect.y, pageBar.rect.height);	
	}
	
	public function getPosition():Float
	{
		return this.currentPos;
	}
	
	
	private function checkScroll() 
	{
		if (this.pageBar == null) return;
		if (this.viewPort == null) return;
		
		var nextBar:PageBar = (this.pageBar.barIdx < gridProc.pageBars.length) ? gridProc.pageBars[this.pageBar.barIdx + 1] : this.pageBar;
		var vPort:Rectangle = this.viewPort.clone();
		var thisBarRect:Rectangle = this.pageBar.rect.clone();
		thisBarRect.offset(this.scrollX, this.scrollY);
		trace(thisBarRect);
		
		if (! vPort.containsRect(thisBarRect))
		{
			if (thisBarRect.y < vPort.y) {
				trace('Kan inte se toppen');
				this.scroll(0, thisBarRect.y);
			}
			if (thisBarRect.y + thisBarRect.height > vPort.y + vPort.height) trace('Kan inte se botten');
		}
	}
	
	dynamic public function scroll(x:Float, y:Float)
	{
		
		
	}

	private var viewPort:Rectangle;
	private var scrollX:Float;
	private var scrollY:Float;
	
	public function setViewPort(viewPort:Rectangle, scrollX:Float, scrollY:Float)
	{
		this.viewPort = viewPort;
		this.scrollX = scrollX;
		this.scrollY = scrollY;
	}
	
	private function viewportCanContainsRects(vPort:Rectangle, rect1:Rectangle, rect2:Rectangle)
	{
		var rect3:Rectangle = rect1.union(rect2);		
		trace(vPort);
		trace(rect3);
		return vPort.containsRect(rect3);
	}
	
	
}