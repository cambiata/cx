package sx.util;

import cx.StrTools;
import cx.ZipTools;
import format.tools.CRC32;
import format.zip.Data;
import format.zip.Data.Entry;
import haxe.io.Bytes;
import haxe.Serializer;
import haxe.Unserializer;
import sx.type.TChannels;
import sx.type.TChannel;
import sx.type.TExample;
import sx.type.TGrid;
import sx.type.TPage;
import sx.type.TPages;
import sx.type.TQuickstarts;

#if flash
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.events.Event;
import flash.utils.ByteArray;
#else
import cx.FileTools;
#end


/**
 * ...
 * @author Jonas Nyström
 */

using StringTools;
using cx.StrTools;

class ScorxZip
{
	private var _filename:String;
	private var _fileExists:Bool;
	private var _exampleEntry:Entry;
	private var _gridEntry:Entry;
	private var _quickstartsEntry:Entry;
	private var _channelEntries:List<Entry>;
	private var _pagesEntries:List<Entry>;
	private var _loadedCallback:Void -> Void;
	
	public function new(filename:String) 
	{
		this._filename = filename;
	}
	
	public function loadZip(loadedCallback:Void->Void) {
		this._loadedCallback = loadedCallback;
		#if flash
			var ul = new URLLoader();
			ul.dataFormat = URLLoaderDataFormat.BINARY;
			ul.addEventListener(Event.COMPLETE, onFlashZipLoaded);
			ul.load(new URLRequest(this._filename));
		#else		
			this._fileExists = FileTools.exists(this._filename);		
			if (this._fileExists) this._loadZip(this._filename);
		#end
	}
	
	
	#if flash
	private function onFlashZipLoaded(e:Event) {
		var byteArray:ByteArray = cast(e.target, URLLoader).data;
		trace(byteArray.length);
		var bytes:Bytes = Bytes.ofData(byteArray);  
		var entries = ZipTools.getEntriesFromBytes(bytes);
		this._getScorxEntries(entries);
	}
	#else 
	private function _loadZip(filename:String) {
		var entries = ZipTools.getEntries(filename);		
		this._getScorxEntries(entries);
	}
	#end
	
	///-----------------------------------------------------------------------------------------------------
	/// IF NOT FLASH:
	
#if !flash	
	public function setExample(example:TExample) {		
		var data = Bytes.ofString(Serializer.run(example));
		this._exampleEntry = cx.ZipTools.createDataEntry('example.data', data);
	}
	
	public function setGrid(grid:TGrid) {
		var data = Bytes.ofString(Serializer.run(grid));
		this._gridEntry = cx.ZipTools.createDataEntry('grid.data', data);		
	}
	
	public function setQuickstarts(quickstarts:TQuickstarts) {
		var data = Bytes.ofString(Serializer.run(quickstarts));
		this._quickstartsEntry = cx.ZipTools.createDataEntry('quickstarts.data', data);		
	}
	
	public function setChannels(channels:TChannels) {		
		this._channelEntries = new List();
		for (channel in channels) {
			var zipFilename = 'channels/' + channel.id + '.mp3';
			var entry = ZipTools.createDataEntry(zipFilename, channel.data);
			this._channelEntries.push(entry);
		}
	}
	
	public function setPages(pages:TPages) {		
		this._pagesEntries = new List();
		for (page in pages) {
			var zipFilename = 'pages/' + page.id + '.png';
			var entry = ZipTools.createDataEntry(zipFilename, page.data);
			this._pagesEntries.push(entry);
		}
	}	
	
	public function saveZip(filename:String=null) {
		var saveFilename = (filename != null) ? filename : this._filename;
		var entries = new List<Entry>();		
		if (this._gridEntry != null) entries.push(this._gridEntry);
		if (this._exampleEntry != null) entries.push(this._exampleEntry);
		if (this._quickstartsEntry != null) entries.push(this._quickstartsEntry);
		if (this._channelEntries != null) for (entry in this._channelEntries) entries.push(entry);
		if (this._pagesEntries != null) for (entry in this._pagesEntries) entries.push(entry);
		ZipTools.saveZipEntries(saveFilename, entries);
	}
#end	
	///
	///-----------------------------------------------------------------------------------------------------


	private function _getScorxEntries(entries:List<Entry>) {
		for (entry in entries) {
			//trace(entry.fileName);
			if (entry.fileName.startsWith('example.data')) this._exampleEntry = entry;
			if (entry.fileName.startsWith('grid.data')) this._gridEntry = entry;
			if (entry.fileName.startsWith('quickstarts.data')) this._quickstartsEntry = entry;
			if (entry.fileName.startsWith('channels/')) {
				if (this._channelEntries == null) this._channelEntries = new List<Entry>();
				this._channelEntries.push(entry);
			}
			if (entry.fileName.startsWith('pages/')) {
				if (this._pagesEntries == null) this._pagesEntries = new List<Entry>();
				this._pagesEntries.push(entry);
			}
		}		
		if (this._loadedCallback != null) this._loadedCallback();		
	}
	
	//-----------------------------------------------------------------------------------------------------

	public function getExample(): TExample {
		if (this._exampleEntry == null) throw "No valid TExample data";
		var data:TExample = Unserializer.run(this._exampleEntry.data.toString());
		return data;		
	}	
	
	public function getGrid(): TGrid {
		if (this._gridEntry == null) throw "No valid TGrid data";
		var data:TGrid = Unserializer.run(this._gridEntry.data.toString());
		return data;		
	}

	public function getQuickstarts(): TQuickstarts {
		if (this._quickstartsEntry == null) throw "No valid TQuickstarts data";
		var data:TQuickstarts = Unserializer.run(this._quickstartsEntry.data.toString());
		return data;		
	}
	
	public function getPages(): TPages {
		if (this._pagesEntries == null) throw "No valid Pages entries data";
		
		var items = new TPages();
		for (entry in this._pagesEntries) {
			var item:TPage = {
				id: entry.fileName.afterLast('/'),
				data: entry.data,				
			}
			items.push(item);
		}
		items.sort(function(a, b) { return Reflect.compare(a.id, b.id); } );
		return items;		
	}	
	
	public function getChannels(): TChannels {
		if (this._pagesEntries == null) throw "No valid Channels entries data";
		
		var items = new TChannels();
		for (entry in this._channelEntries) {			
			var item:TChannel = {				
				id: entry.fileName.afterLast('/'),
				name: entry.fileName,
				data: entry.data,				
			}
			items.push(item);
		}
		//var data:TExample = Unserializer.run(this._exampleEntry.data.toString());
		items.sort(function(a, b) { return Reflect.compare(a.id, b.id); } );
		return items;		
	}			
	
	
}