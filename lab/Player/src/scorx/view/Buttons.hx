package scorx.view;
import haxe.Serializer;
import scorx.controller.Confload;
import scorx.controller.Load;
import scorx.controller.LoadPages;
import scorx.controller.Play;
import scorx.controller.Stop;
import scorx.model.Configuration;
import sx.data.ScoreLoadingType;
import sx.mvc.view.VBoxView;


import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Text;

import cx.flash.ui.UI;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFormat;

/**
 * ...
 * @author 
 */

class ButtonsView extends VBoxView
{
	public var btnStart:Button;
	public var btnStop:Button;
	public var btnLoad:Button;
	
	public var txtInfo:Text;

	override public function createChildren() 
	{
		this.align = 'top,right';
		this.w = 56;
		this.h = 200;
		
		this.btnStart = UIBuilder.create(Button);
		this.btnStart.text = "P";
		this.btnStart.w = 40;
		//this.addChild(this.btnStart);
		
		this.btnStop = UIBuilder.create(Button);
		this.btnStop.text = "S";
		this.btnStop.w = 40;
		//this.addChild(this.btnStop);

		this.btnLoad = UIBuilder.create(Button);
		this.btnLoad.text = "L";
		this.btnLoad.w = 40;
		//this.addChild(this.btnLoad);		
		
		
		this.txtInfo = UIBuilder.create(Text);
		this.txtInfo.text = 'info';
		this.txtInfo.w = 32;
		this.btnStart.w = 40;
		this.addChild(this.txtInfo);
		
	}	
	
}

class ButtonsMediator extends mmvc.impl.Mediator<ButtonsView>
{	
	@inject public var play:Play;
	@inject public var stop:Stop;
	
	@inject public var loadPages:LoadPages;
	@inject public var debug:Debug;
	
	@inject public var config:Configuration;
	
	
	override function onRegister()
	{
		// view event handlers
		
		this.view.btnStart.addEventListener(MouseEvent.MOUSE_DOWN, function (e) {
			play.dispatch(222);
		});
		
		this.view.btnStop.addEventListener(MouseEvent.MOUSE_DOWN, function (e) {
			stop.dispatch();
		});
		
		this.view.btnLoad.addEventListener(MouseEvent.MOUSE_DOWN, function (e) {
			
			var loadParameters:LoadParameters = new LoadParameters();
			loadParameters.host = config.host;
			loadParameters.productId = config.productId;
			loadParameters.userId = config.userId;
			loadParameters.type = ScoreLoadingType.screen;
			loadPages.dispatch(loadParameters);
		});

		// mediate signals from controllers		
		mediate(loadPages.completed.addOnce(function(nrOfPages:Int) {
			Debug.log('ButtonsMediator is notified : loadPages.completed! - $nrOfPages pages');
		}));		
		
		mediate(this.config.updated.add(function() {
			Debug.log('ButtonsMediator is notified : configModel.updated!');			
			Debug.log(config.host);
			Debug.log(config.productId);
			Debug.log(config.userId);
			this.view.txtInfo.text = config.productId + ':' + config.userId;
		}));
		
	}
}