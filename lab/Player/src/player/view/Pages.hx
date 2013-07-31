package player.view;
import flash.display.BitmapData;
import player.controller.LoadPages;
import sx.mvc.view.HBoxView;
import sx.mvc.view.ScrollWidgetView;

import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.UIBuilder;

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
	
	@inject public var loadPages:LoadPages;	
	
	override function onRegister()
	{
		trace('PagesMediator registered');
		//this.view.skinMe();
		
		/*
		mediate(loadPages.started.add(function(nrOfPages:Int) {
			trace('PagesMediator is notified :loadPages.started... $nrOfPages');			
			this.view.initPages(nrOfPages);
		}));		

		mediate(loadPages.progress.add(function(loadPagesInfo:LoadPagesInfo) {
			var pageNr = loadPagesInfo.pageNr;
			var nrOfPages = loadPagesInfo.nrOfPages;
			var data = loadPagesInfo.data;
			
			trace('PagesMediator is notified :loadPages.progress:  $pageNr of $nrOfPages');
			this.view.addPage(pageNr, nrOfPages, data);
		}));		
		
		
		mediate(loadPages.completed.add(function() {
			trace('PagesMediator is notified :loadPages.completed...');
		}));		
		*/
		
		
		
		
	}
}