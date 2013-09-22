package player.view;

import cx.EnumTools;
import cx.TimerTools;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.StageDisplayState;
import flash.events.Event;
import flash.Lib;
import flash.text.TextFormat;
import player.controller.Setzoom;
import ru.stablex.ui.skins.Img;
import ru.stablex.ui.skins.Layer;
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

@:bitmap('assets/img/checkboxChecked.png') class TestBitmap extends BitmapData { }
@:bitmap('assets/img/zoom-full.png') class BmpZoomFull extends BitmapData { }
@:bitmap('assets/img/zoom-full-light.png') class BmpZoomFullLight extends BitmapData { }

@:bitmap('assets/img/zoom-minus.png') class BmpZoomMinus extends BitmapData { }
@:bitmap('assets/img/zoom-minus-light.png') class BmpZoomMinusLight extends BitmapData { }

@:bitmap('assets/img/zoom-plus.png') class BmpZoomPlus extends BitmapData { }
@:bitmap('assets/img/zoom-plus-light.png') class BmpZoomPlusLight extends BitmapData { }


 
class ZoomView extends VBoxView 
 {
	public var skinMinus:Img;
	public  var skinMinusLight:Img;
	public  var skinPlus:Img;
	public  var skinPlusLight:Img;
	 
	public var btnScreenFull:Button;
	public var btnZ40:Button;
	public var btnFull:Button;

	
	//static public inline var BTN_W:Float =40;
	static public inline var BTN_H:Float = 32;	
	
	override public function createChildren() 
	 {
		this.childPadding = 10;		 
		this.align = 'top,center';			
		btnScreenFull = UIBuilder.create(Button);		
		var skinFull:Img = new Img();
		skinFull.bitmapData = new BmpZoomFull(0, 0);
		var skinFullLight:Img = new Img();
		skinFullLight.bitmapData = new BmpZoomFullLight(0, 0);
		btnScreenFull.skin = skinFull;
		btnScreenFull.skinHovered = skinFullLight;
		btnScreenFull.w = 80;
		btnScreenFull.h = 32;
		
		this.addChild(btnScreenFull);
		

		btnFull = UIBuilder.create(Button);		
		btnFull.w = 80;
		btnFull.h = 32;

		skinMinus = new Img();
		skinMinus.bitmapData = new BmpZoomMinus(0, 0);
		skinMinusLight = new Img();
		skinMinusLight.bitmapData = new BmpZoomMinusLight(0, 0);
		
		btnFull.skin = skinMinus;
		btnFull.skinHovered = skinMinusLight;
		this.addChild(btnFull);
		
		skinPlus = new Img();
		skinPlus.bitmapData = new BmpZoomPlus(0, 0);
		skinPlusLight = new Img();
		skinPlusLight.bitmapData = new BmpZoomPlusLight(0, 0);		
		
		
		
		//this.addChild(btnFull);		
		this.align = 'top,center';		
		this.w = 100;		
	}
	
	private function createButton(text:String):Button
	{
		var btn:Button = UIBuilder.create(Button);
		btn.w = 80;		
		btn.text = text; // Std.string(i);
		btn.format = new TextFormat('Arial', 12, 0xFFFFFF);
		
		var skinFull:Img = new Img();
		skinFull.bitmapData = new BmpZoomFull(0, 0);
		var skinFullLight:Img = new Img();
		skinFullLight.bitmapData = new BmpZoomFullLight(0, 0);
	
		btn.w = 80;
		btn.h = 26;
		btn.skin = skinFull;		
		btn.skinHovered = skinFullLight;		
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
			trace('onPress');
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
					this.view.btnFull.skin = this.view.skinMinus;
					this.view.btnFull.skinHovered = this.view.skinMinusLight;
				default:
					this.view.btnFull.skin = this.view.skinPlus;
					this.view.btnFull.skinHovered = this.view.skinPlusLight;
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
				zooma.doZoomResetTop();
				
				
			#end
		}
	}	

}



/*

import player.view.Zoom.ZoomView;
import player.view.Zoom.ZoomMediator;


mediatorMap.mapView(ZoomView, ZoomMediator);

*/