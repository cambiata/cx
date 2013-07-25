package nx3.elements;

import nx3.units.Level;

/**
 * ...
 * @author 
 */
class DPause extends IDNoteRects
{
	public var level(default, null):Level;

	public function new(note:Note) 
	{
		switch(note.type)
		{
			case ENoteType.Pause(level):
				this.level = level;
			default:
				throw 'DNote should have type ENoteType.Pause, but has ${note.type}';
		}		
	}
	
	public var rectsFront(get, null): Array<NRect>;
	public var rectsBack(get, null): Array<NRect>;

	private function get_rectsFront():Array<NRect>
	{
		return null;
	}
	
	private function get_rectsBack():Array<NRect>
	{
		return null;
	}			
	
	
}