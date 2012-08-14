package nx.output;
import cx.ArrayTools;
import nme.display.GradientType;
import nme.display.Graphics;
import nme.display.Shape;
import nme.display.Sprite;
import nme.geom.Rectangle;
import nme.Vector;
import nx.Constants;
import nx.core.display.DBar;
import nx.core.display.DNote;
import nx.core.display.DPart;
import nx.core.display.Complex;
import nx.core.display.DVoice;
import nx.display.beam.BeamTools;
import nx.display.beam.IBeamGroup;
import nx.display.DisplayNote;
import nx.enums.EClef;
import nx.enums.EDirectionUAD;
import nx.enums.EDirectionUD;
import nx.enums.EHeadType;
import nx.enums.EKey;
import nx.enums.ENoteType;
import nx.enums.ENoteValue;
import nx.enums.utils.EDirectionTools;
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
	
	
	public function lines(x:Float, y:Float, width:Float) {
		target.graphics.lineStyle(scaling.linesWidth, 0);
		for (f in -2...3) {
			var yPos = f * scaling.space;
			target.graphics.moveTo(x, y - yPos);
			target.graphics.lineTo(x + width, y - yPos);
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
		var currentWidth = this.scaling.scaleX2(dbar.columnsRectAlloted.width);
		dbar.stretchContentTo( this.scaling.descaleX(stretchToWidth));		
		
		// STRETCHED WIDTH:
		// trace(this.scaling.scaleX2(dbar.columnsRectStretched.width));		
		
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
				y2 += 180;
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
			y2 += 180;
		}
		
		// Draw voice stuff...
		
		y2 = y;
		for (dpart in dbar.dparts) {
			for (dvoice in dpart.dvoices) {
				this.dvoiceTies(x, y2, dbar, dvoice);
			}
			y2 += 180;
		}

		//-----------------------------------------------------------------------------------------------------
		
		if (rects) {		
			var r = Scaling.scaleRectangle(dbar.columnsRectStretched, this.scaling);
			r.y = -20;
			r.height = 20;
			
			r.offset(x, y);
			this.gr.lineStyle(1, 0x00FF00);
			this.gr.drawRect(r.x, r.y, r.width, r.height);			
		}
	}
	

	

	
	//-----------------------------------------------------------------------------------------------------
	

	
	public function dbarFull(x:Float, y:Float, dbar:DBar, stretchToWidth:Float=0,  rects:Bool = true ) {
		
		var barMeas = dbar.getTotalWidthAlloted();
		
		var scaledAttrLeftWidth = this.scaling.scaleX2(barMeas.attribLeftWidth);
		var scaledAttrRightWidth	= this.scaling.scaleX2(barMeas.attribRightWidth);
		var contentUnstretchedWidth = this.scaling.scaleX2(barMeas.columnsWidth);
		
		var minWidth = scaledAttrLeftWidth + contentUnstretchedWidth + scaledAttrRightWidth;
		stretchToWidth = Math.max(minWidth, stretchToWidth);
		
		var stretchToWidth2 = stretchToWidth - (scaledAttrLeftWidth + scaledAttrRightWidth);
		//dbar.stretchContentTo(this.scaling.descaleX(stretchToWidth2));
		//trace(stretchToWidth2);
		
		var attrLeftX = x;
		var attrLeftWidth = this.scaling.scaleX2(barMeas.attribLeftWidth);
		this.dbarAttributesLeft(x, y, dbar, rects);
		var y2 = y;
		for (dpart in dbar.dparts) {			
			attributeClef(x, y2, dbar, dpart, rects);
			attributeKey(x, y2, dbar, dpart, rects);
			attributeTime(x, y2, dbar, dpart, rects);
			y2 += 180;
		}
		
		var columnsX = x + attrLeftWidth;		
		var columnsXAdjust = this.scaling.scaleX2(-dbar.columnsRectStretched.x);
		this.dbar(columnsX+columnsXAdjust, y, dbar, stretchToWidth2, true);
		
		//trace(dbar.columnsRectAlloted.width);
		//trace(dbar.columnsRectStretched.width);
		
		var columnsWidth = this.scaling.scaleX2(dbar.columnsRectStretched.width);

		var attrRightX = columnsX + columnsWidth;
		this.dbarAttributesRight(attrRightX, y, dbar, rects);
		
	}
	

	public function dbarAttributesLeft(x:Float, y:Float, dbar:DBar, rects:Bool = true) {
		//var rClef = this.scaling.scaleRect(dbar.rectClef);
		this.gr.endFill();
		this.drawRect(x, y, dbar.attributesRectLeft, 4, 0xaaaaaa);
		this.drawRect(x, y, dbar.rectClef, 2, 0x00FF00);
		//attributeClef(x, y, dbar, rects);
		this.drawRect(x, y, dbar.rectKey, 2, 0xFF0000);
		this.drawRect(x, y, dbar.rectTime, 2, 0x0000FF);
		this.drawRect(x, y, dbar.rectMarginLeft, 1, 0xFF0000);
	}
	
	public function attributeClef(x:Float, y:Float, dbar:DBar, dpart:DPart, rects:Bool = true) {
		var x2 = x + this.scaling.scaleX2(dbar.rectClef.x);
		if (dpart.part.clef == null) return;
		
		var shape:Shape = null;
		switch(dpart.part.clef) {
			case EClef.ClefG:
				shape = SvgAssets.getSvgShape('clefG', this.scaling);
			case EClef.ClefC:
				shape = SvgAssets.getSvgShape('clefC', this.scaling);
			case EClef.ClefF:
				shape = SvgAssets.getSvgShape('clefF', this.scaling);
		}
		
		shape.x = x2 + scaling.svgX + this.scaling.scaleX2(Constants.HEAD_HALFWIDTH);
		shape.y = y + scaling.svgY + this.scaling.scaleY(Constants.HEAD_HEIGHT);
		target.addChild(shape);
	}
	
	public function attributeKey(x:Float, y:Float, dbar:DBar, dpart:DPart, rects:Bool = true) {
		var x2 = x + this.scaling.scaleX2(dbar.rectKey.x);
		if (dpart.part.key == null) return;
		
		
		var shape:Shape = null;
		
		var keyValue = dpart.part.key.levelShift;
		var absValue = Std.int(Math.abs(keyValue));
		if (absValue == 0) return;
		
		var keySharp:Bool = (keyValue > 0);
		
				
		for (i in 0...absValue) {
			if (keySharp) {
				shape = SvgAssets.getSvgShape('signSharp', this.scaling);
			} else {
				shape = SvgAssets.getSvgShape('signFlat', this.scaling);
			}				
			
			var x3 = x2 + scaling.svgX + (i * this.scaling.scaleX2(Constants.SIGN_WIDTH)) + this.scaling.scaleX2(Constants.HEAD_HALFWIDTH);
			var y2 = y + scaling.svgY + this.scaling.scaleY(EKey.getSignLevel(keyValue, i, dpart.part.clef));
			shape.x = x3;
			shape.y = y2;
			target.addChild(shape);
		}
	}

	public function attributeTime(x:Float, y:Float, dbar:DBar, dpart:DPart, rects:Bool = true) {
		var x2 = x + this.scaling.scaleX2(dbar.rectTime.x);
		if (dbar.bar.time == null) return;	
		
		
		
		var shape:Shape = null;
		var shapeLower:Shape = null;
		
		var x3 = x2 + scaling.svgX + scaling.scaleX2(Constants.HEAD_HALFWIDTH);
		var y2 = y + scaling.svgY;
		
		var timeId = dbar.bar.time.id;
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
		
		//var rClef = this.scaling.scaleRect(dbar.rectClef);
		this.gr.endFill();
		this.drawRect(x, y, dbar.attributesRectRight, 4, 0xaaaaaa);
		this.drawRect(x, y, dbar.rectMarginRight, 2, 0x00FF00);
		this.drawRect(x, y, dbar.rectBarline, 2, 0xFF0000);
	}
		
	
}