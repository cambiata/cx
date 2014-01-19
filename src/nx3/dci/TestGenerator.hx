package nx3.dci;

import dci.Context;

/**
 * ...
 * @author Jonas Nyström
 */
class TestGenerator implements Context 
{

	public function new(/*itemA:Something*/) 
	{
		//this.roleA = itemA
	}
	
	public function execute()
	{
		this.roleA.roleMethod1();
	}
	
	@role var roleA = 
	{
		var roleInterface: Something
		/*
		{
			var value1:Int;
		}
		*/
		
		function roleMethod1()
		{
			// self.
		}
		
	}

	/*
	@role var roleB = 
	{
		var roleInterface: // ?		
		//{
		//	var value1:Int;
		//}		
		
		function doSomething()
		{
			// self.
		}		
	}	
	*/
	
	
}