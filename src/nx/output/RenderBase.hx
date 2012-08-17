package nx.output;

import cx.ArrayTools;
import nme.display.GradientType;
import nme.display.Graphics;
import nme.display.Shape;
import nme.display.Sprite;
import nme.geom.Rectangle;
import nme.Vector;
import nx.Constants;
import nx.display.DBar;
import nx.display.DNote;
import nx.display.DPart;
import nx.display.Complex;
import nx.display.DVoice;
import nx.display.beam.BeamTools;
import nx.display.beam.IBeamGroup;
import nx.enums.EDirectionUAD;
import nx.enums.EDirectionUD;
import nx.enums.EHeadType;
import nx.enums.ENoteType;
import nx.enums.ENoteValue;
import nx.enums.ESign;
import nx.enums.utils.EDirectionTools;
import nx.output.text.TextBitmap;
import nx.svg.SvgAssets;
import nx.output.Scaling;
import nx.display.beam.BeamGroupFrame;
import nx.display.type.TSign;
import nx.display.type.TSigns;

/**
 * ...
 * @author Jonas Nyström
 */

using nx.output.Scaling;
using cx.ArrayTools;
using nx.display.DBar;
using Lambda;
using StringTools;
 
class RenderBase 
{

	private var target:Sprite;
	private var scaling:TScaling;
	private var gr:Graphics;
	
	private var textOutput:Text;
	
	public function new(target:Sprite, scaling:TScaling) {
		this.target = target;
		this.gr = target.graphics;
		this.scaling = scaling;
		//this.textOutput = new Text(this.scaling);
	}
	
