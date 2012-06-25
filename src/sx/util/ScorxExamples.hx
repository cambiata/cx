package sx.util;
import cx.FileTools;
import haxe.Serializer;
import haxe.Unserializer;
import neko.Utf8;
import sx.type.TScorxExamples;
import sx.util.ScorxDb;
import sx.type.THashIds;
import sx.type.TExamples;
import sx.type.TFiles;
import sx.type.TListExample;
import sx.type.TListExamples;
import sx.type.TOriginators;

/**
 * ...
 * @author Jonas Nyström
 */

class ScorxExamples 
{
	private var files:TFiles;
	private var listExamples:TListExamples;
	private var ids:Array<Int>;
	
	public function new(dir:String=null, subdirs:Array<String>=null) 
	{
		this.files = new TFiles();
		this.ids = new Array<Int>();
		this.listExamples = new TListExamples();		
		if (dir == null) return;
		this.files = ScorxTools.getFilesInDirectory(dir, subdirs);		
		this.ids = ScorxTools.getIdsFromFiles(this.files);		
		for (id in this.ids) {			
			this.listExamples.set(id, getListExample(id));
		}						
	}
	
	public function getIds():Array<Int> {
		return this.ids;
	}
	
	public function getFiles():TFiles {
		return this.files;
	}
	
	public function getFilename(id:Int) {
		return this.files.get(id);
	}
	
	public function getFilenames(stripDirectory:Bool=true) {
		var ret = new Array<String>();
		for (file in this.files) {
			var filename = (stripDirectory) ? FileTools.getFilename(file) : file;
			ret.push(filename);
		}
		ret.sort(function(a, b) { return Reflect.compare(a, b); } );
		return ret;
	}
	
	
	public function getListExamples():TListExamples {
		return this.listExamples;
	}	
	
	private function getListExample(id:Int):TListExample {
		var filename = getFilename(id);
		return ExampleTools.getListExample(ScorxDb.getExample(filename));
	}
	
	public function saveListExamples(filename:String) {
		var sl:TScorxExamples = { listExamples:null, files:null, ids:null };
		sl.listExamples = this.listExamples;
		sl.ids = this.ids;
		sl.files = this.files;		
		FileTools.putContent(filename, Serializer.run(sl));
	}
	
	public function loadListExamples(filename:String) {
		var sl:TScorxExamples = Unserializer.run(FileTools.getContent(filename));
		
		
		this.listExamples = sl.listExamples;
		this.files = sl.files;
		this.ids = sl.ids;
	}
	
}