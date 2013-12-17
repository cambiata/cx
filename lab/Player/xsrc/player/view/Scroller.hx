package player.view;

import flash.events.Event;
import flash.events.MouseEvent;
import ru.stablex.ui.events.WidgetEvent;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.widgets.Progress;
import ru.stablex.ui.widgets.Text;
import scorx.data.Errors;
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
import sx.player.TPlaybackChannels;
import sx.ScorxColors;


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
	public var btnStop:Button;	
	
	public var txtPos:Text;
	
	override public function createChildren() 
	{
		this.progress = UIBuilder.create(Progress);
		this.progress.interactive = true;
		this.progress.w = 400;
		this.progress.h = 16;
		this.addChild(progress);
		this.progress.useHandCursor = true;
		
		this.txtPos = UIBuilder.create(Text);
		this.txtPos.text = "0:00";		
		this.addChild(this.txtPos);

		this.btnGrid = UIBuilder.create(Button);
		this.btnGrid.text = "grid";
		this.btnGrid.w = 140;
		this.addChild(this.btnGrid);
		this.btnGrid.visible = false;
		
		this.btnScreen = UIBuilder.create(Button);
		this.btnScreen.text = "screen";
		this.btnScreen.w = 140;
		this.addChild(this.btnScreen);				
		this.btnScreen.visible = false;		
		
		this.btnSound = UIBuilder.create(Button);
		this.btnSound.text = "sound";
		this.btnSound.w = 140;
		this.addChild(this.btnSound);		
		this.btnSound.visible = false;		
		
		this.btnPlay = UIBuilder.create(Button);
		this.btnPlay.text = "Play";
		this.btnPlay.w = 80;
		this.addChild(this.btnPlay);		
		this.btnPlay.visible = false;		
		
		this.btnStop = UIBuilder.create(Button);
		this.btnStop.text = "Stop";
		this.btnStop.w = 80;
		this.addChild(this.btnStop);			
		this.btnStop.visible = false;		
		
		this.w = 400;
		this.h = 30;		
		
		this.visible = false;
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
	@inject public var errors:Errors;
	
	
	override function onRegister() 
	 {
		trace('ScrollerMediator registered');	
		
		// handle scroller progress bar interaction
		this.view.progress.addEventListener(WidgetEvent.CHANGE, function(e)
		{						
		});		
		
		this.view.progress.addEventListener(MouseEvent.MOUSE_MOVE, function(e)
		{
			var value:Float = this.view.progress.value / 100;	
			playPosition.setPosition(value, this.view.progress);
		});
		
		this.view.progress.addEventListener(MouseEvent.MOUSE_UP, function(e)
		{
			this.playbackEngine.stop();
			var value:Float = this.view.progress.value / 100;	
			playPosition.setPosition(value, this.view.progress);
		});		
		
		
		// handle position update from playPosition 
		mediate(playPosition.positionSignal.add( function(info:PlayPositionInfo) {			
			if (Std.string(info.sender) != Std.string(this.view.progress)) this.view.progress.value = info.pos * 100;
			
			var seconds = this.playbackEngine.getSoundLength();
			var pos = (info.pos * seconds) / 1000;
			
			/*
			var str:String = Std.string(pos).substr(0, 5);			
			var secs:String = str.substr(0, str.indexOf("."));
			*/
			var secs:Int = Math.floor(pos % 60);
			var sec:String = (secs < 10) ? '0$secs' : '$secs';
			var mins:Int = Math.floor(pos / 60);
			var min:String = (mins < 10) ? '0$mins' : '$mins';
			this.view.txtPos.text = '$min:$sec';
			
		}));
		
		// handle grid loading result
		mediate(gridLoader.result.add( function( result:GridResult) {
			switch (result)
			{
				case GridResult.success(xmlString):
					trace('SUCC');
				case GridResult.error(message, url):
					trace('ERR');
			}
		}));
		
		// handle page loading result
		mediate(pagesLoader.result.add( function( result:PagesResult) {
			switch (result)
			{
				case PagesResult.started(nrOfPages):
					trace('STARTED ' + nrOfPages);
				default:
			}
		}));
		
		// handle channels loading result
		channelsLoader.result.add( function( result: ChannelsResult) {
			switch(result)
			{
				case ChannelsResult.started(channels):
				
				case ChannelsResult.loaded(data, tag):
					
					
				case ChannelsResult.complete(channelsData):
					#if js
						trace('ChannelsData complete JS');
						var url = '${configuration.host}media/channel/${configuration.productId}/200/${configuration.userId}';
						trace(url);
						playbackEngine.loadOneFile(url);
					#else
						trace('ChannelsData complete ' + channelsData.length);
						for (channelData in channelsData)
						{
							trace(channelData.id);
						}
						playbackEngine.addChannels(channelsData);
						this.view.visible = true;
					#end
				default:
			}
		});
		
		// load grid
		this.view.btnGrid.onPress = function(e:Event) {
			trace('press');
			
			gridLoader.load(configuration.host, configuration.productId, configuration.userId);
		}

		// load screen
		this.view.btnScreen.onPress = function(e:Event) {
			trace('press');			
			pagesLoader.load(configuration.host, configuration.productId, configuration.userId);
		}
		
		// load sound
		this.view.btnSound.onPress = function(e:Event) {
			channelsLoader.load(configuration.host, configuration.productId, configuration.userId);
		}
		
		// start playback
		this.view.btnPlay.onPress = function(e:Event) {
			//playbackEngine.complete();
			playbackEngine.start(this.playPosition.getPosition());
			this.errors.addError('This is an error!');
		}	
		
		// stop playback
		this.view.btnStop.onPress = function(e:Event) {
			//playbackEngine.complete();
			playbackEngine.stop();
			this.errors.clear();
		}			
		
		// update pointer position from playPosition 
		this.playbackEngine.onPosition.add(function( position:Float) {				
			//trace('position ' + position);			
			this.playPosition.setPosition(position, this);
		});		
		
		this.playbackEngine.onStart.add(function(position:Float) {
			//trace('onStart ' + position);			
		});
	}	
}



/*

import player.view.Scroller.ScrollerView;
import player.view.Scroller.ScrollerMediator;


		var viewScrollerView:ScrollerView = new ScrollerView();
		this.view.addChild(viewScrollerView);



		mediatorMap.mapView(ScrollerView, ScrollerMediator);

*/