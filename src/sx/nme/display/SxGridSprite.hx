package sx.nme.display;
import cx.nme.display.ResizeSprite;
import nme.display.Graphics;
import nme.display.Sprite;
import sx.nme.display.type.TPageSize;
import sx.type.TGridItem;

/**
 * ...
 * @author Jonas Nyström
 */

class SxGridSprite extends ResizeSprite
{
	private var _systemItem:TGridItem;
	private var _barItems:Array<TGridItem>;
	private var _pageSize:TPageSize;
	private var _barSprite:Sprite;
	private var _gr:Graphics;

	public function new(x:Float=100, y:Float=100, width:Float=300, height:Float=100, systemItem:TGridItem, pageSize:TPageSize ) {	
		super(x, y, width, height);		
		this._barSprite = new Sprite();
		this._gr = this._barSprite.graphics;
		this._gr.lineStyle(1, 0xFF0000);				
		this.addChild(this._barSprite);		
		this._systemItem = systemItem;
		this._barItems = [];
		this._pageSize = pageSize;
	}
	
	public function setBarItem(gridItem:TGridItem) {		
		this._barItems.push(gridItem);
		//trace('- ' + gridItem.x);
	}
	
	public function drawBarItems() {		
		this._gr.clear();
		this._gr.lineStyle(1, 0xFF0000);			
		for (gridItem in this._barItems) {	
			var x = gridItem.x * this._pageSize.width;
			var height = gridItem.height * this._pageSize.height;
			this._gr.moveTo(x, 0);
			this._gr.lineTo(x, height);
		}
	}
	
	public function getItem():TGridItem {
		return this._systemItem;
	}
	
	
}