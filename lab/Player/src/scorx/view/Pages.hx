package scorx.view;
import flash.display.BitmapData;
import scorx.controller.LoadPages;
import scorx.model.Debug;
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
	@inject public var debug:Debug;
	
	override function onRegister()
	{
		debug.log('PagesMediator registered');
		//this.view.skinMe();
		
		
		mediate(loadPages.started.add(function(nrOfPages:Int) {
			debug.log('PagesMediator is notified :loadPages.started... $nrOfPages');			
			this.view.initPages(nrOfPages);
		}));		

		mediate(loadPages.progress.add(function(pageInfo:LoadedPageInfo) {
			var pageNr = pageInfo.pageNr;
			var nrOfPages = pageInfo.nrOfPages;
			var data = pageInfo.data;
			debug.log('PagesMediator is notified :loadPages.progress:  $pageNr of $nrOfPages');
			this.view.addPage(pageNr, nrOfPages, data);
		}));		
		
		mediate(loadPages.completed.add(function() {
			debug.log('PagesMediator is notified :loadPages.completed...');
		}));		
		
	}
}