package sx.objecthandles.events;
import flash.events.Event;

/**
 * ...
 * @author Jonas Nyström
 */

class PropertyChangeEvent extends Event
{
	public static var PROPERTY_CHANGE:String = "propertyChange";
	
    public static function createUpdateEvent(
                                    source:Dynamic,
                                    property:Dynamic,
                                    oldValue:Dynamic,
                                    newValue:Dynamic):PropertyChangeEvent
    {
        var event:PropertyChangeEvent = new PropertyChangeEvent(PROPERTY_CHANGE);
        
        event.kind = PropertyChangeEventKind.UPDATE;
        event.oldValue = oldValue;
        event.newValue = newValue;
        event.source = source;
        event.property = property;
        
        return event;
    }	
	
    public var kind:String;
    public var newValue:Dynamic;
    public var oldValue:Dynamic;	
    public var property:Dynamic;
    public var source:Dynamic;	
	
    public function new(type:String, bubbles:Bool = false,
                                        cancelable:Bool = false,
                                        kind:String = null,
                                        property:Dynamic = null, 
                                        oldValue:Dynamic = null,
                                        newValue:Dynamic = null,
                                        source:Dynamic = null)
    {
        super(type, bubbles, cancelable);

        this.kind = kind;
        this.property = property;
        this.oldValue = oldValue;
        this.newValue = newValue;
        this.source = source;
    }
	
    override public function clone():Event
    {
        return new PropertyChangeEvent(type, bubbles, cancelable, kind,
                                       property, oldValue, newValue, source);
    }	
	
}

class PropertyChangeEventKind
{
	public static var UPDATE:String = "update";
	public static var DELETE:String = "delete";
}