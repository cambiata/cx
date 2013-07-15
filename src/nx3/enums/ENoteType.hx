package nx3.enums;
import nx3.elements.Head;
import nx3.units.Level;

/**
 * ...
 * @author Jonas Nyström
 */
enum ENoteType {
	Note(heads:Array<Head>, ?variant:ENoteVariant, ?articulations: Array<ENoteArticulation>, ?attributes:Array<ENoteAttributes>);
	Pause(level:Level); 
	BarPause;
	Tpl;
	Lyric(text:String, ?offset:EPosition, ?continuation:ELyricContinuation, ?format:ELyricFormat);
	Chord;
	Dynam;
}