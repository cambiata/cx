package player.view;

import flash.display.BitmapData;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import scorx.controller.LoadPages;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;

/**
 * ...
 * @author 
 */
class SmallthumbsView extends VBoxView 
 {

	public var btn:Button;	
	
	override public function createChildren() 
	 {
		 this.align = 'top,center';
		 
		this.w = Constants.PLAYER_VIEW_SMALLTHUMBS_W;
		this.h = 200;		
	}
	
	override public function addSkin()
	{
		var skin = new Paint();
		skin.color = 0xFF0000;
		//skin.apply(this);						
		
	}
}

class SmallthumbsMediator extends mmvc.impl.Mediator<SmallthumbsView>
{
	
	@inject public var loadPages:LoadPages;	
	//static public inline var PAGEBTN_W:Float =30;
	static public inline var PAGEBTN_H:Float =40;
	
	override function onRegister() 
	 {
		trace('SmallthumbsMediator registered');	
		
		mediate(loadPages.status.add(function (status){ 	
			switch(status)
			{
				case LoadPagesStatus.started(nrOfPages):
					Debug.log('PagesMediator is notified :loadPages.started... $nrOfPages');			
					this.initPages(nrOfPages);				
				case LoadPagesStatus.progress(pageInfo):
					var pageNr = pageInfo.pageNr;
					var nrOfPages = pageInfo.nrOfPages;
					this.addPage(pageNr, nrOfPages);				
				case LoadPagesStatus.completed(nrOfPages):
					Debug.log('PagesMediator is notified :loadPages.completed... $nrOfPages');
			}
		}));
		
		
	}	

	function addPage(pageNr:Int, nrOfPages:Int) 
	{
		var pageBtn:Button = cast this.view.getChildAt(pageNr - 1);
		pageBtn.text = Std.string(pageNr);
	}
	
	function initPages(nrOfPages:Int) 
	{
		this.clearPages();
		
		for (i in 0...nrOfPages)
		{
			var pageBtn:Button = UIBuilder.create(Button);
			pageBtn.w = Constants.PLAYER_VIEW_SMALLTHUMBS_W-10;
			pageBtn.h = PAGEBTN_H;			
			pageBtn.text = ''; // Std.string(i);
			
			var skin:Paint = new Paint();
			skin.color = 0xFFFFFF;
			skin.corners = [8, 8];
			skin.border = 2;
			skin.borderColor = 0xcccccc;			
			pageBtn.skin = skin;
			
			var skin:Paint = new Paint();
			skin.color = 0xFFFFFF;
			skin.corners = [8, 8];
			skin.border = 2;
			skin.borderColor = 0x888888;			
			pageBtn.skinHovered = skin;			
			pageBtn.refresh();
			
			//pageBtn.skinHovered = 
			
			this.view.addChild(pageBtn);			
		}
		this.view.refresh();
		
	}
	
	function clearPages()
	{
		while (this.view.numChildren > 0) this.view.removeChildAt(0);		
	}			
	
}



/*

import player.view.Smallthumbs.SmallthumbsView;
import player.view.Smallthumbs.SmallthumbsMediator;


mediatorMap.mapView(SmallthumbsView, SmallthumbsMediator);

*/