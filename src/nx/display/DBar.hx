package nx.display;
import cx.ArrayTools;
import nme.geom.Rectangle;
import nx.Constants;
import nx.display.beam.BeamingProcessor_4dot;
import nx.display.beam.IBeamingProcessor;
import nx.display.type.TPartsYMeasurements;
import nx.element.Bar;
import nme.ObjectHash;
import nx.enums.EAckolade;
import nx.enums.EAllotment;
import nx.enums.EAttributeDisplay;
import nx.enums.EBarline;
import nx.enums.EBarlineLeft;
import nx.enums.EClef;
import nx.enums.EKey;
import nx.enums.EPartType;
import nx.enums.EPartType.EPartTypeDistances;
import nx.enums.ETime;
import nx.enums.utils.EAllotmentCalculator;
import nx.display.DPart;
import nx.display.type.TPartDisplaySettings;
import nx.display.type.TBarDisplaySettings;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.ArrayTools;
using nx.enums.utils.EAllotmentCalculator;
using nx.enums.utils.EnumsTools;
using nx.display.util.DBarUtil;
class DBar 
{
	public var dparts							(default, null)	:	Array<DPart>;
	public var bar								(default, null)	:	Bar;
	public var positions						(default, null)	:	Array<Int>;
	public var positionDistance			(default, null)	:	IntHash<Float>;
	public var postionDistpos				(default, null)	:	IntHash<Float>;
	
	public var columns						(default, null)	:	Array<Column>;
	public var dnoteColumn				(default, null)		:ObjectHash<DNote, Column>;
	public var dnoteComplexXadjust	(default, null)		:ObjectHash<DNote, Float>;
	public var dnoteComplex				(default, null)		:ObjectHash<DNote, Complex>;

	public var columnsRectMinframe	(default, null) :	Rectangle;	
	public var columnsRectCramped		(default, null) :	Rectangle;	
	public var columnsRectAlloted		(default, null) :	Rectangle;	
	public var columnsRectStretched	(default, null) :	Rectangle;	
	
	public var allotment						(default, null)	: 	EAllotment;	
	
	public var dTime							(default, null)	:	ETime;
	public var dBarline						(default, null)	:	EBarline;
	public var dBarlineLeft					(default, null)	:	EBarlineLeft;
	public var dAckolade					(default, null)	:	EAckolade;
	public var dIndentLeft					(default, null)	:	Null<Float>;
	public var dIndentRight				(default, null)	:	Null<Float>;
	
	//private var beamingProcessor		(default, null)	:	IBeamingProcessor;
	
	
	public function new(bar:Bar=null, barDisplaySettings:TBarDisplaySettings=null, beamingProcessor:BProcessor=null) {				
		this.bar 					= (bar != null) ? bar : new Bar();				
		this.allotment 		= EAllotment.Logaritmic;
		this._value 			= 0;
		
		//-----------------------------------------------------------------------------------------------------
		
		this.dparts = [];
		for (part in this.bar.parts) {
	
			var partDisplaySettings:TPartDisplaySettings = null;
			if (barDisplaySettings != null) {
				if (barDisplaySettings.partsDisplaySettings != null) {
					var partIdx = this.bar.parts.index(part);
					if (barDisplaySettings.partsDisplaySettings[partIdx] != null) 	partDisplaySettings = barDisplaySettings.partsDisplaySettings[partIdx];
				}
			}
			
	
			if (beamingProcessor == null) {
				beamingProcessor = this.getDefaultBeamProcessor();
			}
			
			
			this.dparts.push(new DPart(part, partDisplaySettings, beamingProcessor));
		}		

		//-----------------------------------------------------------------------------------------------------
		
		this._calcPositions();		
		this._calcColumns();
		this._calcColumnValues();
		this._calcColumValueWeight();
		this._calcDnotesColumnsAndComplexes();
		this._calcDnotesComplexXadjust();
		this._calcColumnsDistancesX();
		this._calcColumnsPositionsX();		
		/*
		this._calcColumnsSpacing();
		this._calcColumnsRects();	
		*/
		
		//-----------------------------------------------------------------------------------------------------
		
		this.setDisplaySettings();

	}
	

