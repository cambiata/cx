package nx.output;
import nme.display.Shape;
import nme.display.Sprite;
import nx.display.DisplayNote;
import nx.enums.EHeadType;
import nx.svg.SvgAssets;

/**
 * ...
 * @author Jonas Nyström
 */

class Render implements IRender
{
	private var target:Sprite;
	private var scaling:TScaling;
	public function new(target:Sprite, scaling:TScaling) {
		this.target = target;
		this.scaling = scaling;
	}
	
	public function lines(x:Int, y:Int, width:Int) {
		target.graphics.lineStyle(scaling.linesWidth, 0);
		for (f in -2...3) {
			var yPos = f * scaling.space;
			target.graphics.moveTo(x, y - yPos);
			target.graphics.lineTo(x + width, y - yPos);
		}		
	}
	
	public function clef(x:Float, y:Float) {
		var shape = nx.svg.SvgAssets.getSvgShape('clefG', scaling);
		shape.x = x + scaling.svgX + scaling.space;  
		shape.y = y + scaling.svgY + scaling.space;
		target.addChild(shape);	  		
		
	}
	
	/*
	static public function testClef(target:Sprite, ms:TScaling, x:Float, y:Float) {
		var shape = nx.svg.SvgAssets.getSvgShape('clefG', ms);
		shape.x = x + ms.svgX + ms.space;  
		shape.y = y + ms.svgY + ms.space;
		target.addChild(shape);	  		
	}	

	static public function testLines(target:Sprite, ms:TScaling, x:Int, y:Int, width:Int) {		
		target.graphics.lineStyle(ms.linesWidth, 0);
		for (f in -2...3) {
			var yPos = f * ms.space;
			target.graphics.moveTo(x, y - yPos);
			target.graphics.lineTo(x + width, y - yPos);
		}
	}	
	*/
	
	public function note(noteX:Float, noteY:Float, displayNote:DisplayNote) {
		//if (meas == null) meas = new scaling();
		var graphics = target.graphics;
		var noteW = scaling.noteWidth;

		function drawHead(x:Float, y:Float, level:Int, position:Int, headType:EHeadType) {
			var headY = y + (level * scaling.halfSpace);
			var headX = x + position * noteW;
			var shape:Shape; // = SvgAssets.getSvgShape("noteBlack", scaling);
			//if (headType == EHeadType.Whole) shape = SvgAssets.getSvgShape("noteWhole", scaling);
			//if (headType == EHeadType.White) shape = SvgAssets.getSvgShape("noteWhite", scaling);
			
			switch(headType) {
				case EHeadType.Whole:
					shape = SvgAssets.getSvgShape("snoteWhole", scaling);
				case EHeadType.White:
					shape = SvgAssets.getSvgShape("noteWhite", scaling);
				default:
					shape = SvgAssets.getSvgShape("noteBlack", scaling);
			}
			
			shape.x = headX + scaling.svgX;  
			shape.y = headY + scaling.svgY;
			target.addChild(shape);	  			
		}
		

		if (displayNote == null) return;
		
		graphics.beginFill(0, 0);
		graphics.lineStyle(1, 0xff0000);
		
		// Zero line
		graphics.lineStyle(1, 0xCCCCCC);
		graphics.moveTo(noteX, noteY - 60);
		graphics.lineTo(noteX, noteY + 60);		
		
		// Heads
		var r = Scaling.toDRect(displayNote.getDisplayRect(), scaling); 
		//graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);		
		for (dHead in displayNote.getDisplayHeads()) drawHead(noteX, noteY, dHead.getLevel(), dHead.getPosition(), displayNote.getNote().value.headType);
		
		// Signs
		var r = Scaling.toDRect(displayNote.getSignsDisplayRect(), scaling); 
		//graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);		
		signs(displayNote.getSigns(), noteX + r.left, noteY);
		


		


		
		

		
		/*
		gr.lineStyle(1, 0xccffcc);
		var r = Scaling.toDRect(displayNote.getDisplayStaveRect(),scaling); 
		gr.drawRect(x + r.x, y + r.y, r.width, r.height);
		*/

	}	
	
	public function signs(signs:TSigns, x:Float, y:Float) {
		var gr = target.graphics;
		var posSpace = scaling.signPosWidth;
		
		var maxPos = 0;
		for (sign in signs) {
			trace(sign.position);
			maxPos = Std.int(Math.max(maxPos, sign.position));
		}
		trace(maxPos);
		var xOffset = (maxPos * scaling.signPosWidth) + scaling.halfNoteWidth;
		
		
		function drawSign(x:Float, y:Float, level:Int, position:Int, sign:nx.enums.ESign) {		
			trace('drawSign x:' + x);
			var shape:Shape;			
			switch(sign) {
				case ESign.Sharp: shape = SvgAssets.getSvgShape('signSharp', scaling);
				case ESign.Flat: shape = SvgAssets.getSvgShape('signFlat', scaling);
				default: shape = SvgAssets.getSvgShape('signNatural', scaling);
			}
			y = y + (scaling.halfSpace * level);
			x = x - (position * scaling.signPosWidth) + xOffset;
			shape.x = x + scaling.svgX;  
			shape.y = y + scaling.svgY;

			target.addChild(shape);	  			
		}
		
		for (sign in signs) {
			drawSign(x, y, sign.level, sign.position, sign.sign);			
		}
	}	
	
	
}