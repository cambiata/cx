package scorx.controller;

import flash.utils.ByteArray;
import msignal.Signal.Signal1;
import mmvc.impl.Command;
import scorx.controller.LoadPages.LoadParameters;
import scorx.data.ChannelsLoader;
import scorx.model.PlaybackEngine;

/**
 * ...
 * @author 
 */
 
 
  enum LoadChannelsStatus
 {
	 started(channelIds:Array<String>);
	 progress(channelInfo:LoadedChannelInfo);
	 completed();
 }
 
 
  typedef LoadedChannelInfo = 
 {
	channelId:String,
 }
 
class LoadChannelsController extends Signal1<LoadParameters> 
{

	public var status:Signal1<LoadChannelsStatus>;

	public function new() 
	{
		super(LoadParameters);
		status = new Signal1<LoadChannelsStatus>();
	}	
}

class LoadChannelsCommand extends Command
{

	@inject public var loadChannelsController:LoadChannelsController;	
	@inject public var loadParameters:LoadParameters;	 // parameter in LoadPages
	@inject public var loader:ChannelsLoader;
	@inject public var playbackEngine:PlaybackEngine;
	
	override public function execute():Void
	{
		Debug.log(['LoadChannelsCommand...', loadParameters.productId, loadParameters.userId, loadParameters.host]);
		
		this.loader.setParameters(loadParameters.productId, loadParameters.userId, loadParameters.host);	
		
		this.loader.onChannelLoaded = function(channelNr:Int, channelId:String, channelIds:Array<String>, data:ByteArray) 
		{
			var length = (data != null) ? data.length : 0;
			
			trace("onChannelLoaded " + channelNr + " " + channelId + " " +  channelIds + " " + length);
			
			
			if (channelNr == 0)
			{
				this.loadChannelsController.status.dispatch(LoadChannelsStatus.started(channelIds));
				this.playbackEngine.reset();
				
			}
			else if (channelNr == channelIds.length)
			{
				this.playbackEngine.addChannel(channelId, data);
				
				this.loadChannelsController.status.dispatch(LoadChannelsStatus.progress( {					
					 channelId:channelId,	
				}));
				
				this.playbackEngine.complete();
				this.loadChannelsController.status.dispatch(LoadChannelsStatus.completed);
			}
			else
			{				
				this.playbackEngine.addChannel(channelId, data);
				
				this.loadChannelsController.status.dispatch(LoadChannelsStatus.progress( {					
					 channelId:channelId,							
				}));
				
			}
			
		}
		
		
		this.loader.loadChannels();
		
	}
}



/*

import scorx.controller.LoadChannelsController;
import scorx.controller.LoadChannelsCommand;

		commandMap.mapSignalClass(LoadChannelsController, LoadChannelsCommand);
		
		
	@inject public var signalLoadChannels:Setzoom;		
		
		
*/