	public function setDisplaySettings(settings:TBarDisplaySettings = null) {
		
		//this._dpartTop = null;
		
		//----------------------------------------
		
		this._attributesRectLeft 		= null;
		this._rectLeftindent 			= null;
		this._rectLabels 					= null;
		this._rectAckolade 				= null;
		this._rectAckolademargin 		= null;
		this._rectClef 						= null;
		this._rectKey 						= null;
		this._rectTime 					= null;
		this._rectBarlineleft 			= null;
		this._rectMarginLeft 			= null;
		
		//----------------------------------------
		
		this._attributesRectRight 		= null;		
		this._rectMarginRight			= null;
		this._rectBarline 					= null;
		this._rectCautionaries			= null;
		this._rectRightindent 			= null;

		//----------------------------------------
		
		if (settings == null) {
			settings = {
				dTime:				null,
				dBarline:			null,
				dBarlineLeft:		null,
				dAckolade:			null,
				dIndentLeft:		null,
				dIndentRight:		null,	
				partsDisplaySettings: null,			
			}
		}
		
		if (settings.partsDisplaySettings != null && this.dparts != null) {			
			for (dpart in this.dparts) {
				var idx = this.dparts.index(dpart);
				if (settings.partsDisplaySettings[idx] != null) {
					dpart.setDisplaySettings(settings.partsDisplaySettings[idx]);
				}
			}
		} else {
			for (dpart in this.dparts) {
				dpart.setDisplaySettings();
			}			
		}
		
		//-----------------------------------------------------------------------------------------------------
			
		this.dTime = 			(settings.dTime != null) 				? settings.dTime 			: bar.time;
		this.dBarline = 		(settings.dBarline != null) 			? settings.dBarline 			: bar.barline;
		this.dBarlineLeft = 	(settings.dBarlineLeft != null) 		? settings.dBarlineLeft 	: bar.barlineLeft;
		this.dAckolade = 	(settings.dAckolade != null) 			? settings.dAckolade 		: bar.ackolade;		
		this.dIndentLeft = 	(settings.dIndentLeft != null) 		? settings.dIndentLeft 	: bar.indentLeft;
		this.dIndentRight = (settings.dIndentRight != null) 	? settings.dIndentRight 	: bar.indentRight;
		
		if (bar.timeDisplay == EAttributeDisplay.Always) 		this.dTime = bar.time;
		if (bar.timeDisplay == EAttributeDisplay.Never) 		this.dTime = null;		
		
		//-----------------------------------------------------------------------------------------------------

		/*
		this._calcPositions();		
		this._calcColumns();
		this._calcColumnValues();
		this._calcColumValueWeight();
		this._calcDnotesColumnsAndComplexes();
		this._calcDnotesComplexXadjust();
		this._calcColumnsDistancesX();
		this._calcColumnsPositionsX();		
		*/
		
		this._calcColumnsSpacing();		
		this._calcColumnsRects();			
		
	}
	
	public function getDisplaySettings():TBarDisplaySettings {	
		var settings:TBarDisplaySettings = {
			dTime:				this.dTime,
			dBarline:			this.dBarline,
			dBarlineLeft:		this.dBarlineLeft,
			dAckolade:			this.dAckolade,
			dIndentLeft:		(this.dIndentLeft != 0) ? this.dIndentLeft : null,
			dIndentRight:		(this.dIndentRight != 0) ? this.dIndentRight : null,	
			partsDisplaySettings: [],
		}
		for (dpart in this.dparts) {
			settings.partsDisplaySettings.push(dpart.getDisplaySettings());
		}
		return settings;
	}
	
	/************************************************************************
	 * Private methods
	 * 
	 ************************************************************************/

	private var _value:Int;
	public var value(get_value, null):Int;
	private function get_value():Int 
	{
		if (this._value != 0) return this._value;
		this._value = 0;
		for (dpart in this.dparts) {
			this._value = Std.int(Math.max(this._value, dpart.value));
		}
		return this._value;
	}			
	
	private function _calcPositions() {
		this.positions = [];
		for (dpart in this.dparts) {
			this.positions  = this.positions.concat(dpart.positions);			
		}	
		this.positions = ArrayTools.unique(this.positions);
		this.positions.sort(function(a, b) { return Reflect.compare(a, b); } );
	}
	
	private function _calcColumns() {		
		this.columns = [];	
		
		
		for (pos in this.positions) {			
			var column:Column = { position:pos, value:12345, complexes:[], distanceX:0.0, positionX:0.0, widthX:0.0 };
			for (dpart in this.dparts) {
				var dplex = dpart.positionComplex.get(pos);	
				column.complexes.push(dplex);
			}			
			this.columns.push(column);			
		}
	}	

