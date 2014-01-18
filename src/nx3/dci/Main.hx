package nx3.dci;

import neko.Lib;
import nx3.elements.BItem;
import nx3.elements.DNote;
import nx3.elements.ENoteValue;
import dci.Context;
import nx3.elements.NBar;
import nx3.test.QNote;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{
	
	static function main() 
	{
		
		var nbar = new NBar(null);
		new GenerateDBar(nbar);
		
		new CalculateBeamgroups( { valuePattern: [ENoteValue.Nv4] }, [
			new DNote(new QNote2()), 
			new DNote(new QNote()),
			new DNote(new QNote()),
			new DNote(new QNote8()),
			new DNote(new QNote8()),
		]).execute();
	}
	
}


/*
class CalculateBeamgroups implements Context
{
	public function execute()
	{
		this.processor.adjustPatternLength();
	}
	
	@role var processor = 
	{
		var roleInterface: 
		{
			var valuePattern:Array<ENoteValue>;
		}
		
		function adjustPatternLength():Void
		{
			var sumValue =  this.notes.sumValue();
			var sumPattern = 0;
			for (val in self.valuePattern) sumPattern += val.value;
			
			while (sumPattern < sumValue) 
			{
				self.valuePattern = self.valuePattern.concat(self.valuePattern);
				sumPattern *= 2;
			}
		}
	}
	
	@role var notes = 
	{
		var roleInterface: Array<DNote>;
		
		function sumValue():Int {
			var sum = 0;
			for (note in self) sum += note.value.value;
			return sum;
		}
	}
	
	public function new (processor, notes)
	{
		this.processor = processor;
		this.notes = notes;
	}
	
}
*/