	private function drawRect(x:Float, y:Float, rect:Rectangle, lineWidth = 1.0, lineColor = 0xFF0000) {
		if (rect == null) return;
		var r = this.scaling.scaleRect(rect);
		r.offset(x, y);
		this.gr.lineStyle(lineWidth, lineColor);
		this.gr.drawRect(r.x, r.y, r.width, r.height);
	}		
	
	
	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	

	
	private function dvoiceTies(x:Float, y:Float, dbar:DBar, dvoice:DVoice) {
		
		// Local function: 
		function _drawTie(rightDNote:DNote, leftDNote:DNote) {
			if (leftDNote != null) {				
				var tieConnectLevels = [];
				if (leftDNote.countTies() > 0) {
					var tieLevels = leftDNote.getTieLevels();					
					
					/*
					var columIdx = dbar.dnoteguidColumnidx.get(leftDNote.guid);
					var leftColumn = dbar.columns[columIdx];
					*/
					
					var leftColumn = dbar.dnoteColumn.get(leftDNote);
					
					var leftX = leftColumn.sPositionX + leftDNote.rectTiesfrom.x;
					var tieX 			= x + this.scaling.scaleX(leftX);					
					
					
					var tieXHanging = tieX;
					if (dbar.columns.last() != leftColumn) {
						tieXHanging 	+= this.scaling.scaleX(Constants.TIE_WIDTH);						
					} else {
						tieXHanging 	+= this.scaling.scaleX(Constants.TIE_WIDTH_LASTHANGING);						
					}
					
					
					var rightX = 0.0;
					var tieXRigthNote = 0.0;
					
					// if there is a right note to tie to:
					if (rightDNote != null) {
						tieConnectLevels = leftDNote.getTieConnections(rightDNote);
						
						/*
						 * 2.09 dpp ObjectHash bug workaround - seems to work in 2.10
						 * 
						var columidx = dbar.dnoteguidColumnidx.get(rightDNote.guid);
						var rightColumn = dbar.columns[columidx];
						*/
						
						var rightColumn = dbar.dnoteColumn.get(rightDNote);
						
						/*
						 * 2.09 dpp bug ObjectHash workaround - seems to work in 2.10
						 * 
						var complexIdx = dbar.dnoteguidComplexidx.get(rightDNote.guid);
						var rightComplex = rightColumn.complexes[complexIdx];
						*/
						var rightComplex = dbar.dnoteComplex.get(rightDNote);
						
						/*
						 * 2.09 dpp bug ObjectHash workaround - seems to work in 2.10
						 * 
						rightX = rightColumn.sPositionX + dbar.dnoteguidComplexXadjust.get(rightDNote.guid) - Constants.HEAD_QUARTERWIDTH;							
						*/
						
						rightX = rightColumn.sPositionX + dbar.dnoteComplexXadjust.get(rightDNote) - Constants.HEAD_QUARTERWIDTH;							
						
						
						rightX += (rightDNote.signs.count() > 0) ? rightComplex.rectSigns.x : rightComplex.rectHeads.x;
						tieXRigthNote 	= x + this.scaling.scaleX(rightX);
					}
					var tieConnectLength = rightX - leftX;
					
					
					var tieY:Float = 0.0;
					var tieThickness:Float = this.scaling.scaleY(Constants.TIE_THICKNESS);					
					var tieHeight:Float = 0.0;
					
					//-----------------------------------------------------------------------------------------

					var tieUp:Bool = false; // (leftDNote.direction == EDirectionUD.Up);
					var tieSingle:Bool = (leftDNote.countTies() == 1);
					
					
					switch(dvoice.direction) {
						case EDirectionUAD.Up:
							//trace('VoiceUp = tieUp true');
							tieUp = true;
							if (tieSingle) tieXRigthNote += this.scaling.scaleX(Constants.HEAD_QUARTERWIDTH + Constants.TIE_SINGLE_XCOMP);
						case EDirectionUAD.Down:
							//trace('VoiceDown = tieUp false');
							tieUp = false;
							if (tieSingle) {
								leftX = leftColumn.sPositionX + leftDNote.rectHeads.x + leftDNote.rectHeads.width - Constants.TIE_SINGLE_XCOMP;
								tieX = x + this.scaling.scaleX(leftX);										
							}
						default:							
							if (leftDNote.direction == EDirectionUD.Up) {
								//trace('VoiceAuto, NoteUp = tieUp true');
								tieUp = false;
							} else {
								//trace('VoiceAuto, NoteDown = tieUp true');
								tieUp = true;
							}
							// move y
							if (tieSingle) {								
								leftX = leftColumn.sPositionX + leftDNote.rectHeads.x + leftDNote.rectHeads.width - Constants.TIE_SINGLE_XCOMP;
								tieX = x + this.scaling.scaleX(leftX);		
								tieXRigthNote += this.scaling.scaleX(Constants.HEAD_QUARTERWIDTH + Constants.TIE_SINGLE_XCOMP);
							}
					}
					
					tieHeight = this.scaling.scaleY((tieUp) ? -Constants.TIE_HEIGHT : Constants.TIE_HEIGHT);
					
					if (tieSingle) {
						tieY = this.scaling.scaleY((tieUp) ? -Constants.TIE_SINGLE_YMOVE : Constants.TIE_SINGLE_YMOVE);
					} else {
						tieY = this.scaling.scaleY((tieUp) ? -Constants.TIE_MULTI_YMOVE : Constants.TIE_MULTI_YMOVE);
					}
					
					//-----------------------------------------------------------------------------------------

					var ty:Float = tieY;
					//this.gr.lineStyle(4, 0xFF0000);
					for (tieLevel in tieLevels) {
						ty = tieY + y +  this.scaling.scaleY(tieLevel * Constants.HEAD_HALFHEIGHT);
						if (tieConnectLevels.has(tieLevel)) {
							
							if (tieConnectLength < Constants.TIE_SHORT) {
								tieHeight = this.scaling.scaleY((tieUp) ? -Constants.TIE_SHORT_HEIGHT : Constants.TIE_SHORT_HEIGHT);
							}
							//trace(tieConnectLength, tieHeight);
							
							// connect to next note
							this.tie(this.gr, tieX, ty, tieXRigthNote-tieX, tieHeight, Constants.TIE_DELTA, tieThickness);
						} else {
							// hanging from this note
							this.tie(this.gr, tieX, ty, tieXHanging-tieX, tieHeight, Constants.TIE_DELTA, tieThickness);
						}
					}
				}
			}
		}
		
		// Core fold loop:
		
		var lastDNote:DNote;
		dvoice.dnotes.fold(function(rightDNote:DNote, leftDNote:DNote) {					
			_drawTie(rightDNote, leftDNote);
			lastDNote = rightDNote;			
			return rightDNote;
		}, null);				
		_drawTie(null, lastDNote);
		
	}
	
