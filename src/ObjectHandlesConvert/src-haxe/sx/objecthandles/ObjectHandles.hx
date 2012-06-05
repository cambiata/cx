package sx.objecthandles;

import cx.ReflectTools;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.sampler.NewObjectSample;
import sx.objecthandles.events.HandleClickedEvent;
import sx.objecthandles.events.PropertyChangeEvent;
import flash.utils.TypedDictionary;
import sx.objecthandles.events.SelectionEvent;
import sx.objecthandles.IFactory;
import sx.objecthandles.SpriteHandle;
import sx.objecthandles.HandleRoles;
import sx.objecthandles.HandleDescription;
import sx.objecthandles.events.ObjectChangedEvent;
import sx.objecthandles.IHandle;

/**
 * ...
 * @author Jonas Nyström
 */
using Lambda;
using Reflect;
class ObjectHandles extends EventDispatcher
{

	static public var defaultHandleClass = SpriteHandle;
	
	static public var zero = new Point(0, 0);
	
	private var container:Sprite;
	
	public var enableMultiSelect:Bool;
	
	public var selectionManager: ObjectHandlesSelectionManager;
	
	private var handleFactory:IFactory;
	
	public var defaultHandles:Array<HandleDescription>;
	

		public var multiSelectHandles:Array<Dynamic>;

        private var handles:TypedDictionary<Dynamic, Dynamic>; 

        private var models:TypedDictionary<DisplayObject, Dynamic>;

        private var constraints:TypedDictionary<Dynamic, Dynamic>;

        private var originalModelGeometry:TypedDictionary<Dynamic, Dynamic>;

        private var visuals:TypedDictionary<Dynamic, Dynamic>;
        
        private var handleDefinitions:TypedDictionary<Dynamic, Dynamic>;
        
        // Array of unused, visible=false handles
        private var handleCache:Array<Dynamic>;
        private var temp:Point;
        private var tempMatrix:Matrix;
        private var isDragging:Bool;
        private var currentDragRole:Int;
		
        private var mouseDownPoint:Point;
        private var mouseDownRotation:Float;
        private var originalGeometry:DragGeometry;
        
		/**
		 * An array of IConstraint objects that influence how the objects are allowed to be
		 * moved or resized.
		 * 
		 * For instance, put in a SizeConstraint to set the max or minimum sizes. 
		 **/
        private var defaultConstraints:Array<IConstraint>;
        
        /**
        * An array of IConstraint objects that influence how a group of objects are allowed to be
        * moved or resized.
        **/
        private var multiSelectConstraints:Array<IConstraint>;
        
        private var currentHandleConstraint:IFactory;
        
		/**
		 * Flex 3 and Flex 4 applications manage children addition/removal differently (addChild vs. addElement) so I've abstracted
		 * out that functionality into an IChildManager interface.
		 **/
		private var _childManager:IChildManager;
		
		public var modelList:Array<Dynamic>;
		
       //used to remember object changes so
       //events can be fired when the changes are complete
       public var isMoved:Bool;
       public var isResized:Bool;
       public var isRotated:Bool;
	   
	   public var multiSelectModel:DragGeometry;
            
            
       /** 
       * Many times below we have the need to create lots of temporary DragGeometry objects,
       * we can use this one instead for times when we only need one at a time so we're not
       * allocating and deallocating tons of objects causing the garbage collector to go crazy.
       * 
       * Be very careful not to use this in a way that multiple places are depending on it at once!
       *  
       **/
       private var tempGeometry:DragGeometry;
	
	
	
	
	
	
	
