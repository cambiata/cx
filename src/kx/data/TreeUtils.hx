package kx.data;
import cx.ArrayTools;
import cx.EncodeTools;
import cx.FileTools;
import cx.StrTools;
import haxe.ds.StringMap.StringMap;
import sys.FileSystem;
import sys.io.File;

/**
 * ...
 * @author Jonas Nyström
 */
using Lambda;
using StringTools;

typedef DocInfo = {
	safepath: String,
	filepath: String,
	docname: String,
	sort: String,
	isDir: Bool,
	ext: String,	
}


class TreeUtils
{
	public function new() 
	{
		
	}
	
	static public function getTree(dir:String): StringMap<DocInfo>
	{
		var map = new StringMap<DocInfo>();
	
		dir = FileTools.correctPath(dir);
		var dirPath = dir; // StrTools.untilLast(dir, '/', true);
		
		//map.set(StrTools.afterLast(dir, '/') + '.dir', '');
		
		var files = FileTools.getDirectories(dir, true, null);
		var files = files.map(function(f) { return StringTools.replace(f, dirPath, ''); } ) ;	
		files = files.filter(function(val) { return (!val.startsWith('/x-')); } );
		for (filepath in files)
		{					
			var safepath = /*'doc' +*/ cleanPathFromSortnumbers(filepath); 			
			safepath = EncodeTools.pathsafe(safepath);
			safepath = FileTools.excludeExtension(safepath);
			
			var docname = FileTools.getFilename(filepath, true);
			var sortStr = docname.substr(0, 3);
			var sortvalue = Std.parseInt(sortStr);			
			if (sortvalue != null) 
			{					
				docname = docname.substring(4);
			} 
			else 
			{
				sortStr = docname;
			}
			
			var docinfo = {
				filepath: dir + filepath,
				safepath: safepath,
				docname: docname,			
				sort: sortStr,
				isDir: FileSystem.isDirectory(dir + filepath),
				ext: FileTools.getExtension(filepath),				
			}
			
			map.set(safepath, docinfo);			
		}			

		return map;	
	}	
	
	static public function cleanPathFromSortnumbers(path:String):String
	{
		var pathCleaned = '';
		var segments:Array<String> = [];
		for (s in path.split('/'))
		{
			var sortVal = s.substr(0, 4);
			var segment = s;
			if (Std.parseInt(sortVal) != null) 
			{
				segment = s.substring(4);
			}
			segments.push(segment);			
		}
		return segments.join('/');		
	}
	
	
	static public function getSortedKeys(tree:StringMap<DocInfo>): Array<DocInfo>
	{	
		var a = Lambda.array(tree);
		a.sort(function(a, b) { return Reflect.compare(a.filepath, b.filepath); } );
		return a;
	}
	
	static public function getLevels(trees:StringMap<String>): StringMap<Int>
	{
		var map = new StringMap<Int>();
		for (key in trees.keys())
		{
			var level = key.length - key.replace('/', '').length;
			map.set(key, level);			
		}
		return map;
	}
	
	static public function getSubtree(tree:StringMap<DocInfo>, levelKey:String, depth:Int=1): StringMap<DocInfo>
	{
		var map = new StringMap<DocInfo>();
		var level = StrTools.countSub(levelKey, '/');
		
		
		for (key in tree.keys())
		{
			if (key.startsWith(levelKey)) 
			{
				var subLevel = StrTools.countSub(key, '/');
				trace([subLevel, level]);
				if (subLevel <= level + depth) 
				{
					map.set(key, tree.get(key));
				}
			}
		}
		return map;
	}
}