package player.view;

import cx.EnumTools;
import cx.TimerTools;
import flash.display.StageDisplayState;
import flash.events.Event;
import flash.Lib;
import flash.text.TextFormat;
import player.controller.Setzoom;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import scorx.data.Zooma;
import scorx.view.Pages.PagesMediator;
import sx.mvc.view.enums.ScrollWidgetZoom;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;
import sx.ScorxColors;

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
	static public inline var BTN_H:Float = 32;	
	
	override public function createChildren() 
	 {
		this.align = 'top,center';		
		btnScreenFull = createButton('Full');
		this.addChild(btnScreenFull);		
		btnFull = createButton('Page');		
		this.addChild(btnFull);		
		this.align = 'top,center';		
		this.w = 100;		
	}
	
	private function createButton(text:String):Button
	{
		var btn:Button = UIBuilder.create(Button);
		btn.w = 80;		
		btn.text = text; // Std.string(i);
		btn.format = new TextFormat('Arial', 12, 0xFFFFFF);
		
		var skin:Paint = new Paint();
		skin.color = ScorxColors.ScorxPetrol;
		skin.corners = [8, 8];
		btn.skin = skin;
		
		var skin:Paint = new Paint();
		skin.color = ScorxColors.ScorxPetrolLight;
		skin.corners = [8, 8];		
		btn.skinHovered = skin;		
		
		btn.refresh();	
		return btn;
	}

}

class ZoomMediator extends mmvc.impl.Mediator<ZoomView>
{
	
	//@inject public var setzoom:Setzoom;
	@inject public var zooma:Zooma;
	
	
	#if js 
	var firstFullscreen:Bool = true;
	#end
	
	
	override function onRegister() 
	 {	
		this.view.btnFull.onPress = function(e) {
			//this.setzoom.dispatch(ScrollWidgetZoom.ZoomFullHeight);		
			if (zooma.getZoom() == ScrollWidgetZoom.ZoomFullHeight)
			{
				this.zooma.setZoom(ScrollWidgetZoom.Zoom40);
			}
			else
			{
				this.zooma.setZoom(ScrollWidgetZoom.ZoomFullHeight);				
			}
		};
		
		/*
		this.setzoom.add(function(zoom:ScrollWidgetZoom) {
			trace(Std.string(zoom));			
		});
		*/
		
		this.zooma.zoomSignal.add(function(zoom:ScrollWidgetZoom) {
			switch(zoom)
			{
				case ScrollWidgetZoom.ZoomFullHeight:
					this.view.btnFull.text = 'To small';
				default:
					this.view.btnFull.text = 'To full';
			}
		});
		
		
		this.view.btnScreenFull.onPress = function(e)	
		{			
			Debug.log(Lib.current.stage.displayState);
			
			#if js
				var size:Dynamic = untyped __js__('__jsFullscreen()');
				Debug.log(size);
				
				/*if (firstFullscreen) 
				{
					Lib.current.stage.displayState = (Lib.current.stage.displayState == StageDisplayState.NORMAL) ? StageDisplayState.FULL_SCREEN : StageDisplayState.NORMAL;
					firstFullscreen = false;
				}
				*/
				
				TimerTools.delay(function() {
					Debug.log('resize');			
					Lib.current.stage.dispatchEvent(new Event(Event.RESIZE));
				}, 300);			
				
			#else						
				Lib.current.stage.displayState = (Lib.current.stage.displayState == StageDisplayState.NORMAL) ? StageDisplayState.FULL_SCREEN : StageDisplayState.NORMAL;				
			#end
		}
	}	

}



/*

import player.view.Zoom.ZoomView;
import player.view.Zoom.ZoomMediator;


mediatorMap.mapView(ZoomView, ZoomMediator);

*/