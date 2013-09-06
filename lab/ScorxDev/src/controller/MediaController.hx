package controller;
import cx.FileTools;
import haxe.io.Bytes;
import ufront.web.mvc.BytesResult;
import ufront.web.mvc.Controller;
import ufront.web.mvc.FileResult;

/**
 * ...
 * @author Jonas Nyström
 */
class MediaController extends Controller
{

	public function new() 
	{
		super();
	}
	
	public function index()
	{
		return "MediaController.index()";
	}
	
	public function screen(productId:Int = 1, pageNr:Int = 0, userId:Int = 0)
	{
		var filename:String = 'F:/_cx/lab/ScorxDev/bin/files/$productId/screen/page$pageNr.png';
		var filebytes:Bytes = FileTools.getBytes(filename);
		return new BytesResult(filebytes, 'image/png', filename);
	}
	
	public function screenCount(productId:Int = 1)
	{
		switch(productId)
		{
			case 1: return 2;
			default: return 0;
		}
		return 0;
	}
	
	
}