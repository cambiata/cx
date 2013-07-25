package nx3.elements;

import nx3.units.NRect;

/**
 * ...
 * @author 
 */
class DLyric implements IDNoteRects
{
	public var text(default, null):String;
	public var offset(default, null):EPosition;
	public var continuation(default, null):ELyricContinuation;
	public var format(default, null):ELyricFormat;

	public function new(note:Note) 
	{
		switch(note.type)
		{
			case ENoteType.Lyric(text, offset, continuation, format):
				this.text = text;
				this.offset = offset;
				this.continuation = continuation;
				this.format = format;
			default:
				throw 'DNote should have type ENoteType.Lyric, but has ${note.type}';
		}				
	}

	public var rectsFront(get, null):Array<NRect>;
	public var rectsBack(get, null):Array<NRect>;
	
	function get_rectsFront():Array<NRect> 
	{
		return null;
	}
	
	function get_rectsBack():Array<NRect> 
	{
		return null;
	}
	
}