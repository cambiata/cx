package sx.objecthandles.events;

/**
 * ...
 * @author Jonas Nyström
 */

    import flash.events.Event;
	import sx.objecthandles.IHandle;
    
    class HandleClickedEvent extends Event
    {
        public static var HANDLE_CLICKED:String = "handleClicked";
        
        public var clickedHandle:IHandle;
        
        public function new(handle:IHandle)
        {
            super(HANDLE_CLICKED, false, false);
            this.clickedHandle = handle;
        }
        
        override public function clone() : Event
        {
            return new HandleClickedEvent(clickedHandle);
        }
    }