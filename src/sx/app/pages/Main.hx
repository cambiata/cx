package sx.app.pages;

import com.bit101.components.ScrollPane;
import com.bit101.layout.AlignHorizontal;
import com.bit101.layout.AlignVertical;
import com.bit101.layout.LayoutBehavior;
import cx.ZipTools;
import format.zip.Data;
import haxe.io.Bytes;
import haxe.io.BytesData;
import nme.display.Loader;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.events.MouseEvent;
import nme.geom.Point;
import nme.Lib;
import nme.net.URLRequest;
import nme.utils.ByteArray;
import sx.nme.display.SXEditGrid;
import sx.nme.display.SXPages;
import sx.type.TExample;
import sx.type.TPage;
import sx.util.ScorxZip;
import sx.nme.display.type.TPageSize;

#if neko
import cx.FileTools;
import cx.SqliteTools;
import neko.FileSystem;
import sys.io.File;
import sx.util.ScorxDb;
import neko.db.Sqlite;
#end



/**
 * ...
 * @author Jonas Nyström
 */

class Main extends Sprite 
{
	private var pages:SXPages;
	private var _zoom:Float;
	private var scrollPane:ScrollPane;
	private var editGrid:SXEditGrid;
	private var _pageSize:TPageSize;
	private var _horizontalMode:Bool;
	
	public function new() 
	{
		super();
		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end
	}

	private function init(e) 
	{
		
		this._zoom = 1;
		this._horizontalMode = true;
		var filename = 'testConvertedPng.zip';				
		#if flash
		filename = '../../' + filename;
		#else
		filename = '../../../' + filename;
		#end
		
		/*
		var loader = new Loader();
		this.addChild(loader);
		
		this._pages = new Pages(null, null, false);
		Lib.current.addChild(this._pages);
		
		var scorxZip = new ScorxZip(filename);
		
		scorxZip.loadZip(function() {
			trace('onLoaded');		
			this._pages.setPages(scorxZip.getPages());			
		});
		*/
		
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		
		
		scrollPane = new ScrollPane(Lib.current.stage, 0, 0);		
		//scrollPane.setDragContent(true);
		this._pageSize = { width:630.0, height:891.0, margin:8.0, horizontalMode:this._horizontalMode };
		this.pages = new SXPages(null, this._pageSize);		
		this.editGrid = new SXEditGrid(this.pages, this._pageSize);
		
		scrollPane.addChild(editGrid);
		scrollPane.setScrollHorizontal(500);
		
		new LayoutBehavior(scrollPane, AlignHorizontal.Fill, AlignVertical.Fill, 0, 0, 200, 0);
		
		var scorxZip = new ScorxZip(filename);		
		scorxZip.loadZip(function() {
			trace('onLoaded');		
			this.pages.setPages(scorxZip.getPages());	
			this.editGrid.setGrid(scorxZip.getGrid());
			
			trace(editGrid._getPageRect(0));
			trace(editGrid._getPageRect(10));
			
		});		
		
		#if neko 
		
		/*
		trace('neko');
		var filedir = 'D:/dropbox_scorxmedia/My Dropbox/smd/smdfiles/scorx/kvintessens/';
		var filename = '00000209.alaha-ruha.nyberg.PEACE.sqlite';
		
		var example:TExample = ScorxDb.getExample(filedir + filename);
		var grid = ScorxDb.getGrid(filedir + filename);
		var quickstarts = ScorxDb.getQuickstarts(filedir + filename);
		var channels = ScorxDb.getChannels(filedir + filename);
		var pages = ScorxDb.getPages(filedir + filename);		
		
		var page:TPage = pages[0];
		
		trace(page.data.length);
		var loader = new Loader();
		this.addChild(loader);
		loader.loadBytes(ByteArray.fromBytes(page.data));		
		*/
		
		/*
		var loader = new Loader();
		this.addChild(loader);				
		
		var bytes = File.getBytes('page0000.png');
		loader.loadBytes(ByteArray.fromBytes(bytes));
		*/
		
		/*
		var filename = 'data.sqlite';
		
		sys.FileSystem.deleteFile(filename);
		
		SqliteTools.createSqlite(filename);
		SqliteTools.execute(filename, 'CREATE TABLE "data" ("data" blob)  ');
		
		var cnx = Sqlite.open(filename);
		
		var bytes = File.getBytes('test.png');
		var blobdata = cnx.quote(neko.Lib.stringReference(bytes));
		var rset = cnx.request('INSERT INTO data (data) VALUES (' + blobdata + ')');		
		
		
		var sql = 'SELECT * FROM data';		
		var items = cnx.request(sql).results();
		cnx.close();						
		var bytes:Bytes = null;
		var bytesString:Bytes = null;
		for (item in items) {				
			bytes = neko.Lib.bytesReference(item.data);
			bytesString = Bytes.ofString(item.data);
		}		
		trace(bytes.length);
		trace(bytesString.length);
		FileTools.putBytes('testRef.png', bytes);
		FileTools.putBytes('testString.png', bytesString);
		loader.loadBytes(ByteArray.fromBytes(bytesString));				
		*/
		
		#end
		
		
		
		
		#if windows
		
		/*
		var filedir = 'D:/dropbox_scorxmedia/My Dropbox/smd/smdfiles/scorx/kvintessens/';
		var filename = '00000209.alaha-ruha.nyberg.PEACE.sqlite';
		
		var example:TExample = ScorxDb.getExample(filedir + filename);
		var grid = ScorxDb.getGrid(filedir + filename);
		var quickstarts = ScorxDb.getQuickstarts(filedir + filename);
		var channels = ScorxDb.getChannels(filedir + filename);
		var pages = ScorxDb.getPages(filedir + filename);		
		*/
		
		//-----------------------------------------------------------------------------------------------------
		// works!
		/*
		var bytes = FileTools.getBytes('page0000b.png');
		trace(bytes.length);
		var loader = new Loader();
		this.addChild(loader);
		loader.loadBytes(ByteArray.fromBytes(bytes));
		*/
		
		/*
		var bytes = FileTools.getBytes('page0000b.png');
		var entry = ZipTools.createDataEntry('page0000b.png', bytes);
		var entries = new List<format.zip.Data.Entry>();
		entries.push(entry);
		ZipTools.saveZipEntries('zippedPage.zip', entries);
		*/
		/*
		var entries2 = ZipTools.getEntries('zippedPage.zip');
		//trace(entries2);
		var entry = entries2.first();
		trace(entry.fileName);

		var bytes = entry.data;
		trace(bytes.length);
		var loader = new Loader();
		this.addChild(loader);
		loader.loadBytes(ByteArray.fromBytes(bytes));
		*/
		
		#end
	}
	
