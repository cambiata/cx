package nx.element;
import nx.element.base.Node;
import nx.enums.EAttributeDisplay;
import nx.enums.EBarline;
import nx.enums.EHeadType;
import nx.enums.ETime;

/**
 * ...
 * @author Jonas Nyström
 */

class Bar < T:Part<Voice<Note<Head<Dynamic>>>> > extends Node<Part<Voice<Note<Head<Dynamic>>>>> {
	private var time:ETime;
	private var timeDisplay:EAttributeDisplay;
	private var barline:EBarline;
	private var barlineLeft:EBarline;
	
	public function new() { 
		this.children = new Array<Part<Voice<Note<Head<Dynamic>>>>>(); 
		this.time = ETime.T3_4;
		this.timeDisplay = EAttributeDisplay.Layout;
		this.barline = EBarline.Normal;
		this.barlineLeft = EBarline.None;
	}
	
	static public function getNew(?children:Array<Part<Voice<Note<Head<Dynamic>>>>>=null, ?time:ETime, ?timeDisplay:EAttributeDisplay, ?barline:EBarline, ?barlineLeft:EBarline) {
		var item = new Bar<Part<Voice<Note<Head<Dynamic>>>>>();
		if (children != null) 			for (child in children) item.add(child);
		if (time != null) 				item.time = time;
		if (timeDisplay != null) 		item.timeDisplay = timeDisplay;
		if (barline != null) 			item.barline = barline;
		if (barlineLeft != null) 		item.barlineLeft = barlineLeft;
		return item;
	}

	override public function toString():String {
		return super.toString() + ' \t' 
		+ 'time:' + this.time
		+ ', timeDisplay:' + this.timeDisplay
		+ ', barline:' + this.barline
		+ ', barlineLeft:' + this.barlineLeft
		;
	}
}