	public function cubicCurveTo(graphics:Graphics, anchorX1 : Float, anchorY1 : Float, controlX1 : Float, controlY1 : Float, controlX2 : Float, controlY2 : Float, anchorX2 : Float, anchorY2 : Float) {
		function _scaleCoords(coords:Vector<Float>) {				
			var i = 0;
			do {
				coords[i] 		= this.scaling.scaleX(coords[i]);
				coords[i + 1] 	= this.scaling.scaleY(coords[i + 1]);
				i += 2;					
			} while (i < Std.int(coords.length));
		}
		
		var segments:Float = 100;
		var step:Float = 1/segments;
		
		var posx:Float = 0.0;
		var posy:Float = 0.0;			
		var u:Float = 0.0;
		
		var cmds: Vector<Int> = new Vector<Int>();
		var coords: Vector<Float> = new Vector<Float>();
		
		do {
			posx = Math.pow(u,3)*(anchorX2+3*(controlX1-controlX2)-anchorX1)+3*Math.pow(u,2)*(anchorX1-2*controlX1+controlX2)+3*u*(controlX1-anchorX1)+anchorX1;
			posy = Math.pow(u,3)*(anchorY2+3*(controlY1-controlY2)-anchorY1)+3*Math.pow(u,2)*(anchorY1-2*controlY1+controlY2)+3*u*(controlY1-anchorY1)+anchorY1;
			//graphics.lineTo(posx, posy);
			
			cmds.push(2);
			coords.push(posx);
			coords.push(posy);
			
			u += step;
		} while (u <= 1);

		// graphics.drawPath(cmds, coords);
		this.graphicsDrawPath(this.gr, cmds, coords);

	}	
	
	public function tie(graphics:Graphics, x:Float, y:Float, width:Float, height:Float, delta:Float=8.0, thickness:Float=4.0) {
		var x2 = x + width;
		var deltaX = width / delta;
		//trace('deltaX: ' + deltaX);
		var cx1:Float = x + deltaX;
		var cx2:Float = x2 - deltaX;
		var halfThickness = thickness / 2;			
		graphics.moveTo(x, y);
		graphics.beginFill(0x000000);
		graphics.lineStyle(0); // , 0x000000, 0);
		this.cubicCurveTo(graphics, x, y-0, cx1, y + height - halfThickness, cx2, y + height - halfThickness, x2, y-0);
		this.cubicCurveTo(graphics, x2, y+0, cx2, y + height + halfThickness, cx1, y + height + halfThickness, x, y+0);
		graphics.endFill();
	}	
	
	// Js drawPath
	private function graphicsDrawPath(graphics:Graphics, cmds:Vector<Int>, coords:Vector<Float>) {
		for (i in 0...cmds.length) {
			var j = i * 2;
			var cmd = cmds[i];
			var coordX = coords[j];
			var coordY = coords[j + 1];
			if (cmd == 1) {
				graphics.moveTo(coordX, coordY);
			} else {
				graphics.lineTo(coordX, coordY);
			}
		}
	}	
	
