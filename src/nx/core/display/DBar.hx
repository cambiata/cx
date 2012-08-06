package nx.core.display;
import cx.ArrayTools;
import nme.geom.Rectangle;
import nx.Constants;
import nx.core.element.Bar;
import nme.ObjectHash;
import nx.enums.EAllotment;
import nx.enums.utils.EAllotmentCalculator;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.ArrayTools;
using nx.enums.utils.EAllotmentCalculator;

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
	
	public var columnsRectMinframe	(default, null) :	Rectangle;	
	public var columnsRectCramped		(default, null) :	Rectangle;	
	public var columnsRectAlloted		(default, null) :	Rectangle;	
	public var columnsRectStretched	(default, null) :	Rectangle;	
	
	public var allotment						(default, null)	: 	EAllotment;	
	
	
	public function new(bar:Bar=null, allotment:EAllotment=null) {				
		this.bar = (bar != null) ? bar : new Bar();				
		this.allotment = (allotment != null) ? allotment : EAllotment.Logaritmic;
		this._value = 0;
		
		this.dparts = [];
		for (part in this.bar.parts) {
			this.dparts.push(new DPart(part));
		}				
		this._calcPositions();		
		this._calcColumns();
		this._calcColumnValues();
		this._calcColumValueWeight();
		this._calcDnotesColumns();
		this._calcDnotesComplexXadjust();
		this._calcColumnsDistancesX();
		this._calcColumnsPositionsX();		
		this._calcColumnsSpacing();
		this._calcColumnsRects();		
	}
	

	/************************************************************************
	 * Private methods
	 * 
	 ************************************************************************/
	
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
		this.dnoteColumn = new ObjectHash<DNote, Column>();
		
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
	
	private function _calcDnotesColumns() {
		for (column in this.columns) {
			for (complex in column.complexes) {
				if (complex == null) continue;
				for (dnote in complex.dnotes) {
					this.dnoteColumn.set(dnote, column);
				}
			}
		}
	}	
	
	private function _calcDnotesComplexXadjust() {
		this.dnoteComplexXadjust = new ObjectHash<DNote, Float>();
		for (column in this.columns) {
			for (complex in column.complexes) {
				if (complex == null) continue;
				var idx = 0;
				for (dnote in complex.dnotes) {
					var adjustX = complex.dnoteXshift(idx);
					this.dnoteComplexXadjust.set(dnote, adjustX);
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
			//column.sWidthX = column.aWidthX;

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
		
		/*
		trace(this.columnsRectAlloted);
		trace(this.columnsRectStretched);		
		*/
		
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
	
	
	
	//------------------------------------------------------------------------------------------------------
	
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
	
}


typedef TPosComplex = {
	position: Int,
	rectsAll: Array<Array<Rectangle>>,	
	rectsHeadW:Array<Float>,
}