	public function new( container:Sprite, selectionManager:ObjectHandlesSelectionManager=null, handleFactory:IFactory=null, childManager:IChildManager=null ) 
	{
		super();
		this.defaultHandles = [];
		this.multiSelectHandles = [];
		this.handles = new TypedDictionary<Dynamic, Dynamic>(); 
		this.models = new TypedDictionary<DisplayObject, Dynamic>();
		this.constraints = new TypedDictionary<Dynamic, Dynamic>();
		this.originalModelGeometry = new TypedDictionary<Dynamic, Dynamic>();
		this.visuals = new TypedDictionary<IEventDispatcher, Dynamic>();
		this.handleDefinitions = new TypedDictionary<Dynamic, Dynamic>();
        this.handleCache = new Array<Dynamic>();
        this.temp = new Point(0, 0);		
        this.tempMatrix = new Matrix();
        this.isDragging  = false;
        this.currentDragRole = 0;
		this.defaultConstraints = [];
		this.multiSelectConstraints = [];
		this.modelList = [];
		this.isMoved = false;
		this.isResized = false;
		this.isRotated = false;
		this.multiSelectModel = new DragGeometry();
		this.tempGeometry = new DragGeometry();
		this.translation = new DragGeometry();
		
		this.container = container;
		
		this.selectionMatrix = new Matrix();
		this.objectMatrix = new Matrix();
		this.relativeGeometry = new Point();		
		

		if( selectionManager != null )          
			this.selectionManager = selectionManager;           
		else            
			this.selectionManager = new ObjectHandlesSelectionManager();		
		
		if( handleFactory != null)
			this.handleFactory = handleFactory;
		else
			this.handleFactory = new ClassFactory(SpriteHandle);
			//this.handleFactory = new flash.sampler.ClassFactory().SampleClass<SpriteHandle>();
			
			//new SpriteHandle();			
			//trace(this.handleFactory.newInstance());
			trace(this.handleFactory);
			
		this.selectionManager.addEventListener(SelectionEvent.ADDED_TO_SELECTION, onSelectionAdded );
		this.selectionManager.addEventListener(SelectionEvent.REMOVED_FROM_SELECTION, onSelectionRemoved );
		this.selectionManager.addEventListener(SelectionEvent.SELECTION_CLEARED, onSelectionCleared );			
			
			multiSelectHandles.push( new HandleDescription( HandleRoles.RESIZE_UP + HandleRoles.RESIZE_LEFT, 
				zero ,
				zero ) ); 
			
			multiSelectHandles.push( new HandleDescription( HandleRoles.RESIZE_UP ,
				new Point(50,0) , 
				zero ) ); 
			
			multiSelectHandles.push( new HandleDescription( HandleRoles.RESIZE_UP + HandleRoles.RESIZE_RIGHT,
				new Point(100,0) ,
				zero ) ); 
			
			multiSelectHandles.push( new HandleDescription( HandleRoles.RESIZE_RIGHT,
				new Point(100,50) , 
				zero ) ); 
			
			multiSelectHandles.push( new HandleDescription( HandleRoles.RESIZE_DOWN + HandleRoles.RESIZE_RIGHT,
				new Point(100,100) , 
				zero ) ); 
			
			multiSelectHandles.push( new HandleDescription( HandleRoles.RESIZE_DOWN ,
				new Point(50,100) ,
				zero ) ); 
			
			multiSelectHandles.push( new HandleDescription( HandleRoles.RESIZE_DOWN + HandleRoles.RESIZE_LEFT,
				new Point(0,100) ,
				zero ) ); 
			
			multiSelectHandles.push( new HandleDescription( HandleRoles.RESIZE_LEFT,
				new Point(0,50) ,
				zero ) ); 
							
			multiSelectHandles.push( new HandleDescription( HandleRoles.ROTATE,
				new Point(100,50) , 
				new Point(20,0) ) ); 
				
			//trace(multiSelectHandles);	
				
				
            defaultHandles.push( new HandleDescription( HandleRoles.RESIZE_UP + HandleRoles.RESIZE_LEFT, 
                                                        zero ,
                                                        zero ) ); 
        
            defaultHandles.push( new HandleDescription( HandleRoles.RESIZE_UP ,
                                                        new Point(50,0) , 
                                                        zero ) ); 
        
            defaultHandles.push( new HandleDescription( HandleRoles.RESIZE_UP + HandleRoles.RESIZE_RIGHT,
                                                        new Point(100,0) ,
                                                        zero ) ); 
        
            defaultHandles.push( new HandleDescription( HandleRoles.RESIZE_RIGHT,
                                                        new Point(100,50) , 
                                                        zero ) ); 
        
            defaultHandles.push( new HandleDescription( HandleRoles.RESIZE_DOWN + HandleRoles.RESIZE_RIGHT,
                                                        new Point(100,100) , 
                                                        zero ) ); 
            
            defaultHandles.push( new HandleDescription( HandleRoles.RESIZE_DOWN ,
                                                        new Point(50,100) ,
                                                        zero ) ); 
            
            defaultHandles.push( new HandleDescription( HandleRoles.RESIZE_DOWN + HandleRoles.RESIZE_LEFT,
                                                        new Point(0,100) ,
                                                        zero ) ); 
        
            defaultHandles.push( new HandleDescription( HandleRoles.RESIZE_LEFT,
                                                        new Point(0,50) ,
                                                        zero ) ); 
        
        
            defaultHandles.push( new HandleDescription( HandleRoles.ROTATE,
                                                        new Point(100,50) , 
                                                        new Point(20, 0) ) ); 
														
			//trace(defaultHandles);									
														
			
			
			if( childManager == null )
			{
				_childManager = new As3ChildManager();
			}
			else
			{
				_childManager = childManager;
			}
			
			trace(_childManager);
			
			
			registerComponent(multiSelectModel,null,multiSelectHandles,false);		
		
			
	}
	

	
	
        public function registerComponent( dataModel:EventDispatcher, 
        									visualDisplay:DisplayObject, //IEventDispatcher , 
        									handleDescriptions:Array<Dynamic> = null, 
        									captureKeyEvents:Bool = true,
        									customConstraints:Array<Dynamic> = null) :Void
        {
			
			trace(' - registerComponent');		
			
			
			
			
			modelList.push(dataModel);
			
			
			if( visualDisplay != null )
			{
				
	            visualDisplay.addEventListener( MouseEvent.MOUSE_DOWN, onComponentMouseDown, false, 0, true );
	
	            visualDisplay.addEventListener( SelectionEvent.SELECTED, handleSelection );
	            if(captureKeyEvents)
	            {
	             visualDisplay.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
            	}
				
				//models[visualDisplay] = dataModel;
				//models[0] = dataModel;
				//this.models[visualDisplay] = dataModel;
				this.models.set(visualDisplay, dataModel);
			}

			trace(dataModel);
			
            dataModel.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onModelChange );
            
			this.visuals.set(dataModel, visualDisplay);
           // visuals[dataModel] = visualDisplay;     
            if( handleDescriptions != null)
            {
                //handleDefinitions[ dataModel ] = handleDescriptions;
				this.handleDefinitions.set(dataModel, handleDescriptions);
            }  
            
