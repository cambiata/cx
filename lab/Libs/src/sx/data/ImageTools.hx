package sx.data;
import cx.ByteArrayTools;
import cx.command.msignal.Command;
import cx.command.msignal.SerialCommand;
import cx.DataTools;
import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.utils.ByteArray;
import haxe.io.Bytes;

/**
 * ...
 * @author 
 */
class ImageTools
{
	/*
	public static function bytesToBitmaps(bytes:Bytes)
	{
		
		onStart();
		
		var items: DataItems = null;
		try 
		{
			 items = DataTools.bytesToItems(bytes);
		}
		catch (err:Dynamic)
		{
			onError(Std.string(err));
		}
		
		//------------------------------------------------------------------------------------------
		
		var targetBitmaps:Array<Bitmap> = [];
		var commands:Array<Command> = [];		
		
		//------------------------------------------------------------------------------------------
		
		for (item in items)
		{
			try 
			{
				var bytes:Bytes = item.data;
				var byteArray = ByteArrayTools.fromBytes(bytes);
				var command = new BytesToBitmapCommand(bytes, targetBitmaps);
				commands.push(command);
			}
			catch (err:Dynamic)
			{
				onError(Std.string(err));
			}
		}
		
		//------------------------------------------------------------------------------------------
		
		try 
		{
			var ser:SerialCommand = new SerialCommand(commands);		
			ser.addOnce(function () {
				onComplete(targetBitmaps);
			});
			ser.start();
		}
		catch (err:Dynamic)
		{
			onError(Std.string(err));
		}
		
		//------------------------------------------------------------------------------------------
	}
	
	dynamic static public  function onComplete(bitmaps:Array<Bitmap>) 
	{
		trace(bitmaps.length);
	}
	
	dynamic static public function onStart()
	{
		trace('onSTart');
	}
	
	dynamic static public function onError(msg:String)
	{
		
	}
	*/
}

class BytesToBitmapCommand extends Command
{
	var bytes:Bytes;
	var bitmapCompleteCallback:Bitmap -> Void;
	public function new(bytes:Bytes, bitmapCompleteCallback:Bitmap->Void)
	{
		super();
		
		this.bytes = bytes;		
		this.bitmapCompleteCallback = bitmapCompleteCallback;
		
	}	
	override public function execute()
	{
		try 
		{			
			var loader:Loader = new Loader();
			var byteArray:ByteArray = ByteArrayTools.fromBytes(this.bytes);
			loader.loadBytes(byteArray);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e)
			{
				var bitmap:Bitmap = cast(loader.content, Bitmap);
				this.bitmapCompleteCallback(bitmap);
				this.complete();
			});		
		}
		catch (err:Dynamic)
		{
			trace(Std.string(err));
		}		
	}	
}


