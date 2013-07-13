package nx3.enums;

/**
 * ...
 * @author Jonas Nyström
 */
enum ENoteType {
	Note(variant:ENoteVariant);
	Pause; 
	BarPause;
	Tpl;
	Lyric(text:String);
	Chord;
	Dynam;
}