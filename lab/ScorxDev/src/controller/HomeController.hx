package controller;
import ufront.web.mvc.Controller;
import ufront.web.mvc.ViewResult;

/**
 * ...
 * @author Jonas Nyström
 */

class HomeController extends Controller
{
    public function index() 
    {
        //return "Hello from HomeController.index()";
		return new ViewResult( { name: "Jonas" } );
    }
    
	public function player(productId:Int=1, userId:Int=333)
	{
		return new ViewResult({host:"localhost:2000", id:productId, userId:userId});	
	}
	
	public function playerjs(productId:Int=1, userId:Int=333)
	{
		return new ViewResult({host:"localhost:2000", id:productId, userId:userId});	
	}	
}