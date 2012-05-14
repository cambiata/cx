package nx.element;
import nx.element.base.Node;
import nx.enums.EDirectionUAD;
import nx.display.beam.IBeamingProcessor;

/**
 * ...
 * @author Jonas Nyström
 */
 

interface IVoice {
	//function setDirection(direction:EDirectionUAD):Voice<Node<Head<Dynamic>>>;
	function getDirection():EDirectionUAD;
}

 
class Voice < T:Note<Head<Dynamic>> > extends Node<Note<Head<Dynamic>>>, implements IVoice {
	public function new() { 
		this.children = new Array<Note<Head<Dynamic>>>(); 
		this.direction = EDirectionUAD.Auto;
	}
	
	static public function getNew(?children:Array<Note<Head<Dynamic>>>=null, ?direction:EDirectionUAD) {
		var item = new Voice<Note<Head<Dynamic>>>();
		if (children != null) 		for (child in children) item.add(child);
		if (direction != null) 		item.direction = direction;
		return item;
	}

	private var direction:EDirectionUAD;
	public function setDirection(direction:EDirectionUAD) {
		this.direction = direction;
		return this;
	}
	public function getDirection():EDirectionUAD {
		return this.direction;
	}
	

	
	override public function toString():String {
		return super.toString() + '\t' + 'direction:' + this.getDirection();
	}		
	
	//-----------------------------------------------------------------------------------------------------
	
	public function toXml():Xml {		
		
		var xml:Xml = Xml.createElement('voice');				
		
		
		for (note in this.children) {
			var cxml = note.toXml();
			xml.addChild(cxml);
		}
		xml.set('direction', Std.string(this.getDirection()));
		return xml;
	}
	
	static public function fromXml(xmlStr:String):Voice<Note<Head<Dynamic>>> {
		
		var xml = Xml.parse(xmlStr).firstElement();
		
		var notes = new Array<Note<Head<Dynamic>>>();
		
		for (n in xml.elementsNamed('note')) {
			var note = Note.fromXml(n.toString());
			notes.push(note);
		}	
		
		var direction:EDirectionUAD = null;
		var str = xml.get('direction');
		if (str != null) try direction = Type.createEnum(EDirectionUAD, str);		
		
		var voice = Voice.getNew(notes, direction);
		
		return voice;
	}
	
}