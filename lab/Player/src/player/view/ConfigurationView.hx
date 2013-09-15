package player.view;

import flash.text.TextFormat;
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
	public var labelViewLevel:Text;

	public var btn:Button;	
	
	override public function createChildren() 
	 {
		this.childPadding = 0;
		 
		this.align = 'top,left';
		
		var format = new TextFormat('Arial', 10);
		
		this.labelUserId = UIBuilder.create(Text);
		this.labelUserId.h = 14;
		this.labelUserId.text = 'UserId:';
		this.labelUserId.format = format;		
		this.addChild(this.labelUserId);
	
		this.labelProductId = UIBuilder.create(Text);
		this.labelProductId.h = 14;
		this.labelProductId.text = 'ProductId:';
		this.labelProductId.format = format;
		this.addChild(this.labelProductId);		
		
		this.labelHost = UIBuilder.create(Text);
		this.labelHost.h = 14;
		this.labelHost.text = 'Host:';
		this.labelHost.format = format;
		this.addChild(this.labelHost);				
		
		this.labelPlaybackLevel = UIBuilder.create(Text);
		this.labelPlaybackLevel.h = 14;
		this.labelPlaybackLevel.text = 'PlaybackLevel:';
		this.labelPlaybackLevel.format = format;
		this.addChild(this.labelPlaybackLevel);				

		this.labelViewLevel = UIBuilder.create(Text);
		this.labelViewLevel.h = 14;
		this.labelViewLevel.text = 'ViewLevel:';
		this.labelViewLevel.format = format;
		this.addChild(this.labelViewLevel);		
		
		this.w = 200;
		this.h = 90;		
	}
	
	override public function addSkin()
	 {
		var skin:Paint = new Paint();
		skin.color = 0xFFFFFF;
		skin.corners = [8];
		skin.alpha = 1;
		skin.border = 1;
		skin.borderColor = 0xDDDDDD;
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
			this.view.labelViewLevel.text = 'ViewLevel: ' + Std.string(config.viewLevel);

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