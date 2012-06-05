package sx.objecthandles.events;

/**
 * ...
 * @author Jonas Nyström
 */

   import flash.events.Event;

   class ObjectChangedEvent extends Event
   {

       public static var OBJECT_MOVED:String = "objectMoved";
       public static var OBJECT_RESIZED:String = "objectResized";
       public static var OBJECT_ROTATED:String = "objectRotated";

	   public static var OBJECT_MOVING:String = "objectMoving";
	   public static var OBJECT_RESIZING:String = "objectResizing";
	   public static var OBJECT_ROTATING:String = "objectRotating";
	   
	   //public static var OBJECT_CHANGED:String = "objectChanged";

       /**
       * An array of objects that were moved/resized or rotated.
       **/
       public var relatedObjects:Array<Dynamic>;

       public function new(relatedObjects:Array<Dynamic>, type:String, bubbles:Bool=false, cancelable:Bool=false)
       {
           super(type, bubbles, cancelable);
           this.relatedObjects = relatedObjects;
       }
       
	   /*
       public function setType(val:String):Void
       {
       	 this.type = val;
       }
	   */

   }