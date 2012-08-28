package nx.output;
import cx.ArrayTools;
import cx.ReflectTools;
import nme.display.BitmapData;
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
import nx.display.DSystems;
import nx.display.DVoice;
import nx.display.beam.BeamTools;
import nx.display.beam.IBeamGroup;
import nx.enums.EBarline;
import nx.enums.EClef;
import nx.enums.EDirectionUAD;
import nx.enums.EDirectionUD;
import nx.enums.EHeadType;
import nx.enums.EKey;
import nx.enums.ENoteType;
import nx.enums.ENoteValue;
import nx.enums.EPartType;
import nx.enums.EVoiceType;
import nx.enums.utils.EDirectionTools;
import nx.output.Scaling;
import nx.display.beam.BeamGroupFrame;
import nx.enums.ETime;
import nx.enums.ETime.ETimeUtils;
import nx.display.type.TSign;
import nx.display.type.TSigns;
import nx.svg.MusicElements;

/**
 * ...
 * @author Jonas Nyström
 */
using nx.output.Scaling;
using cx.ArrayTools;
using nx.display.DBar;
using Lambda;
using StringTools;
using nx.svg.MusicElements;

class Render 
{
	
	static private var textOutput:Text;	
	
	static public function lines(target:Sprite, scaling:TScaling, x:Float, y:Float, width:Float, dbar:DBar=null, dpart:DPart=null) {
		var gr = target.graphics;
		
		if (dpart.dType != EPartType.Normal) return;
		var x2 = x;
		
		if (dbar != null) {
			var ackodladeOffset = scaling.scaleX(dbar.rectAckolademargin.x);
			var indentRightOffset = scaling.scaleX(dbar.rectRightindent.width);
			x2 += ackodladeOffset;
			width -= (ackodladeOffset + indentRightOffset);
		}
		
		target.graphics.lineStyle(scaling.linesWidth, 0);
		for (f in -2...3) {
			var yPos = f * scaling.space;
			gr.moveTo(x2, y - yPos);
			gr.lineTo(x2 + width, y - yPos);
		}		
		
	}
	
