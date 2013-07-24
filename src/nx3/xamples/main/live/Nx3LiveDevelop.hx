package nx3.xamples.main.live;

import flash.display.Shape;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import format.SVG;
import format.svg.SVG2Gfx;
import format.svg.SVGRenderer;
import nx3.display.DComplex;
import nx3.display.DNote;
import nx3.elements.Note;
import nx3.elements.Head;
import nx3.enums.EDirectionUD;
import nx3.enums.ENoteValue;
import nx3.enums.ESign;
import nx3.render.FontRenderer;
import nx3.render.FrameRenderer;
import nx3.render.MultiRenderer;
import nx3.render.scaling.Scaling;
import nx3.render.svg.Elements;
import nx3.render.svg.ShapeTools;


/**
 * ...
 * @author 
 */

class Nx3LiveDevelop extends Sprite
{
	public function new()
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
	}
	
	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		
		//write your code here		
		//var xampleSprite = Examples.basic1();
		//Lib.current.addChild(xampleSprite);			
		
		var target:Sprite = new Sprite();
		this.addChild(target); 
		
		var note1:Note = new Note([
			//new Head( -3, ESign.DoubleSharp), 
			new Head(0, ESign.Flat),  
			//new Head(2, ESign.Natural)
			], ENoteValue.Nv4, EDirectionUD.Up);
			
		var note2:Note = new Note([
			new Head(3, ESign.None)
			], ENoteValue.Nv4, EDirectionUD.Down);
		
		var render:MultiRenderer = new MultiRenderer(target, Scaling.MID, [
			FrameRenderer,
			//FrameRenderer,
			//FontRenderer,
			]);
		/*
		var render:FrameRenderer = new FrameRenderer(target, Scaling.MID);
		*/
		var dnote1:DNote = new DNote(note1);
		var dnote2:DNote = new DNote(note2);
		var dcomplex:DComplex = new DComplex([
			dnote1, 
			dnote2,
			]);
		render.notelines(0, 100, 700);
		render.complex(200, 100, dcomplex);
		
		/*
		var render:FrameRenderer = new FrameRenderer(target, Scaling.NORMAL);
		var dnote1:DNote = new DNote(note1);
		var dnote2:DNote = new DNote(note2);		
		var dcomplex:DComplex = new DComplex([dnote1, dnote2]);
		render.notelines(0, 300, 700);
		render.complex(200, 300, dcomplex);		
		*/
		/*
		var svg:Shape = ShapeTools.getShape(Elements.noteBlack, Scaling.MID);
		svg.x = 100 + Scaling.MID.svgX;
		svg.y = 100 + Scaling.MID.svgY;
		target.addChild(svg);
		*/
	}
	
	private function onRemoved(e:Event):Void 
	{			
		removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		removeChildren();		
		//don't forget to remove event listeners, 
		//that you added manually to onAdded function or elsewhere
		//for proper garbage collection
	}
	
	static function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.addChild(new Nx3LiveDevelop());
	}
	
}