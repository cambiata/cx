package nx.element;
import nx.display.beam.IBeamingProcessor;
import nx.element.base.Node;
import nx.enums.EAttributeDisplay;
import nx.enums.EClef;
import nx.enums.EKey;
import nx.enums.ESystemicBarline;
/**
 * ...
 * @author Jonas Nyström
 */

class Part < T:Voice<Note<Head<Dynamic>>> > extends Node<Voice<Note<Head<Dynamic>>>> {
	public var clef:EClef;
	public var clefDisplay:EAttributeDisplay;
	public var key:EKey;
	public var keyDisplay:EAttributeDisplay;
	public var label:String;
	public var systemicBarline:ESystemicBarline;
	private var beaming:IBeamingProcessor;
	
	public function new() { 
		this.children = new Array<Voice<Note<Head<Dynamic>>>>(); 
		this.clef = EClef.ClefG;
		this.clefDisplay = EAttributeDisplay.Layout;
		this.key = EKey.Sharp2;
		this.keyDisplay = EAttributeDisplay.Layout;
		this.systemicBarline = ESystemicBarline.Normal;
	}
	
	static public function getNew(?children:Array<Voice<Note<Head<Dynamic>>>>=null, ?clef:EClef, ?clefDisplay:EAttributeDisplay, ?key:EKey, ?keyDisplay:EAttributeDisplay,?systemicBarline:ESystemicBarline) {
		var item = new Part<Voice<Note<Head<Dynamic>>>>();
		if (children != null) 			for (child in children) item.add(child);
		if (clef != null)				item.clef = clef;
		if (clefDisplay != null)		item.clefDisplay = clefDisplay;
		if (key != null)				item.key = key;
		if (keyDisplay != null)			item.keyDisplay = keyDisplay;
		if (systemicBarline != null)	item.systemicBarline = systemicBarline;
		return item;
	}
	
	public function getClef():EClef {
		return this.clef;
	}
	
	public function getClefDisplay():EAttributeDisplay {
		return this.clefDisplay;
	}
	
	public function getKey():EKey {
		return this.key;
	}
	
	public function getKeyDisplay(): EAttributeDisplay {
		return this.keyDisplay;
	}
	
	public function getSystemicBarline():ESystemicBarline {
		return this.systemicBarline;
	}
	
	
	
	//-----------------------------------------------------------------------------------------------------
	
	public function toXml():Xml {		
		var xml:Xml = Xml.createElement('part');				
		
		for (child in this.children) {
			var cxml = child.toXml();
			xml.addChild(cxml);
		}
		
		xml.set('clef', Std.string(this.getClef ()));
		xml.set('clefdisplay', Std.string(this.getClefDisplay ()));
		xml.set('key', Std.string(this.getKey().levelShift));
		xml.set('keydisplay', Std.string(this.getKeyDisplay()));
		xml.set('systemicbarline', Std.string(this.getSystemicBarline ()));
		
		return xml;		
	}
	
	static public function fromXml(xmlStr:String):Part<Voice<Note<Head<Dynamic>>>> {
		var xml = Xml.parse(xmlStr).firstElement();
		
		var children = new Array<Voice<Note<Head<Dynamic>>>>();
		
		for (child in xml.elementsNamed('voice')) {
			var voice = Voice.fromXml(child.toString());
			children.push(voice);
		}	
		
		var clef:EClef = null;
		var str = xml.get('clef');
		if (str != null) try clef = Type.createEnum(EClef, str);		
		
		var clefDisplay:EAttributeDisplay = null;
		var str = xml.get('clefdisplay');
		if (str != null) try clefDisplay = Type.createEnum(EAttributeDisplay, str);			
		
		var key:EKey = null;
		var str = xml.get('key');
		if (str != null) try key = new EKey(Std.parseInt(str));

		var keyDisplay:EAttributeDisplay = null;
		var str = xml.get('keydisplay');
		if (str != null) try keyDisplay = Type.createEnum(EAttributeDisplay, str);			
		
		var systemicBarline:ESystemicBarline = null;
		var str = xml.get('systemicbarline');
		if (str != null) try systemicBarline = Type.createEnum(ESystemicBarline, str);			
		
		var part = Part.getNew(children, clef, clefDisplay, key, keyDisplay, systemicBarline);
		
		return part;
	}
	
	override public function toString():String {
		return super.toString() + '\t' 
		+ 'label:' + this.label 
		+ ', clef:' + this.clef 
		+ ', clefDisplay:' + this.clefDisplay
		+ ', key:' + this.key
		+ ', keyDisplay:' + this.keyDisplay
		+ ', systemicBarline:' + this.systemicBarline
		;
	}		
	
}