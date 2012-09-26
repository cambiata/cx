package smd.server.sxjs.controller;
import haxe.Firebug;
import js.Lib;
import smd.server.sxjs.MainController;

/**
 * ...
 * @author Jonas Nyström
 */
using Detox;
class Controller 
{
	private var main:MainController;	
	
	public function new(main:MainController) {
		this.main = main;
		
	}
	
	private function findElement(tag:String):DOMCollection {
		var domCollection = tag.find();
		if (domCollection == null) Lib.alert( "Template error: Can't find dom element " + tag);
		return domCollection;		
	}
	

	
}