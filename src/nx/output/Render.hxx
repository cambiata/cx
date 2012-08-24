package nx.output;
import cx.ArrayTools;
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
import nx.svg.SvgAssets;
import nx.output.Scaling;
import nx.display.beam.BeamGroupFrame;
import nx.enums.ETime;
import nx.enums.ETime.ETimeUtils;

/**
 * ...
 * @author Jonas Nyström
 */
using nx.output.Scaling;
using cx.ArrayTools;
using nx.display.DBar;
using Lambda;

class Render extends RenderBase, implements IRender
{
	static public var drawRects:Bool = false;

	
	public function new(target:Sprite, scaling:TScaling) {
		super(target, scaling);
		/*
		this.target = target;
		this.gr = target.graphics;
		this.scaling = scaling;
		*/
	}

	
	public function getScaling():TScaling {
		return this.scaling;
	}	
	
	
	public function lines(x:Float, y:Float, width:Float, dbar:DBar=null, dpart:DPart=null) {
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
			target.graphics.moveTo(x2, y - yPos);
			target.graphics.lineTo(x2 + width, y - yPos);
		}		
		
	}
	
	public function clefG(x:Float, y:Float) {
	var shape = nx.svg.SvgAssets.getSvgShape('clefG', scaling);
	shape.x = x + scaling.svgX + scaling.space;  
	shape.y = y + scaling.svgY + scaling.space;
	target.addChild(shape);	  	
	}	
	public function clefC(x:Float, y:Float) {
	var shape = nx.svg.SvgAssets.getSvgShape('clefC', scaling);
	shape.x = x + scaling.svgX + scaling.space;  
	shape.y = y + scaling.svgY + scaling.space;
	target.addChild(shape);	  	
	}
	public function clefF(x:Float, y:Float) {
		var shape = nx.svg.SvgAssets.getSvgShape('clefF', scaling);
		shape.x = x + scaling.svgX + scaling.space;  
		shape.y = y + scaling.svgY + scaling.space;
		target.addChild(shape);	  	
	}
	
	//-----------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------
	
	public function dbar(x:Float, y:Float, dbar:DBar, stretchToWidth:Float=0, rects:Bool = true) {
		this.gr.endFill();
		
		// Stretch		
		var currentWidth = this.scaling.scaleX(dbar.columnsRectAlloted.width);
		dbar.stretchContentTo( this.scaling.descaleX(stretchToWidth));		
		
		// STRETCHED WIDTH:
		// trace(this.scaling.scaleX(dbar.columnsRectStretched.width));		
		
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
			//x2 = x + Scaling.scaleX(column.sPositionX, this.scaling);
			x2 = x + this.scaling.scaleX(column.sPositionX);
			for (partComplex in column.complexes) {
				if (partComplex != null) {					
					y2 = y + scaling.scaleY(dbar.dpartTop.get(partComplex.dpart));					
					this.complex(x2, y2, partComplex, rects, 0, false);
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
								//var posX = Scaling.scaleX(column.sPositionX + rectStaveX + adjustX, this.scaling);
								var posX = this.scaling.scaleX(column.sPositionX + rectStaveX + adjustX);
								
								dnotesPositionsX.push(posX);
							}
							this.beamGroup(x, y2, frame, dnotesPositionsX);
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
				drawRect(x, y2, heightRect, 1, 0x00FF00);						
			}
		}
		
		
		
		// Draw voice stuff...
		
		for (dpart in dbar.dparts) {
			y2 = y + scaling.scaleY(dbar.dpartTop.get(dpart));			
			for (dvoice in dpart.dvoices) {
				this.dvoiceBarpause(x, y2, dbar, dvoice);
				this.dvoiceTies(x, y2, dbar, dvoice);
				
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
			var r = this.scaling.scaleRect(dbar.columnsRectStretched);
			r.y = -20;
			r.height = 20;
			
			r.offset(x, y);
			this.gr.lineStyle(1, 0x00FF00);
			this.gr.drawRect(r.x, r.y, r.width, r.height);			
		}
	}
	
	private function dvoiceBarpause(x:Float, y2:Float, dbar:DBar, dvoice:DVoice) {
		if (dvoice.voice.type != EVoiceType.Barpause) return;

		var level = dvoice.voice.notes.first().heads.first().level;
		var ry = level - 2 - (level % 2);
		var r = this.scaling.scaleRect( new Rectangle(-Constants.HEAD_HALFWIDTH, ry, Constants.HEAD_WIDTH , Constants.HEAD_HALFHEIGHT));

		var width = this.scaling.scaleX(dbar.columnsRectStretched.width) ;
		var x2 = x + this.scaling.scaleX(dbar.columnsRectStretched.x);
		var x3 = x2 + ((width - r.width) / 2);
		
		r.offset(x3, y2);
		this.gr.lineStyle(1, 0x00000);		
		this.gr.beginFill(0x000000);
		this.gr.drawRect(r.x, r.y, r.width, r.height);
		this.gr.endFill();				
	}
	

	

	
	//-----------------------------------------------------------------------------------------------------
	

	
	public function dbarFull(x:Float, y:Float, dbar:DBar, stretchToWidth:Float=0,  rects:Bool = true ) {
		
		var barMeas = dbar.getTotalWidthAlloted();
		
		var scaledAttrLeftWidth = this.scaling.scaleX(barMeas.attribLeftWidth);
		var scaledAttrRightWidth	= this.scaling.scaleX(barMeas.attribRightWidth);
		var contentUnstretchedWidth = this.scaling.scaleX(barMeas.columnsWidth);
		
		var minWidth = scaledAttrLeftWidth + contentUnstretchedWidth + scaledAttrRightWidth;
		stretchToWidth = Math.max(minWidth, stretchToWidth);
		
		var stretchToWidth2 = stretchToWidth - (scaledAttrLeftWidth + scaledAttrRightWidth);
		//dbar.stretchContentTo(this.scaling.descaleX(stretchToWidth2));
		//trace(stretchToWidth2);
		
		var attrLeftX = x;
		var attrLeftWidth = this.scaling.scaleX(barMeas.attribLeftWidth);
		//var y2 = y;
		
		
		var y2:Float = 0.0;
		for (dpart in dbar.dparts) {			
			y2 = y + scaling.scaleY(dbar.dpartTop.get(dpart));			
			
			dbarAttributesLeft(x, y2, dbar, dpart, rects);									
			attributeClef(x, y2, dbar, dpart, rects);
			attributeKey(x, y2, dbar, dpart, rects);
			attributeTime(x, y2, dbar, dpart, rects);
			//y2 += 180;
		}
		
		var columnsX = x + attrLeftWidth;		
		var columnsXAdjust = this.scaling.scaleX(-dbar.columnsRectStretched.x);
		this.dbar(columnsX+columnsXAdjust, y, dbar, stretchToWidth2, rects);
		
		//trace(dbar.columnsRectAlloted.width);
		//trace(dbar.columnsRectStretched.width);
		
		var columnsWidth = this.scaling.scaleX(dbar.columnsRectStretched.width);

		var attrRightX = columnsX + columnsWidth;
		var attrRightWidth =  this.scaling.scaleX(barMeas.attribRightWidth);
		
		
		var x2 = attrRightX + attrRightWidth - x;
		
		for (dpart in dbar.dparts) {			
			y2 = Std.int(y + scaling.scaleY(dbar.dpartTop.get(dpart)));									
			
			barline(attrRightX, y2, dbar, dpart, rects);
			
			dbarAttributesRight(attrRightX, y2, dbar, rects);                        
			lines(x, y2, x2, dbar, dpart);
		}
	}
	
	private function barline(x:Float, y:Float, dbar:DBar, dpart:DPart, rects:Bool) {
		
		if (dpart.dType != EPartType.Normal) return;
		
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
	

	public function dbarAttributesLeft(x:Float, y:Float, dbar:DBar, dpart:DPart, rects:Bool = true) {
		//var rClef = this.scaling.scaleRect(dbar.rectClef);
		if (!rects) return;
		this.gr.endFill();
		this.drawRect(x, y, dbar.attributesRectLeft, 1, 0xaaaaaa);

		this.drawRect(x, y, dbar.rectLeftindent, 1, 0x0000FF);
		this.drawRect(x, y, dbar.rectLabels, 1, 0x00FF00);
		this.drawRect(x, y, dbar.rectAckolade, 1, 0x0000FF);
		this.drawRect(x, y, dbar.rectAckolademargin, 1, 0x0000FF);
		this.drawRect(x, y, dbar.rectClef, 1, 0x00FF00);
		//attributeClef(x, y, dbar, rects);
		this.drawRect(x, y, dbar.rectKey, 1, 0xFF0000);
		this.drawRect(x, y, dbar.rectTime, 1, 0x0000FF);
		this.drawRect(x, y, dbar.rectBarlineleft, 1, 0x00FF00);
		this.drawRect(x, y, dbar.rectMarginLeft, 1, 0xFF0000);
	}
	
	public function attributeClef(x:Float, y:Float, dbar:DBar, dpart:DPart, rects:Bool = true) {
		if (dpart.dType != EPartType.Normal) return;
		if (dpart.dClef == null) return;
		//trace(dbar.rectClef);
		var x2 = x + this.scaling.scaleX(dbar.rectClef.x);
		
		var shape:Shape = null;
		switch(dpart.dClef) {
			case EClef.ClefG:
				shape = SvgAssets.getSvgShape('clefG', this.scaling);
			case EClef.ClefC:
				shape = SvgAssets.getSvgShape('clefC', this.scaling);
			case EClef.ClefF:
				shape = SvgAssets.getSvgShape('clefF', this.scaling);
		}
		
		shape.x = x2 + scaling.svgX + this.scaling.scaleX(Constants.HEAD_HALFWIDTH);
		shape.y = y + scaling.svgY + this.scaling.scaleY(Constants.HEAD_HEIGHT);
		target.addChild(shape);
	}
	
	public function attributeKey(x:Float, y:Float, dbar:DBar, dpart:DPart, rects:Bool = true) {
		if (dpart.dType != EPartType.Normal) return;
		if (dpart.dKey == null) return;
		if (dpart.dKey.levelShift == 0) return;
		
		var x2 = x + this.scaling.scaleX(dbar.rectKey.x);
		
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
				shape = SvgAssets.getSvgShape('signSharp', this.scaling);
			} else {
				shape = SvgAssets.getSvgShape('signFlat', this.scaling);
			}				
			
			var x3 = x2 + scaling.svgX + (i * this.scaling.scaleX(Constants.SIGN_WIDTH)) + this.scaling.scaleX(Constants.HEAD_HALFWIDTH);
			var y2 = y + scaling.svgY + this.scaling.scaleY(EKey.getSignLevel(keyValue, i, dpart.dClef));
			shape.x = x3;
			shape.y = y2;
			target.addChild(shape);
		}
	}

	public function attributeTime(x:Float, y:Float, dbar:DBar, dpart:DPart, rects:Bool = true) {
		if (dpart.dType != EPartType.Normal) return;
		if (dbar.dTime == null) return;
		
		var x2 = x + this.scaling.scaleX(dbar.rectTime.x);
		
		var shape:Shape = null;
		var shapeLower:Shape = null;
		
		var x3 = x2 + scaling.svgX + scaling.scaleX(Constants.HEAD_HALFWIDTH);
		var y2 = y + scaling.svgY;
		
		var timeId = ETimeUtils.toString(dbar.dTime);
		switch (timeId) {
			case 'Common': 
				shape = SvgAssets.getSvgShape('timeCommon', this.scaling);
			case 'Allabreve': 
				shape = SvgAssets.getSvgShape('timeAllabreve', this.scaling);
			default: 
				var ids = timeId.split('/');
				var upper = 'time' + ids[0];
				var lower = 'time' + ids[1];
				shape = SvgAssets.getSvgShape(upper, this.scaling);
				y2 -= scaling.scaleY(Constants.HEAD_HEIGHT);
				
				shapeLower = SvgAssets.getSvgShape(lower, this.scaling);
				shapeLower.x = x3;
				shapeLower.y = y2 + scaling.scaleY(Constants.HEAD_HEIGHT*2);
				target.addChild(shapeLower);
		}
		
		shape.x = x3 ;
		shape.y = y2;		
		target.addChild(shape);
	}

	public function dbarAttributesRight(x:Float, y:Float, dbar:DBar, rects:Bool = true) {		
		if (!rects) return;
		//var rClef = this.scaling.scaleRect(dbar.rectClef);
		this.gr.endFill();
		this.drawRect(x, y, dbar.attributesRectRight, 1, 0xaaaaaa);
		
		this.drawRect(x, y, dbar.rectMarginRight, 1, 0x00FF00);
		this.drawRect(x, y, dbar.rectBarline, 1, 0xFF0000);
		this.drawRect(x, y, dbar.rectCautionaries, 1, 0x00FF00);
		this.drawRect(x, y, dbar.rectRightindent, 1, 0x0000FF);
	}
	
	//-----------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------
	
	public function systems(x:Float, y:Float, dsystems:DSystems, rects:Bool = true) {		
		
		for (system in dsystems.systems) {
			for (dbar in system.dbars) {
				var meas = system.getDbarMeasurments(dbar);
				var dbX 				= this.scaling.scaleX(meas.x);
				var dbWidth 		= this.scaling.scaleX(meas.width);
				var x2 = x + dbX;				
				//this.dbarFull(x2, y-50, dbar, 0, rects);
				this.dbarFull(x2, y, dbar, dbWidth, rects);
			}
			y += scaling.scaleY(80);
		}		
		
	}
	
	public function savePng(filename:String='test.png') 
	{
#if (windows || neko)		
		var bitmapData = new BitmapData(Std.int(this.target.width), Std.int(this.target.height), false);
		bitmapData.draw(this.target);		
		cx.FileTools.putBinaryContent(filename, bitmapData.encode('png').asString());
#else
		trace('Cant save sprite to bitmap from this target');
#end
	}

		
	
}