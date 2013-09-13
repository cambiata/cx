package sx.mvc.view;

import cx.flash.layout.DocumentLayout;
import cx.flash.ui.UIProgress;
import cx.TimerTools;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Mouse;
import ru.stablex.ui.widgets.Scroll;
import ru.stablex.ui.widgets.Widget;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Bmp;
import ru.stablex.ui.UIBuilder;
import flash.events.Event;
import sx.mvc.view.enums.ScrollWidgetZoom;
import sx.player.grid.PageBars;
import sx.player.grid.PageSystems;
import sx.player.grid.PageSystemsUtils;

/**
 * ...
 * @author 
 */
class ScrollWidgetView extends Scroll
{
	public var widget(default, null): Widget;
	public var gridOverlay(default, null): Widget;
	public var orgOverlay(default, null): Widget;
	public var pagesOverlay(default, null): Widget;
	
	
	var pageSize:Point;
	var zoom:ScrollWidgetZoom;		
	
	public function new() 
	{	
		super();
		
		
		this.w = 500;
		this.h = 500;
		
		this.zoom = ScrollWidgetZoom.ZoomFullHeight;
		
		this.widget = UIBuilder.create(Widget);
		
		this.pagesOverlay = UIBuilder.create(Widget);
		this.widget.addChild(this.pagesOverlay);
		this.doubleClickEnabled = true;
		this.pagesOverlay.doubleClickEnabled = true;
		this.pagesOverlay.addEventListener(MouseEvent.DOUBLE_CLICK, function(e:MouseEvent) {
			trace('double');
			this.handleMouseDoubleClick(this.pagesOverlay.mouseX, this.pagesOverlay.mouseY);
		});		
		
		
		/*
		this.pagesOverlay.graphics.beginFill(0x00FF00);
		this.pagesOverlay.graphics.drawRect(0, 0, 400, 400);		
		*/
		
		this.gridOverlay = UIBuilder.create(Widget);
		this.widget.addChild(this.gridOverlay);
		
		this.orgOverlay = UIBuilder.create(Widget);
		this.widget.addChild(this.orgOverlay);

				
		
		/*
		this.gridOverlay.graphics.beginFill(0x0000FF);
		this.gridOverlay.graphics.drawRect(0, 0, 300, 300);		
		*/
		
		this.addChild(this.widget);
		
		//createChildren();
		addSkin();
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
	
	public function addSkin()
	{
		
		var skin = new ru.stablex.ui.skins.Paint();
		skin.color = 0x00FF00;		
		//skin.apply(this);
		this.skin = skin;
		this.applySkin();
		
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
		
		this.w = width;
		this.h = height;
		
		var size:Point = this.getZoomSize(this.zoom, width, height);			
		
		var docInfo:DocInfo = DocumentLayout.arrange(this.pagesOverlay, width, size.x, size.y);			
		this.widget.w = docInfo.holderRect.width;
		this.widget.h = docInfo.holderRect.height;		
		this.pageSize = docInfo.pageSize;			
		
		this.gridOverlay.x = this.pagesOverlay.x;
		this.gridOverlay.w = this.pagesOverlay.w;
		this.gridOverlay.h = this.pagesOverlay.h;
			
		this.orgOverlay.x = this.pagesOverlay.x;		
		this.orgOverlay.w = this.pagesOverlay.w;
		this.orgOverlay.h = this.pagesOverlay.h;
		
		/*	
			var pageBars:PageBars = gridProcessor.getPageBars(documentInfo);			
			PageSystemsUtils.drawPageBars(this.gridOverlay, pageBars);
		*/
		this.afterReziseGrid(this.gridOverlay, docInfo);
		
		this.refresh();	
	}
	
	dynamic public function afterReziseGrid(gridOverlay:Widget, docInfo:DocInfo)
	{
		trace('AFTER RESIZE GRID');
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

	public function setZoom(zoom:ScrollWidgetZoom)
	{
		this.zoom = zoom;		
		this.scrollY = 0;
		this.resize_();
	}	
	
	public function initPages(nrOfPages:Int) 
	{		
		clearPages();
		//for (i in 0...nrOfPages) widget.addChild(getTest());
		for (i in 0...nrOfPages) this.pagesOverlay.addChild(getTest());
		this.pagesOverlay.refresh();
		this.resize_(0, 0, this.w, this.h);
		
		
		widget.refresh();
	}
	
	public function clearPages()
	{
		//while (widget.numChildren > 0) widget.removeChildAt(0);		
		while (this.pagesOverlay.numChildren > 0) this.pagesOverlay.removeChildAt(0);
	}
	
	public function addPage(pageNr:Int, nrOfPages:Int, data:BitmapData) 
	{
		var size:Point = getZoomSize(this.zoom, this.w, this.h);
		
		var bmp = cast(this.pagesOverlay.getChildAt(pageNr), Bmp);		
		bmp.bitmapData = data;
		bmp.w = size.x;
		bmp.h = size.y;
		
		/*
		bmp.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent) {			
			this.handleMouseDown(pageNr, e.localX, e.localY);
		});
		*/
		
		bmp.doubleClickEnabled = true;
		
		var child : DisplayObject = this.pagesOverlay.getChildAt(pageNr);
		child.width = size.x;
		child.height = size.y;
		
		bmp.removeChildAt(0);
		bmp.removeChildAt(0);
		
	}
	
	dynamic public function handleMouseDoubleClick(x:Float, y:Float)
	{
		trace('handleMouseDown');
	}
	
	private function getZoomSize(zoom: ScrollWidgetZoom, width:Float, height:Float):Point
	{
		var w:Float = 1;
		var h:Float = 1;
		if (this.zoom == null) this.zoom = ScrollWidgetZoom.Zoom40;
		switch(this.zoom)
		{
			case ScrollWidgetZoom.ZoomFullHeight:
				h = Math.max(297, Math.min(891, height-20));
				w = (210 / 297) * h;
			case ScrollWidgetZoom.ZoomFullWidth:
				w = Math.max(210, Math.min(630, width-20));
				h = (297 / 210) * w;	
			case ScrollWidgetZoom.Zoom40:
				w = 630 * 0.4;
				h = 891 * 0.4;
			case ScrollWidgetZoom.Zoom60:
				w = 630 * 0.6;
				h = 891 * 0.6;
			case ScrollWidgetZoom.Zoom80:
				w = 630 * 0.8;
				h = 891 * 0.8;
			case ScrollWidgetZoom.Zoom100:
				w = 630 ;
				h = 891;					
			//default:
		}				
		return new Point(w, h);
	}
}

/*
 enum SxScrollZoom 
 {
	 ZoomFullWidth;
	 ZoomFullHeight;
	 Zoom40;
	 Zoom60;
	 Zoom80;	 
	 Zoom100;	 
 }
*/