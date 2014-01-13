package nx3.elements;
import nx3.elements.NHead;
import nx3.units.Level;

/**
 * ...
 * @author Jonas Nyström
 */
enum ENoteType {
	Note(heads:Array<NHead>, ?variant:ENotationVariant, ?articulations: Array<ENoteArticulation>, ?attributes:Array<ENoteAttributes>);
	Pause(level:Level); 
	BarPause;
	Tpl;
	Lyric(text:String, ?offset:EPosition, ?continuation:ELyricContinuation, ?format:ELyricFormat);
	Chord;
	Dynam;
}