package sx.mvc.view;

import cx.flash.layout.DocumentLayout;
import cx.flash.ui.UIProgress;
import cx.TimerTools;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Point;
import ru.stablex.ui.widgets.Scroll;
import ru.stablex.ui.widgets.Widget;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Bmp;
import ru.stablex.ui.UIBuilder;
import flash.events.Event;

/**
 * ...
 * @author 
 */
class ScrollWidgetView extends Scroll
{
	public var widget(default, null): Widget;
	
	var pageSize:Point;
	var zoom:SxScrollZoom;	
	
	public function new() 
	{	
		super();
		
		this.zoom = SxScrollZoom.ZoomFullHeight;

		this.w = 500;
		this.h = 500;
		
		this.widget = UIBuilder.create(Widget);
		
		this.addChild(this.widget);
		createChildren();
		this.refresh();
		this.addEventListener(Event.ADDED, function(e)  { sx.mvc.app.AppView.REGISTER.dispatch(this); } );
		
	}
	
	override public function onInitialize() 
	{
		super.onInitialize();
		trace('on init');		
	}
	
	
	private function createChildren()
	{
		
	}
	
	public function skinMe()
	{
		/*
		var skin = new ru.stablex.ui.skins.Paint();
		skin.color = 0x00FF00;		
		skin.apply(this);
		*/
		
		var sliderSkin = new  ru.stablex.ui.skins.Paint();
		sliderSkin.color = 0xFF0000;
		sliderSkin.apply(this.vBar.slider);
		sliderSkin.apply(this.hBar.slider);

		var barSkin = new  ru.stablex.ui.skins.Paint();
		barSkin.color = 0x0000FF;
		barSkin.apply(this.vBar);		
		barSkin.apply(this.hBar);		
		this.vBar.visible = true;
		this.vBar.h = 0;
		this.vBar.w = 10;
		this.hBar.visible = true;
		this.hBar.h = 10;		
		this.hBar.w = 0;
		
		this.refresh();
		
	}
	
	/*
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
	*/
	
	public function afterResize(x:Float, y:Float, width:Float, height:Float) 
	{				
		TimerTools.timeout(function() {
			this.resize_(x, y, width, height);
		}, 200);	
	};	
	
	private function resize_(x:Float=0, y:Float=0, width:Float=0, height:Float=0) 
	{
		if (width == 0) width = this.w;
		if (height == 0) height = this.h;
		
		var size:Point = this.getZoomSize(this.zoom, width, height);			
		this.pageSize = DocumentLayout.arrange(widget, width, size.x, size.y);	
		this.refresh();			
	}
	
	private function getTest()
	{		
		var bmp:Bmp = UIBuilder.create(Bmp);
		var size:Point = getZoomSize(this.zoom, this.w, this.h);
		
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
		this.resize_();
	}	
	
	public function initPages(nrOfPages:Int) 
	{
		clearPages();
		for (i in 0...nrOfPages) widget.addChild(getTest());
		this.resize_(0, 0, this.w, this.h);
		widget.refresh();
	}
	
	public function clearPages()
	{
		while (widget.numChildren > 0) widget.removeChildAt(0);		
	}
	
	public function addPage(pageNr:Int, nrOfPages:Int, data:BitmapData) 
	{
		var size:Point = getZoomSize(this.zoom, this.w, this.h);
		
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
		if (this.zoom == null) this.zoom = SxScrollZoom.Zoom40;
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

 enum SxScrollZoom 
 {
	 ZoomFullWidth;
	 ZoomFullHeight;
	 Zoom40;
	 Zoom60;
	 Zoom80;	 
	 Zoom100;	 
 }