	public function dnote(x:Float, y:Float, dnote:DNote, rects:Bool=false, collisionShiftX:Float=0, dvoice:DVoice=null) {
		var positions = dnote.headPositions.copy();
		
		switch (dnote.notetype) {
			case ENoteType.Lyric:
				this._drawLyric(x, y, dnote);
			case ENoteType.Pause:
				this._drawPause(x, y, dnote);
			
			case ENoteType.Normal:
				
				for (dhead in dnote.dheads) {
					var position = positions.shift();
					var xshift = scaling.scaleX(collisionShiftX);
					this._drawHead(x + xshift, y, dhead.level, position, dnote.notevalue.headType);					
					
					
					
					
					if (dnote.notevalue.dotLevel > 0) {
						
						//var tieUp:Bool = false; // (leftDNote.direction == EDirectionUD.Up);
						var dotLevel = 0;
						
						if (dhead.level < 0) {
							dotLevel = dhead.level  + ((dhead.level-1) % 2);
						} else {
							dotLevel = dhead.level-1 + (dhead.level % 2) ;
						}
						
						this._drawHeadDot(x, y, dotLevel, position, dnote);
					}					
					
				}
				
				_drawLegers(x, y, dnote);
				
			default:
		}
		
		this.dnoteDots(x, y, dnote, rects);
		
		
		if (rects) {
			//this.drawRect(x, y, dnote.rectHeads, 3, 0x0000FF);
			
			this.drawRect(x, y, dnote.rectStave, 1, 0xFF0000);
			if (dnote.rectDots != null)   this.drawRect(x, y, dnote.rectDots, 3, 0x00FF00);
			if (dnote.rectTiesfrom != null)  this.drawRect(x, y, dnote.rectTiesfrom, 3, 0xFF0000);
		}
	}
	
	private function _drawLyric(x:Float, y:Float, dnote:DNote) {
		var text:String = dnote.note.text;
		if (text.endsWith('-')) text.replace('-', '');
		if (text.endsWith('_')) text.replace('-', '');
		
		if (this.textOutput == null) {
			this.textOutput = new Text(this.scaling);
		}
		
		var bmp = textOutput.getStringBitmap(text);
		bmp.x = x + this.scaling.scaleX(dnote.rectText.x) - this.scaling.scaleX(Constants.TEXT_XADJUST);
		bmp.y = y + this.scaling.scaleY(dnote.rectText.y)- this.scaling.scaleX(Constants.TEXT_YADJUST);
		trace([text, bmp.width]);
		this.target.addChild(bmp);
	}
	
	private function _drawLegers(x:Float, y:Float, dnote:DNote) {
		
		var x1 = x + scaling.scaleX(dnote.rectHeads.x - Constants.HEAD_LEGER_LEFT) ;
		var x2 = x1 + scaling.scaleX(dnote.rectHeads.width + Constants.HEAD_LEGER_RIGHT);
		if (dnote.notevalue.stavingLevel == 0) x2 += scaling.scaleX(Constants.HEAD_LEGER_RIGHT_WHOLE);
		
		
		this.gr.lineStyle(scaling.linesWidth);
		if (dnote.levelTop <= -6) {
			for (level in 5...-dnote.levelTop+1) {
				if (level % 2 == 1) continue;
				var y1 = y + scaling.scaleY(-level);
				this.gr.moveTo(x1, y1);
				this.gr.lineTo(x2, y1);	
				//trace(x1, y1, x2);
			}
			
		}
		
		if (dnote.levelBottom >= 6) {
			for (level in 5...dnote.levelBottom+1) {
				if (level % 2 == 1) continue;
				var y1 = y + scaling.scaleY(level);
				this.gr.moveTo(x1, y1);
				this.gr.lineTo(x2, y1);	
			}
		}
	}
	
