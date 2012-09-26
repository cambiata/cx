package smd.server.sxjs.widget.scorx;
import dtx.widget.Widget;
import haxe.Http;
import js.Lib;
import smd.server.sxjs.controller.PagediscussionController;
import sx.type.TComments;

/**
 * ...
 * @author Jonas Nyström
 */
using Detox;
using StringTools;
class Pagecommentsitem extends Widget
{
	private var controller:PagediscussionController;

	public function new(controller:PagediscussionController, comments:TComments) {
		super();
		
		this.controller = controller;
		
		var btn = this.find("#pagecommentbutton");		
		btn.click(function (e) {
			var text = this.find("#pagecommentinput").val();
			
			if (text == '') {
				Lib.alert('Ingen kommentartext angiven...');
				return;
			}
			
			this.addComment(text);
			
		});
		
		
		this.updateCommentsList(comments);
	}
	
	
	private function updateCommentsList(comments:TComments) {
		//trace(comments.length);
		
		for (comment in comments) {
			
			var alertDiv = "div".create();
			alertDiv.setAttr('class', 'alert');
			alertDiv.setCSS('width', '560px');
			alertDiv.setCSS('marginBottom', '8px');
			
			// border-radius: 0px 0px 16px 16px
			
			var nameSpan = "span".create();
			nameSpan.setText(comment.name + ': ');
			alertDiv.append(nameSpan);
			nameSpan.setCSS('marginRight', '8px');
			
			var textSpan = "span".create();
			textSpan.setText(comment.text);
			textSpan.setCSS('color', '#333333');
			alertDiv.append(textSpan);
			
			if (comment.roll.startsWith('Admin')) {
				alertDiv.addClass('alert-success');
				alertDiv.setCSS('marginLeft', '180px');
				alertDiv.setCSS('borderRadius', '16px 4px 16px 16px');
			} else {
				alertDiv.setCSS('borderRadius', '4px 16px 16px 16px');				
			}
			
			this.find("#pagecommentsdiv").append(alertDiv);			
			
			
		}
	}
	
	public function addComment(text:String) {
		
		var http = new Http('/sx/addpagecomment/' + this.controller.uri);
		http.setParameter('commenttext', text);
		http.request(false);
		http.onData = onAddedComment;		
	}
	
	private function onAddedComment(data:String) {
		//trace('onAdded...');
		this.controller.getDiscussion(data);
		/*
		var comments:TComments;
		if (data != '') {
			comments = Unserializer.run(data);
		} else {
			comments = new TComments();
		}
		*/
			
	}		
	
	
	

	
}