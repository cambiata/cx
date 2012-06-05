package com.roguedevelopment.objecthandles
{
	import flash.display.DisplayObject;
	

	/**
	 * A class that knows how to add and remove children from a As3 based component using
	 * either addChild or rawChildren.addChild
	 **/
	public class As3ChildManager implements IChildManager
	{
		
		public function addChild(container:Object, child:Object):void
		{
			container.addChild( child as DisplayObject);
		}
		
		public function removeChild(container:Object, child:Object):void
		{

			container.removeChild( child as DisplayObject);
		}
	}
}