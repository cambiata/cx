package nx.core.display;
import cx.ArrayTools;
import nme.geom.Rectangle;
import nx.core.element.Bar;
import nx.geom.HPlane;
import nme.ObjectHash;

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
	
	public function new(bar:Bar=null) {				
		this.bar = (bar != null) ? bar : new Bar();				
		this.dparts = [];
		for (part in this.bar.parts) {
			this.dparts.push(new DPart(part));
		}				
		this._calcPositions();
		this._calcColumns();
		this._calcDnotesColumns();
		this._calcColumnsDistancesX();
		this._calcColumnsPositionsX();
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
		trace(this.positions);
	}
	
	private function _calcColumns() {		
		this.columns = [];	
		this.dnoteColumn = new ObjectHash<DNote, Column>();
		
		for (pos in this.positions) {			
			var column:Column = { position:pos, complexes:[], distanceX:0.0, positionX:0.0 };
			for (dpart in this.dparts) {
				var dplex = dpart.positionComplex.get(pos);	
				column.complexes.push(dplex);
			}			
			this.columns.push(column);			
		}
		trace(this.columns.length);
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
	
	private function _calcColumnsDistancesX() {
		var testPB:TPosComplex = { position:0, rectsAll:[], rectsHeadW:[] };
		var firstpb = this.columns[0];		
		for (complex in firstpb.complexes) {
			var dplexRectsAll = complex.rectsAll;
			testPB.rectsAll.push(complex.getRectsAllCopy());
			testPB.rectsHeadW.push(complex.rectHeads.width);
		}
		
		var i = 0;
		for (column in this.columns) {
			if (i == 0) {
				i++;
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
					trace(distanceX);
					maxDistanceX = Math.max(maxDistanceX, distanceX);
				} else {
					
				}				
			}
			
			//-----------------------------------------------------------------------

			//trace('Max distanceX:' + maxDistanceX);
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
			
			//-----------------------------------------------------------------------
			
			i++;
		}
	}
	
	private function _calcColumnsPositionsX() {
		var positionX = 0.0;
		for (column in this.columns) {
			positionX += column.distanceX;
			column.positionX = positionX;			
		}
	}	
	
	
	
	private function _calcColumnsWidthX() {
		
		var firstColumn = this.columns.first();
		var firstMinX = 0.0;
		for (complex in firstColumn.complexes) {
			firstMinX = Math.min(firstMinX, complex.rectFull.x);
		}
		
		var columnsW = this.columns.last().positionX;
		
		var lastColumn = this.columns.last();
		var lastMaxW = 0.0;
		for (complex in lastColumn.complexes) {
			if (complex != null) {
				lastMaxW = Math.max(lastMaxW, complex.rectFull.x + complex.rectFull.width);				
			}
		}		
		
		this.columnsRectAll = new Rectangle(firstMinX, 0, -firstMinX + columnsW + lastMaxW, 0);
	}	
	
	
}


typedef TPosComplex = {
	position: Int,
	rectsAll: Array<Array<Rectangle>>,	
	rectsHeadW:Array<Float>,
}