	private function _drawHeadDot(x:Float, y:Float, level:Int, position:Int, dnote:DNote) {
		
		
		//trace([level, dlevel]);
		
		var x2 = x + this.scaling.scaleX(dnote.rectDots.x + Constants.HEAD_QUARTERWIDTH);
		var y2 = y + this.scaling.scaleY(level);
		
		//trace(['dot', x, dnote.rectDots.x, x, y, x2, y2]);
		
		this.gr.beginFill(0x000000);	
		this.gr.lineStyle(0);
		var radius = this.scaling.scaleX(Constants.HEAD_DOTRADIUS);
		this.gr.drawCircle(x2, y2, radius);
		//var r = new Rectangle(x2 - radius, y2 - radius, 2 * radius, 2 * radius);
		//trace(r);
		//this.gr.drawEllipse(r.x, r.y, r.width, r.height);
		this.gr.endFill();
		
	}
	

	
	private function dnoteDots(x:Float, y:Float, dnote:DNote, rects:Bool) {
		if (dnote.rectDots == null) return;
		/*
		if (rects) {
			this.gr.lineStyle(1, 0x00FFFF);		
			var r = Scaling.scaleRectangle(dnote.rectDots, this.scaling);
			r.offset(x, y);
			this.gr.drawRect(r.x, r.y, r.width, r.height);		
		}	
		*/
		
	}
	
	private function dnoteStave(x:Float, y:Float, dnote:DNote, rects:Bool) {		
		if (dnote.rectStave == null) return;
		
		//if (dnote.type != ENoteType.Normal) return;		
		
		var r = this.scaling.scaleRect(dnote.rectStave);
		r.offset(x, y);

		/*
		if (rects) {
			this.gr.lineStyle(1, 0xFF0000);					
			this.gr.drawRect(r.x, r.y, r.width, r.height);		
		}				
		*/
		
		this.gr.lineStyle(this.scaling.linesWidth, 0x000000);
		this.gr.moveTo(r.x, r.y);
		this.gr.lineTo(r.x, r.y + r.height);

	}

	private function _drawHead(x:Float, y:Float, level:Int, position:Int, headType:EHeadType) {
		
		var headY = y + (level * scaling.halfSpace);
		var headX = x + position * this.scaling.scaleX(Constants.HEAD_WIDTH);
		
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
				this.gr.endFill();
			case ENoteValue.Nv1, ENoteValue.Nv1dot, ENoteValue.Nv1tri:
				var ry = level - 2 - (level % 2);
				var r = this.scaling.scaleRect( new Rectangle(-Constants.HEAD_HALFWIDTH, ry, Constants.HEAD_WIDTH , Constants.HEAD_HALFHEIGHT));
				r.offset(x, y);
				this.gr.beginFill(0x000000);
				this.gr.drawRect(r.x, r.y, r.width, r.height);
				this.gr.endFill();				
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
		
		//trace('draw flag!');
		
		var shape:Shape = new nme.display.Shape(); // = SvgAssets.getSvgShape("flaggor", scaling);
		
		
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
		
		
		//var shape = SvgAssets.getSvgShape('flagUp8', this.scaling);
		

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
		
		shape.x = x + scaling.svgX + scaling.scaleX(1.15);  
		
		target.addChild(shape);	 		
		
	}	
	
	
	
