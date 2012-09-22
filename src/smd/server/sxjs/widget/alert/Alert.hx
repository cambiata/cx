package smd.server.sxjs.widget.alert;

import dtx.widget.Widget;

using Detox;
using StringTools;

class Alert extends Widget
{
	
	public function new(title:String, comment:String, cssClass:String)
	{
		super();

		// Set the title and the comment
		this.find("#title").setText(title);
		this.find("#comment").setText(comment.replace('\n', '\n<br />'));

		this.addClass(cssClass);
		
		// Set up the event to close the notification
		this.find('.close').click(function (e) {
			trace ("remove");
			this.remove();
		});
		
	}

	
}