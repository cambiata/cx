package nx3.elements.tools;
import nx3.elements.ENoteValue;
import nx3.elements.NHead;
import nx3.elements.EDirectionUD;
import nx3.elements.EHeadType;
import nx3.elements.EHeadValuetype;
import nx3.units.Level;
import nx3.units.NRect;
import nx3.units.NY;

/**
 * ...
 * @author 
 */
class HeadTool
{
	static public function getHeadRect(head:NHead, value:ENoteValue)
	//valuetype:EHeadValuetype, headtype:EHeadType, level:Level)
	{
		var rect:NRect = null;
		switch(value.head)
		{
			case EHeadValuetype.HVT1:
				rect =  new NRect( -2, -1, 4, 2);
			case EHeadValuetype.HVT2, EHeadValuetype.HVT4:
				rect = new NRect( -1.6, -1, 3.2, 2);			
		}	
		rect.offset(0, NY.fromInt(head.level));		
		//trace(rect);
		return rect;
	}
	
	static public function getDirection(heads:Array<NHead>):EDirectionUD
	{
		return null;
	}
	
}