	static public function dbar(target:Sprite, scaling:TScaling, x:Float, y:Float, dbar:DBar, stretchToWidth:Float=0, rects:Bool = true) {
		var gr = target.graphics;
		gr.endFill();
		
		// Stretch		
		var currentWidth = scaling.scaleX(dbar.columnsRectAlloted.width);
		dbar.stretchContentTo( scaling.descaleX(stretchToWidth));		
		
		// STRETCHED WIDTH:
		// trace(scaling.scaleX(dbar.columnsRectStretched.width));		
		
		//-----------------------------------------------------------------
		
		var x2:Float;
		var y2:Float;

		/*
		for (dpart in dbar.dparts) {
			trace(dbar.dpartTop.get(dpart));
		}
		*/
		
		// Draw complexes...
		
		for (column in dbar.columns) {
			//x2 = x + Scaling.scaleX(column.sPositionX, scaling);
			x2 = x + scaling.scaleX(column.sPositionX);
			for (partComplex in column.complexes) {
				if (partComplex != null) {					
					y2 = y + scaling.scaleY(dbar.dpartTop.get(partComplex.dpart));					
					complex(target, scaling, x2, y2, partComplex, rects, 0, false);
				}
			}
		}
		
		// Draw beams...
		
		for (dpart in dbar.dparts) {
			y2 = y + scaling.scaleY(dbar.dpartTop.get(dpart));					
			switch (dpart.dType) {
				case EPartType.Normal:
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
								//var posX = Scaling.scaleX(column.sPositionX + rectStaveX + adjustX, scaling);
								var posX = scaling.scaleX(column.sPositionX + rectStaveX + adjustX);
								
								dnotesPositionsX.push(posX);
							}
							beamGroup(target, scaling, x, y2, frame, dnotesPositionsX);
						}
					}
				default:
					// draw no beams!
			}
		}
		
		// Draw part stuff...
		
		for (dpart in dbar.dparts) {
			y2 = y + scaling.scaleY(dbar.dpartTop.get(dpart));				
			
			if (rects) {
				var heightRect = dpart.rectDPartHeight;
				heightRect.width = 10;
				drawRect(target, scaling, x, y2, heightRect, 1, 0x00FF00);						
			}
		}
		
		
		
		// Draw voice stuff...
		
		for (dpart in dbar.dparts) {
			y2 = y + scaling.scaleY(dbar.dpartTop.get(dpart));			
			for (dvoice in dpart.dvoices) {
				dvoiceBarpause(target, scaling, x, y2, dbar, dvoice);
				dvoiceTies(target, scaling, x, y2, dbar, dvoice);
				
				/*
				var heightRect = dvoice.heightRect;	
				heightRect.width = 200;
				gr.lineStyle(2, 0x00FF00);
				drawRect(x, y2, heightRect, 2, 0x00FF00);
				*/
				
			}
		}

		//-----------------------------------------------------------------------------------------------------
		
		if (rects) {		
			var r = scaling.scaleRect(dbar.columnsRectStretched);
			r.y = -20;
			r.height = 20;
			
			r.offset(x, y);
			gr.lineStyle(1, 0x00FF00);
			gr.drawRect(r.x, r.y, r.width, r.height);			
		}
	}
	
	static public function dvoiceBarpause(target:Sprite, scaling:TScaling, x:Float, y2:Float, dbar:DBar, dvoice:DVoice) {
		var gr = target.graphics;
		
		if (dvoice.voice.type != EVoiceType.Barpause) return;

		var level = dvoice.voice.notes.first().heads.first().level;
		var ry = level - 2 - (level % 2);
		var r = scaling.scaleRect( new Rectangle(-Constants.HEAD_HALFWIDTH, ry, Constants.HEAD_WIDTH , Constants.HEAD_HALFHEIGHT));

		var width = scaling.scaleX(dbar.columnsRectStretched.width) ;
		var x2 = x + scaling.scaleX(dbar.columnsRectStretched.x);
		var x3 = x2 + ((width - r.width) / 2);
		
		r.offset(x3, y2);
		gr.lineStyle(1, 0x00000);		
		gr.beginFill(0x000000);
		gr.drawRect(r.x, r.y, r.width, r.height);
		gr.endFill();				
	}
	
	static public function dbarFull(target:Sprite, scaling:TScaling, x:Float, y:Float, dbar:DBar, stretchToWidth:Float=0,  rects:Bool = true ) {
		
		var barMeas = dbar.getTotalWidthAlloted();
		
		var scaledAttrLeftWidth = scaling.scaleX(barMeas.attribLeftWidth);
		var scaledAttrRightWidth	= scaling.scaleX(barMeas.attribRightWidth);
		var contentUnstretchedWidth = scaling.scaleX(barMeas.columnsWidth);
		
		var minWidth = scaledAttrLeftWidth + contentUnstretchedWidth + scaledAttrRightWidth;
		stretchToWidth = Math.max(minWidth, stretchToWidth);
		
		var stretchToWidth2 = stretchToWidth - (scaledAttrLeftWidth + scaledAttrRightWidth);
		//dbar.stretchContentTo(scaling.descaleX(stretchToWidth2));
		//trace(stretchToWidth2);
		
		var attrLeftX = x;
		var attrLeftWidth = scaling.scaleX(barMeas.attribLeftWidth);
		//var y2 = y;
		
		
		var y2:Float = 0.0;
		for (dpart in dbar.dparts) {			
			y2 = y + scaling.scaleY(dbar.dpartTop.get(dpart));			
			
			dbarAttributesLeft(target, scaling, x, y2, dbar, dpart, rects);									
			attributeClef(target, scaling, x, y2, dbar, dpart, rects);
			attributeKey(target, scaling, x, y2, dbar, dpart, rects);
			attributeTime(target, scaling, x, y2, dbar, dpart, rects);
			//y2 += 180;
		}
		
		var columnsX = x + attrLeftWidth;		
		var columnsXAdjust = scaling.scaleX(-dbar.columnsRectStretched.x);
		Render.dbar(target, scaling, columnsX + columnsXAdjust, y, dbar, stretchToWidth2, rects);
		
		//trace(dbar.columnsRectAlloted.width);
		//trace(dbar.columnsRectStretched.width);
		
		var columnsWidth = scaling.scaleX(dbar.columnsRectStretched.width);

		var attrRightX = columnsX + columnsWidth;
		var attrRightWidth =  scaling.scaleX(barMeas.attribRightWidth);
		
		
		var x2 = attrRightX + attrRightWidth - x;
		
		for (dpart in dbar.dparts) {			
			y2 = Std.int(y + scaling.scaleY(dbar.dpartTop.get(dpart)));									
			
			barline(target, scaling, attrRightX, y2, dbar, dpart, rects);
			
			dbarAttributesRight(target, scaling, attrRightX, y2, dbar, rects);                        
			lines(target, scaling, x, y2, x2, dbar, dpart);
		}
	}
	
	static public function barline(target:Sprite, scaling:TScaling, x:Float, y:Float, dbar:DBar, dpart:DPart, rects:Bool) {
		
		if (dpart.dType != EPartType.Normal) return;
		
		var gr = target.graphics;
		
		var x2 =x + scaling.scaleX(dbar.rectBarline.x + dbar.rectBarline.width);
		var lineThickness = scaling.linesWidth * 1.5;
		gr.lineStyle(lineThickness, 0x000000);

		var barlineHeight = scaling.scaleY(2 * Constants.HEAD_HEIGHT) ;
		
		var barline = dbar.dBarline;
		if (barline == null) barline = EBarline.Normal;
		
		switch (barline) {
			case EBarline.Normal:
				gr.moveTo(x2, y - barlineHeight);
				gr.lineTo(x2, y + barlineHeight);
			case EBarline.Double: 
				gr.moveTo(x2, y - barlineHeight);
				gr.lineTo(x2, y + barlineHeight);
				x2 -= scaling.scaleX(Constants.BARLINE_DOUBLE_WIDTH);
				gr.moveTo(x2, y - barlineHeight);
				gr.lineTo(x2, y + barlineHeight);
			default: 
				gr.moveTo(x2, y - barlineHeight);
				gr.lineTo(x2, y + barlineHeight);
		}
		
	}

	static public function dbarAttributesLeft(target:Sprite, scaling:TScaling, x:Float, y:Float, dbar:DBar, dpart:DPart, rects:Bool = true) {		
		if (!rects) return;
		
		
		target.graphics.endFill();
		
		drawRect(target, scaling, x, y, dbar.attributesRectLeft, 1, 0xaaaaaa);
		drawRect(target, scaling, x, y, dbar.rectLeftindent, 1, 0x0000FF);
		drawRect(target, scaling, x, y, dbar.rectLabels, 1, 0x00FF00);
		drawRect(target, scaling, x, y, dbar.rectAckolade, 1, 0x0000FF);
		drawRect(target, scaling, x, y, dbar.rectAckolademargin, 1, 0x0000FF);
		drawRect(target, scaling, x, y, dbar.rectClef, 1, 0x00FF00);
		drawRect(target, scaling, x, y, dbar.rectKey, 1, 0xFF0000);
		drawRect(target, scaling, x, y, dbar.rectTime, 1, 0x0000FF);
		drawRect(target, scaling, x, y, dbar.rectBarlineleft, 1, 0x00FF00);
		drawRect(target, scaling, x, y, dbar.rectMarginLeft, 1, 0xFF0000);
	}
	
	static public function attributeClef(target:Sprite, scaling:TScaling, x:Float, y:Float, dbar:DBar, dpart:DPart, rects:Bool = true) {
		if (dpart.dType != EPartType.Normal) return;
		if (dpart.dClef == null) return;
		//trace(dbar.rectClef);
		var x2 = x + scaling.scaleX(dbar.rectClef.x);
		
		var shape:Shape = null;
		switch(dpart.dClef) {
			case EClef.ClefG:
				shape = MusicElements.clefG.getShape(scaling);
			case EClef.ClefC:
				shape = MusicElements.clefC.getShape(scaling);
			case EClef.ClefF:
				shape = MusicElements.clefF.getShape(scaling);
		}
		
		shape.x = x2 + scaling.svgX + scaling.scaleX(Constants.HEAD_HALFWIDTH);
		shape.y = y + scaling.svgY + scaling.scaleY(Constants.HEAD_HEIGHT);
		target.addChild(shape);
	}
	
	static public function attributeKey(target:Sprite, scaling:TScaling, x:Float, y:Float, dbar:DBar, dpart:DPart, rects:Bool = true) {
		if (dpart.dType != EPartType.Normal) return;
		if (dpart.dKey == null) return;
		if (dpart.dKey.levelShift == 0) return;
		
		var x2 = x + scaling.scaleX(dbar.rectKey.x);
		
		var shape:Shape = null;
		var key = dpart.dKey;				
#if (flash || windows)
		var keyValue = key.levelShift;
#else
		var keyValue = (key.levelShift != null) ? key.levelShift : 0;
#end		
		
		//trace(keyValue);
		var absValue = Std.int(Math.abs(keyValue));
		if (absValue == 0) return;
		
		var keySharp:Bool = (keyValue > 0);
		
				
		for (i in 0...absValue) {
			if (keySharp) {
				shape = MusicElements.signSharp.getShape(scaling);
			} else {
				shape = MusicElements.signFlat.getShape(scaling);
			}				
			
			var x3 = x2 + scaling.svgX + (i * scaling.scaleX(Constants.SIGN_WIDTH)) + scaling.scaleX(Constants.HEAD_HALFWIDTH);
			var y2 = y + scaling.svgY + scaling.scaleY(EKey.getSignLevel(keyValue, i, dpart.dClef));
			shape.x = x3;
			shape.y = y2;
			target.addChild(shape);
		}
	}

	static public function attributeTime(target:Sprite, scaling:TScaling, x:Float, y:Float, dbar:DBar, dpart:DPart, rects:Bool = true) {
		if (dpart.dType != EPartType.Normal) return;
		if (dbar.dTime == null) return;
		
		var x2 = x + scaling.scaleX(dbar.rectTime.x);
		
		var shape:Shape = null;
		var shapeLower:Shape = null;
		
		var x3 = x2 + scaling.svgX + scaling.scaleX(Constants.HEAD_HALFWIDTH);
		var y2 = y + scaling.svgY;
		
		var timeId = ETimeUtils.toString(dbar.dTime);
		switch (timeId) {
			case 'Common': 
				shape = MusicElements.timeCommon.getShape(scaling);
			case 'Allabreve': 
				shape = MusicElements.timeAllabreve.getShape(scaling);
			default: 
				var ids = timeId.split('/');
				var upper = 'time' + ids[0];
				var lower = 'time' + ids[1];
				shape = MusicElements.getSvgString(upper).getShape(scaling);
				y2 -= scaling.scaleY(Constants.HEAD_HEIGHT);
				shapeLower = MusicElements.getSvgString(lower).getShape(scaling);
				shapeLower.x = x3;
				shapeLower.y = y2 + scaling.scaleY(Constants.HEAD_HEIGHT*2);
				target.addChild(shapeLower);
		}
		
		shape.x = x3 ;
		shape.y = y2;		
		target.addChild(shape);
		
	}

	static public function dbarAttributesRight(target:Sprite, scaling:TScaling, x:Float, y:Float, dbar:DBar, rects:Bool = true) {		
		if (!rects) return;
		//var rClef = scaling.scaleRect(dbar.rectClef);
		target.graphics.endFill();
		drawRect(target, scaling, x, y, dbar.attributesRectRight, 1, 0xaaaaaa);
		
		drawRect(target, scaling, x, y, dbar.rectMarginRight, 1, 0x00FF00);
		drawRect(target, scaling, x, y, dbar.rectBarline, 1, 0xFF0000);
		drawRect(target, scaling, x, y, dbar.rectCautionaries, 1, 0x00FF00);
		drawRect(target, scaling, x, y, dbar.rectRightindent, 1, 0x0000FF);
	}
	
	static public function systems(target:Sprite, scaling:TScaling, x:Float, y:Float, dsystems:DSystems, rects:Bool = true) {		
		
		for (system in dsystems.systems) {
			for (dbar in system.dbars) {
				var meas = system.getDbarMeasurments(dbar);
				var dbX 				= scaling.scaleX(meas.x);
				var dbWidth 		= scaling.scaleX(meas.width);
				var x2 = x + dbX;				
				//dbarFull(x2, y-50, dbar, 0, rects);
				dbarFull(target, scaling, x2, y, dbar, dbWidth, rects);
			}
			y += scaling.scaleY(80);
		}		
		
	}
	
	static public function savePng(target:Sprite, filename:String='test.png') 	{
#if (windows || neko)		
		var bitmapData = new BitmapData(Std.int(target.width), Std.int(target.height), false);
		bitmapData.draw(target);		
		cx.FileTools.putBinaryContent(filename, bitmapData.encode('png').asString());
#else
		trace('Cant save sprite to bitmap from this target');
#end
	}

	static public function drawRect(target:Sprite, scaling:TScaling, x:Float, y:Float, rect:Rectangle, lineWidth = 1.0, lineColor = 0xFF0000) {
		if (rect == null) return;
		var graphics = target.graphics;
		
		var r = scaling.scaleRect(rect);
		r.offset(x, y);
		graphics.lineStyle(lineWidth, lineColor);
		graphics.drawRect(r.x, r.y, r.width, r.height);
	}		
	
	static public function dvoiceTies(target:Sprite, scaling:TScaling, x:Float, y:Float, dbar:DBar, dvoice:DVoice) {
		var graphics = target.graphics;
		
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
					var tieX 			= x + scaling.scaleX(leftX);					
					
					
					var tieXHanging = tieX;
					if (dbar.columns.last() != leftColumn) {
						tieXHanging 	+= scaling.scaleX(Constants.TIE_WIDTH);						
					} else {
						tieXHanging 	+= scaling.scaleX(Constants.TIE_WIDTH_LASTHANGING);						
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
						tieXRigthNote 	= x + scaling.scaleX(rightX);
					}
					var tieConnectLength = rightX - leftX;
					
					
					var tieY:Float = 0.0;
					var tieThickness:Float = scaling.scaleY(Constants.TIE_THICKNESS);					
					var tieHeight:Float = 0.0;
					
					//-----------------------------------------------------------------------------------------

					var tieUp:Bool = false; // (leftDNote.direction == EDirectionUD.Up);
					var tieSingle:Bool = (leftDNote.countTies() == 1);
					
					
					switch(dvoice.direction) {
						case EDirectionUAD.Up:
							//trace('VoiceUp = tieUp true');
							tieUp = true;
							if (tieSingle) tieXRigthNote += scaling.scaleX(Constants.HEAD_QUARTERWIDTH + Constants.TIE_SINGLE_XCOMP);
						case EDirectionUAD.Down:
							//trace('VoiceDown = tieUp false');
							tieUp = false;
							if (tieSingle) {
								leftX = leftColumn.sPositionX + leftDNote.rectHeads.x + leftDNote.rectHeads.width - Constants.TIE_SINGLE_XCOMP;
								tieX = x + scaling.scaleX(leftX);										
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
								tieX = x + scaling.scaleX(leftX);		
								tieXRigthNote += scaling.scaleX(Constants.HEAD_QUARTERWIDTH + Constants.TIE_SINGLE_XCOMP);
							}
					}
					
					tieHeight = scaling.scaleY((tieUp) ? -Constants.TIE_HEIGHT : Constants.TIE_HEIGHT);
					
					if (tieSingle) {
						tieY = scaling.scaleY((tieUp) ? -Constants.TIE_SINGLE_YMOVE : Constants.TIE_SINGLE_YMOVE);
					} else {
						tieY = scaling.scaleY((tieUp) ? -Constants.TIE_MULTI_YMOVE : Constants.TIE_MULTI_YMOVE);
					}
					
					//-----------------------------------------------------------------------------------------

					var ty:Float = tieY;
					//gr.lineStyle(4, 0xFF0000);
					for (tieLevel in tieLevels) {
						ty = tieY + y +  scaling.scaleY(tieLevel * Constants.HEAD_HALFHEIGHT);
						if (tieConnectLevels.has(tieLevel)) {
							
							if (tieConnectLength < Constants.TIE_SHORT) {
								tieHeight = scaling.scaleY((tieUp) ? -Constants.TIE_SHORT_HEIGHT : Constants.TIE_SHORT_HEIGHT);
							}
							//trace(tieConnectLength, tieHeight);
							
							// connect to next note
							tie(graphics, scaling, tieX, ty, tieXRigthNote-tieX, tieHeight, Constants.TIE_DELTA, tieThickness);
						} else {
							// hanging from this note
							tie(graphics, scaling, tieX, ty, tieXHanging-tieX, tieHeight, Constants.TIE_DELTA, tieThickness);
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
	
	static public function cubicCurveTo(graphics:Graphics, scaling:TScaling, anchorX1 : Float, anchorY1 : Float, controlX1 : Float, controlY1 : Float, controlX2 : Float, controlY2 : Float, anchorX2 : Float, anchorY2 : Float) {
		function _scaleCoords(coords:Vector<Float>) {				
			var i = 0;
			do {
				coords[i] 		= scaling.scaleX(coords[i]);
				coords[i + 1] 	= scaling.scaleY(coords[i + 1]);
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
		graphicsDrawPath(graphics, scaling, cmds, coords);

	}	
	
	static public function tie(graphics:Graphics, scaling:TScaling, x:Float, y:Float, width:Float, height:Float, delta:Float=8.0, thickness:Float=4.0) {
		var x2 = x + width;
		var deltaX = width / delta;
		//trace('deltaX: ' + deltaX);
		var cx1:Float = x + deltaX;
		var cx2:Float = x2 - deltaX;
		var halfThickness = thickness / 2;			
		graphics.moveTo(x, y);
		graphics.beginFill(0x000000);
		graphics.lineStyle(0); // , 0x000000, 0);
		cubicCurveTo(graphics, scaling, x, y-0, cx1, y + height - halfThickness, cx2, y + height - halfThickness, x2, y-0);
		cubicCurveTo(graphics, scaling, x2, y+0, cx2, y + height + halfThickness, cx1, y + height + halfThickness, x, y+0);
		graphics.endFill();
	}	
	// Js drawPath
	static public function graphicsDrawPath(graphics:Graphics, scaling:TScaling, cmds:Vector<Int>, coords:Vector<Float>) {
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
	
	static public function dnote(target:Sprite, scaling:TScaling, x:Float, y:Float, dnote:DNote, rects:Bool=false, collisionShiftX:Float=0, dvoice:DVoice=null) {
		var graphics = target.graphics;
		
		var positions = dnote.headPositions.copy();
		
		switch (dnote.notetype) {
			
			case ENoteType.Tpl, ENoteType.TplChain: 
				_drawTpl(target, scaling, x, y, dnote);			
			case ENoteType.Lyric:
				_drawLyric(target, scaling, x, y, dnote);
			case ENoteType.Pause:
				_drawPause(target, scaling, x, y, dnote);
			
			case ENoteType.Normal:
				
				for (dhead in dnote.dheads) {
					var position = positions.shift();
					var xshift = scaling.scaleX(collisionShiftX);
					_drawHead(target, scaling, x + xshift, y, dhead.level, position, dnote.notevalue.headType);					
					
					if (dnote.notevalue.dotLevel > 0) {
						
						//var tieUp:Bool = false; // (leftDNote.direction == EDirectionUD.Up);
						var dotLevel = 0;
						
						if (dhead.level < 0) {
							dotLevel = dhead.level  + ((dhead.level-1) % 2);
						} else {
							dotLevel = dhead.level-1 + (dhead.level % 2) ;
						}
						
						_drawHeadDot(target, scaling, x, y, dotLevel, position, dnote);
					}					
					
				}
				
				_drawLegers(target, scaling, x, y, dnote);
				
			default:
		}
		
		//dnoteDots(target, scaling, x, y, dnote, rects);
		
		
		if (rects) {
			//drawRect(x, y, dnote.rectHeads, 3, 0x0000FF);
			
			drawRect(target, scaling, x, y, dnote.rectStave, 1, 0xFF0000);
			if (dnote.rectDots != null)   drawRect(target, scaling, x, y, dnote.rectDots, 3, 0x00FF00);
			if (dnote.rectTiesfrom != null)  drawRect(target, scaling, x, y, dnote.rectTiesfrom, 3, 0xFF0000);
		}
	}
	
	static public function _drawTpl(target:Sprite, scaling:TScaling, x:Float, y:Float, dnote:DNote) {
		var graphics = target.graphics;
		
		var level = dnote.levelTop;
		var tpl = 'tpl' + (7-((level + 48) % 7));
		var octave = Std.int(level / 7);
		
		//trace(tpl);
		
		var tplX = x + scaling.svgX + scaling.scaleX(Constants.TPL_X);  
		var tplY = y + scaling.svgY + scaling.scaleY(Constants.TPL_Y);
		
		// Chain?
		if (dnote.notetype == ENoteType.TplChain) 
			tplY += scaling.scaleY(level * Constants.TPLCHAIN_Y_SHIFT);		
		
		
		// circle
#if js
		var cx = tplX + scaling.scaleX(Constants.TPL_CIRCLE_X);
		var cy = tplY + scaling.scaleY(Constants.TPL_CIRCLE_Y);
		var radius = scaling.scaleX(Constants.TPL_CIRCLE_RADIUS);
		var linethickness = scaling.scaleX(Constants.TPL_CIRCLE_THICKNESS);
		graphics.lineStyle(linethickness, 0x000000);
		graphics.endFill();
		//gr.beginFill(0xFFFFFF);
		graphics.drawCircle(cx, cy, radius);
		graphics.endFill();
#else
		var shape:Shape = MusicElements.tplCircle.getShape(scaling);				
		shape.x = tplX;
		shape.y = tplY;		
		target.addChild(shape);
#end
		// number
		var shape = MusicElements.getSvgString(tpl).getShape(scaling);
		shape.x = tplX;
		shape.y = tplY;		
		target.addChild(shape);
		
		// arrow
		switch (dnote.note.heads.first().sign) {
			case ESign.Sharp:
				var shape = MusicElements.tplArrowUp.getShape(scaling);		
				shape.x = tplX;
				shape.y = tplY;		
				target.addChild(shape);
			case ESign.Flat:
				var shape = MusicElements.tplArrowDown.getShape(scaling);		
				shape.x = tplX;
				shape.y = tplY;		
				target.addChild(shape);
			default:	
		}		
		
	}
	
	static public function _drawLyric(target:Sprite, scaling:TScaling, x:Float, y:Float, dnote:DNote) {
		var graphics = target.graphics;
		
		var text:String = dnote.note.text;
		if (text.endsWith('-')) text.replace('-', '');
		if (text.endsWith('_')) text.replace('-', '');
		
		if (textOutput == null) {
			textOutput = new Text(scaling);
		}
		
		var bmp = textOutput.getStringBitmap(text);
		
		/*
		var bmpWidth = scaling.descaleX(bmp.width);
		trace(' - - - ');
		trace(dnote.rectText.x);
		trace(dnote.rectText.width);
		trace(bmpWidth);
		*/
		
		var bmpX = dnote.rectText.x;
		
		bmp.x = x + scaling.scaleX(bmpX) - scaling.scaleX(Constants.TEXT_XADJUST);
		bmp.y = y + scaling.scaleY(dnote.rectText.y)- scaling.scaleX(Constants.TEXT_YADJUST);
		//trace([text, bmp.width]);
		target.addChild(bmp);
	}
	
	static public function _drawLegers(target:Sprite, scaling:TScaling, x:Float, y:Float, dnote:DNote) {
		var graphics = target.graphics;
		
		var x1 = x + scaling.scaleX(dnote.rectHeads.x - Constants.HEAD_LEGER_LEFT) ;
		var x2 = x1 + scaling.scaleX(dnote.rectHeads.width + Constants.HEAD_LEGER_RIGHT);
		if (dnote.notevalue.stavingLevel == 0) x2 += scaling.scaleX(Constants.HEAD_LEGER_RIGHT_WHOLE);
		
		
		graphics.lineStyle(scaling.linesWidth);
		if (dnote.levelTop <= -6) {
			for (level in 5...-dnote.levelTop+1) {
				if (level % 2 == 1) continue;
				var y1 = y + scaling.scaleY(-level);
				graphics.moveTo(x1, y1);
				graphics.lineTo(x2, y1);	
				//trace(x1, y1, x2);
			}
			
		}
		
		if (dnote.levelBottom >= 6) {
			for (level in 5...dnote.levelBottom+1) {
				if (level % 2 == 1) continue;
				var y1 = y + scaling.scaleY(level);
				graphics.moveTo(x1, y1);
				graphics.lineTo(x2, y1);	
			}
		}
	}
	
	static public function _drawHeadDot(target:Sprite, scaling:TScaling, x:Float, y:Float, level:Int, position:Int, dnote:DNote) {
		var graphics = target.graphics;
		
		//trace([level, dlevel]);
		
		var x2 = x + scaling.scaleX(dnote.rectDots.x + Constants.HEAD_QUARTERWIDTH);
		var y2 = y + scaling.scaleY(level);
		
		graphics.beginFill(0x000000);	
		graphics.lineStyle(0);
		var radius = scaling.scaleX(Constants.HEAD_DOTRADIUS);
		graphics.drawCircle(x2, y2, radius);
		graphics.endFill();
		
	}
	
	static public function dnoteStave(target:Sprite, scaling:TScaling, x:Float, y:Float, dnote:DNote, rects:Bool) {		
		if (dnote.rectStave == null) return;

		var graphics = target.graphics;
		//if (dnote.type != ENoteType.Normal) return;		
		
		var r = scaling.scaleRect(dnote.rectStave);
		r.offset(x, y);

		
		graphics.lineStyle(scaling.linesWidth, 0x000000);
		graphics.moveTo(r.x, r.y);
		graphics.lineTo(r.x, r.y + r.height);

	}

	static public function _drawHead(target:Sprite, scaling:TScaling, x:Float, y:Float, level:Int, position:Int, headType:EHeadType) {
		
		var headY = y + (level * scaling.halfSpace);
		var headX = x + position * scaling.scaleX(Constants.HEAD_WIDTH);
		
		var shape:Shape; // = SvgAssets.getShape(MusicElements.noteBlack", scaling);			
		switch(headType) {
			case EHeadType.Whole:
				shape = MusicElements.noteWhole.getShape(scaling);
			case EHeadType.White:
				shape = MusicElements.noteWhite.getShape(scaling);
			default:
				shape = MusicElements.noteBlack.getShape(scaling);
		}
		
		shape.x = headX + scaling.svgX;  
		shape.y = headY + scaling.svgY;
		target.addChild(shape);	  	
	}		
	
	static public function _drawPause(target:Sprite, scaling:TScaling, x:Float, y:Float, dnote:DNote) {
		var graphics = target.graphics;
		
		var shape:Shape = null; // SvgAssets.getShape(MusicElements.pauseNv16", scaling);		
		//trace(dnote.notevalue);
		
		var level = dnote.dheads[0].level;
		
		switch (dnote.notevalue) {
			case ENoteValue.Nv16 , ENoteValue.Nv16dot, ENoteValue.Nv16tri:
				shape = MusicElements.pauseNv16.getShape(scaling);			
			case ENoteValue.Nv8 , ENoteValue.Nv8dot, ENoteValue.Nv8tri:
				shape = MusicElements.pauseNv8.getShape(scaling);
			case ENoteValue.Nv4, ENoteValue.Nv4dot, ENoteValue.Nv4ddot, ENoteValue.Nv4tri:
				shape = MusicElements.pauseNv4.getShape(scaling);
				
			case ENoteValue.Nv2, ENoteValue.Nv2dot, ENoteValue.Nv2tri:
				var ry = level - 1 - (level % 2);
				var r = scaling.scaleRect( new Rectangle(-Constants.HEAD_HALFWIDTH, ry, Constants.HEAD_WIDTH * 0.9, Constants.HEAD_HALFHEIGHT));
				r.offset(x, y);
				graphics.beginFill(0x000000);
				graphics.drawRect(r.x, r.y, r.width, r.height);
				graphics.endFill();
			case ENoteValue.Nv1, ENoteValue.Nv1dot, ENoteValue.Nv1tri:
				var ry = level - 2 - (level % 2);
				var r = scaling.scaleRect( new Rectangle(-Constants.HEAD_HALFWIDTH, ry, Constants.HEAD_WIDTH , Constants.HEAD_HALFHEIGHT));
				r.offset(x, y);
				graphics.beginFill(0x000000);
				graphics.drawRect(r.x, r.y, r.width, r.height);
				graphics.endFill();				
			default: 
				shape = MusicElements.noteBlack.getShape(scaling);		
		}
		
		if (shape != null) {
			var headY = y + (level * scaling.halfSpace);
			var headX = x;		
			shape.x = headX + scaling.svgX;  
			shape.y = headY + scaling.svgY;
			target.addChild(shape);	 				
		}
		
		
	}	
	
	static public function _drawFlag(target:Sprite, scaling:TScaling, x:Float, y:Float, frame:BeamGroupFrame) {
		//var graphics = target.graphics;
		
		if (frame.firstNotevalue.beamingLevel < 1) return;
		
		//trace('draw flag!');
		
		var shape:Shape = new nme.display.Shape(); // = SvgAssets.getShape(MusicElements.flaggor", scaling);
		
		
		if (frame.firstNotevalue.beamingLevel == 1) {
			if (frame.direction == EDirectionUD.Up) {				
				shape = MusicElements.flagUp8.getShape(scaling);				
			} else {
				shape = MusicElements.flagDown8.getShape( scaling);				
			}
		} else if (frame.firstNotevalue.beamingLevel == 2) {
				if (frame.direction == EDirectionUD.Up) {				
				shape = MusicElements.flagUp16.getShape(scaling);				
			} else {
				shape = MusicElements.flagDown16.getShape(scaling);				
			}		
		}
		
		
		//var shape = SvgAssets.getShape(MusicElements.flagUp8', scaling);
		

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
	
	static public function complex(target:Sprite, scaling:TScaling, x:Float, y:Float, dplex:Complex, rects:Bool=true, moveX:Float=0, teststaves:Bool=true) {		
		var gr = target.graphics;
		
	
		if (moveX != 0) x += scaling.scaleX(moveX); // Scaling.scaleX(moveX, scaling);
		
		if (rects) {
			gr.lineStyle(1, 0xaaaaaa);
			gr.moveTo(x, y + -60);
			gr.lineTo(x, y + 60);
		}
		
		for (i in 0...dplex.dnotes.length) {			
			dnote(target, scaling, x, y, dplex.dnote(i), rects, dplex.dnoteXshift(i));	
		}		
		
		signs(target, scaling, dplex, x, y);

		if (rects) {			
			gr.lineStyle(1, 0xFF0000);
			var r = scaling.scaleRect(dplex.rectHeads); // Scaling.scaleRectangle(dplex.rectHeads, scaling);
			
			r.offset(x, y);
			r.inflate(2, 2);		
			
			gr.drawRect(r.x, r.y, r.width, r.height);
			
			if (dplex.rectSigns != null) {
				gr.lineStyle(1, 0x00FF00);		
				var r = scaling.scaleRect(dplex.rectSigns);
				r.offset(x, y);
				gr.drawRect(r.x, r.y, r.width, r.height);
			}
			
			gr.lineStyle(1, 0x0000FF);
			var r = scaling.scaleRect(dplex.rectFull);
			r.offset(x, y);
			r.inflate(2, 2);
			gr.drawRect(r.x, r.y, r.width, r.height);
		}		
	}
	
	static public function dpart(target, scaling, x:Float, y:Float, dpart:DPart, rects:Bool = true) {				
		var xpos = 0.0;
		for (dplex in dpart.complexes) {
			var dist = dpart.complexDistance.get(dplex);
			xpos += dist;			
			complex(target, scaling, x, y, dplex, rects, xpos);	
		}		
	}	
	
	static public function signs(target:Sprite, scaling:TScaling, dplex:Complex, x:Float, y:Float) {
		var gr = target.graphics;
		var posSpace = scaling.signPosWidth;
		
		
		if (dplex.rectSigns == null) return;
		
		var signs = dplex.signs;
		var xShift = scaling.scaleX(dplex.rectSigns.x);
		
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
				case ESign.Sharp: shape = MusicElements.signSharp.getShape(scaling);
				case ESign.Flat: shape = MusicElements.signFlat.getShape(scaling);
				default: shape = MusicElements.signNatural.getShape(scaling);
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
	
	static public function xsigns(target:Sprite, scaling:TScaling, signs:TSigns, x:Float, y:Float) {
		var gr = target.graphics;
		var posSpace = scaling.signPosWidth;

		var maxPos = 0;
		for (sign in signs) {
			//trace(sign.position);
			maxPos = Std.int(Math.max(maxPos, sign.position));
		}
		//trace(maxPos);
		var xOffset = (maxPos * scaling.signPosWidth) + scaling.halfNoteWidth;


		function __drawSign(x:Float, y:Float, level:Int, position:Int, sign:nx.enums.ESign) {	
			//trace('drawSign x:' + x);
			var shape:Shape;	
			switch(sign) {
				case ESign.Sharp: shape = MusicElements.signSharp.getShape(scaling);
				case ESign.Flat: shape = MusicElements.signFlat.getShape(scaling);
				default: shape = MusicElements.signNatural.getShape(scaling);
			}
			y = y + (scaling.halfSpace * level);
			x = x - (position * scaling.signPosWidth) + xOffset;
			shape.x = x + scaling.svgX;
			shape.y = y + scaling.svgY;

			target.addChild(shape);	
		}

		for (sign in signs) {
			__drawSign(x, y, sign.level, sign.position, sign.sign);	
		}
	}		
	
	static public function beamGroup(target:Sprite, scaling:TScaling, xpos:Float, y:Float, frame:BeamGroupFrame, dnotePositionsX:Array<Float>) {
		var gr = target.graphics;
		
		
		function _dStave(sX:Float, sTopY:Float, sBottomY:Float) {
			gr.moveTo(sX , sTopY);
			gr.lineTo(sX , sBottomY);			
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
		
		var adjustX = 0; // scaling.halfNoteWidth; // frame.adjustX * scaling.halfNoteWidth;
		var firstTopY = y + (xfirstStave.topY * scaling.halfSpace);
		var lastTopY = y + (xlastStave.topY * scaling.halfSpace); 
		var firstBottomY = y + (xfirstStave.bottomY  * scaling.halfSpace);
		var lastBottomY = y + (xlastStave.bottomY * scaling.halfSpace);
		
		
		var beamHeight = scaling.scaleY(Constants.BEAM_HEIGHT);
		
		switch (frame.firstType) {
			
			case ENoteType.Normal: 
				
				gr.lineStyle(scaling.linesWidth, 0x000000);
				
				if (frame.direction == EDirectionUD.Up) {			
					
					beamH = lastTopY - firstTopY;
					
					// Staves
					//gr.moveTo(firstX , firstTopY);
					//gr.lineTo(firstX , firstBottomY);
					_dStave(firstX, firstTopY, firstBottomY);
					
					if (count > 1) {
						//gr.moveTo(lastX , lastTopY);				
						//gr.lineTo(lastX , lastBottomY);							
						_dStave(lastX, lastTopY, lastBottomY);
					}

					if (count > 2) {
						var idx = 1;
						for (innerStave in xinnerStaves) {
							var staveX = (xpos + dnotePositionsX[idx]);
							var slopeDelta = (staveX - firstX) / beamW;
							var innerTopY = firstTopY + beamH * slopeDelta;
							var innerBottomY = y + scaling.scaleY(innerStave.bottomY);
							gr.moveTo(staveX, innerBottomY);
							gr.lineTo(staveX, innerTopY);			
							idx++;
						}							
					}
					
					// Beam/flag
					
					if ((count > 1) && (frame.firstNotevalue.beamingLevel > 0)) {
						// 8th beam
						
							gr.beginFill(0x000000);
							gr.moveTo(firstX		, firstTopY);
							gr.lineTo(lastX 	, lastTopY);
							gr.lineTo(lastX 	, lastTopY + beamHeight);
							gr.lineTo(firstX 		, firstTopY + beamHeight);
							gr.lineTo(firstX 		, firstTopY);
							gr.endFill();	
							
							
							
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
										x2 = prevStaveX + scaling.scaleX(Constants.BEAM_SUBWIDTH);
									case ESubBeam.ShortRight:										
										x1 = staveX - scaling.scaleX(Constants.BEAM_SUBWIDTH);
									default:
										
								}
								
								var yshift = scaling.scaleY(Constants.BEAM_SUBDISTANCE);
								
								var subW:Float = x2 - x1;								
								var subH = beamH * (subW / beamW);
								var y1 = firstTopY + ((x1-firstX) / beamW) * beamH + yshift;
								var y2 = firstTopY + ((x2-firstX) / beamW) * beamH + yshift;
								
								
								if (stave.flag16 != ESubBeam.None) {
									gr.beginFill(0x000000);
									gr.moveTo(x1		, y1);
									gr.lineTo(x2 		, y2);
									gr.lineTo(x2 		, y2 + beamHeight);
									gr.lineTo(x1 		, y1 + beamHeight);
									gr.lineTo(x1 		, y1);
									gr.endFill();									
								}
								
								
								prevStave = stave;
								prevStaveX = staveX;
								idx++;
							}
						
						
					} else {
						_drawFlag(target, scaling, firstX, y, frame);
					}
				} else {
					
					beamH = lastBottomY - firstBottomY;
					
					gr.moveTo(firstX , firstBottomY);
					gr.lineTo(firstX , firstTopY);			
					if (count > 1) {
						gr.moveTo(lastX , lastBottomY);				
						gr.lineTo(lastX , lastTopY);				
					}
					if (count > 2) {
						var idx = 1;
						for (innerStave in xinnerStaves) {
							var staveX = xpos + dnotePositionsX[idx];
							var slopeDelta = (staveX - firstX) / beamW;
							var innerBottomY = firstBottomY + beamH * slopeDelta;
							var innerTopY = y + scaling.scaleY(innerStave.topY);
							gr.moveTo(staveX, innerBottomY);
							gr.lineTo(staveX, innerTopY);			
							idx++;
						}
					}	
					
					
					if ((count > 1) && (frame.firstNotevalue.beamingLevel > 0)) {
					
					
						gr.beginFill(0x000000);
						gr.moveTo(firstX 		, firstBottomY);
						gr.lineTo(lastX 	, lastBottomY);
						gr.lineTo(lastX 	, lastBottomY - beamHeight);
						gr.lineTo(firstX		, firstBottomY - beamHeight);
						gr.lineTo(firstX 		, firstBottomY);
						gr.endFill();		
						
						
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
										x2 = prevStaveX + scaling.scaleX(Constants.BEAM_SUBWIDTH);
									case ESubBeam.ShortRight:										
										x1 = staveX - scaling.scaleX(Constants.BEAM_SUBWIDTH);
									default:
										
								}
								
								var yshift = scaling.scaleY(Constants.BEAM_SUBDISTANCE);
								
								var subW:Float = x2 - x1;								
								var subH = beamH * (subW / beamW);
								var y1 = firstBottomY + ((x1-firstX) / beamW) * beamH - yshift;
								var y2 = firstBottomY + ((x2-firstX) / beamW) * beamH - yshift;
								
								if (stave.flag16 != ESubBeam.None) {
									gr.beginFill(0x000000);
									gr.moveTo(x1		, y1);
									gr.lineTo(x2 		, y2);
									gr.lineTo(x2 		, y2 - beamHeight);
									gr.lineTo(x1 		, y1 - beamHeight);
									gr.lineTo(x1 		, y1);
									gr.endFill();									
								}
								
								
								prevStave = stave;
								prevStaveX = staveX;
								idx++;
							}
						
						
						
						
					} else {
						_drawFlag(target, scaling, firstX, y, frame);
					}
				}
				
			default:
			
		}
		
		
		
		
	}
		
	
	
}