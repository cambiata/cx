package nx3.render;
//import nx3.elements.DComplex;
//import nx3.elements.DNote;
import nx3.elements.interfaces.IDistanceRects;

/**
 * ...
 * @author 
 */
interface IRenderer
{
	function notelines(x:Float, y:Float, width:Float): Void;
	/*
	function stave(x:Float, y:Float, dnote:DNote): Void;
	function heads(x:Float, y:Float, dnote:DNote): Void;
	function signs(x:Float, y:Float, dcomplex:DComplex): Void;
	function note(x:Float, y:Float, dnote:DNote): Void;		
	function complex(x:Float, y:Float,  dcomplex:DComplex):Void;
	*/
}