	private function _calcColumnValues() {
		var prevColumn:Column = null;
		for (column in this.columns) {			
			if (column == this.columns.first()) {
				prevColumn = column;				
				continue;
			}			
			var prevValue = column.position - prevColumn.position;
			prevColumn.value = prevValue;
			prevColumn = column;
		}
		var lastColumn = prevColumn;
		lastColumn.value = this.value - lastColumn.position;
		
	}
	
	private function _calcColumValueWeight() {
		var barvalue = this.value;
		for (column in this.columns) {
			column.valueWeight = column.value / barvalue;
		}
	}
	
	private function _calcDnotesColumnsAndComplexes() {
		this.dnoteColumn 				= new ObjectHash<DNote, Column>();
		this.dnoteComplex 				= new ObjectHash <DNote, Complex>();

		/*
		 * 2.09 dpp ObjectHash bug workaround - seems to work in 2.10
		 * 
		this.dnoteguidColumnidx 		= new Hash<Int>();
		this.dnoteguidComplexidx 	= new Hash<Int>();
		*/
		
		for (column in this.columns) {
			for (complex in column.complexes) {
				if (complex == null) continue;
				for (dnote in complex.dnotes) {
					this.dnoteColumn.set(dnote, column);
					this.dnoteComplex.set(dnote, complex);
			
					/*
					 * 2.09 dpp ObjectHash bug workaround - seems to work in 2.10
					 * 
					var columnIdx = this.columns.index(column);
					this.dnoteguidColumnidx.set(dnote.guid, columnIdx);
					
					var complexIdx = column.complexes.index(complex);
					this.dnoteguidComplexidx.set(dnote.guid, complexIdx);
					*/
					
				}
			}
		}
	}	
	
	
	
	private function _calcDnotesComplexXadjust() {
		this.dnoteComplexXadjust = new ObjectHash<DNote, Float>();

		/*
		 * 2.09 dpp ObjectHash bug workaround - seems to work in 2.10
		 * 		
		this.dnoteguidComplexXadjust = new Hash<Float>();
		*/
		
		for (column in this.columns) {
			for (complex in column.complexes) {
				if (complex == null) continue;
				var idx = 0;
				for (dnote in complex.dnotes) {
					var adjustX = complex.dnoteXshift(idx);
					this.dnoteComplexXadjust.set(dnote, adjustX);
					
					/*
					 * 2.09 dpp ObjectHash bug workaround - seems to work in 2.10
					 * 					
					var complexIdx = column.complexes.index(complex);
					this.dnoteguidComplexXadjust.set(dnote.guid, adjustX);
					*/
					
					idx++;
				}
			}
		}
		
	}
	
	private function _calcColumnsDistancesX() {
		var testPB:TPosComplex = { position:0, rectsAll:[], rectsHeadW:[] };
		var firstpb = this.columns[0];		
		for (complex in firstpb.complexes) {
			var dplexRectsAll = complex.rectsAll;
			testPB.rectsAll.push(complex.getRectsAllCopy());
			testPB.rectsHeadW.push(complex.rectHeads.width);
		}
		
		var prevColumn:Column = null;
		for (column in this.columns) {
			

			if (column == this.columns.first()) {
				prevColumn = column;
				continue;
			}
			
			//-----------------------------------------------------------------------			
			//trace('*** pb ' + i + ' ***');			
			//-----------------------------------------------------------------------

			var maxDistanceX = 0.0;
			for (j in 0...column.complexes.length) {

				var dplex = column.complexes[j];
				var testRectsAll = testPB.rectsAll[j];
				var testRectHeadW = testPB.rectsHeadW[j];

				if (dplex != null) {
					var dplexRectsAll = dplex.rectsAll;
					var distanceX = Complex.dplexDistanceX(testRectsAll, testRectHeadW, dplexRectsAll);
					maxDistanceX = Math.max(maxDistanceX, distanceX);
				} else {
					
				}				
			}
			
			//-----------------------------------------------------------------------

			//trace('Max distanceX:' + maxDistanceX);
			prevColumn.widthX = maxDistanceX;
			column.distanceX = maxDistanceX;
		
			//-----------------------------------------------------------------------

			for (j in 0...column.complexes.length) {

				var dplex = column.complexes[j];
				var testRectsAll = testPB.rectsAll[j];
				var testRectHeadW = testPB.rectsHeadW[j];
				
				if (dplex != null) {
					testPB.rectsAll[j] = dplex.getRectsAllCopy();
					testPB.rectsHeadW[j] = dplex.rectHeads.width;
				} else {				
					for (rect in testPB.rectsAll[j]) {
						rect.offset( -maxDistanceX, 0);
					}
					testPB.rectsHeadW[j] += -maxDistanceX;					
				}	
				
			}
			prevColumn = column;
		}
	}
	
