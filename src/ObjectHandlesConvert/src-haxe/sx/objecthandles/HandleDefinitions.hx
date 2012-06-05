package sx.objecthandles;

/**
 * ...
 * @author Jonas Nyström
 */

	import flash.geom.Point;
	import sx.objecthandles.HandleDescription;
	import sx.objecthandles.HandleRoles;
	
	class HandleDefinitions
	{
		public static var DEFAULT_DEFINITION:Array<HandleDescription> = [
									 new HandleDescription ( HandleRoles.RESIZE_UP + HandleRoles.RESIZE_LEFT, 
																				new Point(0,0) ,
																				new Point(0,0) ),  
								
									 new HandleDescription( HandleRoles.RESIZE_UP ,
																				new Point(50,0) , 
																				new Point(0,0) ),  
								
									 new HandleDescription( HandleRoles.RESIZE_UP + HandleRoles.RESIZE_RIGHT,
																				new Point(100,0) ,
																				new Point(0,0) ),  
								
									 new HandleDescription( HandleRoles.RESIZE_RIGHT,
																				new Point(100,50) , 
																				new Point(0,0) ),  
								
									 new HandleDescription( HandleRoles.RESIZE_DOWN + HandleRoles.RESIZE_RIGHT,
																				new Point(100,100) , 
																				new Point(0,0) ),  
									
									 new HandleDescription( HandleRoles.RESIZE_DOWN ,
																				new Point(50,100) ,
																				new Point(0,0) ),  
									
									 new HandleDescription( HandleRoles.RESIZE_DOWN + HandleRoles.RESIZE_LEFT,
																				new Point(0,100) ,
																				new Point(0,0) ),  
								
									 new HandleDescription( HandleRoles.RESIZE_LEFT,
																				new Point(0,50) ,
																				new Point(0,0) ),  
									
									 new HandleDescription( HandleRoles.ROTATE,
																				new Point(100,50) , 
																				new Point(20,0) ) 		
						];
						
				public static var NO_ROTATE_DEFINITION:Array<HandleDescription> = [
									 new HandleDescription( HandleRoles.RESIZE_UP + HandleRoles.RESIZE_LEFT, 
																				new Point(0,0) ,
																				new Point(0,0) ),  
								
									 new HandleDescription( HandleRoles.RESIZE_UP ,
																				new Point(50,0) , 
																				new Point(0,0) ),  
								
									 new HandleDescription( HandleRoles.RESIZE_UP + HandleRoles.RESIZE_RIGHT,
																				new Point(100,0) ,
																				new Point(0,0) ),  
								
									 new HandleDescription( HandleRoles.RESIZE_RIGHT,
																				new Point(100,50) , 
																				new Point(0,0) ),  
								
									 new HandleDescription( HandleRoles.RESIZE_DOWN + HandleRoles.RESIZE_RIGHT,
																				new Point(100,100) , 
																				new Point(0,0) ),  
									
									 new HandleDescription( HandleRoles.RESIZE_DOWN ,
																				new Point(50,100) ,
																				new Point(0,0) ),  
									
									 new HandleDescription( HandleRoles.RESIZE_DOWN + HandleRoles.RESIZE_LEFT,
																				new Point(0,100) ,
																				new Point(0,0) ),  
								
									 new HandleDescription( HandleRoles.RESIZE_LEFT,
																				new Point(0,50) ,
																				new Point(0,0) )  
									
									 
						];
		public static var DEFAULT_PLUS_MOVE_DEFINITION:Array<HandleDescription> = [
									new HandleDescription( HandleRoles.MOVE, 
																				new Point(50,50) ,
																				new Point(0,0) ),
																				  
									 new HandleDescription( HandleRoles.RESIZE_UP + HandleRoles.RESIZE_LEFT, 
																				new Point(0,0) ,
																				new Point(0,0) ),  
								
									 new HandleDescription( HandleRoles.RESIZE_UP ,
																				new Point(50,0) , 
																				new Point(0,0) ),  
								
									 new HandleDescription( HandleRoles.RESIZE_UP + HandleRoles.RESIZE_RIGHT,
																				new Point(100,0) ,
																				new Point(0,0) ),  
								
									 new HandleDescription( HandleRoles.RESIZE_RIGHT,
																				new Point(100,50) , 
																				new Point(0,0) ),  
								
									 new HandleDescription( HandleRoles.RESIZE_DOWN + HandleRoles.RESIZE_RIGHT,
																				new Point(100,100) , 
																				new Point(0,0) ),  
									
									 new HandleDescription( HandleRoles.RESIZE_DOWN ,
																				new Point(50,100) ,
																				new Point(0,0) ),  
									
									 new HandleDescription( HandleRoles.RESIZE_DOWN + HandleRoles.RESIZE_LEFT,
																				new Point(0,100) ,
																				new Point(0,0) ),  
								
									 new HandleDescription( HandleRoles.RESIZE_LEFT,
																				new Point(0,50) ,
																				new Point(0,0) ),  
									
									 new HandleDescription( HandleRoles.ROTATE,
																				new Point(100,50) , 
																				new Point(20,0) ) 		
						];
		
		public static var RESIZE_MOVE_NOROTATE:Array<HandleDescription> = [
			new HandleDescription( HandleRoles.MOVE, 
				new Point(50,50) ,
				new Point(0,0) ),
			
			new HandleDescription( HandleRoles.RESIZE_UP + HandleRoles.RESIZE_LEFT, 
				new Point(0,0) ,
				new Point(0,0) ),  
			
			new HandleDescription( HandleRoles.RESIZE_UP ,
				new Point(50,0) , 
				new Point(0,0) ),  
			
			new HandleDescription( HandleRoles.RESIZE_UP + HandleRoles.RESIZE_RIGHT,
				new Point(100,0) ,
				new Point(0,0) ),  
			
			new HandleDescription( HandleRoles.RESIZE_RIGHT,
				new Point(100,50) , 
				new Point(0,0) ),  
			
			new HandleDescription( HandleRoles.RESIZE_DOWN + HandleRoles.RESIZE_RIGHT,
				new Point(100,100) , 
				new Point(0,0) ),  
			
			new HandleDescription( HandleRoles.RESIZE_DOWN ,
				new Point(50,100) ,
				new Point(0,0) ),  
			
			new HandleDescription( HandleRoles.RESIZE_DOWN + HandleRoles.RESIZE_LEFT,
				new Point(0,100) ,
				new Point(0,0) ),  
			
			new HandleDescription( HandleRoles.RESIZE_LEFT,
				new Point(0,50) ,
				new Point(0,0) )  
						
			];
		
	}
