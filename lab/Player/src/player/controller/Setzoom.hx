package player.controller;

import msignal.Signal.Signal1;
import mmvc.impl.Command;
import sx.mvc.view.enums.ScrollWidgetZoom;
/**
 * ...
 * @author 
 */

 class SetzoomStatus
 {
	public var zoom:ScrollWidgetZoom;
	 public function new(zoom:ScrollWidgetZoom)
	 {
		 this.zoom = zoom;
	 }
 }
 
 
class Setzoom extends Signal1<ScrollWidgetZoom> 
{
	public function new() super(ScrollWidgetZoom);
}


/*

import player.controller.Setzoom;
	commandMap.mapSignalClass(Setzoom, SetzoomCommand);
		
	@inject public var signalSetzoom:Setzoom;		
		
		
*/