            if( customConstraints != null)
            {
            	//constraints[dataModel] = customConstraints;
				this.constraints.set(dataModel, customConstraints);
            }  
			
        }
		
        public function addDefaultConstraint( constraint:IConstraint ) : Void
        {
        	defaultConstraints.push( constraint );
        }	
		
        public function addMultiSelectConstraint( constraint:IConstraint ) : Void
        {
        	multiSelectConstraints.push( constraint );
        }		

        public function getDisplayForModel( model:IEventDispatcher ) : IEventDispatcher
        {
        	return visuals.get(model);
        }	
		
		/*
        private function onKeyDown(event:KeyboardEvent):void
        {
            var t:DragGeometry = new DragGeometry();
            switch(event.keyCode )
            {
                case Keyboard.UP : t.y --; break;
                case Keyboard.DOWN : t.y ++; break;
                case Keyboard.RIGHT : t.x ++; break;
                case Keyboard.LEFT : t.x --; break;             
                default:return; 
            }
            
			originalGeometry = selectionManager.getGeometry();
                                
            
            applyConstraints( t, HandleRoles.MOVE );
            
            applyTranslation( t );
        }		
		*/
		
        private function hasMovementHandle( model:EventDispatcher ) : Bool
        {
            var desiredHandles:Array<HandleDescription> = getHandleDefinitions(model);
            for ( handle in desiredHandles )
            {
                if( HandleRoles.isMove( handle.role ) ) return true;
            }
            return false;
        }	
		
        private function getHandleDefinitions( model:EventDispatcher ) :Array<HandleDescription>
        {
            var desiredHandles:Array<HandleDescription>;
            desiredHandles = handleDefinitions.get(model);
            if(desiredHandles == null)
            {
                desiredHandles = defaultHandles;
            }
            return desiredHandles;
        }	
		
		public function unregisterAll() {
			for (model in this.models) {
				this.selectionManager.removeFromSelected(model);
				this.unregisterModel(model);
			}
		}		
		
        
        public function unregisterModel( model:EventDispatcher )
        {
        	var display:DisplayObject = visuals.get(model);
        	unregisterComponent( display );
        	
        }
        
        public function unregisterComponent( visualDisplay:DisplayObject ) 
        {
            visualDisplay.removeEventListener( MouseEvent.MOUSE_DOWN, onComponentMouseDown);
            visualDisplay.removeEventListener( SelectionEvent.SELECTED, handleSelection );
            visualDisplay.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
            
			var dataModel:Dynamic = findModel(visualDisplay);
           
			if( dataModel != null)
            {
            	dataModel.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onModelChange );
            }
            
			modelList.splice( modelList.indexOf(dataModel), 1 );
			
			visuals.delete(dataModel);
            models.delete(visualDisplay);
			
			if (selectionManager.currentlySelected.indexOf(dataModel) != -1 )
			{
				selectionManager.clearSelection();
			}
        }		
		
        public function findModel( display:DisplayObject ) : Dynamic
        {
            var model:Dynamic = models.get(display);
            while( (model==null) && (display.parent != null) )
            {
                display = cast(display.parent , DisplayObject);
                model = models.get( display );
            }
            return model;
        }		
		
		
        public function onModelChange(event:PropertyChangeEvent):Void
        {
            
			switch( event.property )
            {
                case "x":
                case "y":
                case "width":
                case "height":
                case "rotation": updateHandlePositions(event.target);
				case "isLocked": redrawHandle(event.target);
			}
			
        }
		
        private function onSelectionAdded( event:SelectionEvent ) 
        {
			setupHandles();			
        }
        
        private function onSelectionRemoved( event:SelectionEvent ) 
        {
			setupHandles();            
        }
        
        private function onSelectionCleared( event:SelectionEvent ) 
        {			
			setupHandles();
			lastSelectedModel=null;
        }		
		
		
		private function onKeyDown(e:Event):Void 
		{
			
		}
		

		
        private function onComponentMouseDown(event:MouseEvent)
        {           
			trace(' - onComponentMouseDown');
			
			handleSelection( event );
			
            container.stage.addEventListener(MouseEvent.MOUSE_MOVE, onContainerMouseMove );
            container.stage.addEventListener( MouseEvent.MOUSE_UP, onContainerMouseUp );

            try
            {
              event.target.setFocus();
            }catch(e:Dynamic){}
            
            var model:Dynamic = findModel( cast(event.target, DisplayObject));
            if( ! hasMovementHandle(model) )
            {
                currentDragRole = HandleRoles.MOVE; // a mouse down on the component itself as opposed to a handle is a move operation.
                currentHandleConstraint = null;
                handleBeginDrag( event );
            }
        }
		
		private function onContainerMouseUp(e:MouseEvent):Void 
		{
           if (isMoved)
           {
                dispatchEvent(new ObjectChangedEvent(selectionManager.currentlySelected, ObjectChangedEvent.OBJECT_MOVED, true));
           }
           else if (isResized)
           {
                dispatchEvent(new ObjectChangedEvent(selectionManager.currentlySelected, ObjectChangedEvent.OBJECT_RESIZED, true));
           }
           else if (isRotated)
           {
                dispatchEvent(new ObjectChangedEvent(selectionManager.currentlySelected, ObjectChangedEvent.OBJECT_ROTATED, true));
           }
           
           isMoved = false;
           isResized = false;
           isRotated = false;
           container.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onContainerMouseMove );
           container.stage.removeEventListener( MouseEvent.MOUSE_UP, onContainerMouseUp );
        
		   if( selectionManager.currentlySelected.length > 1 )
		   {
			   multiSelectModel.copyFrom( selectionManager.getGeometry() );					   
		   	   updateHandlePositions(multiSelectModel);
		   }
		   
           isDragging = false;			
		}
		
		private var translation:DragGeometry ;
		
		private function onContainerMouseMove(event:MouseEvent):Void 
		{
			trace(' - onContainerMouseMove');
			trace(currentDragRole);
			var locked:Bool = false;
			
			if( selectionManager.currentlySelected.length > 0)
			{
				for ( obj in selectionManager.currentlySelected )
				{
					 
					/*
					if( obj.hasOwnProperty("isLocked") && obj["isLocked"] )
					{
						locked = true;
					}
					*/
				}
			}
			
            if( (! isDragging) || locked) { return; }
            //var translation:DragGeometry = new DragGeometry();
			
            translation.height=0;
            translation.width=0;
            translation.x=0;
            translation.y=0;
            translation.rotation=0;
            
			
			
            if( HandleRoles.isMove( currentDragRole ) )
            {
                isMoved = true;
                applyMovement( event, translation );
                applyConstraints(translation, currentDragRole );
            }
            
            if( HandleRoles.isResizeLeft( currentDragRole ) )
            {
                isResized = true;
                applyResizeLeft( event, translation );              
            }
            
            if( HandleRoles.isResizeUp( currentDragRole) )
            {
                isResized = true;
                applyResizeUp( event, translation );                
            }
            
            if( HandleRoles.isResizeRight( currentDragRole ) )
            {
                isResized = true;
                applyResizeRight( event, translation );             
            }

            if( HandleRoles.isResizeDown( currentDragRole ) )
            {
                isResized = true;
                applyResizeDown( event, translation );                      
            }
            
            if( HandleRoles.isRotate( currentDragRole ) )
            {
                isRotated = true;
                applyRotate( event, translation );              
            }
            applyConstraints(translation, currentDragRole );
            
            applyAnchorPoint(originalGeometry, translation, currentDragRole );
            
            applyTranslation( translation );            
			
			//trace(translation);
            
            
			event.updateAfterEvent();    
			
			
			if (isMoved)
			{
								
				dispatchEvent(new ObjectChangedEvent(selectionManager.currentlySelected,ObjectChangedEvent.OBJECT_MOVING,true) );
			}
			else if (isResized)
			{
				
				dispatchEvent(new ObjectChangedEvent(selectionManager.currentlySelected,ObjectChangedEvent.OBJECT_RESIZING,true) );
			}
			else if (isRotated)
			{				
				dispatchEvent(new ObjectChangedEvent(selectionManager.currentlySelected,ObjectChangedEvent.OBJECT_ROTATING,true) );
			}	
			
		}
		
        private function handleBeginDrag( event : MouseEvent ) 
        {
            
			isDragging = true;  
            mouseDownPoint = new Point( event.stageX, event.stageY );           
            originalGeometry = selectionManager.getGeometry();
			
            
            // saving old coordinates
            originalModelGeometry = new TypedDictionary<Dynamic, Dynamic>();
			
            for (current in selectionManager.currentlySelected) {
            	originalModelGeometry.set(current, selectionManager.getGeometryForObject(current));				
            }
			
            mouseDownRotation = originalGeometry.rotation + toDegrees( getAngleInRadians(event.stageX, event.stageY) );         
        }
		
        	
        public function handleSelection( event : MouseEvent ) 
        {
            trace(' - handle selection');
			var model:Dynamic = findModel( cast(event.target, DisplayObject ));
            
            if( model == null ) { return; }
            
			
            // if shift key - add/remove to selection
            if(event.shiftKey && enableMultiSelect)  
			{
            	if(selectionManager.isSelected(model) && selectionManager.currentlySelected.length > 1) {
            		selectionManager.removeFromSelected(model);
            	} else {
					selectionManager.addToSelected(model);
            	}            
            } 
			else 
			{
				if(! selectionManager.isSelected( model ) )
            			selectionManager.setSelected( model );
            }
            
        }	

	

	
	
        public function updateHandlePositions( model:Dynamic ) 
        {
            var h:Array<IHandle> = handles.get(model);
			
            var scroll:Point = getContainerScrollAmount();
            
            if(  h == null ) { return; }
            for ( handle in h )
            {       
                /*
                if( model.hasOwnProperty("rotation") )
                {
					
					tempMatrix.identity();					
					tempMatrix.translate( (model.width * handle.handleDescriptor.percentageOffset.x / 100)  + handle.handleDescriptor.offset.x, // The tX 
										  (model.height * handle.handleDescriptor.percentageOffset.y / 100)  + handle.handleDescriptor.offset.y);
					
					//tempMatrix.translate(- Math.floor(handle.width / 2), - Math.floor(handle.height / 2));
					tempMatrix.rotate( toRadians( model.rotation ) );
					tempMatrix.translate( model.x, model.y);
					
					
					
					
					var p2:Point = tempMatrix.transformPoint( zero );
										 
					handle.rotation = model.rotation;
                    handle.x = p2.x  - scroll.x ;
                    handle.y = p2.y  - scroll.y ;
                }
                else
                {
				*/
				
                    handle.setX(model.x  + (model.width * handle.getHandleDescriptor() .percentageOffset.x / 100)  + handle.getHandleDescriptor().offset.x - scroll.x);
                    handle.setY(model.y  + (model.height * handle.getHandleDescriptor() .percentageOffset.y / 100)  + handle.getHandleDescriptor().offset.y - scroll.y);
                //}
            }   
        }
		
		public function redrawHandle( model:Dynamic ) 
		{
			var h:Array<IHandle> = handles.get(model);
			
			if( h == null ) { return; }
			
			for ( handle in h )
			{
				handle.redraw();
			}			
		}	
		
        private function getContainerScrollAmount() : Point 
        { 
            var rv:Point = new Point(0,0); 

            return rv; 
        }	
		
        private static function toRadians( degrees:Float ) :Float
        {
            return degrees * Math.PI / 180;
        }
        private static function toDegrees( radians:Float ) :Float
        {
            return radians *  180 / Math.PI;
        }		

		private var lastSelectedModel:Dynamic;
		
        private function setupHandles() 
        {   
        	
        	var selection:Array<Dynamic> = getCurrentSelection();
			
			
			if( selection.length == 0 )
			{
				removeHandles( lastSelectedModel );
				removeHandles( multiSelectModel );
			}
			else if( selection.length == 1 )
			{
				// single object selected
				
				createHandlesFor( selection[0] );
				updateHandlePositions(selection[0]);
				removeHandles( multiSelectModel );
				removeHandles( lastSelectedModel );
				lastSelectedModel = selection[0] ;
			}
			else
			{
				// Many objects selected
				removeHandles( lastSelectedModel );
				var geo:DragGeometry = selectionManager.getGeometry();				
				if(geo != null)
				{
					multiSelectModel.copyFrom( geo );
					createHandlesFor( multiSelectModel );
					updateHandlePositions( multiSelectModel );
					lastSelectedModel = multiSelectModel;
				}
			}
        }	
		
		private function createHandlesFor( model:Dynamic ) 
		{
			var desiredHandles:Array<HandleDescription> = getHandleDefinitions(model);
			for ( descriptor in desiredHandles )
			{
				createHandle( model, descriptor);
			}			
		}	
		
        private function createHandle( model:Dynamic, descriptor:HandleDescription ) 
        {
            var current:Array<IHandle> = handles.get(model);
            if( current == null) 
            {
                current = [];
                handles.set(model, current);
            }
            // todo: use cached handles for performance.
            //var handle:IHandle
            
            /*
			if (descriptor.handleFactory != null)
            {
                handle = descriptor.handleFactory.newInstance() as IHandle;
            }
            else
            {
                handle = handleFactory.newInstance() as IHandle;
            }
			*/
			var handle:IHandle = new SpriteHandle();
			
            handle.setTargetModel(model);
            handle.setHandleDescriptor(descriptor);
            connectHandleEvents( handle , descriptor);
            current.push(handle);
            addToContainer( cast(handle, Sprite));
            handle.redraw();
        }	
		
        private function connectHandleEvents( handle:IHandle , descriptor:HandleDescription) 
        {
            handle.addEventListener( MouseEvent.MOUSE_DOWN, onHandleDown );
        }		
		
        private function addToContainer( display:Sprite)
        {
            _childManager.addChild(container, display );
        }       
        
        private function removeFromContainer( display:Sprite)
        {
			_childManager.removeChild(container, display );            
        }	
		
        private function removeHandles( model:Dynamic ) 
        {
			
			var currentHandles:Array<IHandle> = handles.get(model);
            
			if (currentHandles == null) return;
            
			for (  handle in currentHandles )
            {               
                if( handleCache.length <= 10 )
                {
                    
					handle.setVisible(false);
                    handleCache.push( handle );
                }
                else
                {
                    removeFromContainer( cast(handle, Sprite));                  
                }
            }
            
            handles.delete(model); 
            
        }		
		
		private function onHandleDown(event:MouseEvent):Void 
		{
            var handle:IHandle = cast(event.target, IHandle);
            if( handle == null ) { return; }
            
            
            // If it has NO_ROLE we just send an event as it is more like a "click"
            if (handle.getHandleDescriptor().role == HandleRoles.NO_ROLE)
            {
                dispatchEvent( new HandleClickedEvent(cast(event.target, IHandle)) );
            }
            else
            {
                container.stage.addEventListener(MouseEvent.MOUSE_MOVE, onContainerMouseMove );
                container.stage.addEventListener( MouseEvent.MOUSE_UP, onContainerMouseUp );
    
                currentDragRole = handle.getHandleDescriptor().role;
                currentHandleConstraint = handle.getHandleDescriptor().constraint;
                handleBeginDrag(event);
            }			
		}
		
		private function getCurrentSelection() : Array<Dynamic>
		{
			
			var rv:Array<Dynamic> = [];
			for (  model in selectionManager.currentlySelected )
			{
				if( visuals.has(model))
				{
					rv.push( model );
				}				
			}			
			return rv;
		}		
		
         private function getAngleInRadians(x:Float,y:Float):Float
         {
            tempMatrix.identity();
            var mousePos:Point = container.globalToLocal( new Point(x,y) );
			
            var angle1:Float;
            tempMatrix.rotate( toRadians( originalGeometry.rotation)  );
            var originalCenter:Point = tempMatrix.transformPoint( new Point(originalGeometry.width/2, originalGeometry.height/2) );
            originalCenter.offset( originalGeometry.x,  originalGeometry.y );
			
            return Math.atan2(mousePos.y - originalCenter.y, mousePos.x - originalCenter.x) ; 
        }		

        private function applyAnchorPoint( original:DragGeometry, translation:DragGeometry, currentDragRole:Int ) 
        {
        	if( HandleRoles.isRotate( currentDragRole ) )
        	{
        		var mid:Point =  new Point(original.width/2, original.height/2) ;
        		// We want to rotate around the center instead of around the upper left corner.
        		tempMatrix.identity();
        		tempMatrix.rotate( toRadians(original.rotation) );
        		temp = tempMatrix.transformPoint( mid ); // this is where the center was.
        		
        		tempMatrix.identity();
        		tempMatrix.rotate( toRadians(original.rotation + translation.rotation) );
        		mid = tempMatrix.transformPoint( mid ); // This is where the new center should be.
        		
        		translation.x = temp.x - mid.x;
        		translation.y = temp.y - mid.y;
        		
        	}
        	
        	
        	if( HandleRoles.isResize(currentDragRole)  ) 
        	{
        
	        	var proportion:Point = getAnchorProportion( currentDragRole );
	        	
	        	tempMatrix.identity();
	        	tempMatrix.rotate(toRadians(original.rotation));
	        	
	        	temp.x = (proportion.x *  (translation.width + originalGeometry.width)) - proportion.x *  originalGeometry.width;
	        	temp.y = (proportion.y * (translation.height + originalGeometry.height)) - proportion.y * originalGeometry.height;
	        	
	        	
	        	
	        	temp = tempMatrix.transformPoint( temp );
	        	
	        	translation.x += temp.x;
	        	translation.y += temp.y;
        	}
        	
       }		
		
        private function getAnchorProportion( resizeHandleRole:Int) : Point
        {
        	 var anchorPoint:Point = new Point();
            if( HandleRoles.isResizeUp(resizeHandleRole)  )
            {
            	if( HandleRoles.isResizeLeft( resizeHandleRole ) )
            	{
	            	// Upper left handle being used, so the lower right corner should not move.
	            	anchorPoint.x = -1; 
	            	anchorPoint.y = -1; 
	            }
	            else if( HandleRoles.isResizeRight( resizeHandleRole ) )
	            {
	            	// Upper right handle
	            	anchorPoint.x = 0; 
	            	anchorPoint.y = -1; 	            	
	            }
	            else
	            {
	            	anchorPoint.x = -0.5;
	            	anchorPoint.y = -1;	            		            	
	            }
            }
            else if( HandleRoles.isResizeDown(resizeHandleRole)  )
            {
            	if( HandleRoles.isResizeLeft( resizeHandleRole ) )
            	{
	            	// lower left handle
	            	anchorPoint.x = -1;
	            	anchorPoint.y = 0;
	            }
	            else if( HandleRoles.isResizeRight( resizeHandleRole ) )
	            {
	            	// lower right handle
	            	anchorPoint.x = 0;
	            	anchorPoint.y = 0;	            	
	            }
	            else
	            {
	            	// middle bottom handle
	            	anchorPoint.x = -0.5;
	            	anchorPoint.y = 0;	            		            	
	            }
            }
            else if( HandleRoles.isResizeLeft(resizeHandleRole) )
            {
            	// left middle handle
            	anchorPoint.x = -1;
            	anchorPoint.y = -0.5;
            }
            else 
            {
            	// right middle
            	anchorPoint.x = 0;
            	anchorPoint.y = -0.5;
            }

            return anchorPoint;
        }
		
        private function applyMovement( event:MouseEvent, translation:DragGeometry ) 
        {           
			
			temp.x = event.stageX;
            temp.y = event.stageY;
            var localDown:Point = container.globalToLocal( mouseDownPoint );
            var current:Point = container.globalToLocal( temp );
            var mouseDelta:Point = new Point( current.x - localDown.x, current.y - localDown.y );
            
            
            translation.x = mouseDelta.x;
            translation.y = mouseDelta.y;
            
        }		
		
        private function applyConstraints(translation:DragGeometry, currentDragRole:Int)
        {
        	var constraint:IConstraint;
        	

            if (currentHandleConstraint != null)
            {
                currentHandleConstraint.newInstance().applyConstraint( originalGeometry, translation, currentDragRole );
            }
        	
			if( selectionManager.currentlySelected.length > 1 )
			{
				// Deal with multi-select
				for ( constraint in multiSelectConstraints )
				{
					constraint.applyConstraint( originalGeometry, translation, currentDragRole );
				} 
				return;
				// we'll apply per-component constraints in the applyTranslation method
			}
			
			
         	// Single object selection constraint...
         	applySingleObjectConstraints( selectionManager.currentlySelected[0], originalGeometry, translation, currentDragRole );
         	   
            
        }	
		
        private function applySingleObjectConstraints(modelObject:Dynamic, originalGeometry:DragGeometry, translation:DragGeometry, currentDragRole:Int)
        {
        	var constraint:IConstraint;
        	
        	// Default ObjectHandles wide constraints
            for  ( constraint in defaultConstraints )
            {
                constraint.applyConstraint( originalGeometry, translation, currentDragRole );
            }
            
            // Constraints that are set on a per component basis in the registerComponent call
            var customConstraints:Array<Dynamic> = constraints.get(modelObject);
			
            if( customConstraints != null )
            {
            	for ( constraint in customConstraints )
            	{
            		constraint.applyConstraint( originalGeometry, translation, currentDragRole );
            	}
            } 
            
        }	
		
       private function applyResizeRight( event:MouseEvent, translation:DragGeometry ) 
        {
            var containerOriginalMousePoint:Point = container.globalToLocal(new Point( mouseDownPoint.x, mouseDownPoint.y ));       
            var containerMousePoint:Point = container.globalToLocal( new Point(event.stageX, event.stageY) );
            
            // "local coordinates" = the coordinate system that is relative to the piece that moves around.
            
            // matrix describes the current rotation and helps us to go from container to local coordinates 
            tempMatrix.identity();
            tempMatrix.rotate( toRadians( originalGeometry.rotation ) );
            // The inverse matrix helps us to go from local to container coordinates
            var invMatrix:Matrix = tempMatrix.clone();
            invMatrix.invert();
            
            // The point where we pressed the mouse down in local coordinates
            var localOriginalMousePoint:Point = invMatrix.transformPoint( containerOriginalMousePoint );
            // The point where the mouse is currently in local coordinates
            var localMousePoint:Point = invMatrix.transformPoint( containerMousePoint );
            
            // How far along the X axis (in local coordinates) has the mouse been moved?  This is the amount the user has tried to resize the object
            var resizeDistance:Float = localMousePoint.x - localOriginalMousePoint.x;
            
            // So our new width is the original width plus that resize amount
            translation.width +=  resizeDistance;
            
//            applyConstraints(translation, currentDragRole );
            
//            // Now, that we've resize the object, we need to know where the upper left corner should get moved to because when we resize left, we have to move left.
//            var translationp:Point = matrix.transformPoint( zero );
//            
//            translation.x +=  translationp.x;
//            translation.y +=  translationp.y;
        }
        
        private function applyResizeDown( event:MouseEvent, translation:DragGeometry ) 
        {
            var containerOriginalMousePoint:Point = container.globalToLocal(new Point( mouseDownPoint.x, mouseDownPoint.y ));       
            var containerMousePoint:Point = container.globalToLocal( new Point(event.stageX, event.stageY) );
            
            // "local coordinates" = the coordinate system that is relative to the piece that moves around.
            
            // matrix describes the current rotation and helps us to go from container to local coordinates 
            tempMatrix.identity();
            tempMatrix.rotate( toRadians( originalGeometry.rotation ) );
            // The inverse matrix helps us to go from local to container coordinates
            var invMatrix:Matrix = tempMatrix.clone();
            invMatrix.invert();
            
            // The point where we pressed the mouse down in local coordinates
            var localOriginalMousePoint:Point = invMatrix.transformPoint( containerOriginalMousePoint );
            // The point where the mouse is currently in local coordinates
            var localMousePoint:Point = invMatrix.transformPoint( containerMousePoint );
            
            // How far along the X axis (in local coordinates) has the mouse been moved?  This is the amount the user has tried to resize the object
            var resizeDistance:Float = localMousePoint.y - localOriginalMousePoint.y;
            
            // So our new width is the original width plus that resize amount
            translation.height +=  resizeDistance;
            
//            applyConstraints(translation, currentDragRole );
            
//            // Now, that we've resize the object, we need to know where the upper left corner should get moved to because when we resize left, we have to move left.
//            var translationp:Point = matrix.transformPoint( zero );
//            
//            translation.x +=  translationp.x;
//            translation.y +=  translationp.y;
        }
        
        private function applyResizeLeft( event:MouseEvent, translation:DragGeometry ) 
        {
            var containerOriginalMousePoint:Point = container.globalToLocal(new Point( mouseDownPoint.x, mouseDownPoint.y ));       
            var containerMousePoint:Point = container.globalToLocal( new Point(event.stageX, event.stageY) );
            
            // "local coordinates" = the coordinate system that is relative to the piece that moves around.
            
            // matrix describes the current rotation and helps us to go from container to local coordinates 
            tempMatrix.identity();
            tempMatrix.rotate( toRadians( originalGeometry.rotation ) );
            // The inverse matrix helps us to go from local to container coordinates
            var invMatrix:Matrix = tempMatrix.clone();
            invMatrix.invert();
            
            // The point where we pressed the mouse down in local coordinates
            var localOriginalMousePoint:Point = invMatrix.transformPoint( containerOriginalMousePoint );
            // The point where the mouse is currently in local coordinates
            var localMousePoint:Point = invMatrix.transformPoint( containerMousePoint );
            
            // How far along the X axis (in local coordinates) has the mouse been moved?  This is the amount the user has tried to resize the object
            var resizeDistance:Float = localOriginalMousePoint.x - localMousePoint.x ;
            
            // So our new width is the original width plus that resize amount
            translation.width +=  resizeDistance;
            
            
//            applyConstraints(translation, currentDragRole );
            
//            // Now, that we've resize the object, we need to know where the upper left corner should get moved to because when we resize left, we have to move left.
//            var translationp:Point = matrix.transformPoint( new Point(-translation.width,0) );
//            
//            translation.x +=  translationp.x;
//            translation.y +=  translationp.y;
        }
        
        private function applyResizeUp( event:MouseEvent, translation:DragGeometry ) 
        {
            var containerOriginalMousePoint:Point = container.globalToLocal(new Point( mouseDownPoint.x, mouseDownPoint.y ));       
            var containerMousePoint:Point = container.globalToLocal( new Point(event.stageX, event.stageY) );
            
            // "local coordinates" = the coordinate system that is relative to the piece that moves around.
            
            // matrix describes the current rotation and helps us to go from container to local coordinates 
            tempMatrix.identity();
            tempMatrix.rotate( toRadians( originalGeometry.rotation ) );
            // The inverse matrix helps us to go from local to container coordinates
            var invMatrix:Matrix = tempMatrix.clone();
            invMatrix.invert();
            
            // The point where we pressed the mouse down in local coordinates
            var localOriginalMousePoint:Point = invMatrix.transformPoint( containerOriginalMousePoint );
            // The point where the mouse is currently in local coordinates
            var localMousePoint:Point = invMatrix.transformPoint( containerMousePoint );
            
            // How far along the Y axis (in local coordinates) has the mouse been moved?  This is the amount the user has tried to resize the object
            var resizeDistance:Float = localOriginalMousePoint.y - localMousePoint.y ;
            
            // So our new width is the original width plus that resize amount
            translation.height +=  resizeDistance;
            
//            applyConstraints(translation, currentDragRole );
            
            // Now, that we've resize the object, we need to know where the upper left corner should get moved to because when we resize left, we have to move left.
//            var translationp:Point = matrix.transformPoint( new Point(0, -translation.height) );
//            
//            translation.x += translationp.x;
//            translation.y += translationp.y;
        }       
        
		
        private function applyRotate( event:MouseEvent, proposed:DragGeometry ) 
        {
        	
        	
        	
            var centerRotatedAmount:Float = toRadians(originalGeometry.rotation) - 
											 toRadians(mouseDownRotation) + 
											 getAngleInRadians(event.stageX, event.stageY);
            
            tempMatrix.identity();
            //var oldRotationMatrix:Matrix = new Matrix();
            tempMatrix.rotate( toRadians( originalGeometry.rotation) );
            var oldCenter:Point = tempMatrix.transformPoint(new Point(originalGeometry.width/2,originalGeometry.height/2));
//          
            var newRotationMatrix:Matrix = new Matrix();
            //newRotationMatrix.rotate( toRadians(originalGeometry.rotation) );
            newRotationMatrix.translate(-oldCenter.x, -oldCenter.y);//-originalGeometry.width/2,-originalGeometry.height/2);                                    
            newRotationMatrix.rotate( centerRotatedAmount );
            newRotationMatrix.translate(oldCenter.x, oldCenter.y);
            
            
                                      
            var newOffset:Point = newRotationMatrix.transformPoint( zero );
            
            
           // proposed.x += newOffset.x;
           // proposed.y += newOffset.y;
            proposed.rotation = toDegrees(centerRotatedAmount);
            
            
        }  		
		
		private function applyTranslation( translation:DragGeometry) 
        {
			
            if( selectionManager.currentlySelected.length == 1 )
            {               				
				applyTranslationForSingleObject( selectionManager.currentlySelected[0], translation, originalGeometry );                    
            }
            else if( selectionManager.currentlySelected.length > 1 )
            {				
				applyTranslationForSingleObject(multiSelectModel, translation , originalGeometry);
				for  ( subObject in selectionManager.currentlySelected )
				{
					var subTranslation:DragGeometry = calculateTranslationFromMultiTranslation( translation, subObject );
					var originalGeometry:DragGeometry = originalModelGeometry.get( subObject );
					// At this point, constraints to the entire group have already been applied, but we need to apply per component constraints.
					
					applySingleObjectConstraints(subObject, originalGeometry, subTranslation, currentDragRole );

					applyTranslationForSingleObject( subObject, subTranslation , originalModelGeometry.get(subObject) );
				}
            }

        }		
		
		private function applyTranslationForSingleObject( current:Dynamic, translation:DragGeometry , originalGeometry:DragGeometry) 
		{
			//trace(Std.is(current, Sprite)); 
			//var current = cast(current, Sprite);
			trace(current);
			trace(translation);
			trace(originalGeometry);
			
			current.x = translation.x + originalGeometry.x;
			current.y = translation.y + originalGeometry.y;
			
			trace([current.x, current.y]);
			//current.width = translation.width + originalGeometry.width;
			//current.height = translation.height + originalGeometry.height;
			//current.rotation = translation.rotation + originalGeometry.rotation;
			
			/*
			if( Reflect.hasField(current, 'x'))  current.x = translation.x + originalGeometry.x;
			if( current.hasOwnProperty("y") ) current.y = translation.y + originalGeometry.y;
			
			if( current.hasOwnProperty("width") ) current.width = translation.width + originalGeometry.width;
			if( current.hasOwnProperty("height") ) current.height = translation.height + originalGeometry.height;
			if( current.hasOwnProperty("rotation") ) current.rotation = translation.rotation + originalGeometry.rotation;
			*/
			
			updateHandlePositions(current);
		}
		
		private var selectionMatrix:Matrix;
		private var objectMatrix:Matrix;
		private var relativeGeometry:Point;
		
				
		private function calculateTranslationFromMultiTranslation(overallTranslation:DragGeometry ,  object:Dynamic) : DragGeometry
		{
			var rv:DragGeometry = new DragGeometry();

			
			// This is the rotation, scaling, and translation of the entire selection.
			
			selectionMatrix.identity();
			selectionMatrix.rotate( toRadians( overallTranslation.rotation ));
			selectionMatrix.scale( (originalGeometry.width + overallTranslation.width) / originalGeometry.width,
				(originalGeometry.height + overallTranslation.height) / originalGeometry.height );
			selectionMatrix.translate( overallTranslation.x + originalGeometry.x, overallTranslation.y + originalGeometry.y);

 			// This is the point the object is relative to the selection
			
			relativeGeometry.x = originalModelGeometry.get(object).x - originalGeometry.x;
			relativeGeometry.y = originalModelGeometry.get(object).y - originalGeometry.y;			
			
			objectMatrix.identity();
			objectMatrix.rotate( toRadians( overallTranslation.rotation +  originalModelGeometry.get(object).rotation) ); 			
			objectMatrix.translate(relativeGeometry.x, relativeGeometry.y);
			

			var translatedZeroPoint:Point = objectMatrix.transformPoint( zero );
			var translatedTopRightCorner:Point = objectMatrix.transformPoint( new Point(originalModelGeometry.get(object).width,0) );			
			var translatedBottomLeftCorner:Point = objectMatrix.transformPoint( new Point(0,originalModelGeometry.get(object).height) );			

			translatedZeroPoint = selectionMatrix.transformPoint( translatedZeroPoint );
			translatedTopRightCorner = selectionMatrix.transformPoint( translatedTopRightCorner );
			translatedBottomLeftCorner = selectionMatrix.transformPoint( translatedBottomLeftCorner );

			// uncomment to draw debug graphics.
//			container.graphics.lineStyle(2,0xff0000,0.5);
//			container.graphics.drawCircle(translatedZeroPoint.x, translatedZeroPoint.y , 4);
//			container.graphics.lineStyle(2,0xffff00,0.5);
//			container.graphics.drawCircle(translatedTopRightCorner.x, translatedTopRightCorner.y , 4);
			
			
			
			
			var targetWidth:Float = Point.distance( translatedZeroPoint, translatedTopRightCorner);
			var targetHeight:Float = Point.distance( translatedZeroPoint, translatedBottomLeftCorner ) ;
			
			// remember, rv is the CHANGE in value from the original, not an absolute value.
			rv.x = translatedZeroPoint.x - originalModelGeometry.get(object).x; 
			rv.y = translatedZeroPoint.y - originalModelGeometry.get(object).y;
			rv.width = targetWidth - originalModelGeometry.get(object).width;
			rv.height = targetHeight - originalModelGeometry.get(object).height;
			
			var targetAngle:Float = toDegrees(Math.atan2( translatedTopRightCorner.y - translatedZeroPoint.y, translatedTopRightCorner.x - translatedZeroPoint.x));
			
			rv.rotation = targetAngle - originalModelGeometry.get(object).rotation - overallTranslation.rotation;
			return rv;
		}		
		
		
        /*
		private function findModel( display:DisplayObject ) : Dynamic
        {
            var model:Dynamic = models.get( display );
            
            
            while( (model==null) && (display.parent != null) )
            {
                display = cast(display.parent, DisplayObject);
                model = models[ display ];
            }
            return model;
        }		
		*/
		
}




