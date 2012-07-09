package sx.nme.display;
import haxe.io.BytesData;
import nme.display.Loader;
import nme.display.LoaderInfo;
import nme.display.Sprite;
import nme.events.Event;
import nme.utils.ByteArray;
import sx.nme.display.type.TPageSize;
import sx.type.TPages;

/**
 * ...
 * @author Jonas Nyström
 */

class SXPages extends Sprite
{
	private var _pages:TPages;
	private var _pageSize:TPageSize;
	public var pageNum(default, null):Int;
	//public var reformatCallback:Int->TPageSize->Array<TPageCoordinates>->Void;
	
	public function new(pages:TPages=null, pageSize:TPageSize=null) 
	{
		trace('pages');
		super();		
		this._pageSize = (pageSize == null) ? { width:210.0, height:297.0, margin:10.0, horizontalMode:true} : pageSize;		
		this.setPages(pages);		
	}
	
	public function setPages(pages:TPages) {
		this._pages = pages;
		if (this._pages != null) this._createChildren();
	}
	
	private function _createChildren() {
		while (this.numChildren > 0) this.removeChildAt(0);
		
		for (page in this._pages) {
			var loader:Loader = new Loader();			
			this.addChild(loader);			
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event) {
				var loaderInfo:LoaderInfo = cast(e.target, LoaderInfo);
				loaderInfo.loader.width = this._pageSize.width;
				loaderInfo.loader.height = this._pageSize.height;
			});
			
			#if flash
			loader.loadBytes(page.data.getData());			
			#else
			loader.loadBytes(ByteArray.fromBytes(page.data));			
			#end
			
			trace(this.numChildren);
			this.pageNum = this.numChildren;
		}
		this._formatPages();
	}
	
	private function _formatPages() {
		var c = this.numChildren;
		var w = this._pageSize.width;
		var h = this._pageSize.height;
		var m = this._pageSize.margin;
		
		
		var pcs = new Array<TPageCoordinates>();
		
		for (i in 0...c) {
			var loader:Loader = cast(this.getChildAt(i), Loader);
			loader.width = w;
			loader.height = h;
			if (this._pageSize.horizontalMode) {
				loader.x = (i * w) + ((i + 1) * m);
				loader.y = m;
			} else {
				loader.y = (i * h) + ((i + 1) * m);
				loader.x = m;
			}
			var pc:TPageCoordinates = { x:loader.x, y:loader.y };
			pcs.push(pc);
			
		}
		this.graphics.clear();
		this.graphics.beginFill(0xDDDDDD);
		var width = 0.0;
		var height = 0.0;
		if (this._pageSize.horizontalMode) {
			width = c * w + (c + 1) * m;
			height = h + (2 * m);
			this.graphics.drawRect(0, 0, width, height);		
		} else {
			width = w + (2 * m);
			height = c * h + (c + 1) * m;
			this.graphics.drawRect(0, 0, width, height);		
		}
		this.width = width;
		this.height = height;
		
		//if (this.reformatCallback != null) this.reformatCallback(c, this._pageSize, pcs);
		
	}	
	
	public function setPageSize(pageSize:TPageSize) {
		this._pageSize = pageSize;
		this._formatPages();
	}
}




typedef TPageCoordinates = {
	x:Float,
	y:Float,
}