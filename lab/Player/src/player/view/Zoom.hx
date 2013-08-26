package player.view;

import flash.display.StageDisplayState;
import flash.Lib;
import player.controller.Setzoom;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import sx.mvc.view.enums.ScrollWidgetZoom;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;

/**
 * ...
 * @author 
 */
class ZoomView extends VBoxView 
 {
	 public var btnScreenFull:Button;
	public var btnZ40:Button;
	public var btnFull:Button;

	
	//static public inline var BTN_W:Float =40;
	static public inline var BTN_H:Float =40;	
	
	override public function createChildren() 
	 {
		this.align = 'top,center';
		
		btnScreenFull = createButton('Full');
		this.addChild(btnScreenFull);

		btnZ40 = createButton('40%');
		this.addChild(btnZ40);
		
		btnFull = createButton('Page');
		this.addChild(btnFull);
		
		/* 
		 this.btn = UIBuilder.create(Button);
		this.btn.text = "ZoomView";
		this.btn.w = BTN_W;
		this.btn.h = BTN_H;
		this.addChild(this.btn);
		*/
		
		this.w =Constants.PLAYER_VIEW_ZOOMBUTTONS_W;
		
	}
	
	private function createButton(text:String):Button
	{
		var btn:Button = UIBuilder.create(Button);
		btn.w = Constants.PLAYER_VIEW_ZOOMBUTTONS_W - 8;
		btn.h = BTN_H;			
		btn.text = text; // Std.string(i);
		
		var skin:Paint = new Paint();
		skin.color = 0xFFFFFF;
		skin.corners = [8, 8];
		skin.border = 2;
		skin.borderColor = 0xcccccc;			
		btn.skin = skin;
		
		var skin:Paint = new Paint();
		skin.color = 0xFFFFFF;
		skin.corners = [8, 8];
		skin.border = 2;
		skin.borderColor = 0x888888;			
		btn.skinHovered = skin;			
		btn.refresh();	
		return btn;
	}
	
}

class ZoomMediator extends mmvc.impl.Mediator<ZoomView>
{
	
	@inject public var setzoom:Setzoom;
	
	override function onRegister() 
	 {
		trace('ZoomMediator registered');	

		this.view.btnZ40.onPress = function(e) {			
			this.setzoom.dispatch(ScrollWidgetZoom.Zoom40);			
		};
		
		this.view.btnFull.onPress = function(e) {
			this.setzoom.dispatch(ScrollWidgetZoom.ZoomFullHeight);			
		};
		
		this.view.btnScreenFull.onPress = function(e)	Lib.current.stage.displayState = (Lib.current.stage.displayState == StageDisplayState.NORMAL) ? StageDisplayState.FULL_SCREEN : StageDisplayState.NORMAL;				
		
	}	

}



/*

import player.view.Zoom.ZoomView;
import player.view.Zoom.ZoomMediator;


mediatorMap.mapView(ZoomView, ZoomMediator);

*/