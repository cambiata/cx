package nx.core.element;

/**
 * ...
 * @author Jonas Nyström
 */

class Bars 
{
	public var bars(default, null): Array<Bar>;
	
	public function new(bars:Iterable<Bar>=null) 
	{
		this.bars = (bars != null) ? Lambda.array(bars) : [new Bar()];
	}
	
	/*************************************************************
	 * XML functions
	 */
	
	static public var XBARS 				= 'bars';
	//static public var XDIRECTION		= 'direction';
	
	public function toXml():Xml {		
		var xml:Xml = Xml.createElement(XBARS);				
		
		for (item in this.bars) {
			var itemXml = item.toXml();
			xml.addChild(itemXml);
		}
		
		//if (this.direction != EDirectionUAD.Auto) 		xml.set(XDIRECTION, 		Std.string(this.direction));
		
		return xml;
	}
	
	static public function fromXmlStr(xmlStr:String):Bars {	
		
		var xml = Xml.parse(xmlStr).firstElement();
		var items:Array<Bar> = [];
		for (itemXml in xml.elementsNamed(Bar.XBAR)) {
			var item = Bar.fromXmlStr(itemXml.toString());
			items.push(item);
		}	
		
		//var direction = EDirectionUAD.createFromString(xml.get(XDIRECTION));
		
		return new Bars(items);
		
	}
	
	
}