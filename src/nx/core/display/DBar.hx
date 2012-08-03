package nx.core.display;
import cx.ArrayTools;
import nme.geom.Rectangle;
import nx.Constants;
import nx.core.element.Bar;
import nme.ObjectHash;
import nx.enums.EAllotment;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.ArrayTools;
class DBar 
{
	public var dparts					(default, null)		:Array<DPart>;
	public var bar						(default, null)		:Bar;
	public var positions				(default, null)		:Array<Int>;
	public var positionDistance	(default, null)		:IntHash<Float>;
	public var postionDistpos		(default, null)		:IntHash<Float>;
	
	public var columns				(default, null)		:Array<Column>;
	
	public var columnsRectAll		(default, null) 	:Rectangle;
	
	public var dnoteColumn		(default, null)		:ObjectHash<DNote, Column>;
	public var dnoteComplexXadjust		(default, null)		:ObjectHash<DNote, Float>;
	
	public function new(bar:Bar=null) {				
		this.bar = (bar != null) ? bar : new Bar();				
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
		
		this._calcColumnsWidthX();		
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
		trace('*****************************');
		
		var allotment = EAllotment.Logaritmic;

		switch (allotment) {
			
			case EAllotment.Equal: 
				for (column in this.columns) {
					column.sWidthX = column.aWidthX = Math.max(column.widthX, Constants.ASPACING_NORMAL);
					column.sSuperX = column.aSuperX = Math.max(column.widthX - Constants.ASPACING_NORMAL, 0);
				}			
			case EAllotment.Linear: 
				for (column in this.columns) {
					var columnWidthX = (column.value / Constants.BASE_NOTE_VALUE) * Constants.ASPACING_NORMAL;
					column.sWidthX = column.aWidthX = Math.max(column.widthX, columnWidthX);
					column.sSuperX = column.aSuperX = Math.max(column.widthX - columnWidthX, 0);			
				}	
			case EAllotment.Logaritmic:
				for (column in this.columns) {
					var delta:Float = 0.5;
					var columnWidthX = (delta +(column.value / Constants.BASE_NOTE_VALUE) / 2) * Constants.ASPACING_NORMAL;
					column.sWidthX = column.aWidthX = Math.max(column.widthX, columnWidthX);
					column.sSuperX = column.aSuperX = Math.max(column.widthX - columnWidthX, 0);			
				}				
			default:
				for (column in this.columns) {
					column.sWidthX = column.aWidthX = column.widthX;
					column.sSuperX = column.aSuperX = column.widthX;
				}					
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
		
		for (column in this.columns) {
			trace([column.widthX, column.positionX, Constants.ASPACING_NORMAL, column.aSuperX, column.aWidthX, column.aPositionX]);						
		}
		
	}
	
	private function _calcColumnsWidthX() {
		
		var firstColumn = this.columns.first();
		var firstMinX = 0.0;
		for (complex in firstColumn.complexes) {
			firstMinX = Math.min(firstMinX, complex.rectFull.x);
		}
		
		var columnsW = this.columns.last().aPositionX;
		
		var lastColumn = this.columns.last();
		var lastMaxW = 0.0;
		for (complex in lastColumn.complexes) {
			if (complex != null) {
				lastMaxW = Math.max(lastMaxW, complex.rectFull.x + complex.rectFull.width);				
			}
		}	
		lastMaxW = Math.max(lastMaxW, lastColumn.aWidthX);
		
		this.columnsRectAll = new Rectangle(firstMinX, 0, -firstMinX + columnsW + lastMaxW, 0);
	}		
	
	
	//------------------------------------------------------------------------------------------------------
	
	private var _value:Int;
	public var value(get_value, null):Int;
	private function get_value():Int 
	{
		if (this._value != null) return this._value;
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