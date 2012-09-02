package nx.element;
import nx.element.Part;
import nx.enums.EAckolade;
import nx.enums.EBarline;
import nx.enums.EBarlineLeft;
import nx.enums.ESystemicBarline;
//import nx.enums.ETime;
import nx.enums.EAttributeDisplay;
import nx.enums.ETime;
import nx.enums.ETime.ETimeUtils;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.EnumTools;
class Bar 
{
	public var parts(default, null):Array<Part>;

	public function new(parts:Iterable<Part> = null, time:ETime = null, timeDisplay:EAttributeDisplay = null, barline:EBarline = null, barlineLeft:EBarlineLeft = null, ackolade:EAckolade = null, indentLeft:Float = 0.0, indentRight:Float=0.0) {
		this.parts 				= (parts != null) ? Lambda.array(parts) : [new Part()];
		//this.time 				= ETime.T3_4;
		this.time				= time;
		this.timeDisplay 		= (timeDisplay != null) ? timeDisplay : EAttributeDisplay.Layout;		
		this.barline 			= barline;
		this.barlineLeft 		= barlineLeft;
		this.ackolade 			= ackolade;
		this.indentLeft 		= indentLeft;
		this.indentRight 		= indentRight;
	}
	
	//public var time(default, null): ETime;
	public var time(default, default): ETime;
	public var timeDisplay(default, null):EAttributeDisplay;	
	public var barline(default, default):EBarline;	
	public var barlineLeft(default, null):EBarlineLeft;
	public var ackolade(default, null):EAckolade;
	public var indentLeft(default, null):Float;
	public var indentRight(default, null):Float;
	
	
	/*************************************************************
	 * XML functions
	 */
	
	static public var XBAR 					= 'bar';
	static public var XTIME 				= 'time';
	static public var XTIMEDISPLAY 	= 'timedisplay';
	static public var XBARLINE 			= 'barline';
	static public var XBARLINELEFT 	= 'barlineleft';
	static public var XACKOLADE	 		= 'ackolade';
	static public var XINDENTLEFT	 	= 'indentleft';
	static public var XINDENTRIGHT	= 'indentright';
	
	public function toXml():Xml {		
		var xml:Xml = Xml.createElement(XBAR);				
		
		for (item in this.parts) {
			var itemXml = item.toXml();
			xml.addChild(itemXml);
		}
		
		//if (this.time != null) 											xml.set(XTIME, 				this.time.id);
		if (this.time != null) 											xml.set(XTIME, 			ETimeUtils.toString(this.time));
		if (this.timeDisplay != EAttributeDisplay.Layout)	xml.set(XTIMEDISPLAY,	Std.string(this.timeDisplay));
		if (this.barline != null) 										xml.set(XBARLINE, 			Std.string(this.barline));
		if (this.barlineLeft != null) 									xml.set(XBARLINELEFT, 	Std.string(this.barlineLeft));
		if (this.ackolade != null) 										xml.set(XACKOLADE, 		Std.string(this.ackolade));
		if (this.indentLeft != 0.0) 									xml.set(XINDENTLEFT, 	Std.string(this.indentLeft)); 
		if (this.indentRight != 0.0) 									xml.set(XINDENTRIGHT, 	Std.string(this.indentRight));
		
		return xml;
	}
	
	static public function fromXmlStr(xmlStr:String):Bar {	
		
		var xml = Xml.parse(xmlStr).firstElement();
		var items:Array<Part> = [];
		for (itemXml in xml.elementsNamed(Part.XPART)) {
			var item = Part.fromXmlStr(itemXml.toString());
			items.push(item);
		}	
		
		/*
		var time:ETime = null;
		var timeStr = xml.get(XTIME);
		if (timeStr != null) time = ETime.getFromId(timeStr);
		*/
		
		var time:ETime		= ETimeUtils.fromString(xml.get(XTIME));
		
		var timeDisplay 			= EAttributeDisplay.createFromString(xml.get(XTIMEDISPLAY));
		var barline 					= EBarline.createFromString(xml.get(XBARLINE));
		var barlineLeft 			= EBarlineLeft.createFromString(xml.get(XBARLINELEFT));
		var ackolade 				= EAckolade.createFromString(xml.get(XACKOLADE));
		
		
		var indentLeft:Float = 0.0;
		if (xml.get(XINDENTLEFT) != null ) indentLeft = Std.parseFloat(xml.get(XINDENTLEFT));
		
		var indentRight:Float  = 0.0;
		if (xml.get(XINDENTRIGHT) != null) indentRight = Std.parseFloat(xml.get(XINDENTRIGHT));
		
		return new Bar(items, time, timeDisplay, barline, barlineLeft, ackolade , indentLeft, indentRight);
		
	}
	
	
	
	
}