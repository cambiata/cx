package player.view;
import player.controller.Load;
import player.controller.LoadPages;
import player.controller.Play;
import player.controller.Stop;

import sx.mvc.view.HBoxView;

import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.UIBuilder;

import cx.flash.ui.UI;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFormat;

/**
 * ...
 * @author 
 */

class ButtonsView extends HBoxView
{
	public var btnStart:Button;
	public var btnStop:Button;
	public var btnLoad:Button;

	override public function createChildren() 
	{
		this.w = 100;
		this.h = 40;
		
		this.btnStart = ru.stablex.ui.UIBuilder.create(Button);
		this.btnStart.text = "Start";
		this.addChild(this.btnStart);
		
		this.btnStop = ru.stablex.ui.UIBuilder.create(Button);
		this.btnStop.text = "Stop";
		this.addChild(this.btnStop);

		this.btnLoad = ru.stablex.ui.UIBuilder.create(Button);
		this.btnLoad.text = "Load";
		this.addChild(this.btnLoad);		
	}	
	
}

class ButtonsMediator extends mmvc.impl.Mediator<ButtonsView>
{	
	@inject public var play:Play;
	@inject public var stop:Stop;
	
	@inject public var loadPages:LoadPages;
	
	
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
			loadPages.dispatch("http://test.com");
		});

		// mediate signals from controllers
		
		mediate(loadPages.completed.addOnce(function() {
			trace('TestMediator is notified :loadSomething.completed!');
		}));		
	}
}