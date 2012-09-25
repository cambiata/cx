package smd.server.sxjs.widget.scorx;


import dtx.widget.Widget;
import js.Lib;
import smd.server.sxjs.MainController;
import sx.type.TListExample;

using Detox;
using StringTools;

class Scorxitem  extends Widget
{
	private var listexample:TListExample;
	private var main:MainController;
	
	public function new(main:MainController, listexample:TListExample) {
		super();
		
		this.main = main;
		
		this.listexample = listexample;
		
		this.find('#title').setText(listexample.title);
		this.find('#subtitle').setText(listexample.subtitle);		
		this.find('#bes').setText(listexample.bes);
		this.find('#bes').setAttr('class', 'badge ' + listexample.bes);
		this.find('#ack').setText(listexample.ack);
		this.find('#ack').setAttr('class', 'badge ' + listexample.ack);
		this.find('#id').setText('' + listexample.id);
		
		this.find('#like').addClass('id-' + listexample.id);
		this.find('#likespan').addClass('id-' + listexample.id);
		this.find('#liketext').addClass('id-' + listexample.id);
		
		this.find('#comments-wrapper').addClass('id-' + listexample.id);
		
		for (originatorItem in listexample.originatorItems) {
			var originatortext = originatorItem.originator.firstname + ' ' + originatorItem.originator.lastname;
			
			var aOriginator = "a".create();
			aOriginator.setAttr('href', '#');
			
			var spanOriginatortext = "span".create();
			spanOriginatortext.setText(originatortext + ' • ');
			
			aOriginator.append(spanOriginatortext);
			this.find('#originators').append(aOriginator);						
			
			aOriginator.click(function (e) { 					
				e.preventDefault();		
				trace(originatorItem);				
			} );
		}
		
		this.find('#info').click(function (e) { 			
			//trace('info');
			e.preventDefault();			
		} );
		
		this.find('#like').click(function (e) { 			
			//trace('like');
			e.preventDefault();			
		} );
		
		this.find('#comment').click(function (e) { 			
			//trace('comment');
			e.preventDefault();			
		} );
					
		this.find('#title').click( function (e) { 			
			//trace('title');
			main.testfunction(listexample.id);
			e.preventDefault();			
		} );		
		
		this.find('#like').click(onLikeClick);
		
		this.find('#comment').click(onCommentClick);
		
	}
	
	private function onCommentClick(e) {
		//var allWrappers = "#comments-wrapper";
		//allWrappers.find().setCSS('display', 'hidden');
		/*
		var idString = 'id-' + this.listexample.id;
		var wrapper = "#comments-wrapper." + idString;
		wrapper.find().setCSS('display', '');
		*/
		main.getComments(this.listexample.id);
	}
	
	private function onLikeClick(e) {
		this.main.addLike(this.listexample.id);
	}
	
	

	
}