package smd.server.sxjs.widget.scorx;
import dtx.widget.Widget;
import haxe.Http;
import js.Lib;
import smd.server.sxjs.controller.ScorxlistController;
import sx.type.TComments;
/**
 * ...
 * @author Jonas Nyström
 */

 using Detox;
using StringTools;
 
class Commentsitem extends Widget
{
	private var id:Int;
	private var comments:TComments;
	private var controller:ScorxlistController;
	
	public function new( controller:ScorxlistController, id:Int, comments:TComments) {
		this.id = id;
		this.comments = comments;
		this.controller = controller;
		
		super();
		
		this.find("#comment-btn").click(function(e) {
				var text = "#comment-input".find().val();				
				//Lib.alert(text);								
				this.controller.addComment(id, text);
			});
			
		updateComments(comments);			
	}
	


	public function updateComments(comments:TComments) {
		for (comment in comments) {
			
			var alertDiv = "div".create();
			alertDiv.setAttr('class', 'alert');
			alertDiv.setCSS('width', '560px');
			alertDiv.setCSS('marginBottom', '8px');
			
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
			}
			
			this.find("#comments-div").append(alertDiv);
			

			
		}
		
		
	}
	
	

	
}