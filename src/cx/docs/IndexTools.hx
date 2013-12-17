package cx.docs;
import haxe.ds.StringMap.StringMap;

/**
 * ...
 * @author Jonas Nyström
 */


typedef Index = Array<IndexItem>;

typedef IndexItem = {
	text:String,
	id:String,
	keyword:String,	
	pos:Int,
	length:Int,
	filename:String,
	filekey:String,
	//key2:String,
}

typedef TOC = {
	type:String,
	content:String,
	filename:String,
	filekey:String,
}

class IndexTools {	
	private var index:Index;
	public function new(indexes:Iterable<Index>) {
		this.index = new Index();
		for (index in indexes) {
			this.index = this.index.concat(index);
		}
		trace(this.index);
	}	
	
	public function getKeywordIndex():StringMap<Index> {
		var ret = new StringMap<Index>();
		for (indexItem in this.index) {			
			if (!ret.exists(indexItem.keyword)) ret.set(indexItem.keyword, new Index());
			ret.get(indexItem.keyword).push(indexItem);
		}
		return ret;
	}

	public function getTextwordIndex():StringMap<Index> {
		var ret = new StringMap<Index>();
		for (indexItem in this.index) {			
			if (!ret.exists(indexItem.text)) ret.set(indexItem.text, new Index());
			ret.get(indexItem.text).push(indexItem);
		}
		return ret;
	}
	
	public function getFilenameIndex():StringMap<Index> {
		var ret = new StringMap<Index>();
		for (indexItem in this.index) {			
			if (!ret.exists(indexItem.filename)) ret.set(indexItem.filename, new Index());
			ret.get(indexItem.filename).push(indexItem);
		}
		return ret;
	}	
	
	
	
}

class IndexParser {
	static public function parse(html:String, refFilename:String = '') :Index {
		
		var ret = new Index();
		var regex = ~/<a[ .]*href="idx:\/\/([^"]*)"[.]*>([a-zA-Z0-9]*)[.]*<\/a>/igm;
		while (regex.match(html)) {
			var indexWordsInfo = regex.matched(1);
			var textWord = regex.matched(2);

			var pos = regex.matchedPos().pos;
			var length = regex.matchedPos().len;
			html = regex.matchedRight();

			var indexWords = StrTools.splitTrim(indexWordsInfo, ';');
			
			for (indexWord in indexWords) {
				trace(indexWord);
					var index:IndexItem = {
							text:textWord,
							id:null,
							keyword:indexWord,	
							pos:pos,
							length:length,
							filename:refFilename,
							filekey:null,
					}
					ret.push(index);
			}
		}
		return ret;
	}
	
	
}