package sx.nme.display;
import cx.nme.display.ResizeSprite;
import cx.nme.display.behavior.ResizeBehavior;
import nme.display.Sprite;
import nme.geom.Rectangle;
import sx.nme.display.SXPages;
import sx.nme.display.type.TPageSize;
import sx.type.TGrid;
import sx.type.TGridItem;
import sx.type.TGridItem.GridItemFactory;

/**
 * ...
 * @author Jonas Nyström
 */

class SXEditGrid extends Sprite 
{
	private var _pages:SXPages;
	private var _grid:TGrid;
	private var _systemsLayer:Sprite;
	private var _pageSize:TPageSize;
	private var _pageRects:IntHash<Rectangle>;

	public function new(pages:SXPages, pageSize:TPageSize, grid:TGrid=null) 
	{
		super();
		this._pages = pages;
		this._pageRects = new IntHash();
		this._pageSize = pageSize;
		//this._pages.reformatCallback = this.reformatCallback;
		this.addChild(this._pages);
		
		this._systemsLayer = new Sprite();
		this.addChild(this._systemsLayer);
		/*
		var sys = new Sprite();	
		new ResizeBehavior(sys);
		this._systemsLayer.addChild(sys);
		*/
		

		
		/*
		this._grid = new TGrid();
		
		
		///-------------------------------------
		
		this._grid.push(GridItemFactory.getNew(0.1, 0, 'system'));
		this._grid.push(GridItemFactory.getNew(0.2, 1, 'system'));
		*/
		
		this.setGrid(grid);
		this.setPageSize(this._pageSize);
	}
	
	/*
	public function reformatCallback(numPages:Int, pageSize:TPageSize, pagesCoordinates:Array<TPageCoordinates>) {
		trace('reformat callback ' + numPages);
		this._drawGridItems(numPages, pageSize, pagesCoordinates);
	}
	*/
	
	private function _formatGrid() {
		trace('format');
		while (this._systemsLayer.numChildren > 0) {
			cast(this._systemsLayer.getChildAt(0), ResizeSprite).removeListeners();
			this._systemsLayer.removeChildAt(0);
		}
		
		//trace(this._grid);
		if (this._grid == null) return;
		
		var gridSprite:SxGridSprite = null;
		
		for (gridItem in this._grid) {
			switch (gridItem.type) {
			case 'system':
				var pageNr = gridItem.page;
				var rect = this._getPageRect(pageNr);
				var x = rect.x + (gridItem.x * rect.width);
				var y = rect.y + (gridItem.y * rect.height);
				var width = gridItem.width * rect.width;
				var height = gridItem.height * rect.height;					
				gridSprite = new SxGridSprite(x, y, width, height, gridItem, this._pageSize);
				this._systemsLayer.addChild(gridSprite);						
			case 'bar':
				if (gridSprite != null) {
					gridSprite.setBarItem(gridItem);					
				}			
			}			
		}		
		
		this._updateGrid();
		
	}
	
	public function _updateGrid() {
		for (i in 0...this._systemsLayer.numChildren) {
			cast(this._systemsLayer.getChildAt(i), SxGridSprite).drawBarItems();
		}
	}
	
	
	public function setGrid(grid:TGrid) {
		this._grid = grid;
		//trace(this._grid);
		this.setPageSize(this._pageSize);		
	}
	
	public function setPageSize(pageSize:TPageSize) {
		this._pageSize = pageSize;		
		this._pageRects = new IntHash();						
		this._formatGrid();
	}	
	
	public function _getPageRect(pageNr:Int) {

		if (this._pageRects.exists(pageNr)) return this._pageRects.get(pageNr);

		var w = this._pageSize.width;
		var h = this._pageSize.height;
		var m = this._pageSize.margin;		
		var i = pageNr;
		var rect:Rectangle = new Rectangle();
		rect.width = w;
		rect.height =  h;
		if (this._pageSize.horizontalMode) {
			rect.x = (i * w) + ((i + 1) * m);
			rect.y = m;
		} else {
			rect.y = (i * h) + ((i + 1) * m);
			rect.x = m;
		}		
		this._pageRects.set(pageNr, rect);
		return rect;
		
	}
	
	public function getGridRects():Array<Rectangle> {
		/*
		var ret = new Array<Rectangle>();
		
		for (i in 0...this._systemsLayer.numChildren) {
			//cast(this._systemsLayer.getChildAt(i), SxGridSprite).
			var rect = this._systemsLayer.getChildAt(i).getBounds(this);
			ret.push(rect);
		}		
		return ret;
		*/
		return null;
		
	}
	
}
