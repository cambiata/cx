package nx.element;
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