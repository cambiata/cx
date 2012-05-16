package nx.output;
import nme.display.Shape;
import nme.display.Sprite;
import nx.Constants;
import nx.display.beam.IBeamGroup;
import nx.display.DisplayNote;
import nx.enums.EDirectionUD;
import nx.enums.EHeadType;
import nx.svg.SvgAssets;
import nx.output.Scaling;
import nx.display.beam.BeamGroupDimensions;

/**
 * ...
 * @author Jonas Nyström
 */
using nx.output.Scaling;



class Render implements IRender
{
	static public var drawRects:Bool = false;
	
	private var target:Sprite;
	private var scaling:TScaling;
	public function getScaling():TScaling {
		return this.scaling;
	}
	
	public function new(target:Sprite, scaling:TScaling) {
		this.target = target;
		this.scaling = scaling;
	}
	
	public function lines(x:Float, y:Float, width:Float) {
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
	
	public function noteARects(noteX:Float, noteY:Float, displayNote:DisplayNote, color:Int=0xFF0000) {
		nx.display.utils.DisplayNoteUtils.drawAODR(displayNote.getArrayOfDisplayRects() , this.target, noteX, noteY, this.scaling, color);		
	}
	
	public function noteRects(noteX:Float, noteY:Float, displayNote:DisplayNote) {
		var graphics = target.graphics;
		
		graphics.beginFill(0, 0);
		
		
		// Zero line
		graphics.lineStyle(1, 0xCCCCCC);
		graphics.moveTo(noteX, noteY - 60);
		graphics.lineTo(noteX, noteY + 60);				
		
		
		// heads
		graphics.lineStyle(1, 0xFF0000);
		for (h in displayNote.getDisplayHeads()) {			
			var r = Scaling.scaleRectangle(h.getDisplayRect(), scaling); 		
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);			
		}
		
		
		
		// note
		//var r = Scaling.scaleRectangle(displayNote.getDisplayRect(), scaling); 		
		//graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);			
		
		// signs
		graphics.lineStyle(1, 0x00FFFF);
		var signsDisplayRect = displayNote.getDisplayRectSigns();
		if (signsDisplayRect != null) {		
			var r = Scaling.scaleRectangle(signsDisplayRect, scaling); 
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);				
		}
		
