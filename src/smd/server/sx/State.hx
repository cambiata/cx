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
using StringTools;
class State 
{	
	
	//static public var domaintag :String = StringTools.replace(WebTools.getDomainInfo().subMain, '.', '-');
	
	//static public var indexPage: String = Config.templatesDir + 'index.html'; // WebTools.getDomainInfo().submain + '.html';
	
	static public var messages:Messages = {
		errors: [],
		success: [],
		infos: [],
		systems: [],
		copyrights: [], 
		tips: [],
		discuss: [],
		debugs: [],
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
			
			var pagepath = FileTools.stripLastSlash(Config.contentDir + WebTools.domaintag + check); 
			
			if (FileTools.exists(pagepath)) {
				var files = FileTools.getFilesNamesInDirectory(pagepath + '/', 'html');			
				for (file in files) {
					var filename = pagepath + '/' + file;
					if (filename.endsWith('error.html')) State.messages.errors.push(FileTools.getContent(filename));
					if (filename.endsWith('info.html')) State.messages.infos.push(FileTools.getContent(filename));
					if (filename.endsWith('copyright.html')) State.messages.copyrights.push(FileTools.getContent(filename));
					if (filename.endsWith('tips.html')) State.messages.tips.push(FileTools.getContent(filename));
					if (filename.endsWith('discuss.html')) State.messages.discuss.push(FileTools.getContent(filename));
				}
			}
			
			/*
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
			*/
			
		}		
	}		
	
	static public function getLayout():String {
		
		var layout:String = null;
		var uri = WebTools.getUri();
		
		if (uri == '/') layout = 'front';
		if (uri.startsWith('/dok')) layout = 'document';
		if (uri.startsWith('/info')) layout = 'info';
		
		return layout;
	}
	
	
}