	public function complex(x:Float, y:Float, dplex:Complex, rects:Bool=true, moveX:Float=0, teststaves:Bool=true) {		
		if (moveX != 0) x += this.scaling.scaleX(moveX); // Scaling.scaleX(moveX, this.scaling);
		
		if (rects) {
			this.gr.lineStyle(1, 0xaaaaaa);
			this.gr.moveTo(x, y + -60);
			this.gr.lineTo(x, y + 60);
		}
		
		for (i in 0...dplex.dnotes.length) {			
			this.dnote(x, y, dplex.dnote(i), rects, dplex.dnoteXshift(i));	
		}		
		
		this.signs(dplex, x, y);

		if (rects) {			
			this.gr.lineStyle(1, 0xFF0000);
			var r = this.scaling.scaleRect(dplex.rectHeads); // Scaling.scaleRectangle(dplex.rectHeads, this.scaling);
			
			r.offset(x, y);
			r.inflate(2, 2);		
			
			this.gr.drawRect(r.x, r.y, r.width, r.height);
			
			if (dplex.rectSigns != null) {
				this.gr.lineStyle(1, 0x00FF00);		
				var r = this.scaling.scaleRect(dplex.rectSigns);
				r.offset(x, y);
				this.gr.drawRect(r.x, r.y, r.width, r.height);
			}
			
			this.gr.lineStyle(1, 0x0000FF);
			var r = this.scaling.scaleRect(dplex.rectFull);
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
	
	public function signs(dplex:Complex, x:Float, y:Float) {
		var gr = target.graphics;
		var posSpace = scaling.signPosWidth;
		
		
		if (dplex.rectSigns == null) return;
		
		var signs = dplex.signs;
		var xShift = this.scaling.scaleX(dplex.rectSigns.x);
		
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

	/*
	public function note(noteX:Float, noteY:Float, displayNote:DisplayNote) {		
		//if (drawRects) this.noteRects(noteX, noteY, displayNote);
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
			var r = this.scaling.scaleRect(signsDisplayRect); 
			xsigns(displayNote.getSigns(), noteX + r.left, noteY);			
		}
		


	}	
	*/
	
	
	
	
	
	public function beamGroup(xpos:Float, y:Float, frame:BeamGroupFrame, dnotePositionsX:Array<Float>) {
		
		function _dStave(sX:Float, sTopY:Float, sBottomY:Float) {
			this.target.graphics.moveTo(sX , sTopY);
			this.target.graphics.lineTo(sX , sBottomY);			
		}	
		
		if (frame.firstNotevalue.stavingLevel < 1) return;
		
		var firstX = (xpos + dnotePositionsX.first());
		var lastX = (xpos + dnotePositionsX.last());
		var beamW = lastX - firstX;
		var beamH = 0.0;
		
		var staves = frame.staves.copy();
		
		var count = frame.staves.length;
		
		var xfirstStave:BeamGroupStave = staves.shift();
		var xlastStave:BeamGroupStave = null; 
		var xinnerStaves:BeamGroupStaves = null;
		if (count > 1) {
			xlastStave = staves.pop();
		} else {
			xlastStave = xfirstStave;
		}
		
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
							var staveX = (xpos + dnotePositionsX[idx]);
							var slopeDelta = (staveX - firstX) / beamW;
							var innerTopY = firstTopY + beamH * slopeDelta;
							var innerBottomY = y + this.scaling.scaleY(innerStave.bottomY);
							this.gr.moveTo(staveX, innerBottomY);
							this.gr.lineTo(staveX, innerTopY);			
							idx++;
						}							
					}
					
					// Beam/flag
					
					if ((count > 1) && (frame.firstNotevalue.beamingLevel > 0)) {
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
							for (stave in frame.staves) {
								var staveX = xpos + dnotePositionsX[idx];
								
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
										x2 = prevStaveX + this.scaling.scaleX(Constants.BEAM_SUBWIDTH);
									case ESubBeam.ShortRight:										
										x1 = staveX - this.scaling.scaleX(Constants.BEAM_SUBWIDTH);
									default:
										
								}
								
								var yshift = this.scaling.scaleY(Constants.BEAM_SUBDISTANCE);
								
								var subW:Float = x2 - x1;								
								var subH = beamH * (subW / beamW);
								var y1 = firstTopY + ((x1-firstX) / beamW) * beamH + yshift;
								var y2 = firstTopY + ((x2-firstX) / beamW) * beamH + yshift;
								
								
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
					
					
					if ((count > 1) && (frame.firstNotevalue.beamingLevel > 0)) {
					
					
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
							for (stave in frame.staves) {
								var staveX = xpos + dnotePositionsX[idx];
								
								
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
										x2 = prevStaveX + this.scaling.scaleX(Constants.BEAM_SUBWIDTH);
									case ESubBeam.ShortRight:										
										x1 = staveX - this.scaling.scaleX(Constants.BEAM_SUBWIDTH);
									default:
										
								}
								
								var yshift = this.scaling.scaleY(Constants.BEAM_SUBDISTANCE);
								
								var subW:Float = x2 - x1;								
								var subH = beamH * (subW / beamW);
								var y1 = firstBottomY + ((x1-firstX) / beamW) * beamH - yshift;
								var y2 = firstBottomY + ((x2-firstX) / beamW) * beamH - yshift;
								
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
	
	/*
	public function noteARects(noteX:Float, noteY:Float, displayNote:DisplayNote, color:Int=0xFF0000) {
		nx.display.utils.DisplayNoteUtils.drawAODR(displayNote.getArrayOfDisplayRects() , this.target, noteX, noteY, this.scaling, color);		
	}
	*/
	
	/*
	public function noteRects(noteX:Float, noteY:Float, displayNote:DisplayNote) {
		var graphics = target.graphics;
		
		//graphics.beginFill(0, 0);
		graphics.endFill();
		
		
		// Zero line
		graphics.lineStyle(1, 0xCCCCCC);
		graphics.moveTo(noteX, noteY - 60);
		graphics.lineTo(noteX, noteY + 60);				
		
		
		// heads
		graphics.lineStyle(1, 0xFF0000);
		for (h in displayNote.getDisplayHeads()) {			
			var r = this.scaling.scaleRect(h.getDisplayRect()); 		
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);			
		}
		
		
		
		// note
		//var r = Scaling.scaleRectangle(displayNote.getDisplayRect(), scaling); 		
		//graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);			
		
		// signs
		graphics.lineStyle(1, 0x00FFFF);
		var signsDisplayRect = displayNote.getDisplayRectSigns();
		if (signsDisplayRect != null) {		
			var r = this.scaling.scaleRect(signsDisplayRect); 
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);				
		}
		
		// stave
		graphics.lineStyle(1, 0xff0000);
		var staveDisplayRect = displayNote.getDisplayRectStave();
		if (staveDisplayRect != null) {
			var r = this.scaling.scaleRect(staveDisplayRect);
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);				
		}
		
		// dots
		graphics.lineStyle(1, 0x00ff00);
		var r = displayNote.getDisplayRectDots();
		if (r != null) {
			var r = this.scaling.scaleRect(r);
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);	
		}
		
		// tieFrom
		graphics.lineStyle(1, 0x0000ff);
		var r = displayNote.getDisplayRectTieFrom();
		if (r != null) {
			var r = this.scaling.scaleRect(r);
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);	
		}
		
		// apoggiatura 
		graphics.lineStyle(1, 0xff0000);
		var r = displayNote.getDisplayRectAppogiatura();
		if (r != null) {
			var r = this.scaling.scaleRect(r);
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);	
		}

		// arpeggio 
		graphics.lineStyle(1, 0x000000);
		var r = displayNote.getDisplayRectArpeggio();
		if (r != null) {
			var r = this.scaling.scaleRect(r);
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);	
		}

		// tieTo
		graphics.lineStyle(1, 0x0000ff);
		var r = displayNote.getDisplayRectTieTo();
		if (r != null) {
			var r = this.scaling.scaleRect(r);
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);	
		}		
		
		// clef
		graphics.lineStyle(1, 0xff00ff);
		var r = displayNote.getDisplayRectClef();
		if (r != null) {
			var r = this.scaling.scaleRect(r);
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);	
		}		
		
		// total
		graphics.lineStyle(2, 0x000000);
		var r = displayNote.getTotalRect();
		if (r != null) {
			var r = this.scaling.scaleRect(r);
			graphics.drawRect(noteX + r.x, noteY + r.y, r.width, r.height);	
		}			
		
		
	}
	*/
	
	
}

/*
typedef TSign = {
	sign:ESign,
	level:Int,	
	position:Int,
}

typedef TSigns = Array<TSign>;
*/