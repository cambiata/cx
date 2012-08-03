package nx.output;
import cx.ArrayTools;
import nme.display.GradientType;
import nme.display.Graphics;
import nme.display.Shape;
import nme.display.Sprite;
import nme.geom.Rectangle;
import nx.Constants;
import nx.core.display.DBar;
import nx.core.display.DNote;
import nx.core.display.DPart;
import nx.core.display.Complex;
import nx.display.beam.BeamTools;
import nx.display.beam.IBeamGroup;
import nx.display.DisplayNote;
import nx.enums.EDirectionUD;
import nx.enums.EHeadType;
import nx.svg.SvgAssets;
import nx.output.Scaling;
import nx.display.beam.BeamGroupFrame;

/**
 * ...
 * @author Jonas Nyström
 */
using nx.output.Scaling;
using cx.ArrayTools;


class Render implements IRender
{
	static public var drawRects:Bool = false;
	
	private var target:Sprite;
	private var scaling:TScaling;
	private var gr:Graphics;
	
	
	public function getScaling():TScaling {
		return this.scaling;
	}
	
	public function new(target:Sprite, scaling:TScaling) {
		this.target = target;
		this.gr = target.graphics;
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
			xsigns(displayNote.getSigns(), noteX + r.left, noteY);			
		}
		
