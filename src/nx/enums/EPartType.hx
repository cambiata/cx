package nx.enums;

/**
 * ...
 * @author Jonas Nyström
 */

enum EPartType 
{
	Normal;
	Lyrics;
	Tpl;
	Tplchain;
	Dynamics;
	Chords;
}

class EPartTypeDistances {
	static public function getMinDistance(type:EPartType) {
		switch(type) {
			case EPartType.Lyrics: return 4;
			default: return 14;
		}
		return 0;
	}
}