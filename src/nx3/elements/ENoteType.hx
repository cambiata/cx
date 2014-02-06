package nx3.elements;
import nx3.elements.NHead;

/**
 * ...
 * @author Jonas Nyström
 */
enum ENoteType {
	Note(heads:Array<NHead>, ?variant:ENotationVariant, ?articulations: Array<ENoteArticulation>, ?attributes:Array<ENoteAttributes>);
	Pause(level:ULevel); 
	BarPause;
	Tpl;
	Lyric(?text:String, ?offset:EPosition, ?continuation:ELyricContinuation, ?format:ELyricFormat);
	Chord;
	Dynam;
}