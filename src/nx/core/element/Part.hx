package nx.core.element;
import nx.enums.EAttributeDisplay;
import nx.enums.EClef;
import nx.enums.EKey;
import nx.enums.EPartType;
import nx.enums.ETime;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.EnumTools;
class Part 
{
	public function new(type:EPartType=null, voices:Iterable<Voice>=null, clef:EClef=null, clefDisplay:EAttributeDisplay=null, key:EKey=null, keyDisplay:EAttributeDisplay=null, label:String='') {
		this.type = (type != null) ? type : EPartType.Normal;
		this.voices = (voices != null) ? Lambda.array(voices) : [new Voice()];
		this.key = key; // (key != null) ? key : EKey.Flat2;
		this.keyDisplay = (keyDisplay != null) ? keyDisplay : EAttributeDisplay.Layout;
		this.clef = clef; // (clef != null) ? clef : EClef.ClefC;
		this.clefDisplay = (clefDisplay != null) ? clefDisplay : EAttributeDisplay.Layout;
		
		this.label = label;
	}
	
	public var type(default, null):EPartType;	
	public var voices(default, null):Array<Voice>;
	public var key(default, null): EKey;
	public var keyDisplay(default, null):EAttributeDisplay;
	public var clef(default, null): EClef;
	public var clefDisplay(default, null):EAttributeDisplay;
	
	public var label(default, null):String;
	
	
	/*************************************************************
	 * XML functions
	 */
	
	static public var XPART 				= 'part';
	static public var XTYPE					= 'type';
	static public var XCLEF					= 'clef';
	static public var XCLEFDISPLAY		= 'clefdisplay';
	static public var XKEY					= 'key';
	static public var XKEYDISPLAY		= 'keydisplay';
	static public var XLABEL				= 'label';
	
	
	public function toXml():Xml {		
		
		var xml:Xml = Xml.createElement(XPART);				
		
		for (voice in this.voices) {
			var itemXml = voice.toXml();
			xml.addChild(itemXml);
		}
		
		if (this.type != EPartType.Normal) 						xml.set(XTYPE, 				Std.string(this.type));
		if (this.clef != null) 												xml.set(XCLEF, 				Std.string(this.clef));
		if (this.clefDisplay != EAttributeDisplay.Layout)		xml.set(XCLEFDISPLAY,	Std.string(this.clefDisplay));		
		
		if (this.key != null) 												xml.set(XKEY, 				Std.string(this.key.levelShift));
		if (this.keyDisplay != EAttributeDisplay.Layout)		xml.set(XKEYDISPLAY,		Std.string(this.keyDisplay));		
		
		if (this.label != '')												xml.set(XLABEL, 				this.label);
		
		return xml;
	}
	
	static public function fromXmlStr(xmlStr:String):Part {	
		
		var xml = Xml.parse(xmlStr).firstElement();
		
		var voices:Array<Voice> = [];
		
		for (itemXml in xml.elementsNamed(Voice.XVOICE)) {
			var item = Voice.fromXmlStr(itemXml.toString());
			voices.push(item);
		}	

		var type = EPartType.createFromString(xml.get(XTYPE));
		
		var clefDisplay = EAttributeDisplay.createFromString(xml.get(XCLEFDISPLAY));
		var clef = EClef.createFromString(xml.get(XCLEF));
		
		var keyDispaly = EAttributeDisplay.createFromString(xml.get(XKEYDISPLAY));		
		var keyValue = Std.parseInt(xml.get(XKEY));
		var key = new EKey(keyValue);
		
		var label = xml.get(XLABEL);
		
		return new Part(type, voices, clef, clefDisplay, key, keyDispaly, label);
		
	}
	
}

