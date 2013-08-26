package scorx.data;

import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.utils.ByteArray;
import mloader.Loader;
import mloader.LoaderBase;
import msignal.EventSignal;

/**
 * ...
 * @author 
 */
class BytearrayLoader extends LoaderBase<ByteArray>
{
	var loader:URLLoader;
	public var tag(default, null):String;

	public function new(?url:String, tag:String)
	{
		super(url);

		this.tag = tag;
		loader = new URLLoader();
		loader.dataFormat = URLLoaderDataFormat.BINARY;

		loader.addEventListener(flash.events.ProgressEvent.PROGRESS, loaderProgressed);
		loader.addEventListener(flash.events.Event.COMPLETE, loaderCompleted);
		loader.addEventListener(flash.events.IOErrorEvent.IO_ERROR, loaderErrored);
	}

	override function loaderLoad()
	{
		loader.load(new flash.net.URLRequest(url));
	}

	override function loaderCancel()
	{

	}

	function loaderProgressed(event)
	{
		progress = 0.0;

		if (event.bytesTotal > 0)
		{
		progress = event.bytesLoaded / event.bytesTotal;
		}

		loaded.dispatchType(Progress);
	}

	function loaderCompleted(event)
	{
		content = untyped loader.data;
		loaderComplete();
	}

	function loaderErrored(event)
	{
		loaderFail(IO(Std.string(event)));
	}
}
	
