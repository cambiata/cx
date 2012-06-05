package smd.server.ka.data;
import cx.FileTools;
import cx.GoogleTools;
import cx.GoogleTools.Documents;
import haxe.Firebug;
import ka.app.KalleConfig;
import neko.Web;
import smd.server.base.data.DataFunctions;
import smd.server.base.SiteState;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class Functions extends DataFunctions
{
	public function __func_hello() {		
		Firebug.trace(Web.getParams().get('hej'));
	}
	
	/*
	static public function __func_updatescorx() {
		Firebug.trace('Update Scorx!');
	}
	*/
	/*
	public function __func_access() {		
		//Firebug.trace('Access update');
		KaAccess.update(function(msg:String) {
			//Firebug.trace(msg);
			SiteState.messages.infos.push(msg);
		});
	}
	*/
	
	public function __func_xupdate() {
		var doc = Web.getParams().get('doc');
		Firebug.trace(doc);
		
		var d = new cx.GoogleTools.Documents(KalleConfig.email, KalleConfig.passwd);
		var entries = d.getDocumentEntries();
		Firebug.trace(entries);
		
		var entry = d.getEntryForTitle(doc);
		Firebug.trace(entry);
		if (entry == null) {
			SiteState.messages.errors.push("Can't find document entry " + doc);
			return;
		}
		
		var content = d.getDocumentDownloadString(entry.id, 'html');
		content = d.getCleanHtml(content);
		
		var filename = entry.title.replace('ka-sitedoc-', '');
		filename = filename.replace('_', '/');
		Firebug.trace(filename);
		
		FileTools.putContent(Web.getCwd() + '/_docs/' + filename + '.html', content);
	}
	
	public function __func_update() {
		
		var entry:DocumentEntry = null;
		var content:String = null;
		
		try {
			
			var uri = Web.getURI();
			var doc = 'ka-sitedoc-' + uri.substr(1).replace('/', '_');
			var d = new cx.GoogleTools.Documents(KalleConfig.email, KalleConfig.passwd);
			var entries = d.getDocumentEntries();
			
			entry = d.getEntryForTitle(doc);
			if (entry == null) {
				SiteState.messages.errors.push("Can't find document entry " + doc);
				return;
			}
			
			content = d.getDocumentDownloadString(entry.id, 'html');
			content = d.getCleanHtml(content);		
		} catch (e:Dynamic) {
			SiteState.messages.errors.push('Can not load remote document!');
		}
		
		try {
			var filename = entry.title.replace('ka-sitedoc-', '');
			filename = filename.replace('_', '/');
			FileTools.putContent(Web.getCwd() + '/_docs/' + filename + '.html', content);
		} catch (e:Dynamic) {
			SiteState.messages.errors.push('Can not save document!');
		}
	}
	
}