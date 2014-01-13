package nx3.elements;

/**
 * ...
 * @author Jonas Nyström
 */
enum ENotationVariant
{
	Normal;
	Rythmic;
	RythmicSingleLevel(level:Int);
	HeadsOnly;
	StavesOnly;
}