package nx3.render;
import nx3.display.DNote;

/**
 * ...
 * @author 
 */
interface IRenderer
{
	function notelines(x:Float, y:Float, width:Float): Void;
	function stave(x:Float, y:Float, dnote:DNote): Void;
	function heads(x:Float, y:Float, dnote:DNote): Void;
	function note(x:Float, y:Float, dnote:DNote): Void;	
}