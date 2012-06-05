package sx.objecthandles.events;

/**
 * ...
 * @author Jonas Nyström
 */

	import flash.events.Event;

	class SelectionEvent extends Event
	{
		public static var REMOVED_FROM_SELECTION:String = "removedFromSelection";
		public static var SELECTION_CLEARED:String = "selectionCleared";
		public static var ADDED_TO_SELECTION:String = "addedToSelection";
		public static var SELECTED:String = "selected";
		
		public var targets:Array<Dynamic>;
		
		public function new(type:String, bubbles:Bool=false, cancelable:Bool=false)
		{
			this.targets = [];
			super(type, bubbles, cancelable);
		}
		
	}