		/*
		gr.lineStyle(1, 0xccffcc);
		var r = Scaling.toDRect(displayNote.getDisplayStaveRect(),scaling); 
		gr.drawRect(x + r.x, y + r.y, r.width, r.height);
		*/

	}	
	
	
	public function xsigns(signs:TSigns, x:Float, y:Float) {
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
	
	public function signs(dplex:Complex, x:Float, y:Float) {
		var gr = target.graphics;
		var posSpace = scaling.signPosWidth;
		
		
		if (dplex.rectSigns == null) return;
		
		var signs = dplex.signs;
		var xShift = Scaling.scaleX(dplex.rectSigns.x, this.scaling);
		
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
			drawSign(x + xShift, y, sign.level, sign.position, sign.sign);			
		}
	}	
	
	public function beamGroup(xpos:Float, y:Float, frame:BeamGroupFrame, dnotePositionsX:Array<Float>) {
		
		var firstX = xpos + dnotePositionsX.first();
		var lastX = xpos + dnotePositionsX.last();
		
		var adjustX = 0; // this.scaling.halfNoteWidth; // frame.adjustX * this.scaling.halfNoteWidth;
		var firstTopY = y + (frame.firstStave.topY * scaling.halfSpace);
		var lastTopY = y + (frame.lastStave.topY * scaling.halfSpace); 
		var firstBottomY = y + (frame.firstStave.bottomY  * scaling.halfSpace);
		var lastBottomY = y + (frame.lastStave.bottomY * scaling.halfSpace);
		
		this.gr.lineStyle(1, 0x666666);
		if (frame.direction == EDirectionUD.Up) {			
			this.target.graphics.drawCircle(firstX , firstTopY , 3);
			if (frame.count > 1) this.target.graphics.drawCircle(lastX , lastTopY , 3);
		} else {
			this.target.graphics.drawCircle(firstX , firstBottomY , 3);
			if (frame.count > 1) this.target.graphics.drawCircle(lastX , lastBottomY , 3);		
		}
		
		this.target.graphics.lineStyle(this.scaling.linesWidth, 0x000000);
		
		if (frame.direction == EDirectionUD.Up) {			
			this.target.graphics.moveTo(firstX , firstTopY);
			this.target.graphics.lineTo(firstX , firstBottomY);
			
			if (frame.count > 1) {
				this.target.graphics.beginFill(0xFF0000);
				this.target.graphics.moveTo(firstX		, firstTopY);
				this.target.graphics.lineTo(lastX 	, lastTopY);
				this.target.graphics.lineTo(lastX 	, lastTopY - Constants.HEAD_HEIGHT);
				this.target.graphics.lineTo(firstX 		, firstTopY - Constants.HEAD_HEIGHT);
				this.target.graphics.lineTo(firstX 		, firstTopY);
				this.target.graphics.endFill();
				
				this.target.graphics.moveTo(firstX , firstTopY);
				this.target.graphics.lineTo(lastX , lastTopY);
				
				this.target.graphics.moveTo(lastX , lastTopY);				
				this.target.graphics.lineTo(lastX , lastBottomY);
			}
		} else {
			this.target.graphics.moveTo(firstX , firstBottomY);
			this.target.graphics.lineTo(firstX , firstTopY);			
			
			if (frame.count > 1) {

				this.target.graphics.beginFill(0xFF0000);
				this.target.graphics.moveTo(firstX 		, firstBottomY);
				this.target.graphics.lineTo(lastX 	, lastBottomY);
				this.target.graphics.lineTo(lastX 	, lastBottomY + Constants.HEAD_HEIGHT);
				this.target.graphics.lineTo(firstX		, firstBottomY + Constants.HEAD_HEIGHT);
				this.target.graphics.lineTo(firstX 		, firstBottomY);
				this.target.graphics.endFill();								
				
				
				this.target.graphics.moveTo(firstX , firstBottomY);
				this.target.graphics.lineTo(lastX , lastBottomY);	
				
				this.target.graphics.moveTo(lastX , lastBottomY);				
				this.target.graphics.lineTo(lastX , lastTopY);				
			}
		}
	}
	
	//-----------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------
	
	public function dnote(x:Float, y:Float, dnote:DNote, rects:Bool=false, teststave:Bool=true) {
		var positions = dnote.headPositions.copy();
		for (dhead in dnote.dheads) {
			var position = positions.shift();
			this._drawHead(x, y, dhead.level, position, dnote.notevalue.headType);
		}	

		if (teststave) this.dnoteStave(x, y, dnote, rects);
		
		this.dnoteDots(x, y, dnote, rects);
		
		
		if (rects) {
			this.gr.lineStyle(1, 0x0000FF);		
			var r = Scaling.scaleRectangle(dnote.rectHeads, this.scaling);
			r.offset(x, y);
			this.gr.drawRect(r.x, r.y, r.width, r.height);		
		}
	}
	
	private function dnoteDots(x:Float, y:Float, dnote:DNote, rects:Bool) {
		if (dnote.rectDots == null) return;
		if (rects) {
			this.gr.lineStyle(1, 0x00FFFF);		
			var r = Scaling.scaleRectangle(dnote.rectDots, this.scaling);
			r.offset(x, y);
			this.gr.drawRect(r.x, r.y, r.width, r.height);		
		}		
		
	}
	
	private function dnoteStave(x:Float, y:Float, dnote:DNote, rects:Bool) {		
		if (dnote.rectStave == null) return;
		
		var r = Scaling.scaleRectangle(dnote.rectStave, this.scaling);
		r.offset(x, y);

		if (rects) {
			this.gr.lineStyle(1, 0xFF0000);					
			this.gr.drawRect(r.x, r.y, r.width, r.height);		
		}				
		
		
		this.gr.lineStyle(this.scaling.linesWidth, 0x000000);
		this.gr.moveTo(r.x, r.y);
		this.gr.lineTo(r.x, r.y + r.height);

	}

	private function _drawHead(x:Float, y:Float, level:Int, position:Int, headType:EHeadType) {
		var headY = y + (level * scaling.halfSpace);
		var headX = x + position * scaling.noteWidth;
		var shape:Shape; // = SvgAssets.getSvgShape("noteBlack", scaling);			
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
	
	public function complex(x:Float, y:Float, dplex:Complex, rects:Bool=true, moveX:Float=0, teststaves:Bool=true) {		
		if (moveX != 0) x += Scaling.scaleX(moveX, this.scaling);
		
		if (rects) {
			this.gr.lineStyle(1, 0xaaaaaa);
			this.gr.moveTo(x, y + -60);
			this.gr.lineTo(x, y + 60);
		}
		
		for (i in 0...dplex.dnotes.length) {
			this.dnote(x + dplex.dnoteXshift(i) * scaling.quarterNoteWidth, y, dplex.dnote(i), rects, teststaves);	
		}		
		
		this.signs(dplex, x, y);

		if (rects) {			
			this.gr.lineStyle(1, 0xFF0000);
			var r = Scaling.scaleRectangle(dplex.rectHeads, this.scaling);
			r.offset(x, y);
			r.inflate(2, 2);		
			
			this.gr.drawRect(r.x, r.y, r.width, r.height);
			
			if (dplex.rectSigns != null) {
				this.gr.lineStyle(1, 0x00FF00);		
				var r = Scaling.scaleRectangle(dplex.rectSigns, this.scaling);
				r.offset(x, y);
				this.gr.drawRect(r.x, r.y, r.width, r.height);
			}
			
			this.gr.lineStyle(1, 0x0000FF);
			var r = Scaling.scaleRectangle(dplex.rectFull, this.scaling);
			r.offset(x, y);
			r.inflate(2, 2);
			this.gr.drawRect(r.x, r.y, r.width, r.height);
		}		
	}
	
	public function dpart(x:Float, y:Float, dpart:DPart, rects:Bool = true) {		
		var xpos = 0.0;
		for (dplex in dpart.complexes) {
			var dist = dpart.complexDistance.get(dplex);
			xpos += dist;			
			this.complex(x, y, dplex, rects, xpos);	
		}		
	}
	
	public function dbar(x:Float, y:Float, dbar:DBar, rects:Bool = true) {
		
		var x2:Float;
		var y2:Float;
		
		// Draw complexes...
		
		for (column in dbar.columns) {
			var y2 = y;			
			
			x2 = x + Scaling.scaleX(column.sPositionX, this.scaling);
			for (complex in column.complexes) {
				if (complex != null) {
					this.complex(x2, y2, complex, rects, 0, false);
				}
				y2 += 140;
			}
		}
		
		// Draw beams...
		
		var y2 = y;			
		for (dpart in dbar.dparts) {
			for (dvoice in dpart.dvoices) {
				var voiceIdx = ArrayTools.index(dpart.dvoices, dvoice);
				trace(voiceIdx);
				for (beamgroup in dvoice.beamGroups) {
					var frame = BeamTools.getDimensions(beamgroup);
					var dnotes = beamgroup.getNotes();
					var dnotesPositionsX:Array<Float> = [];
					for (dnote in dnotes) {
						var column = dbar.dnoteColumn.get(dnote);						
						var adjustX = dbar.dnoteComplexXadjust.get(dnote); // justera för sekundkrockar etc...						
						
						var posX = Scaling.scaleX(column.sPositionX + dnote.rectStave.x + adjustX, this.scaling);
						
						dnotesPositionsX.push(posX);
					}
					this.beamGroup(x, y2, frame, dnotesPositionsX);
				}
			}
			y2 += 140;
		}
		
		if (rects) {			
			var r = Scaling.scaleRectangle(dbar.columnsRectAll, this.scaling);
			r.y = -100;
			r.height = 360;
			r.offset(x, y);
			r.inflate(3, 3);
			this.gr.lineStyle(1, 0x00FF00);
			this.gr.drawRect(r.x, r.y, r.width, r.height);			
		}
	}
	
	
	
	
	
}