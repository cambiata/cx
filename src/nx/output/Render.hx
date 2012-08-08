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
import nx.enums.ENoteType;
import nx.enums.ENoteValue;
import nx.svg.SvgAssets;
import nx.output.Scaling;
import nx.display.beam.BeamGroupFrame;

/**
 * ...
 * @author Jonas Nyström
 */
using nx.output.Scaling;
using cx.ArrayTools;
using nx.core.display.DBar;


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
		
		function _dStave(sX:Float, sTopY:Float, sBottomY:Float) {
			this.target.graphics.moveTo(sX , sTopY);
			this.target.graphics.lineTo(sX , sBottomY);			
		}	
		
		if (frame.firstNotevalue.stavingLevel < 1) return;
		
		var firstX = xpos + dnotePositionsX.first();
		var lastX = xpos + dnotePositionsX.last();
		var beamW = lastX - firstX;
		var beamH = 0.0;
		
		var staves = frame.staves.copy();
		
		var count = frame.staves.length;
		
		var xfirstStave:BeamGroupStave = staves.shift();
		var xlastStave:BeamGroupStave = staves.pop();
		var xinnerStaves:BeamGroupStaves = staves;
		
		//trace([frame.firstStave, xfirstStave]);
		//trace([frame.lastStave, xlastStave]);
		
		var adjustX = 0; // this.scaling.halfNoteWidth; // frame.adjustX * this.scaling.halfNoteWidth;
		var firstTopY = y + (xfirstStave.topY * scaling.halfSpace);
		var lastTopY = y + (xlastStave.topY * scaling.halfSpace); 
		var firstBottomY = y + (xfirstStave.bottomY  * scaling.halfSpace);
		var lastBottomY = y + (xlastStave.bottomY * scaling.halfSpace);
		
		
		var beamHeight = this.scaling.scaleY(Constants.BEAM_HEIGHT);
		
		switch (frame.firstType) {
			
			case ENoteType.Normal: 
				
				this.target.graphics.lineStyle(this.scaling.linesWidth, 0x000000);
				
				if (frame.direction == EDirectionUD.Up) {			
					
					beamH = lastTopY - firstTopY;
					
					// Staves
					//this.target.graphics.moveTo(firstX , firstTopY);
					//this.target.graphics.lineTo(firstX , firstBottomY);
					_dStave(firstX, firstTopY, firstBottomY);
					
					if (count > 1) {
						//this.target.graphics.moveTo(lastX , lastTopY);				
						//this.target.graphics.lineTo(lastX , lastBottomY);							
						_dStave(lastX, lastTopY, lastBottomY);
					}

					if (count > 2) {
						var idx = 1;
						for (innerStave in xinnerStaves) {
							var staveX = xpos + dnotePositionsX[idx];
							var slopeDelta = (staveX - firstX) / beamW;
							var innerTopY = firstTopY + beamH * slopeDelta;
							var innerBottomY = y + this.scaling.scaleY(innerStave.bottomY);
							this.gr.moveTo(staveX, innerBottomY);
							this.gr.lineTo(staveX, innerTopY);			
							idx++;
						}							
					}
					
					// Beam/flag
					
					if ((count > 1) && (frame.firstNotevalue.beamingLevel > 1)) {
						// 8th beam
						
							this.target.graphics.beginFill(0x000000);
							this.target.graphics.moveTo(firstX		, firstTopY);
							this.target.graphics.lineTo(lastX 	, lastTopY);
							this.target.graphics.lineTo(lastX 	, lastTopY + beamHeight);
							this.target.graphics.lineTo(firstX 		, firstTopY + beamHeight);
							this.target.graphics.lineTo(firstX 		, firstTopY);
							this.target.graphics.endFill();	
							
							
							
							var prevStave:BeamGroupStave = null;
							var prevStaveX:Float = 0;
							var idx = 0;
							trace(firstX);
							trace(frame.staves.length);
							for (stave in frame.staves) {
								var staveX = xpos + dnotePositionsX[idx];
								trace([stave, idx, staveX]);
								
								
								if (prevStave == null) {
									prevStave = stave;
									prevStaveX = staveX;
									idx++;
									continue;
								}

								var x1:Float = prevStaveX;
								var x2:Float = staveX;
								
								switch(stave.flag16) {
									case ESubBeam.ShortLeft:										
										x2 = prevStaveX + this.scaling.scaleX2(Constants.BEAM_SUBWIDTH);
									case ESubBeam.ShortRight:										
										x1 = staveX - this.scaling.scaleX2(Constants.BEAM_SUBWIDTH);
									default:
										
								}
								
								var yshift = this.scaling.scaleY(Constants.BEAM_SUBDISTANCE);
								
								var subW:Float = x2 - x1;								
								var subH = beamH * (subW / beamW);
								var y1 = firstTopY + ((x1-firstX) / beamW) * beamH + yshift;
								var y2 = firstTopY + ((x2-firstX) / beamW) * beamH + yshift;
								
								
								trace([x1, y1, x2, y2]);
								
								if (stave.flag16 != ESubBeam.None) {
									this.target.graphics.beginFill(0x000000);
									this.target.graphics.moveTo(x1		, y1);
									this.target.graphics.lineTo(x2 		, y2);
									this.target.graphics.lineTo(x2 		, y2 + beamHeight);
									this.target.graphics.lineTo(x1 		, y1 + beamHeight);
									this.target.graphics.lineTo(x1 		, y1);
									this.target.graphics.endFill();									
								}
								
								
								prevStave = stave;
								prevStaveX = staveX;
								idx++;
							}
						
						
					} else {
						this._drawFlag(firstX, y, frame);
					}
				} else {
					
					beamH = lastBottomY - firstBottomY;
					
					this.target.graphics.moveTo(firstX , firstBottomY);
					this.target.graphics.lineTo(firstX , firstTopY);			
					if (count > 1) {
						this.target.graphics.moveTo(lastX , lastBottomY);				
						this.target.graphics.lineTo(lastX , lastTopY);				
					}
					if (count > 2) {
						var idx = 1;
						for (innerStave in xinnerStaves) {
							var staveX = xpos + dnotePositionsX[idx];
							var slopeDelta = (staveX - firstX) / beamW;
							var innerBottomY = firstBottomY + beamH * slopeDelta;
							var innerTopY = y + this.scaling.scaleY(innerStave.topY);
							this.gr.moveTo(staveX, innerBottomY);
							this.gr.lineTo(staveX, innerTopY);			
							idx++;
						}
					}	
					
					
					if ((count > 1) && (frame.firstNotevalue.beamingLevel > 1)) {
					
					
						this.target.graphics.beginFill(0x000000);
						this.target.graphics.moveTo(firstX 		, firstBottomY);
						this.target.graphics.lineTo(lastX 	, lastBottomY);
						this.target.graphics.lineTo(lastX 	, lastBottomY - beamHeight);
						this.target.graphics.lineTo(firstX		, firstBottomY - beamHeight);
						this.target.graphics.lineTo(firstX 		, firstBottomY);
						this.target.graphics.endFill();		
						
						
							var prevStave:BeamGroupStave = null;
							var prevStaveX:Float = 0;
							var idx = 0;
							trace(firstX);
							trace(frame.staves.length);
							for (stave in frame.staves) {
								var staveX = xpos + dnotePositionsX[idx];
								trace([stave, idx, staveX]);
								
								
								if (prevStave == null) {
									prevStave = stave;
									prevStaveX = staveX;
									idx++;
									continue;
								}

								var x1:Float = prevStaveX;
								var x2:Float = staveX;
								
								switch(stave.flag16) {
									case ESubBeam.ShortLeft:										
										x2 = prevStaveX + this.scaling.scaleX2(Constants.BEAM_SUBWIDTH);
									case ESubBeam.ShortRight:										
										x1 = staveX - this.scaling.scaleX2(Constants.BEAM_SUBWIDTH);
									default:
										
								}
								
								var yshift = this.scaling.scaleY(Constants.BEAM_SUBDISTANCE);
								
								var subW:Float = x2 - x1;								
								var subH = beamH * (subW / beamW);
								var y1 = firstBottomY + ((x1-firstX) / beamW) * beamH - yshift;
								var y2 = firstBottomY + ((x2-firstX) / beamW) * beamH - yshift;
								
								
								trace([x1, y1, x2, y2]);
								
								if (stave.flag16 != ESubBeam.None) {
									this.target.graphics.beginFill(0x000000);
									this.target.graphics.moveTo(x1		, y1);
									this.target.graphics.lineTo(x2 		, y2);
									this.target.graphics.lineTo(x2 		, y2 - beamHeight);
									this.target.graphics.lineTo(x1 		, y1 - beamHeight);
									this.target.graphics.lineTo(x1 		, y1);
									this.target.graphics.endFill();									
								}
								
								
								prevStave = stave;
								prevStaveX = staveX;
								idx++;
							}
						
						
						
						
					} else {
						this._drawFlag(firstX, y, frame);
					}
				}
				
			default:
			
		}
		
		
		
		
	}
	

	
	//-----------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------
	
	public function dnote(x:Float, y:Float, dnote:DNote, rects:Bool=false, teststave:Bool=true) {
		var positions = dnote.headPositions.copy();
		
		switch (dnote.notetype) {
			
			case ENoteType.Pause:
				this._drawPause(x, y, dnote);
			
			case ENoteType.Normal:
				for (dhead in dnote.dheads) {
					var position = positions.shift();
					this._drawHead(x, y, dhead.level, position, dnote.notevalue.headType);
					
					if (dnote.notevalue.dotLevel > 0) {
						this._drawHeadDot(x, y, dhead.level, position, dnote);
						
					}
					
				}			
				if (teststave) this.dnoteStave(x, y, dnote, rects);
			default:
				
		}
		
		this.dnoteDots(x, y, dnote, rects);
		
		
		if (rects) {
			this.gr.lineStyle(1, 0x0000FF);		
			var r = Scaling.scaleRectangle(dnote.rectHeads, this.scaling);
			r.offset(x, y);
			this.gr.drawRect(r.x, r.y, r.width, r.height);		
		}
	}
	
	private function _drawHeadDot(x:Float, y:Float, level:Int, position:Int, dnote:DNote) {
		
		var dlevel = level + (level % 2)-1;
		trace([level, dlevel]);
		
		var x2 = x + this.scaling.scaleX2(dnote.rectDots.x + Constants.HEAD_QUARTERWIDTH);
		var y2 = y + this.scaling.scaleY(dlevel);
		
		trace(['dot', x, dnote.rectDots.x, x, y, x2, y2]);
		
		this.gr.beginFill(0x000000);	
		this.gr.lineStyle(0);
		var radius = this.scaling.scaleX2(Constants.HEAD_DOTRADIUS);
		this.gr.drawCircle(x2, y2, radius);
		//var r = new Rectangle(x2 - radius, y2 - radius, 2 * radius, 2 * radius);
		//trace(r);
		//this.gr.drawEllipse(r.x, r.y, r.width, r.height);
		this.gr.endFill();
		
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
		
		//if (dnote.type != ENoteType.Normal) return;		
		
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
				shape = SvgAssets.getSvgShape("noteWhole", scaling);
			case EHeadType.White:
				shape = SvgAssets.getSvgShape("noteWhite", scaling);
			default:
				shape = SvgAssets.getSvgShape("noteBlack", scaling);
		}
		
		shape.x = headX + scaling.svgX;  
		shape.y = headY + scaling.svgY;
		target.addChild(shape);	  			
	}		
	
	private function _drawPause(x:Float, y:Float, dnote:DNote) {
		
		var shape:Shape = null; // SvgAssets.getSvgShape("pauseNv16", scaling);		
		//trace(dnote.notevalue);
		
		var level = dnote.dheads[0].level;
		
		switch (dnote.notevalue) {
			case ENoteValue.Nv16 , ENoteValue.Nv16dot, ENoteValue.Nv16tri:
				shape = SvgAssets.getSvgShape("pauseNv16", scaling);			
			case ENoteValue.Nv8 , ENoteValue.Nv8dot, ENoteValue.Nv8tri:
				shape = SvgAssets.getSvgShape("pauseNv8", scaling);
			case ENoteValue.Nv4, ENoteValue.Nv4dot, ENoteValue.Nv4ddot, ENoteValue.Nv4tri:
				shape = SvgAssets.getSvgShape("pauseNv4", scaling);
				
			case ENoteValue.Nv2, ENoteValue.Nv2dot, ENoteValue.Nv2tri:
				var ry = level - 1 - (level % 2);
				var r = this.scaling.scaleRect( new Rectangle(-Constants.HEAD_HALFWIDTH, ry, Constants.HEAD_WIDTH * 0.9, Constants.HEAD_HALFHEIGHT));
				r.offset(x, y);
				this.gr.beginFill(0x000000);
				this.gr.drawRect(r.x, r.y, r.width, r.height);
			case ENoteValue.Nv1, ENoteValue.Nv1dot, ENoteValue.Nv1tri:
				var ry = level - 2 - (level % 2);
				var r = this.scaling.scaleRect( new Rectangle(-Constants.HEAD_HALFWIDTH, ry, Constants.HEAD_WIDTH , Constants.HEAD_HALFHEIGHT));
				r.offset(x, y);
				this.gr.beginFill(0x000000);
				this.gr.drawRect(r.x, r.y, r.width, r.height);

			default: 
				shape = SvgAssets.getSvgShape("noteBlack", scaling);		
		}
		
		
		if (shape != null) {
			var headY = y + (level * scaling.halfSpace);
			var headX = x;		
			shape.x = headX + scaling.svgX;  
			shape.y = headY + scaling.svgY;
			target.addChild(shape);	 				
		}
		
		
	}	
	
	private function _drawFlag(x:Float, y:Float, frame:BeamGroupFrame) {
		
		if (frame.firstNotevalue.beamingLevel < 1) return;
		
		var shape:Shape = SvgAssets.getSvgShape("flaggor", scaling);
		if (frame.firstNotevalue.beamingLevel == 1) {
			if (frame.direction == EDirectionUD.Up) {				
				shape = SvgAssets.getSvgShape("flagUp8", scaling);				
			} else {
				shape = SvgAssets.getSvgShape("flagDown8", scaling);				
			}
		} else if (frame.firstNotevalue.beamingLevel == 2) {
				if (frame.direction == EDirectionUD.Up) {				
				shape = SvgAssets.getSvgShape("flagUp16", scaling);				
			} else {
				shape = SvgAssets.getSvgShape("flagDown16", scaling);				
			}		
		}
		
		var fy = 0.0;
		
		var firstStave = frame.staves.first();
		
		if (frame.direction == EDirectionUD.Up) {			
			//trace(frame.firstStave.topY);
			fy = scaling.scaleY(firstStave.topY+1.8);
		} else {			
			//trace(frame.firstStave.bottomY);
			fy = scaling.scaleY(firstStave.bottomY-1.8);
		}
		
		shape.y = y + scaling.svgY + fy;
		
		shape.x = x + scaling.svgX + scaling.scaleX2(1.15);  
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
	
	public function dbar(x:Float, y:Float, dbar:DBar, stretchToWidth:Float=0, rects:Bool = true) {

		// Stretch		
		var currentWidth = this.scaling.scaleX2(dbar.columnsRectAlloted.width);
		dbar.stretchContentTo( this.scaling.descaleX(stretchToWidth));		
		
		trace(this.scaling.scaleX2(dbar.columnsRectStretched.width));		
		
		//-----------------------------------------------------------------
		
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
				for (beamgroup in dvoice.beamGroups) {
					var frame = BeamTools.getDimensions(beamgroup);
					var dnotes = beamgroup.getNotes();
					var dnotesPositionsX:Array<Float> = [];
					for (dnote in dnotes) {
						var column = dbar.dnoteColumn.get(dnote);						
						var adjustX = dbar.dnoteComplexXadjust.get(dnote); // justera för sekundkrockar etc...						
						var rectStaveX:Float = 0;
						if (dnote.rectStave != null) rectStaveX = dnote.rectStave.x;
						var posX = Scaling.scaleX(column.sPositionX + rectStaveX + adjustX, this.scaling);
						
						dnotesPositionsX.push(posX);
					}
					this.beamGroup(x, y2, frame, dnotesPositionsX);
				}
			}
			y2 += 140;
		}
		
		if (rects) {		
			var r = Scaling.scaleRectangle(dbar.columnsRectStretched, this.scaling);
			r.y = -20;
			r.height = 20;
			
			r.offset(x, y);
			this.gr.lineStyle(1, 0x00FF00);
			this.gr.drawRect(r.x, r.y, r.width, r.height);			
		}
	}
	
	
	
	
	
}