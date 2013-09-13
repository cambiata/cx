package player.view;

import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.widgets.Text;
import scorx.model.Configuration;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;

/**
 * ...
 * @author 
 */
class ConfigurationViewView extends VBoxView 
 {
	 var label:Text;
	public var labelTitle:Text;
	public var labelUserId:Text;
	public  var labelProductId:Text;
	public var labelHost:Text;
	public var labelPlaybackLevel:Text;
	public var labelPlaybackChannelIds:Text;
	public var labelPlaybackChannelLabels:Text;

	public var btn:Button;	
	
	override public function createChildren() 
	 {
		 this.childPadding = 0;
		 
		this.align = 'top,left';
		
		 this.labelTitle = UIBuilder.create(Text);
		this.labelTitle.text = 'CONFIGURATION:';
		this.addChild(this.labelTitle);
		
		 this.labelUserId = UIBuilder.create(Text);
		this.labelUserId.text = 'UserId:';
		this.addChild(this.labelUserId);
	
		this.labelProductId = UIBuilder.create(Text);
		this.labelProductId.text = 'ProductId:';
		this.addChild(this.labelProductId);		
		
		this.labelHost = UIBuilder.create(Text);
		this.labelHost.text = 'Host:';
		this.addChild(this.labelHost);				
		
		this.labelPlaybackLevel = UIBuilder.create(Text);
		this.labelPlaybackLevel.text = 'PlaybackLevel:';
		this.addChild(this.labelPlaybackLevel);				

		this.labelPlaybackChannelIds = UIBuilder.create(Text);
		this.labelPlaybackChannelIds.text = 'Channel ids:';
		this.addChild(this.labelPlaybackChannelIds);				
		
		this.labelPlaybackChannelLabels = UIBuilder.create(Text);
		this.labelPlaybackChannelLabels.text = 'Channel labels:';
		this.addChild(this.labelPlaybackChannelLabels);					
		
		
		this.w = 360;
		this.h = 160;		
	}
	
	override public function addSkin()
	 {
		var skin:Paint = new Paint();
		skin.color = 0xFFFFFF;
		skin.alpha = 0.4;
		skin.border = 1;
		skin.borderColor = 0xFF0000;
		skin.apply(this);				
	}
}

class ConfigurationViewMediator extends mmvc.impl.Mediator<ConfigurationViewView>
{
	@inject public var config:Configuration;	
	override function onRegister() 
	 {
		mediate(this.config.updated.add(function() 
		{
			
			this.view.labelUserId.text = 'UserId: ' + config.userId;
			this.view.labelProductId.text = 'ProductId: ' + config.productId;
			this.view.labelHost.text = 'Host: ' + config.host;
			
			this.view.labelPlaybackLevel.text = 'PlaybackLevel: ' + Std.string(config.playbackLevel);			
			this.view.labelPlaybackChannelIds.text = "Channel ids: ";
			this.view.labelPlaybackChannelLabels.text = "Channel labels: ";

			if (config.playbackChannels != null)
				for (channel in config.playbackChannels)
				{
					this.view.labelPlaybackChannelIds.text  += channel.channelId;
					this.view.labelPlaybackChannelLabels.text  += channel.channelLabel;
				}
		}));				
	}	
}



/*

import player.view.ConfigurationView.ConfigurationViewView;
import player.view.ConfigurationView.ConfigurationViewMediator;


		var viewConfigurationViewView:ConfigurationViewView = new ConfigurationViewView();
		this.view.addChild(viewConfigurationViewView);



		mediatorMap.mapView(ConfigurationViewView, ConfigurationViewMediator);

*/