	private function onKeyDown(e:KeyboardEvent):Void 
	{
		trace(e.keyCode);
		//trace(Lib.current.stage.mouseX);
		
		
		/*
		for (pageNr in 0...pages.pageNum) {
			trace(editGrid._getPageRect(pageNr));
			
		}
		*/
		trace(this.editGrid.getGridRects());
		trace([]);
		
		var point = new Point(this.pages.mouseX, this.pages.mouseY);
		var nr = 0;
		for (rect in this.editGrid.getGridRects()) {
			if (rect.containsPoint(point)) {
				trace('FOUND ' + nr);
			}
			nr++;
		}
		
		
		
	}
	
	private function onMouseWheel(e:MouseEvent)
	{
		if (!e.ctrlKey) {
			if (this._pageSize.horizontalMode == true) {
				this.scrollPane.setScrollHorizontal(this.scrollPane.getScrollHorizontal() - (e.delta * 400));
			} else {
				this.scrollPane.setScrollVertical(this.scrollPane.getScrollVertical() - (e.delta * 200));
			}
			
		} else {
			this._zoom = this._zoom + (e.delta * 0.05);
			setPageZoom(this._zoom);
		}
	}
	
	private function setPageZoom(zoom:Float) {
		zoom = Math.max(Math.min(zoom, 1.5), 0.2);
		
		var pageSize:TPageSize = {
			width: 630 * zoom,
			height: 891 * zoom,
			margin: 8.0,
			horizontalMode: this._horizontalMode,
		}
		
		this.pages.setPageSize(pageSize);
		this.editGrid.setPageSize(pageSize);
		this._zoom = zoom;
		
	}
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		Lib.current.addChild(new Main());
	}
	
}