	private function _calcColumnsPositionsX() {
		var positionX = 0.0;
		for (column in this.columns) {
			positionX += column.distanceX;
			column.positionX = positionX;			
		}
	}	
	
	private function _calcColumnsSpacing() {
		//trace('*****************************');
		
		//allotment = EAllotment.Logaritmic;

		for (column in this.columns) {
			column.aWidthX = this.allotment.aWidthX(column.widthX, column.value);
			column.aSuperX = this.allotment.aSuperX(column.widthX, column.value);
		}
		
		
		
		/*
		//-----------------------------------------------------------------------------------------------------
		// Test equal distance		
		for (column in this.columns) {
			column.aWidthX = Math.max(column.widthX, Constants.ASPACING_NORMAL);
			column.aSuperX = Math.max(column.widthX - Constants.ASPACING_NORMAL, 0);
		}
		
		//-----------------------------------------------------------------------------------------------------
		// Test linear distance
		for (column in this.columns) {
			var columnWidthX = (column.value / Constants.BASE_NOTE_VALUE) * Constants.ASPACING_NORMAL;
			column.aWidthX = Math.max(column.widthX, columnWidthX);
			column.aSuperX = Math.max(column.widthX - columnWidthX, 0);			
		}
		
		//-----------------------------------------------------------------------------------------------------
		// Test logaritmic distance
		for (column in this.columns) {
			var delta:Float = 0.5;
			var columnWidthX = (delta +(column.value / Constants.BASE_NOTE_VALUE) / 2) * Constants.ASPACING_NORMAL;
			column.aWidthX = Math.max(column.widthX, columnWidthX);
			column.aSuperX = Math.max(column.widthX - columnWidthX, 0);			
		}		
		*/
		
		
		var posX = 0.0;
		for (column in this.columns) {
				column.sPositionX = column.aPositionX = posX;			
			posX += column.aWidthX;
		}		
		
		/*
		for (column in this.columns) {
			trace([column.widthX, column.positionX, Constants.ASPACING_NORMAL, column.aSuperX, column.aWidthX, column.aPositionX]);						
		}
		*/
		
	}
	
	private var firstMinX:Float;
	private var lastWidthIncludeValue:Float;
	
