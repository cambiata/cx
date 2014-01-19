package nx3.dci;
import cx.ArrayTools;
import dci.Context;
import haxe.ds.IntMap.IntMap;
import nx3.elements.DPart;
import nx3.elements.DComplex;

import nx3.Constants;
import nx3.elements.DBar;
import nx3.elements.DColumn;
import nx3.elements.EAllotment;

class CalculateColumns implements Context
{
	
	public function execute()
	{
		this.bar.createPartComplexes();
	}	
	
	
	@role var bar = {
		var roleInterface: DBar;

		function createPartComplexes()
		{
			for (dpart in self.dparts)
			{
				new CalculateComplexes(dpart);
			}
			
			this.bar.createColumns();
		}
		
		function createColumns()
		{
			
			var positions = new IntMap<Array<DComplex>>();
			
			for (dpart in self.dparts)
			{
				for (dcomplex in dpart.dcomplexes)
				{
					var pos = dcomplex.position;
					if (!positions.exists(pos)) positions.set(pos, []);
					positions.get(pos).push(dcomplex);
				}	
			}
			
			for (position in positions.keys())
			{
				var column = new DColumn(0);
				column.complexes = positions.get(position);
				this.columns.push(column);
			}
			
			this.columns.calculateDistances();
			
		}
		
		function minComplexDistance(part:DPart, positionL:Int, positionR:Int):Float
		{
			var partComplexes = self.partComplexes(part);
			if (partComplexes.exists(positionL) && partComplexes.exists(positionR))
			{
				
				return 123.456;
			}
			return 0;
		}
		
		function partComplexes(part:DPart): IntMap<DComplex>
		{
			var result = new IntMap<DComplex>();
			for (complex in part.dcomplexes)
			{
				result.set(complex.position, complex);
			}
			return result;
		}
		
		
		
	}
	
	
	@role var columns = {
		var roleInterface: Array<DColumn>;

		function calculateAllotedValues()
		{
			for (column in self) column.allotedValue = Std.int(Constants.BASE_NOTE_VALUE * allotator.delta(column.value));
			
		}
	
		function next(column:DColumn):Null<DColumn>
		{
			
			var idx = Lambda.indexOf(self, column);
			return (idx < self.length) ? self[idx + 1] : null;
			
		}
		
		function calculateDistances():Void
		{
			for (column in self)
			{
				var nextColumn = self.next(column);
				if (nextColumn == null) break;
			
				var positionL = column.position;
				var positionR = nextColumn.position;
				
				var minDistance = .0;
				for (dpart in this.bar.dparts)
				{
					var distance = this.bar.minComplexDistance(dpart, positionL, positionR);
					minDistance = Math.max(distance, minDistance);
				}
				
				// NOTE! set distance value on LEFT column...
				column.distance = minDistance;
				
			}
			
		}
		
	}
	
	@role var allotator = {
		var roleInterface: Allotator;
	}

	public function new(dbar:DBar, allotator:Allotator=null)
	{
		this.bar = dbar;
		this.columns = dbar.columns;
		this.allotator = allotator == null ? new Allotator(EAllotment.Logaritmic) : allotator;
	}
	
	
	
}