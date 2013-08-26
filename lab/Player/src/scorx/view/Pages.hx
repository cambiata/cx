package scorx.view;
import flash.display.BitmapData;
import player.controller.Setzoom;
import scorx.controller.LoadPages;
import sx.mvc.view.enums.ScrollWidgetZoom;
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
	
	@inject public var setzoom:Setzoom;
	
	override function onRegister()
	{
		Debug.log('PagesMediator registered');
		//this.view.skinMe();
		
		mediate(loadPages.status.add(function (status){ 	
			switch(status)
			{
				case LoadPagesStatus.started(nrOfPages):
					Debug.log('PagesMediator is notified :loadPages.started... $nrOfPages');			
					this.view.initPages(nrOfPages);				
				case LoadPagesStatus.progress(pageInfo):
					var pageNr = pageInfo.pageNr;
					var nrOfPages = pageInfo.nrOfPages;
					var data = pageInfo.data;
					this.view.addPage(pageNr, nrOfPages, data);				
				case LoadPagesStatus.completed(nrOfPages):
					Debug.log('PagesMediator is notified :loadPages.completed... $nrOfPages');
			}
		}));

		setzoom.add(function(zoom:ScrollWidgetZoom)
		{
			this.view.setZoom(zoom);
		});

	}
	
	
	
}