	private function _calcColumnsRects() {
		
		var firstColumn = this.columns.first();
		this.firstMinX = 0.0;
		for (complex in firstColumn.complexes) {
			firstMinX = Math.min(firstMinX, complex.rectFull.x);
		}		
		
		var lastColumn = this.columns.last();		
		var lastMaxW = 0.0;
		for (complex in lastColumn.complexes) {
			if (complex != null) {
				lastMaxW = Math.max(lastMaxW, complex.rectFull.x + complex.rectFull.width);				
			}
		}	
		this.lastWidthIncludeValue = Math.max(lastMaxW, lastColumn.aWidthX);				
		
		//-----------------------------------------------------------------------------------------------------
		
		var columnsWidthCramped = lastColumn.positionX;
		
		this.columnsRectMinframe = new Rectangle(firstMinX, 0, -firstMinX + columnsWidthCramped + lastMaxW, 0);		
		this.columnsRectCramped = new Rectangle(firstMinX, 0, -firstMinX + columnsWidthCramped + lastWidthIncludeValue, 0);		
		
		var columnsWidthAlloted = this.columns.last().aPositionX;
		this.columnsRectAlloted = new Rectangle(firstMinX, 0, -firstMinX + columnsWidthAlloted + lastWidthIncludeValue, 0);
		
		var columnsWidthStretched = this.columns.last().sPositionX;
		this.columnsRectStretched = new Rectangle(firstMinX, 0, -firstMinX + columnsWidthStretched + lastWidthIncludeValue, 0);
		
	}		

	
	public function stretchContentTo(stetchedContentWidth:Float=0.0):DBar {		
		
		if (this.allotment == EAllotment.Cramped) return this;
		
		var currentContentWidth = this.columnsRectAlloted.width;
		var stretchAmount:Float = stetchedContentWidth - currentContentWidth;
		
		//trace([currentContentWidth, stetchedContentWidth, stretchAmount]);
		
		if (stetchedContentWidth <= currentContentWidth) return this;

		//-----------------------------------------------------------------------------------------------------
		
		for (column in this.columns) {
			column.sPositionX = column.aPositionX;
			column.sWidthX = column.aWidthX;
		}
		
		//-----------------------------------------------------------------------------------------------------
		
		var currentNormalValueWidth = new IntHash<Float>();
		var newNormalValueWidth = new IntHash<Float>();
		
		for (column in this.columns) {
			var valueWidth = this.allotment.aWidthX(0, column.value);			
			//trace(this.allotment.aWidthX(0, column.value));
			if (!currentNormalValueWidth.exists(column.value)) {
				currentNormalValueWidth.set(column.value, valueWidth);
				newNormalValueWidth.set(column.value, valueWidth);
			}
		}
		
		var currentValues = ArrayTools.fromIterator(currentNormalValueWidth.keys());
		var pott = stretchAmount;				
		var loopCount = 0;
		
		do {		
			// set new width values:
			
			for (value in currentValues) {
				var change = 0.5 * this.allotment.valueFactor(value);	
				newNormalValueWidth.set(value, newNormalValueWidth.get(value) + change);				
			}
			
			for (column in this.columns) {								
				var change = 0.5 * (column.value / Constants.BASE_NOTE_VALUE);			
				var checkWidth = newNormalValueWidth.get(column.value);
				
				if (column.sWidthX < checkWidth) {
					column.sWidthX += change;
					pott -= change;
				} else {
					// utvidga ej!
				}
				
				loopCount++;				
				if (loopCount > Constants.LOOP_COUNT_MAX) {
					throw "Loop check overload";
					pott = 0;								
				}
				
				if (pott <= 0) break;				
			}
			
		} while (pott > 0);
		
		//trace(loopCount);

		//-----------------------------------------------------------------------------------------------------
		// Finally set rectangle

		var pos = 0.0;
		for (column in this.columns) {
			column.sPositionX = pos;
			pos += column.sWidthX;
		}

		this.columnsRectStretched.width = stetchedContentWidth;
		return this;
	}	
	

	//-----------------------------------------------------------------------------------------------------
	
	/// INDENT LEFT
	private var _rectLeftindent:Rectangle;
	public var rectLeftindent(get_rectLeftindent, null):Rectangle;
	private function get_rectLeftindent():Rectangle {
		if (this._rectLeftindent != null) return this._rectLeftindent;
		this._rectLeftindent = new Rectangle(0, -1, this.dIndentLeft, 2);
		return this._rectLeftindent;
	}	
	
	/// PART LABELS
	private var _rectLabels:Rectangle;
	public var rectLabels(get_rectLabels, null):Rectangle;
	private function get_rectLabels():Rectangle {
		if (this._rectLabels != null) return this._rectLabels;
		/// Get from parts...
		this._rectLabels = new Rectangle(0, -1, Constants.ATTRIBUTE_NULL_WIDTH, 2);
		this._rectLabels.offset(this.rectLeftindent.x + this.rectLeftindent.width, 0);
		return this._rectLabels;
	}
	
	/// ACKOLADE
	private var _rectAckolade:Rectangle;
	public var rectAckolade(get_rectAckolade, null):Rectangle;
	private function get_rectAckolade():Rectangle {
		if (this._rectAckolade != null) return this._rectAckolade;
		this._rectAckolade = new Rectangle(0, -3, this.dAckolade.widthAckolade(), 6);
		this._rectAckolade.offset(this.rectLabels.x + this.rectLabels.width, 0);
		return this._rectAckolade;
	}
	
	/// ACKOLAD EMARGIN
	private var _rectAckolademargin:Rectangle;
	public var rectAckolademargin(get_rectAckolademargin, null):Rectangle;
	private function get_rectAckolademargin():Rectangle 
	{
		if (this._rectAckolademargin != null) return this._rectAckolademargin;
		this._rectAckolademargin = new Rectangle(0, -4, Constants.ACKOLADE_CLEF_MARGIN, 8);
		this._rectAckolademargin.offset(this.rectAckolade.x + this.rectAckolade.width, 0);
		return this._rectAckolademargin;
	}	
	
	/// CLEF
	private var _rectClef:Rectangle;
	public var rectClef(get_rectClef, null):Rectangle;
	private function get_rectClef():Rectangle {
		if (this._rectClef != null) return this._rectClef;
		this._rectClef = new Rectangle(0, -2, 0, 2);
		for (dpart in this.dparts) {
			this._rectClef = this._rectClef.union(dpart.rectClef);			
		}		
		this._rectClef.offset(this.rectAckolademargin.x + this.rectAckolademargin.width, 0); 
		return this._rectClef;
	}
	
