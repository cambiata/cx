package nx3.test;
import cx.ArrayTools;
import nx3.elements.EDirectionUAD;
import nx3.elements.ENoteValue;
import nx3.elements.ESign;
import nx3.elements.NNote;
import nx3.elements.NVoice;

/**
 * ...
 * @author Jonas Nyström
 */
class QVoiceDown extends QVoice
 {
	 public function new(?notevalues:Array<Float>=null, ?notevalue:Float=null, ?headlevels:Array<Int> = null, ?levelrepeats:Int=null, ?signs:String = null)
	 {
		 super(notevalues, notevalue, headlevels, levelrepeats, signs, EDirectionUAD.Down);
	 }
 }
 
 class QVoiceUp extends QVoice
 {
	 public function new(?notevalues:Array<Float>=null, ?notevalue:Float=null, ?headlevels:Array<Int> = null, ?levelrepeats:Int=null, ?signs:String = null)
	 {
		 super(notevalues, notevalue, headlevels, levelrepeats, signs, EDirectionUAD.Up);
	 }
 }
 
class QVoice extends NVoice
{

	public function new(?notevalues:Array<Float>=null, ?notevalue:Float=null,  ?headlevels:Array<Int>=null, ?levelrepeats:Int=1, ?signs:String=null, ?direction:EDirectionUAD=null) 
	{
		if (notevalues == null) if (notevalue != null) notevalues = [notevalue];
		if (notevalues == null) notevalues = [4.0];
		
		var r = 1;
		var copy = headlevels.copy();
		while (r < levelrepeats) 
		{
			headlevels = headlevels.concat(copy); 
			r++;
		}
		while (headlevels.length > notevalues.length) notevalues = notevalues.concat(notevalues);
		
		var notes:Array<NNote> = [];
		if (signs == null) signs = '-';
		var asigns = signs.split('');
		while (headlevels.length > asigns.length) asigns = asigns.concat(asigns);
		
		var i = 0;
		for (level in headlevels)
		{
			var sign = getSign(asigns[i]);
			var head = new QHead(level, sign);
			var note = new QNote(head, getNotevalue(notevalues[i]));
			notes.push(note);
			i++;
		}

		super(notes, direction);
	}
	
	private function getSign(val:String)
	{
		switch (val)
		{
			case '#': return ESign.Sharp;
			case 'b': return ESign.Flat;
			case 'N', 'n': return ESign.Natural;
			default: return null;
		}
	}
	
	private function getNotevalue(val:Float)
	{
		switch(val)
		{
			case 16.0: return ENoteValue.Nv16;
			case .16: return ENoteValue.Nv16dot;
			case 8.0: return ENoteValue.Nv8;
			case .8: return ENoteValue.Nv8dot;
			case 4.0: return ENoteValue.Nv4;
			case .4: return ENoteValue.Nv4dot;
			case 2.0: return ENoteValue.Nv2;
			case .2: return ENoteValue.Nv2dot;
			case 1.0: return ENoteValue.Nv1;
			case .1: return ENoteValue.Nv1dot;
			default: throw 'Unknown notevalue: $val';
		}
		return ENoteValue.Nv4;
	}
	
}