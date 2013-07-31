package scorx.setup;
import cx.layout.Horizontal;
import cx.layout.LayoutManager;
import cx.layout.SpriteItem;
import cx.layout.UIManager;
import cx.layout.Vertical;
import cx.layout.WidgetItem;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.StageDisplayState;
import flash.Lib;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.HBox;
import ru.stablex.ui.widgets.Scroll;
import ru.stablex.ui.widgets.Widget;
import scorx.ui.SxScroll;
import sx.data.ImageLoaderExt;
import sx.data.ScoreLoader;

/**
 * ...
 * @author 
 */
class UITest extends UIManager
{
	public function new() 
	{
		super();
		
		/*
		var footer:Sprite = new Sprite();
		footer.graphics.beginFill(0xDDDDDD);
		footer.graphics.drawRect(0, 0, 100, 10);
		footer.width = 100;
		footer.height = 10;			
		this.manager.add(new SpriteItem(footer, Horizontal.STRETCH, Vertical.BOTTOM));
		this.addChild(footer);
		*/
		
		var sxScroll:SxScroll = new SxScroll();
		var scroll:Scroll = sxScroll.getScroll();
		this.addChild(scroll);
		var item:WidgetItem = new WidgetItem(scroll, Horizontal.STRETCH_MARGIN(0, 0), Vertical.STRETCH_MARGIN(0, 0));
		item.afterResize = sxScroll.afterResize;
		this.manager.add(item);
		
		var btnFullscreen:Button = UIBuilder.create(Button);
		btnFullscreen.text = 'F';
		btnFullscreen.h = 40;
		btnFullscreen.w = 40;
		this.addChild(btnFullscreen);
		this.manager.add(new WidgetItem(btnFullscreen, Horizontal.RIGHT_MARGIN(0), Vertical.TOP_MARGIN(10)));
		btnFullscreen.onPress = function(e) Lib.current.stage.displayState = (Lib.current.stage.displayState == StageDisplayState.NORMAL) ? StageDisplayState.FULL_SCREEN : StageDisplayState.NORMAL;		
		
		var btnZoom40:Button = UIBuilder.create(Button);
		btnZoom40.text = '40';
		btnZoom40.h = 40;
		btnZoom40.w = 40;
		this.addChild(btnZoom40);		
		this.manager.add(new WidgetItem(btnZoom40, Horizontal.RIGHT_MARGIN(0), Vertical.TOP_MARGIN(60)));
		btnZoom40.onPress = function(e) sxScroll.setZoom(SxScrollZoom.Zoom40);
		
		var btnZoomFullHeight:Button = UIBuilder.create(Button);
		btnZoomFullHeight.text = 'Height';
		btnZoomFullHeight.h = 40;
		btnZoomFullHeight.w = 40;
		this.addChild(btnZoomFullHeight);		
		this.manager.add(new WidgetItem(btnZoomFullHeight, Horizontal.RIGHT_MARGIN(0), Vertical.TOP_MARGIN(110)));
		btnZoomFullHeight.onPress = function(e) sxScroll.setZoom(SxScrollZoom.ZoomFullHeight);
		
		
		
		
		this.manager.resize();		
		
		
		
		var loader = new ScoreLoader(Config.productId, Config.userId);
		
		sxScroll.initPages(5);
		
		//loader.loadPages(ScoreLoadingType.thumb);
		loader.onPageLoaded = function(pageNr:Int, nrOfPages:Int, data:BitmapData, type:String)
		{
			switch (pageNr)
			{
				case 0:
					sxScroll.initPages(nrOfPages);
				default:
					sxScroll.addPage(pageNr, nrOfPages, data);
			}
		}		
		
		
	}
	

	
}