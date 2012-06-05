package sx.objecthandles;
import flash.events.EventDispatcher;
import sx.objecthandles.events.SelectionEvent;

/**
 * ...
 * @author Jonas Nyström
 */
using Lambda;
class ObjectHandlesSelectionManager extends EventDispatcher
{

		public var currentlySelected:Array<Dynamic>;
		
		
		public function new()
		{
			super();
			this.currentlySelected = [];
		}
		
		public function addToSelected( model:Dynamic ) : Void
		{

			
			if( currentlySelected.indexOf( model ) != -1 ) { return; } // already selected
			
			
			if( currentlySelected.length > 0 ){
				var locked:Bool = isSelectionLocked();
				
				if( locked && !model.isLocked ) {
					return;
				}
				
				if( !locked && model.isLocked ) {
					return;
				}
			}
			
				
			
			currentlySelected.push(model);
			var event:SelectionEvent = new SelectionEvent( SelectionEvent.ADDED_TO_SELECTION );
			event.targets.push( model );
			dispatchEvent( event );
			
		}
		
		public function isSelected( model:Dynamic ) : Bool
		{
			return currentlySelected.indexOf( model ) != -1;
		}

		public function setSelected( model:Dynamic ) : Void
		{
			
			clearSelection();			
			addToSelected( model );			
		}
		
		public function removeFromSelected( model:Dynamic ) : Void
		{
			var ind:Int = currentlySelected.indexOf(model);
			if( ind == -1 ) { return; }
			
			currentlySelected.splice(ind,1);
			
			var event:SelectionEvent = new SelectionEvent( SelectionEvent.REMOVED_FROM_SELECTION);
			event.targets.push(model);			
			dispatchEvent( event );
			
		}

		public function clearSelection(  ) : Void
		{
			var event:SelectionEvent = new SelectionEvent( SelectionEvent.SELECTION_CLEARED );
			event.targets = currentlySelected;
			currentlySelected = [];						
			dispatchEvent( event );			
		}


		public function isSelectionLocked():Bool {
			for (model in currentlySelected) {
				if(model.hasOwnProperty("isLocked")) {
					if(model.isLocked) {
						return true;
					}
				}
			}
			
			return false;
		}		
		
		
		public function getGeometry() : DragGeometry
		{
			var obj:Dynamic;
			var rv:DragGeometry;
			// no selected objects
			if( currentlySelected.length == 0 ) { return null; }
			if( currentlySelected.length == 1) {
				// only one selected object
				obj = currentlySelected[0];
				rv = new DragGeometry();
				
				/*
				if( obj.hasOwnProperty("x") ) rv.x = obj["x"];
				if( obj.hasOwnProperty("y") ) rv.y = obj["y"];
				if( obj.hasOwnProperty("width") ) rv.width = obj["width"];
				if( obj.hasOwnProperty("height") ) rv.height = obj["height"];
				if( obj.hasOwnProperty("rotation") ) rv.rotation = obj["rotation"];
				if( obj.hasOwnProperty("isLocked") ) rv.isLocked = obj["isLocked"];
				*/
				
				rv.x = obj.x;
				
				
				
				return rv;
			} else {
				// a lot of selected objects
				//return calculateMultiGeometry();

			}
			return null;
		}

		/*
		protected function calculateMultiGeometry() : DragGeometry
		{
			var rv:DragGeometry;
			var lx1: Number = Number.POSITIVE_INFINITY; // top left bounds
			var ly1: Number = Number.POSITIVE_INFINITY;
			var lx2: Number = Number.NEGATIVE_INFINITY; // bottom right bounds
			var ly2: Number = Number.NEGATIVE_INFINITY;

			var matrix:Matrix = new Matrix();
			var temp:Point = new Point();
			var temp2:Point = new Point();
			
			for each(var modelObject:Object in currentlySelected) 
			{			
				matrix.identity();
				if( modelObject.hasOwnProperty("rotation") )
				{
					matrix.rotate( toRadians(modelObject.rotation) );
				}
				matrix.translate( modelObject.x, modelObject.y );
				
				
				temp.x=0; // Check top left
				temp.y=0;
				temp = matrix.transformPoint(temp);				
			
				lx1 = Math.min(lx1, temp.x );
				ly1 = Math.min(ly1, temp.y );
				lx2 = Math.max(lx2, temp.x );
				ly2 = Math.max(ly2, temp.y );

				temp.x=0; // Check bottom left
				temp.y=modelObject.height;
				temp = matrix.transformPoint(temp);				
				lx1 = Math.min(lx1, temp.x );
				ly1 = Math.min(ly1, temp.y );
				lx2 = Math.max(lx2, temp.x );
				ly2 = Math.max(ly2, temp.y );

				temp.x=modelObject.width; // Check top right
				temp.y=0;
				temp = matrix.transformPoint(temp);				
				lx1 = Math.min(lx1, temp.x );
				ly1 = Math.min(ly1, temp.y );
				lx2 = Math.max(lx2, temp.x );
				ly2 = Math.max(ly2, temp.y );

				temp.x=modelObject.width; // Check top right
				temp.y=modelObject.height;
				temp = matrix.transformPoint(temp);				
				lx1 = Math.min(lx1, temp.x );
				ly1 = Math.min(ly1, temp.y );
				lx2 = Math.max(lx2, temp.x );
				ly2 = Math.max(ly2, temp.y );

				
			}
			rv = new DragGeometry();
			rv.rotation = 0;
			rv.x = lx1;
			rv.y = ly1;
			rv.width = lx2 - lx1;
			rv.height = ly2 - ly1;
			rv.isLocked = isSelectionLocked();
			return rv;
		}
		*/
		
		private static function toRadians( degrees:Float ) :Float
		{
			return degrees * Math.PI / 180;
		}		
		
		public function getGeometryForObject(a:Dynamic) : DragGeometry
		{
			// Just return coordinates of object
			
				var obj:Dynamic = a;
				var rv:DragGeometry = new DragGeometry();
				
				
				if( obj.hasOwnProperty("x") ) rv.x = obj.x;
				if( obj.hasOwnProperty("y") ) rv.y = obj.y;
				if( obj.hasOwnProperty("width") ) rv.width = obj.width;
				if( obj.hasOwnProperty("height") ) rv.height = obj.height;
				if( obj.hasOwnProperty("rotation") ) rv.rotation = obj.rotation;
				if( obj.hasOwnProperty("isLocked") ) rv.isLocked = obj.isLocked;
				
				return rv;
		}
	
}