	/// KEY
	private var _rectKey:Rectangle;
	public var rectKey(get_rectKey, null):Rectangle;
	private function get_rectKey():Rectangle {
		if (this._rectKey != null) return this._rectKey;
		this._rectKey = new Rectangle(0, 0, 0, 0);
		for (dpart in this.dparts) {
			this._rectKey = this._rectKey.union(dpart.rectKey);						
		}
		this._rectKey.offset(this.rectClef.x + this.rectClef.width, 0);
		return this._rectKey;
	}	
	
	/// TIME
	private var _rectTime:Rectangle;
	public var rectTime(get_rectTime, null):Rectangle;
	private function get_rectTime():Rectangle {
		var rect:Rectangle = null;
		this._rectTime = new Rectangle(0, -2, this.dTime.widthTime(), 4);
		this._rectTime.offset(this.rectKey.x + this.rectKey.width, 0);
		return _rectTime;
	}
	
	/// LEFT BARLINE
	private var _rectBarlineleft:Rectangle;
	public var rectBarlineleft(get_rectBarlineleft, null):Rectangle;
	private function get_rectBarlineleft():Rectangle {
		if (this._rectBarlineleft != null) return this._rectBarlineleft;
		this._rectBarlineleft = new Rectangle(0, -5, this.dBarlineLeft.widthBarlineLeft(), 10);
		this._rectBarlineleft.offset(this.rectTime.x + this.rectTime.width, 0);
		return this._rectBarlineleft;
	}	
	
	/// MARGIN LEFT
	private var _rectMarginLeft:Rectangle;
	public var rectMarginLeft(get_rectMarginLeft, null):Rectangle;
	private function get_rectMarginLeft():Rectangle {
		if (this._rectMarginLeft != null) return this._rectMarginLeft;		
		this._rectMarginLeft = new Rectangle(0, -3, Constants.BAR_MARGIN_LEFT, 4);
		this._rectMarginLeft.offset(this.rectBarlineleft.x + this.rectBarlineleft.width, 0); /// CHANGE TO LEFT BARLINE
		return this._rectMarginLeft;
	}
	
	//--------------------------------------------------------------------------------------
	
	/// MARGIN RIGHT
	private var _rectMarginRight:Rectangle;
	public var rectMarginRight(get_rectMarginRight, null):Rectangle;
	private function get_rectMarginRight():Rectangle {
		if (this._rectMarginRight != null) return this._rectMarginRight;		
		this._rectMarginRight = new Rectangle(0, -3, Constants.BAR_MARGIN_RIGHT, 6);
		return this._rectMarginRight;		
		
	}
	
	/// BARLINE
	private var _rectBarline:Rectangle;
	public var rectBarline(get_rectBarline, null):Rectangle;
	private function get_rectBarline():Rectangle {
		if (this._rectBarline != null) return this._rectBarline;
		this._rectBarline = new Rectangle(0, -2, this.dBarline.widthBarline(), 4);
		this._rectBarline.offset(this.rectMarginRight.x + this.rectMarginRight.width, 0);		
		return this._rectBarline;
	}
	
	/// CAUTIONARIES...
	private var _rectCautionaries:Rectangle;
	public var rectCautionaries(get_rectCautionaries, null):Rectangle;
	private function get_rectCautionaries():Rectangle {
		if (this._rectCautionaries != null) return this._rectCautionaries;		
		this._rectCautionaries = new Rectangle(0, -3, 0, 6);
		/// Get cautionaries from part stuff (clefs, keys)!
		this._rectCautionaries.offset(this.rectBarline.x + this.rectBarline.width, 0);
		return this._rectCautionaries;		
	}
		
	
	/// RIGHT INDENT
	private var _rectRightindent:Rectangle;
	public var rectRightindent(get_rectRightindent, null):Rectangle;
	private function get_rectRightindent():Rectangle {
		if (this._rectRightindent != null) return this._rectRightindent;		
		this._rectRightindent = new Rectangle(0, -3, this.dIndentRight, 6);
		this._rectRightindent.offset(this.rectCautionaries.x + this.rectCautionaries.width, 0);
		return this._rectRightindent;		
	}	
		
	//--------------------------------------------------------------------------------------
	
