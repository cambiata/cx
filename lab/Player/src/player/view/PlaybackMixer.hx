package player.view;

import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.widgets.Progress;
import scorx.model.PlaybackEngine;
import scorx.model.utils.ChannelUtils;
import scorx.ui.ChannelWidget;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;
import scorx.controller.LoadChannels.LoadedChannelInfo;
import scorx.controller.LoadChannels.LoadChannelsController;
import scorx.controller.LoadChannels.LoadChannelsCommand;
import scorx.controller.LoadChannels.LoadChannelsStatus;
import sx.ScorxColors;


/**
 * ...
 * @author 
 */
class PlaybackMixerView extends VBoxView 
 {
	 var progress:Progress;

	public var btn:Button;	
	
	override public function createChildren() 
	{
		 this.paddingBottom = 12;
		 this.childPadding = 8;
		 
		var playSkin:Paint = new Paint();
		playSkin.color = ScorxColors.ScorxGreen;
		playSkin.corners = [8];
		 
		this.btn = UIBuilder.create(Button);
		this.btn.text = "Play";		
		this.btn.w = 100;
		this.btn.skin = playSkin;		
		
		this.align = "bottom,center";
		
		this.w = 120;
		this.h = 320;			
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
		skin.color = ScorxColors.ScorxDarkgray;
		skin.alpha = 1;		
		skin.corners = [8];
		skin.border = 2;
		skin.borderColor = 0x555555;
		skin.apply(this);				
	}
	
}

class PlaybackMixerMediator extends mmvc.impl.Mediator<PlaybackMixerView>
{
	
	
	@inject public var loadChannelsController:LoadChannelsController;	
	@inject public var playbackEngine:PlaybackEngine;
	
	
	override function onRegister() 
	 {
		trace('PlaybackMixerMediator registered');	
		
		this.view.btn.onPress = function(e)
		{
			// do something...
			trace('Pressed');
			if (playbackEngine.isPlaying()) playbackEngine.stop() else playbackEngine.start();			
		};		
		
		mediate(this.loadChannelsController.status.add(function(status:LoadChannelsStatus) 
		{		
			trace(Std.string(status));
			switch(status)
			{
				case LoadChannelsStatus.started(channelIds):
					
					if (channelIds.length > 0)
					{
						this.view.setSkin();
					}
				case LoadChannelsStatus.progress(channelInfo):
					var channelWidget:ChannelWidget = new ChannelWidget(ChannelUtils.getChannelLabel(channelInfo.channelId), channelInfo.channelId);
					this.view.addChild(channelWidget);										
					this.view.refresh();
					channelWidget.onChangeValue = playbackEngine.setVolume;
				case LoadChannelsStatus.completed:					
					this.view.btn.text = "Play";
					this.view.setChildren();
			}
			this.view.refresh();
		}));		
	}	
}



/*

import player.view.PlaybackMixer.PlaybackMixerView;
import player.view.PlaybackMixer.PlaybackMixerMediator;


		var viewPlaybackMixerView:PlaybackMixerView = new PlaybackMixerView();
		this.view.addChild(viewPlaybackMixerView);



		mediatorMap.mapView(PlaybackMixerView, PlaybackMixerMediator);

*/