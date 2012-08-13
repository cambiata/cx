package nx.core.element;
import nx.core.element.Part;
import nx.enums.EBarline;
import nx.enums.ETime;
import nx.enums.EAttributeDisplay;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.EnumTools;
class Bar 
{
	public var parts(default, null):Array<Part>;

	public function new(parts:Iterable<Part>=null, time:ETime=null, timeDisplay:EAttributeDisplay=null, barline:EBarline=null) {
		this.parts = (parts != null) ? Lambda.array(parts) : [new Part()];
		this.time = time; // (time != null) ? time : ETime.T3_4;
		this.timeDisplay = (timeDisplay != null) ? timeDisplay : EAttributeDisplay.Layout;		
		this.barline = barline;
	}
	
	public var time(default, null): ETime;
	public var timeDisplay(default, null):EAttributeDisplay;	
	
	public var barline(default, null):EBarline;
	
	/*************************************************************
	 * XML functions
	 */
	
	static public var XBAR 					= 'bar';
	static public var XTIME 				= 'time';
	static public var XTIMEDISPLAY 	= 'timedisplay';
	static public var XBARLINE 			= 'barline';
	
	public function toXml():Xml {		
		var xml:Xml = Xml.createElement(XBAR);				
		
		for (item in this.parts) {
			var itemXml = item.toXml();
			xml.addChild(itemXml);
		}
		
		if (this.time != null) 											xml.set(XTIME, 				this.time.id);
		if (this.timeDisplay != EAttributeDisplay.Layout)	xml.set(XTIMEDISPLAY,	Std.string(this.timeDisplay));
		if (this.barline != null) 										xml.set(XBARLINE, 			Std.string(this.barline));
		return xml;
	}
	
	static public function fromXmlStr(xmlStr:String):Bar {	
		
		var xml = Xml.parse(xmlStr).firstElement();
		var items:Array<Part> = [];
		for (itemXml in xml.elementsNamed(Part.XPART)) {
			var item = Part.fromXmlStr(itemXml.toString());
			items.push(item);
		}	
		
		var time:ETime = null;
		var timeStr = xml.get(XTIME);
		if (timeStr != null) time = ETime.getFromId(timeStr);
		
		var timeDisplay 	= EAttributeDisplay.createFromString(xml.get(XTIMEDISPLAY));
		var barline 			= EBarline.createFromString(xml.get(XBARLINE));
		
		return new Bar(items, time, timeDisplay, barline);
		
	}
	
	
}