	private var _attributesRectLeft:Rectangle;
	private function get_attributesRectLeft():Rectangle 
	{
		if (this._attributesRectLeft != null) return this._attributesRectLeft;
		var rect = new Rectangle(0, -8, 0, 16)
		
			// left Rightindent
			// part labels
			// ackolade
			.union(this.rectLeftindent)
			.union(this.rectLabels)
			.union(this.rectAckolade)
			.union(this.rectAckolademargin)
			.union(this.rectClef)
			.union(this.rectKey)
			.union(this.rectTime)
			.union(this.rectBarlineleft)
			.union(this.rectMarginLeft)			
			;
		/*
		rect = rect.union(this.rectLabels);	
		rect = rect.union(this.rectAckolade);	
		rect = rect.union(this.rectClef);	
		rect = rect.union(this.rectKey);	
		rect = rect.union(this.rectTime);	
		rect = rect.union(this.rectMarginLeft);	
		*/	
		
		this._attributesRectLeft = rect;
		return this._attributesRectLeft;
	}
	public var attributesRectLeft(get_attributesRectLeft, null):Rectangle;	

	
	private var _attributesRectRight:Rectangle;
	private function get_attributesRectRight():Rectangle 
	{
		if (this._attributesRectRight != null) return this._attributesRectRight;
	
		var rect = new Rectangle(0, -8, 0, 16)
			.union(this.rectMarginRight)
			.union(this.rectBarline)
			.union(this.rectCautionaries)
			.union(this.rectRightindent)
			;
			
		this._attributesRectRight = rect;
		return this._attributesRectRight;
	}
	public var attributesRectRight(get_attributesRectRight, null):Rectangle;	

	
	//---------------------------------------------------------------------------------------------------------

	public function getTotalWidthCramped() {
		var ret:TBarMeasurement = {
			attribLeftWidth: 		this.attributesRectLeft.width,
			columnsWidth: 		this.columnsRectCramped.width,
			attribRightWidth:	this.attributesRectRight.width, 
			totalWidth:			this.attributesRectLeft.width + this.columnsRectCramped.width + this.attributesRectRight.width,
		}
		return ret;		
	}
	
	public function getTotalWidthAlloted() {
		var ret:TBarMeasurement = {
			attribLeftWidth: 		this.attributesRectLeft.width,
			columnsWidth: 		this.columnsRectAlloted.width,
			attribRightWidth:	this.attributesRectRight.width, 
			totalWidth:			this.attributesRectLeft.width + this.columnsRectAlloted.width + this.attributesRectRight.width,
		}
		return ret;		
	}	
	
	public function getTotalWidthStretched() {
		var ret:TBarMeasurement = {
			attribLeftWidth: 		this.attributesRectLeft.width,
			columnsWidth: 		this.columnsRectStretched.width,
			attribRightWidth:	this.attributesRectRight.width, 
			totalWidth:			this.attributesRectLeft.width + this.columnsRectStretched.width + this.attributesRectRight.width,			
		}	
		return ret;
	}
	
	//-----------------------------------------------------------------------------------------------------
	
	/*
	private var _dpartTop:ObjectHash<DPart, Float>;
	public var dpartTop(get_dpartTop, null):ObjectHash<DPart, Float>;
	private function get_dpartTop():ObjectHash<DPart, Float> {

		if (this._dpartTop != null) return this._dpartTop;
		this._dpartTop = new ObjectHash<DPart, Float>();
		
		var distance = 0.0;
		var prevDpart:DPart = null;
		for (dpart in this.dparts) {						
			if (dpart == this.dparts.first()) {
				distance += -(dpart.rectDPartHeight.y);
			} else {
				var increase = (prevDpart.rectDPartHeight.height + prevDpart.rectDPartHeight.y) + -dpart.rectDPartHeight.y + Constants.PART_MIN_DISTANCE;								
				var minDistance = EPartTypeDistances.getMinDistance(dpart.part.type);
				//trace([increase, minDistance]);
				distance += Math.max(minDistance, increase);
			}
			this._dpartTop.set(dpart, distance);			
			prevDpart = dpart;
		}
		return this._dpartTop;
	}
	
	public function resetDpartTop() {
		this._dpartTop = null;
		//var dummy = this.dpartTop;
	}
	*/
	
	//-------------------------------------------------------------------------------------------------
	
