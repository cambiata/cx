package sx.objecthandles;

/**
 * ...
 * @author Jonas Nyström
 */

import flash.geom.Rectangle;

interface IConstraint
{
	function applyConstraint( original:DragGeometry, translation:DragGeometry, resizeHandleRole:Int ) : Void;		
}