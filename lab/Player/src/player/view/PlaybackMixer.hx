package player.view;

import flash.text.TextFormat;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.widgets.Progress;
import ru.stablex.ui.widgets.Widget;
import scorx.data.ChannelsLoader;
import scorx.model.PlaybackEngine;
import scorx.model.PlayPosition;
import scorx.model.utils.ChannelUtils;
import scorx.ui.ChannelWidget;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;
/*
import scorx.controller.LoadChannels.LoadedChannelInfo;
import scorx.controller.LoadChannels.LoadChannelsController;
import scorx.controller.LoadChannels.LoadChannelsCommand;
import scorx.controller.LoadChannels.LoadChannelsStatus;
*/
import sx.ScorxColors;


/**
 * ...
 * @author 
 */
class PlaybackMixerView extends VBoxView 
 {
	 var progress:Progress;
	public var playSkin:Paint;
	public var playSkinHover:Paint;
	public var stopSkin:Paint;
	public var stopSkinHover:Paint;

	 public var btnWidget:Widget;
	 public var btn:Button;	
	
	override public function createChildren() 
	{
		 this.paddingBottom = 12;
		 this.childPadding = 8;
		
		this.w = 100;
		this.h = 320;			 
		 
		playSkin = new Paint();
		playSkin.color = ScorxColors.ScorxGreenDark;
		playSkin.corners = [8];		
		playSkinHover = new Paint();
		playSkinHover.color = ScorxColors.ScorxGreen;
		playSkinHover.corners = [8];		
		
		
		stopSkin = new Paint();
		stopSkin.color = ScorxColors.ScorxRed;
		stopSkin.corners = [8];
		stopSkinHover = new Paint();
		stopSkinHover.color = ScorxColors.ScorxRedLight;
		stopSkinHover.corners = [8];		
		

		this.btnWidget = UIBuilder.create(Widget);
		this.btnWidget.h = 30;
		this.btnWidget.w = this.w;
		this.addChild(btnWidget);
		
		this.btn = UIBuilder.create(Button);
		this.btn.x = 10;
		this.btn.format = new TextFormat('Arial', 12, 0xFFFFFF);		
		this.btn.text = "Play";		
		this.btn.w = 80;
		this.btn.skin = this.playSkin;		
		this.btn.skinHovered = this.playSkinHover;
		this.btnWidget.addChild(this.btn);
		this.btn.visible = false;
		
		
		this.align = "top,center";

	}
	public function setChildren() 
	{
		this.addChild(this.btn);	
	}
	
	override public function addSkin()
	 {		
		
	}
	
	public function setSkin()
	{
		var skin:Paint = new Paint();
		skin.color = 0xdddddd;
		skin.alpha = 1;		
		skin.corners = [8];
		/*skin.border = 2;*/
		/*skin.borderColor = 0x555555;*/
		skin.apply(this);				
	}
	
}

class PlaybackMixerMediator extends mmvc.impl.Mediator<PlaybackMixerView>
{
	
	
	//@inject public var loadChannelsController:LoadChannelsController;	
	@inject public var playbackEngine:PlaybackEngine;
	@inject public var channelsLoader:ChannelsLoader;
	@inject public var playPosition:PlayPosition;
	
	
	override function onRegister() 
	 {
		trace('PlaybackMixerMediator registered');	
		
		this.view.btn.onPress = function(e)
		{
			if (playbackEngine.isPlaying()) playbackEngine.stop() else playbackEngine.start(playPosition.getPosition());			
		};		
		
		// handle channels loading result
		channelsLoader.result.add( function( result: ChannelsResult) {
			switch(result)
			{
				case ChannelsResult.started(channels):
					for (channel in channels)
					{
						var channelWidget:ChannelWidget = new ChannelWidget(channel.Label, channel.Id);
						this.view.addChild(channelWidget);										
						this.view.refresh();
						channelWidget.onChangeValue = playbackEngine.setVolume;
					}
				case ChannelsResult.complete(channelsData):
						this.view.btn.visible = true;
				default:
			}
		});		

		
		this.playbackEngine.onStart.add(function(pos:Float) {
			this.view.btn.text = 'Stop';
			this.view.btn.skin = this.view.stopSkin;
			this.view.btn.skinHovered =  this.view.stopSkinHover;
			this.view.btn.refresh();
			
		});
		
		this.playbackEngine.onStop.add(function() {
			this.view.btn.text = 'Start';
			this.view.btn.skin = this.view.playSkin;
			this.view.btn.skinHovered =  this.view.playSkinHover;
			this.view.btn.refresh();
		});
		
		
	}	
}



/*

import player.view.PlaybackMixer.PlaybackMixerView;
import player.view.PlaybackMixer.PlaybackMixerMediator;


		var viewPlaybackMixerView:PlaybackMixerView = new PlaybackMixerView();
		this.view.addChild(viewPlaybackMixerView);



		mediatorMap.mapView(PlaybackMixerView, PlaybackMixerMediator);

*/