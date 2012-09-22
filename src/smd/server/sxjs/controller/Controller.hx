package smd.server.sxjs.controller;
import haxe.Firebug;
import js.Lib;

/**
 * ...
 * @author Jonas Nyström
 */
using Detox;
class Controller 
{
	
	private function findElement(tag:String):DOMCollection {
		var domCollection = tag.find();
		if (domCollection == null) Lib.alert( "Template error: Can't find dom element " + tag);
		return domCollection;		
	}
	

	
}