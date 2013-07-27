package sx.data;
import mloader.ImageLoader;

/**
 * ...
 * @author 
 */
class ImageLoaderExt extends ImageLoader
{
	public var idx(default, null):Int;

	public function new(url:String, idx:Int) 
	{
		this.idx = idx;
		super(url);
	}
	
}