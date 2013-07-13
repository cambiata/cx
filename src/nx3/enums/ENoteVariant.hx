package nx3.enums;

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