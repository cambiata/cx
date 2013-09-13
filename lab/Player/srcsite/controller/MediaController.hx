package controller;
import cx.FileTools;
import haxe.io.Bytes;
import sx.player.ChannelUtils;
import sx.player.TPlaybackChannel;
import sx.player.TPlaybackChannels;
import sys.io.File;
import ufront.web.mvc.BytesResult;
import ufront.web.mvc.ContentResult;
import ufront.web.mvc.JsonResult;
import ufront.web.mvc.Controller;
import ufront.web.mvc.FileResult;

/**
 * ...
 * @author Jonas Nyström
 */
class MediaController extends Controller
{
	public function new() 
	{
		super();
	}
	
	public function index()
	{
		MediaUtils.getChannels(43);
		return "MediaController.index()";
	}
	
	public function screen(productId:Int = 1, pageNr:Int = 0, userId:Int = 0)
	{
		var files = MediaUtils.getScreenFilenames(productId);
		var file = files[pageNr];		
		var filebytes:Bytes = FileTools.getBytes(file);
		return new BytesResult(filebytes, 'image/png', FileTools.getFilename(file));
	}
	
	public function screenCount(productId:Int = 1)
	{
		var files = MediaUtils.getScreenFilenames(productId);
		return files.length;
	}
	
	public function thumb(productId:Int = 1, pageNr:Int = 0, userId:Int = 0)
	{
		var files = MediaUtils.getThumbFilenames(productId);
		var file = files[pageNr];		
		var filebytes:Bytes = FileTools.getBytes(file);
		return new BytesResult(filebytes, 'image/png', FileTools.getFilename(file));
	}
	
	public function thumbCount(productId:Int = 1)
	{
		var files = MediaUtils.getScreenFilenames(productId);
		return files.length;
	}	
	
	public function print(productId:Int = 1, pageNr:Int = 0, userId:Int = 0)
	{
		var files = MediaUtils.getThumbFilenames(productId);
		var file = files[pageNr];		
		var filebytes:Bytes = FileTools.getBytes(file);
		return new BytesResult(filebytes, 'image/png', FileTools.getFilename(file));
	}
	
	public function printCount(productId:Int = 1)
	{
		var files = MediaUtils.getScreenFilenames(productId);
		return files.length;
	}		
	
	public function grid(productId:Int = 1)
	{
		var filename = MediaUtils.getGridFilename(productId);
		var content = (FileTools.exists(filename)) ? FileTools.getContent(filename) : '<grid message="Grid file does not exist for product id $productId" />';
		return new ContentResult(content, 'text/xml');		
	}
	
	public function info(productId:Int = 1, userId:Int = 1)
	{
		var info:ProductInformation = {
			Message: "Message",
			ProductId: productId,
			UserId: userId,
			MediaContainer: null,
			MediaLegacyId: null,
			IsPremiumProduct: true,
			ViewDetails: null,
			PrintDetails: null,
			PlayDetails: {
				Level: 1,
				Channels: MediaUtils.getChannels(),
			},
			ScreenCount: MediaUtils.getScreenFilenames().length,
			ThumbCount: MediaUtils.getThumbFilenames().length,
			PrintCount: MediaUtils.getPrintFilenames().length,			
		}
		
		return  new JsonResult(info);
	}
	
	public function channels(productId:Int = 1)
	{
		var channels = MediaUtils.getChannels(productId);
		return new JsonResult(channels);
	}
	
	public function channel(productId:Int=1, channelId:String="200", userId=1)
	{		
		var filename = MediaUtils.getChannelFilename(productId, channelId);		
		var filebytes:Bytes = FileTools.getBytes(filename);
		return new BytesResult(filebytes, 'audio/mp3', FileTools.getFilename(filename));
	}
}

class MediaUtils 
{
	static private var FILES_DIRECTORY = "F:/_cx/lab/Player/bin/files/";
	
	static public function getChannels(productId:Int = 43): TPlaybackChannels
	{
		var files = FileTools.getFilesInDirectories(getChannelDir(productId));
		var result:TPlaybackChannels = new TPlaybackChannels();
		for (file in files)
		{			
			var fileId = FileTools.getFilename(file, false);
			var playbackChannel:TPlaybackChannel = ChannelUtils.getChannel(fileId);
			result.push(playbackChannel);
		}
		return result;
	}
	
	static public function getScreenFilenames(productId:Int = 43):Array<String>
	{
		var files = FileTools.getFilesInDirectories(getScreenDir(productId));
		var result:Array<String> = new Array<String>();
		for (file in files)
		{			
			result.push(file);
		}
		return result;		
	}
	
	static public function getThumbFilenames(productId:Int = 43):Array<String>
	{
		var files = FileTools.getFilesInDirectories(getThumbDir(productId));
		var result:Array<String> = new Array<String>();
		for (file in files)
		{			
			result.push(file);
		}
		return result;		
	}	
	
	static public function getPrintFilenames(productId:Int = 43):Array<String>
	{
		var files = FileTools.getFilesInDirectories(getPrintDir(productId));
		var result:Array<String> = new Array<String>();
		for (file in files)
		{			
			result.push(file);
		}
		return result;		
	}		
	
	
	static public function getChannelDir(productId:Int):String
	{
		return FILES_DIRECTORY + Std.string(productId) + "/channel/";		
	}
	
	static public function getScreenDir(productId:Int):String
	{
		return FILES_DIRECTORY + Std.string(productId) + "/screen/";		
	}	
	
	static public function getThumbDir(productId:Int):String
	{
		return FILES_DIRECTORY + Std.string(productId) + "/thumb/";		
	}	

	static public function getPrintDir(productId:Int):String
	{
		return FILES_DIRECTORY + Std.string(productId) + "/print/";		
	}		
	
	static public function getGridFilename(productId:Int):String
	{
		return FILES_DIRECTORY + Std.string(productId) + "/grid.xml";
	}
	
	static public function getChannelFilename(productId:Int, id:String) 
	{
		return FILES_DIRECTORY + Std.string(productId) + "/channel/" + id + ".mp3";
	}
}

typedef ProductInformation =
{
	Message:String,
	ProductId:Int,
	UserId:Int,
	MediaContainer:String,
	MediaLegacyId:String,	
	IsPremiumProduct:Bool,
	ViewDetails: TViewDetails,
	PrintDetails: TPrintDetails,
	PlayDetails: TPlayDetails,
	ScreenCount: Int,
	ThumbCount: Int,
	PrintCount: Int,
}

typedef TViewDetails = 
{
	
}

typedef TPrintDetails = 
{
	
}

typedef TPlayDetails =
{
	Level:Int,
	Channels: TPlaybackChannels,
}

/*
typedef TPlayChannels = Array<TPlayChannel>;

typedef TPlayChannel = 
{
	ChannelId:String,
	ChannelFilename: String,
	ChannelLabel:String,		
}
*/