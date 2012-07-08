package sx.util;

#if !flash
import cx.FileTools;
#else
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.events.Event;
import flash.utils.ByteArray;
import flash.events.EventDispatcher;

#end

import cx.ZipTools;
import format.tools.CRC32;
import format.zip.Data;
import format.zip.Data.Entry;
import haxe.io.Bytes;
import haxe.Serializer;
import haxe.Unserializer;
import sx.type.TChannels;
import sx.type.TExample;
import sx.type.TGrid;
import sx.type.TPages;
import sx.type.TQuickstarts;

/**
 * ...
 * @author Jonas Nyström
 */

using StringTools;

#if !flash
class ScorxZip 
#else
class ScorxZip extends EventDispatcher
#end

{
	private var _filename:String;
	private var _fileExists:Bool;
	
	private var _exampleEntry:Entry;
	private var _gridEntry:Entry;
	private var _quickstartsEntry:Entry;
	private var _channelEntries:List<Entry>;
	private var _pagesEntries:List<Entry>;
	
	public function new(filename:String) 
	{
		this._filename = filename;
		
		
		
#if !flash		
		this._fileExists = FileTools.exists(this._filename);		
		if (this._fileExists) this._loadZip(this._filename);		
#else		
		super();
		var ul = new URLLoader();
		ul.dataFormat = URLLoaderDataFormat.BINARY;
		ul.addEventListener(Event.COMPLETE, onFlashZipLoaded);
		ul.load(new URLRequest(this._filename));
#end
		
		
	}
	
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
		if (this._channelEntries != null) for (entry in this._channelEntries) entries.push(entry);
		if (this._pagesEntries != null) for (entry in this._pagesEntries) entries.push(entry);
		
		ZipTools.saveZipEntries(saveFilename, entries);
		
	}
	
	private function _loadZip(filename:String) {
		var entries = ZipTools.getEntries(filename);		
		this._getScorxEntries(entries);
	}

#end	

#if flash
	private function onFlashZipLoaded(e:Event) {
			trace('loaded');
			
			var byteArray:ByteArray = cast(e.target, URLLoader).data;
			trace(byteArray.length);
			var bytes:Bytes = Bytes.ofData(byteArray);  
			var entries = ZipTools.getEntriesFromBytes(bytes);
			this._getScorxEntries(entries);
			
		}
#end

	private function _getScorxEntries(entries:List<Entry>) {
		for (entry in entries) {
			if (entry.fileName.startsWith('example.data')) this._exampleEntry = entry;
			if (entry.fileName.startsWith('grid.data')) this._gridEntry = entry;
			if (entry.fileName.startsWith('channels/')) {
				if (this._channelEntries == null) this._channelEntries = new List<Entry>();
				this._channelEntries.push(entry);
			}
			if (entry.fileName.startsWith('pages/')) {
				if (this._pagesEntries == null) this._pagesEntries = new List<Entry>();
				this._pagesEntries.push(entry);
			}
		}		
		trace(this._channelEntries.length);
		trace(this._pagesEntries.length);	
	
		
#if flash
		trace('dispatch');	
		this.dispatchEvent(new Event(Event.COMPLETE));
#end
		
	}

	public function getExample(): TExample {
		if (this._exampleEntry == null) throw "No valid TExample data";
		var example:TExample = Unserializer.run(this._exampleEntry.data.toString());
		return example;		
	}
	
}