package smd.server.sx;

//import smd.server.base.auth.AuthUser;
import cx.FileTools;
import cx.WebTools;
import smd.server.base.auth.AuthUser;
import smd.server.base.types.Messages;

/**
 * ...
 * @author Jonas Nyström
 */

class State 
{	
	
	static public var domaintag :String = StringTools.replace(WebTools.getDomainInfo().subMain, '.', '-');
	
	static public var indexPage: String = 'index.html'; // WebTools.getDomainInfo().submain + '.html';
	
	static public var messages:Messages = {
		errors: [],
		success: [],
		infos: [],
		systems: [],
		copyrights: [], 
		tips: [],
		discuss: [],
	}
	
	static public var pagePaths:Array<String> = getPagePaths();
	
	static public function getPagePaths(): Array<String> {
		var segments = WebTools.getUri().substr(1).split('/');
		var result:Array<String> = [];
		while (segments.length > 0) {
			result.push('/' + segments.join('/'));
			segments.pop();				
		}		
		return result;		
	}	
	
	
	static public function getAlerts() 
	{
		
		for (check in State.pagePaths) {
			// errors
			var filename = Config.contentDir + State.domaintag + '.' +  WebTools.slashToUnderscores(check) + '.error';
			if (FileTools.exists(filename)) {
				var text = FileTools.getContent(filename);
				State.messages.errors.push(text);
			}

			// infos
			var filename = Config.contentDir + State.domaintag + '.' +  WebTools.slashToUnderscores(check) + '.info';
			if (FileTools.exists(filename)) {
				var text = FileTools.getContent(filename);
				State.messages.infos.push(text);
			}			
			
			
			// copyrights
			var filename = Config.contentDir + State.domaintag + '.' +  WebTools.slashToUnderscores(check) + '.copyright';
			if (FileTools.exists(filename)) {
				var text = FileTools.getContent(filename);
				State.messages.copyrights.push(text);
			}				

			// tips
			var filename = Config.contentDir + State.domaintag + '.' +  WebTools.slashToUnderscores(check) + '.tips';
			if (FileTools.exists(filename)) {
				var text = FileTools.getContent(filename);
				State.messages.tips.push(text);
			}				
			
			// discuss
			var filename = Config.contentDir + State.domaintag + '.' +  WebTools.slashToUnderscores(check) + '.discuss';
			if (FileTools.exists(filename)) {
				var text = FileTools.getContent(filename);
				State.messages.discuss.push(text);
			}				
			
		}		
	}		
	
	
}