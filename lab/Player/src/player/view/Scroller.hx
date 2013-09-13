package player.view;

import flash.events.Event;
import ru.stablex.ui.events.WidgetEvent;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.widgets.Progress;
import scorx.data.GridLoader;
import scorx.data.GridLoader.GridResult;
import scorx.data.GridProc;
import scorx.data.PagesLoader;
import scorx.data.ChannelsLoader;
import scorx.model.Configuration;
import scorx.model.PlaybackEngine;
import scorx.model.PlayPosition;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;
import scorx.model.PlayPosition.PlayPositionInfo;


/**
 * ...
 * @author 
 */
class ScrollerView extends HBoxView 
 {
	 
	public var progress:Progress;

	public var btnGrid:Button;	
	public var btnScreen:Button;	
	public var btnSound:Button;	
	public var btnPlay:Button;	
	
	override public function createChildren() 
	 {
		
		
		this.progress = UIBuilder.create(Progress);
		this.progress.interactive = true;
		this.progress.w = 200;
		this.addChild(progress);

		this.btnGrid = UIBuilder.create(Button);
		this.btnGrid.text = "Load grid";
		this.btnGrid.w = 140;
		this.addChild(this.btnGrid);
		
		this.btnScreen = UIBuilder.create(Button);
		this.btnScreen.text = "Load screen";
		this.btnScreen.w = 140;
		this.addChild(this.btnScreen);				
		
		this.btnSound = UIBuilder.create(Button);
		this.btnSound.text = "Load sound";
		this.btnSound.w = 140;
		this.addChild(this.btnSound);		
		
		this.btnPlay = UIBuilder.create(Button);
		this.btnPlay.text = "Play";
		this.btnPlay.w = 80;
		this.addChild(this.btnPlay);				
		
		this.w = 400;
		this.h = 30;		
	}
	
	override public function addSkin()
	 {
		/*
		var skin = new Paint();
		skin.color = 0xFF0000;
		skin.apply(this);				
		*/
	}
}

class ScrollerMediator extends mmvc.impl.Mediator<ScrollerView>
{
	
	@inject public var playPosition:PlayPosition;	
	@inject public var configuration:Configuration;
	@inject public var gridLoader:GridLoader;
	@inject public var pagesLoader:PagesLoader;
	@inject public var channelsLoader:ChannelsLoader;
	@inject public var playbackEngine:PlaybackEngine;
	
	
	override function onRegister() 
	 {
		trace('ScrollerMediator registered');	
		
		this.view.progress.addEventListener(WidgetEvent.CHANGE, function(e)
		{			
			var value:Float = this.view.progress.value / 100;	
			playPosition.setPosition(value, this.view.progress);
		});		
		
		mediate(playPosition.positionSignal.add( function(info:PlayPositionInfo) {			
			trace('SCroller set position to ' + info.pos);
			
			trace([Std.string(info.sender), Std.string(this.view.progress)]);
			if (Std.string(info.sender) != Std.string(this.view.progress)) this.view.progress.value = info.pos * 100;
			
		}));
		
		mediate(gridLoader.result.add( function( result:GridResult) {
			switch (result)
			{
				case GridResult.success(xmlString):
					trace('SUCC');
				case GridResult.error(message, url):
					trace('ERR');
			}
		}));
		
		mediate(pagesLoader.result.add( function( result:PagesResult) {
			switch (result)
			{
				case PagesResult.started(nrOfPages):
					trace('STARTED ' + nrOfPages);
				default:
			}
		}));
		
		channelsLoader.result.add( function( result: ChannelsResult) {
			switch(result)
			{
				case ChannelsResult.loaded(data, tag):
					trace(tag);
				case ChannelsResult.complete(channelsData):
					trace('ChannelsData complete ' + channelsData.length);
					playbackEngine.addChannels(channelsData);
				default:
			}
		});
		
		this.view.btnGrid.onPress = function(e:Event) {
			trace('press');
			trace(configuration.getGridUrl());
			gridLoader.load(configuration.getGridUrl(43));
		}

		this.view.btnScreen.onPress = function(e:Event) {
			trace('press');			
			pagesLoader.load(configuration.host, configuration.productId, configuration.userId);
		}
		
		this.view.btnSound.onPress = function(e:Event) {
			channelsLoader.load(configuration.host, configuration.productId, configuration.userId);
		}
		
		this.view.btnPlay.onPress = function(e:Event) {
			playbackEngine.complete();
			playbackEngine.start();
		}		
	}	
}



/*

import player.view.Scroller.ScrollerView;
import player.view.Scroller.ScrollerMediator;


		var viewScrollerView:ScrollerView = new ScrollerView();
		this.view.addChild(viewScrollerView);



		mediatorMap.mapView(ScrollerView, ScrollerMediator);

*/