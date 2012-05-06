package nx.element;

import nx.const.Constants;
import nx.element.base.Node;
import nx.element.pre.PreApoggiatura;
import nx.element.pre.PreTie;
import nx.element.post.PostTie;
import nx.enums.ESign;
import cx.Tools;

/**
 * ...
 * @author Jonas Nyström
 */

interface IHead {
	function setLevel(value:Int): IHead;
	function getLevel():Int;
	function setSign(sign:ESign): IHead;
	function getSign():ESign;
	function setApoggiatura(apoggiatura:PreApoggiatura):IHead;
	function getApoggiatura():PreApoggiatura;
	function setTieTo(tieTo:PreTie):IHead;
	function getTieTo():PreTie;
	function setTieFrom(tieFrom:PostTie): IHead;
	function getTieFrom():PostTie;
}

class Head < T:Node<Dynamic> > extends Node<Dynamic>, implements IHead {

	static public function getNew(?level:Int=0, ?sign:ESign=null) {
		var item = new Head<Dynamic>();
		item.level = level;
		item.sign = (sign != null) ? sign : ESign.None;
		return item;
	}
	
	public function new() {
		this.children = new Array<T>(); 
		this.sign = ESign.None;		
	}
	
	private var level:Int;
	public function setLevel(value:Int):IHead {
		this.level = Tools.intRange( -Constants.HEAD_MAX_LEVEL, value, Constants.HEAD_MAX_LEVEL); 
		return this;
	}
	public function getLevel():Int {
		return this.level;
	}
	
	private var sign:ESign;
	public function setSign(sign:ESign):IHead {
		this.sign = sign;
		return this;
	}	
	public function getSign():ESign {
		return this.sign;
	}
	
	private var apoggiatura:PreApoggiatura;
	public function setApoggiatura(apoggiatura:PreApoggiatura):IHead {
		this.apoggiatura = apoggiatura;
		return this;
	}
	public function getApoggiatura():PreApoggiatura {
		return this.apoggiatura;
	}
	
	private var tieTo:PreTie;
	public function setTieTo(tieTo:PreTie):IHead {
		this.tieTo = tieTo;
		return this;
	}
	public function getTieTo():PreTie {
		return this.tieTo;
	}
	
	private var tieFrom:PostTie;
	public function setTieFrom(tieFrom:PostTie):IHead {
		this.tieFrom = tieFrom;
		return this;
	}
	public function getTieFrom():PostTie {
		return this.tieFrom;
	}
	
	
	override public function toString():String {
		return super.toString() + '\t' + 'level:' + this.getLevel() + ', sign:' + this.getSign();
	}
	
	
	
}

