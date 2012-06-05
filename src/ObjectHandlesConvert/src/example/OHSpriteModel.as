package example 
{
	import com.roguedevelopment.objecthandles.IMoveable;
	import com.roguedevelopment.objecthandles.IResizeable;
	
	import flash.events.EventDispatcher;

	
	/** 
	 * This is an example and not part of the core ObjectHandles library. 
	 **/

	public class OHSpriteModel extends EventDispatcher implements IResizeable, IMoveable
	{
		[Bindable] public var x:Number = 10;
		[Bindable] public var y:Number  = 10;
		[Bindable] public var height:Number = 50;
		[Bindable] public var width:Number = 50;
		[Bindable] public var rotation:Number = 0;
		[Bindable] public var isLocked:Boolean = false;
		
		public function OHSpriteModel(x:Number=0, y:Number=0, height:Number=40, width:Number=40, rotation:Number=0, isLocked:Boolean=false)
		{
			this.x 			= x;
			this.y 			= y;
			this.height 	= height;
			this.width 		= width;
			this.rotation 	= rotation;
			this.isLocked 	= isLocked;
		}
		

		
	}
}