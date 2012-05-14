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

	public function getTime():ETime {
		return this.time;
	} 
	public function setTime(time:ETime) {
		this.time = time;
		return this;
	}
	
	public function getTimeDisplay():EAttributeDisplay {
		return this.timeDisplay;
	}
	public function setTimeDisplay(timeDisplay:EAttributeDisplay) {
		this.timeDisplay = timeDisplay;
		return this;
	}
	
	public function getBarline():EBarline {
		return this.barline;
	}
	public function setBarline(barline:EBarline) {
		this.barline = barline;
		return this;
	}
	
	public function getBarlineLeft():EBarline {
		return this.barlineLeft;
	}
	public function setBarlineLeft(barlineLeft:EBarline) {
		this.barlineLeft = barlineLeft;
		return this;
	}
	
	//-----------------------------------------------------------------------------------------------------
	
	public function toXml():Xml {		
		var xml:Xml = Xml.createElement('bar');				
		for (child in this.children) {
			var cxml = child.toXml();
			xml.addChild(cxml);
		}
		
		xml.set('time', Std.string(this.getTime().id));
		xml.set('timedisplay', Std.string(this.getTimeDisplay()));
		xml.set('barline', Std.string(this.getBarline()));
		xml.set('barlineleft', Std.string(this.getBarlineLeft()));
		return xml;
	}
	
	static public function fromXml(xmlStr:String):Bar<Part<Voice<Note<Head<Dynamic>>>>> {
		var xml = Xml.parse(xmlStr).firstElement();
		
		var children = new Array<Part<Voice<Note<Head<Dynamic>>>>>();
		
		for (child in xml.elementsNamed('part')) {
			var part = Part.fromXml(child.toString());
			children.push(part);
		}	

		var time:ETime = null;
		var str = xml.get('time');
		if (str != null) try time = ETime.getFromId(str);
		
		var timeDisplay:EAttributeDisplay = null;
		var str = xml.get('timedisplay');
		if (str != null) try timeDisplay = Type.createEnum(EAttributeDisplay, str);
		
		var barline:EBarline = null;
		var str = xml.get('barline');
		if (str != null) try barline = Type.createEnum(EBarline, str);				
		
		var barlineLeft:EBarline = null;
		var str = xml.get('barlineleft');
		if (str != null) try barlineLeft = Type.createEnum(EBarline, str);		
		
		var bar = Bar.getNew(children, time, timeDisplay, barline, barlineLeft);
		return bar;
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