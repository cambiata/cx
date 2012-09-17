package smd.server.sx.data;
import cx.FileTools;
import haxe.Unserializer;
import ka.types.Scorxtillgangligheter;
import smd.server.sx.Config;
import sx.type.TListExamples;

/**
 * ...
 * @author Jonas Nyström
 */

class ScorxData 
{

	public function new() 
	{
		
	}
	
	static public function getScorxtillgangligheterIds(kategori:String):Array<Int> {		
		var scorxtg:Scorxtillgangligheter = [];
		try {			
			scorxtg = Unserializer.run(FileTools.getContent(Config.smdDir + 'scorxtillg.data'));
		} catch (e:Dynamic) { throw "Cant read scorxtillg.data"; }		
		
		for (tg in scorxtg) {			
			if (tg.kategori == kategori) return tg.ids;			
		}
		return [];
	}

	static public function getListexamples(ids:Array<Int>) {
		
		var listExamples:TListExamples = new TListExamples();		
		
		try {
			listExamples = Unserializer.run(FileTools.getContent(Config.smdDir + 'scorxlist.data'));
		} catch (e:Dynamic) { throw "Cant read scorxlist.data"; }

		var result:TListExamples = new TListExamples();
		
		for (id in ids) {
			result.set(id, listExamples.get(id));
		}
		
		return result;
	}
	
	
}