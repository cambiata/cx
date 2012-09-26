package smd.server.sxjs.controller;
import haxe.Http;
import haxe.Unserializer;
import js.Lib;
import smd.server.sxjs.MainController;
import smd.server.sxjs.widget.scorx.Pagecommentsitem;
import sx.type.AjaxMessages;
import sx.type.TComments;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
using Detox;
class PagediscussionController extends Controller
{
	public var uri:String;

	/*
	 * *********************************************************
	 * CONSTRUCTOR
	 * *********************************************************
	 *
	*/
	
	public function new(main:MainController) {
		super(main);
		//trace('PagediscussionController');
		uri = Std.string(Lib.window.location);
		if (uri.startsWith('http://')) uri = uri.substr(7);
		uri = uri.substr(uri.indexOf('/'));
		//Lib.alert(uri);
	
		this.getDiscussion();
		

	}
	
	public function getDiscussion(data=null) {
		
		if (data == null) {
			data = Http.requestUrl('/sx/getpagediscussion/' + uri);
		} else {
			if (data == '') data = 'DEFAULT DATA';
		}
		
		try {
			var comments:TComments = Unserializer.run(data);			
			this.updateCommentsList(comments);
		} catch (e:Dynamic) {
			if (data.trim() != AjaxMessages.NO_PAGE_COMMENTS.trim()) {
				Lib.alert(data);
			}
		}		
	}
	
	
	
	
	private function updateCommentsList(comments:TComments) {			
			var pagediscussionwrapper = "#pagediscussionwrapper".find();
			pagediscussionwrapper.setText('');
			var item = new Pagecommentsitem(this, comments);		
			pagediscussionwrapper.append(item);						
	}
	

	
	
	
	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	

	
}