	private var _dpartsRects:Array<Rectangle>;	
	public var dpartsRects(get_dpartsRects, null):Array<Rectangle>;
	private function get_dpartsRects():Array<Rectangle> {
		if (this._dpartsRects != null) return this._dpartsRects;
		this._dpartsRects = [];
		for (dpart in this.dparts) {
			this._dpartsRects.push(dpart.rectDPartHeight);
		}
		return this._dpartsRects;
	}
	
	
	private var _dpartTypes:Array<EPartType>;
	public var dpartTypes(get_dpartTypes, null):Array<EPartType>;
	private function get_dpartTypes():Array<EPartType> {
		if (this._dpartTypes != null) return this._dpartTypes;
		this._dpartTypes = [];
		for (dpart in this.dparts) {
			this._dpartTypes.push(dpart.part.type);
		}
		return this._dpartTypes;
	}
	
	private var _dpartYPositions:Array<Float>;
	public var dpartYPositions(get_dpartYPositions, null):Array<Float>;

	private function get_dpartYPositions():Array<Float> {
		if (this._dpartYPositions != null) return this._dpartYPositions;		
		var meas:TPartsYMeasurements = calcPartsMeasurements(this.dpartsRects, this.dpartTypes);
		this._dpartYPositions = meas.partYPositions;
		this._dpartsHeight = meas.partsHeight;
		return this._dpartYPositions;
	}	
	
	private var _dpartsHeight:Null<Float>;
	public var dpartsHeight(get_dpartsHeight, null):Float;
	private function get_dpartsHeight():Float {
		if (this._dpartsHeight != null) return this._dpartsHeight;
		this._dpartYPositions = null; // force recalculation of dpartYPositions		
		return this._dpartsHeight;
	}
	
	static public function calcPartsMeasurements(partRects:Array<Rectangle>, partTypes:Array<EPartType>=null):TPartsYMeasurements{			
		var distance = 0.0;
		var prevPRect:Rectangle = null;
		var tops:Array<Float> = [];
		for (pRect in partRects) {
			var pIdx = partRects.index(pRect);			
			if (prevPRect == null) {
				distance += -(pRect.y);
				tops.push(distance);
			} else {
				var increase = (prevPRect.height + prevPRect.y) + -pRect.y + Constants.PART_MIN_DISTANCE;												
				var minDistance:Float = 0.0;
				if (partTypes == null) {
					minDistance = EPartTypeDistances.getMinDistance(EPartType.Normal);
				} else {
					minDistance = EPartTypeDistances.getMinDistance(partTypes[pIdx]);
				}
				distance += Math.max(minDistance, increase);
				
				tops.push(distance);
			}			
			prevPRect = pRect;
		}		
		var partsHeight = distance  + (prevPRect.y + prevPRect.height);
		return {partYPositions: tops, partsHeight:partsHeight};		
	}

	/*
	private var _dpartTop:Array<Float>;
	public var dpartTop(get_dpartTop, null):Array<Float>;
	private function get_dpartTop():Array<Float> {

		if (this._dpartTop != null) return this._dpartTop;
		this._dpartTop = [];
		
		var distance = 0.0;
		var prevDpart:DPart = null;
		for (dpart in this.dparts) {						
			
			if (dpart == this.dparts.first()) {
				distance += -(dpart.rectDPartHeight.y);
			} else {
				var increase = (prevDpart.rectDPartHeight.height + prevDpart.rectDPartHeight.y) + -dpart.rectDPartHeight.y + Constants.PART_MIN_DISTANCE;								
				var minDistance = EPartTypeDistances.getMinDistance(dpart.part.type);
				//trace([increase, minDistance]);
				distance += Math.max(minDistance, increase);
			}
			this._dpartTop.push(distance);		
			prevDpart = dpart;
		}
		return this._dpartTop;
	}
	*/
	
}


typedef TBarMeasurement = {
	attribLeftWidth: 		Float,
	columnsWidth: 		Float,
	attribRightWidth:	Float, 
	totalWidth:			Float,
	//columnsX:				Float,
	//attribRightX:			Float,
}



typedef TPosComplex = {
	position: Int,
	rectsAll: Array<Array<Rectangle>>,	
	rectsHeadW:Array<Float>,
}


/*
typedef TBarDisplaySettings = {
	dTime:				ETime,
	//dTime:				ETime,
	dBarline:			EBarline,
	dBarlineLeft:		EBarlineLeft,
	dAckolade:			EAckolade,
	dIndentLeft:		Null<Float>,
	dIndentRight:		Null<Float>,	
	
	partsDisplaySettings: Array<TPartDisplaySettings>,
	
}
*/
