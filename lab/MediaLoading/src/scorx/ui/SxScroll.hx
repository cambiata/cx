package scorx.ui;
import cx.flash.layout.DocumentLayout;
import cx.flash.ui.UIProgress;
import cx.TimerTools;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Point;
import openfl.Assets;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Bmp;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Scroll;
import ru.stablex.ui.widgets.Widget;
import scorx.ui.SxScroll.SxScrollZoom;

/**
 * ...
 * @author 
 */

 enum SxScrollZoom 
 {
	 ZoomFullWidth;
	 ZoomFullHeight;
	 Zoom40;
	 Zoom60;
	 Zoom80;	 
	 Zoom100;	 
 }
 
 
class SxScroll
{
	var widget:Widget;
	var scroll:Scroll;
	var pageSize:Point;
	var zoom:SxScrollZoom;

	public function new()
	{
		this.zoom = SxScrollZoom.ZoomFullHeight;
	}
	
	public function getScroll():Scroll
	{
		widget = UIBuilder.create(Widget);
		widget.w = 100;
		widget.h = 100;
		
		scroll = UIBuilder.create(Scroll, { children: [
			widget,
		] } );		
		
		//widget.addChild(getTest());		
		
		scroll.refresh();
		return scroll;		
	}
	
	public function afterResize(x:Float, y:Float, width:Float, height:Float) 
	{
		TimerTools.timeout(function() {
			this.resize(x, y, width, height);
		}, 200);
	};	
	
	private function resize(x:Float=0, y:Float=0, width:Float=0, height:Float=0) 
	{
		if (width == 0) width = this.scroll.w;
		if (height == 0) height = this.scroll.h;
		
		var size:Point = this.getZoomSize(this.zoom, width, height);			
		this.pageSize = DocumentLayout.arrange(widget, width, size.x, size.y);	
		this.scroll.refresh();			
	}
	
	private function getTest()
	{		
		var bmp:Bmp = UIBuilder.create(Bmp);
		var size:Point = getZoomSize(this.zoom, this.scroll.w, this.scroll.h);
		
		var s:Sprite = new Sprite();
		bmp.addChild(s);
		s.graphics.beginFill(0xDDDDDD);
		s.graphics.drawRect(0, 0, size.x, size.y);		
		
		var child : DisplayObject = bmp;
		bmp.w = s.width = child.width = size.x;
		bmp.h = s.height = child.height = size.y;		
		
		var progress:UIProgress = new UIProgress(10, 10, 50, 50, 0xEEEEEE, 0xCCCCCC, 0, 6);
		progress.spin();
		bmp.addChild(progress);
		return bmp;
	}

	public function setZoom(zoom:SxScrollZoom)
	{
		this.zoom = zoom;
		this.resize();
	}	
	
	public function initPages(nrOfPages:Int) 
	{
		clearPages();
		for (i in 0...nrOfPages) widget.addChild(getTest());
		this.resize(0, 0, scroll.w, scroll.h);
		widget.refresh();
	}
	
	public function clearPages()
	{
		while (widget.numChildren > 0) widget.removeChildAt(0);		
	}
	
	public function addPage(pageNr:Int, nrOfPages:Int, data:BitmapData) 
	{
		var size:Point = getZoomSize(this.zoom, this.scroll.w, this.scroll.h);
		
		var bmp = cast(widget.getChildAt(pageNr-1), Bmp);		
		bmp.bitmapData = data;
		bmp.w = size.x;
		bmp.h = size.y;
		
		var child : DisplayObject = widget.getChildAt(pageNr-1);
		child.width = size.x;
		child.height = size.y;
		
		bmp.removeChildAt(0);
		bmp.removeChildAt(0);
	}
	
	
	private function getZoomSize(zoom: SxScrollZoom, width:Float, height:Float):Point
	{
		var w:Float = 1;
		var h:Float = 1;
		switch(this.zoom)
		{
			case SxScrollZoom.ZoomFullHeight:
				h = Math.max(297, Math.min(891, height-20));
				w = (210 / 297) * h;
			case SxScrollZoom.ZoomFullWidth:
				w = Math.max(210, Math.min(630, width-20));
				h = (297 / 210) * w;	
			case SxScrollZoom.Zoom40:
				w = 630 * 0.4;
				h = 891 * 0.4;
			case SxScrollZoom.Zoom60:
				w = 630 * 0.6;
				h = 891 * 0.6;
			case SxScrollZoom.Zoom80:
				w = 630 * 0.8;
				h = 891 * 0.8;
			case SxScrollZoom.Zoom100:
				w = 630 ;
				h = 891;					
			//default:
		}				
		return new Point(w, h);
	}
	
	
	
	
	
}