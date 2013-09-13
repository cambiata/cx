package scorx.view;
import cx.TimerTools;
import flash.display.BitmapData;
import flash.geom.Rectangle;
import player.controller.Setzoom;
import ru.stablex.ui.events.ScrollEvent;
import ru.stablex.ui.events.WidgetEvent;
import scorx.controller.LoadPages;
import scorx.data.GridLoader;
import scorx.data.GridProc;
import scorx.data.PagesLoader;
import scorx.model.PlayPosition;
import sx.mvc.view.enums.ScrollWidgetZoom;
import sx.mvc.view.HBoxView;
import sx.mvc.view.ScrollWidgetView;
import sx.player.grid.PageBar;
import sx.player.grid.PointerPosition;

import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Widget;
import cx.flash.layout.DocumentLayout.DocInfo;
import sx.player.grid.PageBars;	
import sx.player.grid.PageSystemsUtils;	
import sx.player.grid.GridSystems;
import scorx.model.PlayPosition.PlayPositionInfo;

/**
 * ...
 * @author 
 */
class PagesView extends ScrollWidgetView
{
	public var btnStart:Button;
	override public function createChildren() 
	{	

	}	
}

class PagesMediator extends mmvc.impl.Mediator<PagesView>
{
	var pageBars:PageBars;
	var docInfo:DocInfo;
	
	@inject public var pagesLoader:PagesLoader;
	@inject public var gridLoader:GridLoader;
	@inject public var setzoom:Setzoom;
	@inject public var gridProc:GridProc;
	@inject public var pageSystemUtils:PageSystemsUtils;
	@inject public var playPosition:PlayPosition;
	
	
	override function onRegister()
	{
		this.view.addEventListener(WidgetEvent.SCROLL_STOP, function(e:WidgetEvent) {
			playPosition.setViewPort(new Rectangle(0, 0, this.view.w, this.view.h), this.view.scrollX, this.view.scrollY);
		});		

		
		mediate(pagesLoader.result.add(function (result:PagesResult){ 	
			switch(result)
			{
				case PagesResult.started(nrOfPages):
					Debug.log('PagesMediator is notified :loadPages.started... $nrOfPages');			
					this.view.initPages(nrOfPages);				
				case PagesResult.success(pageNr, nrOfPages, data):
					this.view.addPage(pageNr, nrOfPages, data);				
				case PagesResult.complete(nrOfPages):
					this.view.afterResize(0, 0, 0, 0);
					/*
					gridProc.init();
					pageSystemUtils.init(this.view.gridOverlay, this.view.orgOverlay);
					playPosition.setViewPort(new Rectangle(0, 0, this.view.w, this.view.h), this.view.scrollX, this.view.scrollY);
					*/
				case PagesResult.error(message, url):
					trace([message, url]);
				
			}
		}));
		
		gridLoader.result.add(function(result:GridResult) {
			switch(result)
			{
				case GridResult.success(xmlString):
					gridProc.init(xmlString);
					
				case GridResult.error(message, url):
				
			}
			
		});
		
		mediate(playPosition.positionSignal.add(function(info:PlayPositionInfo) {
			
			trace('posSignal' + info.pos);
			if (this.pageBars == null) return;		
			var pageIdx = info.pageIdx;
			if (info.pos == 0) pageIdx = -1;
			if (info.pos == 1) pageIdx = -1;			
			pageSystemUtils.drawOrgMasks(this.pageBars, pageIdx, gridProc.pageCoordinates);			
		}));
		

		setzoom.add(function(zoom:ScrollWidgetZoom)
		{
			this.view.setZoom(zoom);
		});
		
		this.view.afterReziseGrid = function(gridOverlay:Widget, docInfo:DocInfo)
		{		
			trace('afterReziseGrid');
			this.docInfo = docInfo;
			this.redrawGrid(this.view.gridOverlay, this.docInfo);
		}
		
		
		
		this.view.handleMouseDoubleClick = function(x:Float, y:Float)
		{
			trace([x, y]);
			var pos:Float = gridProc.getPositionFromCoords(x, y);
			if (pos == -1) return;
			playPosition.setPosition(pos, this.view);
			
		}
		
		this.gridProc.afterInit = function(gridSystems:GridSystems)
		{
			trace('gridProc.afterInit');
			pageSystemUtils.init(this.view.gridOverlay, this.view.orgOverlay);
			playPosition.setViewPort(new Rectangle(0, 0, this.view.w, this.view.h), this.view.scrollX, this.view.scrollY);
			this.redrawGrid(this.view.gridOverlay, this.docInfo);
		}
		
		
		
		
		/*
		this.gridProc.updatePointerPosition = function(pageBar:PageBar)
		{			
			pageSystemUtils.updatePointerPosition(pageBar.deltaX, pageBar.rect.y, pageBar.rect.height);	
		}
		*/
		
		/*
		this.playPosition.scroll = function(x:Float, y:Float)
		{
			trace(this.view.scrollY);
			this.view.scrollY -= y;			
		}
		*/	
	
	}
	
	private function redrawGrid(gridOverlay:Widget, docInfo:DocInfo)
	{
		if (gridProc.gridSystems == null) return;
		if (this.docInfo.pageInfos.length < 1) return;
		this.pageBars = gridProc.getPageBars(docInfo);			
		pageSystemUtils.drawPageBars(this.pageBars);	
		playPosition.setViewPort(new Rectangle(0, 0, this.view.w, this.view.h), this.view.scrollX, this.view.scrollY);
		pageSystemUtils.drawOrgMasks(this.pageBars, -1, gridProc.pageCoordinates);	
		playPosition.setPosition(playPosition.getPosition(), this.view);		
	}
	
	
}