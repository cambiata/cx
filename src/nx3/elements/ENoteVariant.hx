package nx3.elements;

/**
 * ...
 * @author Jonas Nyström
 */
enum ENoteVariant
{
	Normal;
	Rythmic;
	RythmicSingleLevel(level:Int);
	HeadsOnly;
	StavesOnly;
}