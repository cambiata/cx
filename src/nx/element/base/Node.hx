package nx.element.base;

class Node < T: Node<Dynamic> > {
	public var children:Array<T>;
	public var parent: Node<Dynamic>;
	
	
	public function add(child:T) {
		this.children.push(child);
		child.parent = this;
	}
	
	public var index(getIndex, never): Int;

	public function getIndex():Int {
		return (this.parent != null) ? Lambda.indexOf(this.parent.children, this) : -1;
	}
	
	public var first(getFirst, never):T;
	private function getFirst():T {
		return this.children[0];
	}
	public var last(getLast, never):T;
	private function getLast():T {
		return this.children[this.children.length-1];
	}
	public function getChild(index:Int):T {
		return this.children[index];
	}
	public var prev(getPrev, never):T;
	private function getPrev():T {
		if (this.parent == null) return null;
		if (this.index < 1) return null;
		return this.parent.children[this.index - 1];
	}	
	public var next(getNext, never):T;
	private function getNext():T {
		if (this.parent == null) return null;
		if (this.index > this.parent.children.length-1) return null;
		return this.parent.children[this.index + 1];
	}
	public var count(getCount, never):Int;
	private function getCount():Int {
		return this.children.length;
	}

	//-----------------------------------------------------------------------------------
	public function toXml(xmlStr:String=''):String {
		var className:String = Type.getClassName(Type.getClass(this));
		xmlStr = xmlStr + '<' + className; 
		xmlStr += this.addXmlAttributes();
		//Lib.println();
		if (this.children.length > 0) {
			xmlStr += '>';
			for (child in this.children) xmlStr = child.toXml(xmlStr);
			xmlStr += '</' + className + '>';
		} else {
			xmlStr += ' />';
		}
		return xmlStr;
	}
	
	private function addXmlAttributes(): String {
		return ' test="123"';
	}
	
	//-----------------------------------------------------------------------------------
	public function tag():String 			return Type.getClassName(Type.getClass(this)) + ':' + this.index
	public function parentTag():String 		return (this.parent != null) ? Type.getClassName(Type.getClass(this.parent)) + ':' + this.parent.index : 'no parent'

	public function toString():String {
		return this.tag(); // + ' (' + this.parentTag() + ')';
	}
	public function test(?level:Int=0) {
		trace(StringTools.lpad('', '.', level) + this.toString());
		for (child in this.children) child.test(level + 1);
		
	}
}
