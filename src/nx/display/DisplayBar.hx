package nx.display;
import nx.element.Bar;
import nx.element.Head;
import nx.element.Note;
import nx.element.Part;
import nx.element.Voice;

/**
 * ...
 * @author Jonas Nyström
 */

interface IDisplayBar {	
	function getBar():Bar<Part<Voice<Note<Head<Dynamic>>>>>;	
	function getDisplayParts(index:Int):DisplayPart;
	function getDisplayPart(index:Int):DisplayPart;
	function getDisplayPartIndex(index:Int):DisplayPart;
	function getDisplayPartsCount(index:Int):DisplayPart;
	function getValue():Int;
}

using Lambda;

class DisplayBar {
	private var bar:Bar<Part<Voice<Note<Head<Dynamic>>>>>;
	public function getBar():Bar<Part<Voice<Note<Head<Dynamic>>>>> {
		return bar;
	}
	
	private var displayParts:Array<DisplayPart>;
	public function new(bar:Bar<Part<Voice<Note<Head<Dynamic>>>>>) {
		this.bar = bar;
		this.displayParts = new Array<DisplayPart>();
		for (child in bar.children) this.displayParts.push(new DisplayPart(child));
		this.getValue();
	}
	
	public function getDisplayPart(index:Int):DisplayPart {
		return this.displayParts[index];
	}
	
	public function getDisplayParts():Array<DisplayPart> {
		return this.displayParts;
	}
	
	public function getDisplayPartIndex(dPart:DisplayPart): Int {
		return this.displayParts.indexOf(dPart);
	}
	
	public function getDisplayPartsCount():Int {
		return this.displayParts.length;
	}
	
	private var value:Int;
	
	public function getValue():Int {
		if (this.value > 0) return this.value;
		var maxValue = 0.0;
		for (displayPart in this.getDisplayParts()) {
			maxValue = Math.max(displayPart.getValue(), maxValue);
		}
		return Std.int(maxValue);
	}
	

	
	//-----------------------------------------------------------------------------------
	public function toString() {
		var r:String = '..DisplayBar: ' + this.bar;
		for (displayPart in this.displayParts) r += '\n' + displayPart;
		return r;
	}
}