		// stave
		graphics.lineStyle(1, 0xff0000);
		var staveDisplayRect = displayNote.getDisplayRectStave();
		if (staveDisplayRect != null) {
			var r = staveDisplayRect.scaleRectangle(this.scaling);
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);				
		}
		
		// dots
		graphics.lineStyle(1, 0x00ff00);
		var r = displayNote.getDisplayRectDots();
		if (r != null) {
			var r = r.scaleRectangle(this.scaling);
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);	
		}
		
		// tieFrom
		graphics.lineStyle(1, 0x0000ff);
		var r = displayNote.getDisplayRectTieFrom();
		if (r != null) {
			var r = r.scaleRectangle(this.scaling);
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);	
		}
		
		// apoggiatura 
		graphics.lineStyle(1, 0xff0000);
		var r = displayNote.getDisplayRectAppogiatura();
		if (r != null) {
			var r = r.scaleRectangle(this.scaling);
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);	
		}

		// arpeggio 
		graphics.lineStyle(1, 0x000000);
		var r = displayNote.getDisplayRectArpeggio();
		if (r != null) {
			var r = r.scaleRectangle(this.scaling);
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);	
		}

		// tieTo
		graphics.lineStyle(1, 0x0000ff);
		var r = displayNote.getDisplayRectTieTo();
		if (r != null) {
			var r = r.scaleRectangle(this.scaling);
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);	
		}		
		
		// clef
		graphics.lineStyle(1, 0xff00ff);
		var r = displayNote.getDisplayRectClef();
		if (r != null) {
			var r = r.scaleRectangle(this.scaling);
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);	
		}		
		
		// total
		graphics.lineStyle(2, 0x000000);
		var r = displayNote.getTotalRect();
		if (r != null) {
			var r = r.scaleRectangle(this.scaling);
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);	
		}			
		
		
	}
	
	public function note(noteX:Float, noteY:Float, displayNote:DisplayNote) {		
		if (drawRects) this.noteRects(noteX, noteY, displayNote);
		//if (meas == null) meas = new scaling();
		var graphics = target.graphics;
		//var noteW = scaling.noteWidth;

		function drawHead(x:Float, y:Float, level:Int, position:Int, headType:EHeadType) {
			var headY = y + (level * scaling.halfSpace);
			var headX = x + position * scaling.noteWidth;
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
		

		
		// Heads
		//var r = Scaling.scaleRectangle(displayNote.getDisplayRect(), scaling); 
		//graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);		
		for (dHead in displayNote.getDisplayHeads()) 
		{
			//trace(dHead.getPosition());
			drawHead(noteX, noteY, dHead.getLevel(), dHead.getPosition(), displayNote.getNote().value.headType);
		}
		
		// Signs
		var signsDisplayRect = displayNote.getDisplayRectSigns();
		if (signsDisplayRect != null) {
			var r = Scaling.scaleRectangle(signsDisplayRect, scaling); 
			signs(displayNote.getSigns(), noteX + r.left, noteY);			
		}
		
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
			//trace(sign.position);
			maxPos = Std.int(Math.max(maxPos, sign.position));
		}
		//trace(maxPos);
		var xOffset = (maxPos * scaling.signPosWidth) + scaling.halfNoteWidth;
		
		
		function drawSign(x:Float, y:Float, level:Int, position:Int, sign:nx.enums.ESign) {		
			//trace('drawSign x:' + x);
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
	
	public function beamGroup(noteX:Float, noteY:Float, lastNoteX:Float, bgd:BeamGroupDimensions) {
		//trace(this.scaling);
		//trace(bgd);
		var adjustX = bgd.adjustX * this.scaling.halfNoteWidth;
		var firstTopY = noteY + (bgd.firstStave.topY * scaling.halfSpace);
		var lastTopY = noteY + (bgd.lastStave.topY * scaling.halfSpace); 
		var firstBottomY = noteY + (bgd.firstStave.bottomY  * scaling.halfSpace);
		var lastBottomY = noteY + (bgd.lastStave.bottomY * scaling.halfSpace);

		if (bgd.count == 1) {
			
			
		}
		
		this.target.graphics.lineStyle(this.scaling.linesWidth, 0x000000);
		
		if (bgd.direction == EDirectionUD.Up) {			
			this.target.graphics.drawCircle(noteX + adjustX, firstTopY , 3);
			this.target.graphics.moveTo(noteX + adjustX, firstTopY);
			this.target.graphics.lineTo(noteX + adjustX, firstBottomY);
			
			if (bgd.count > 1) {
				
				this.target.graphics.beginFill(0xFF0000);
				this.target.graphics.moveTo(noteX 		+ adjustX, firstTopY);
				this.target.graphics.lineTo(lastNoteX 	+ adjustX, lastTopY);
				this.target.graphics.lineTo(lastNoteX 	+ adjustX, lastTopY - Constants.HEAD_HEIGHT);
				this.target.graphics.lineTo(noteX 		+ adjustX, firstTopY - Constants.HEAD_HEIGHT);
				this.target.graphics.lineTo(noteX 		+ adjustX, firstTopY);
				this.target.graphics.endFill();
				
				this.target.graphics.drawCircle(lastNoteX + adjustX, lastTopY , 3);
				this.target.graphics.moveTo(noteX + adjustX, firstTopY);
				this.target.graphics.lineTo(lastNoteX + adjustX, lastTopY);
				
				this.target.graphics.moveTo(lastNoteX + adjustX, lastTopY);				
				this.target.graphics.lineTo(lastNoteX + adjustX, lastBottomY);
			}
		} else {
			this.target.graphics.drawCircle(noteX + adjustX, firstBottomY , 3);
			this.target.graphics.moveTo(noteX + adjustX, firstBottomY);
			this.target.graphics.lineTo(noteX + adjustX, firstTopY);			
			
			if (bgd.count > 1) {

				this.target.graphics.beginFill(0xFF0000);
				this.target.graphics.moveTo(noteX 		+ adjustX, firstBottomY);
				this.target.graphics.lineTo(lastNoteX 	+ adjustX, lastBottomY);
				this.target.graphics.lineTo(lastNoteX 	+ adjustX, lastBottomY + Constants.HEAD_HEIGHT);
				this.target.graphics.lineTo(noteX 		+ adjustX, firstBottomY + Constants.HEAD_HEIGHT);
				this.target.graphics.lineTo(noteX 		+ adjustX, firstBottomY);
				this.target.graphics.endFill();								
				
				this.target.graphics.drawCircle(lastNoteX + adjustX, lastBottomY , 3);		
				this.target.graphics.moveTo(noteX + adjustX, firstBottomY);
				this.target.graphics.lineTo(lastNoteX + adjustX, lastBottomY);	
				
				this.target.graphics.moveTo(lastNoteX + adjustX, lastBottomY);				
				this.target.graphics.lineTo(lastNoteX + adjustX, lastTopY);				
			}
		}
		
		//trace([bgd.firstStave.topY, bgd.lastStave.topY]);
		//trace([firstTopY, lastTopY]);
		
	}
	
	
}