package nx.display.type;
import nx.enums.EAckolade;
import nx.enums.EBarline;
import nx.enums.EBarlineLeft;
import nx.enums.ETime;

/**
 * ...
 * @author Jonas Nyström
 */

typedef TBarDisplaySettings = {
	dTime:				ETime,
	dBarline:			EBarline,
	dBarlineLeft:		EBarlineLeft,
	dAckolade:			EAckolade,
	dIndentLeft:		Null<Float>,
	dIndentRight:		Null<Float>,	
	
	partsDisplaySettings: Array<TPartDisplaySettings>,
	
}

class BarDisplayTools {
	
	static public function clone(settings:TBarDisplaySettings) {
		
		var partsSettings:Array<TPartDisplaySettings> = [];
		
		for (partSettings in settings.partsDisplaySettings) {
			var newPartSettings = {
				dType:		partSettings.dType,
				dKey:		partSettings.dKey,
				dClef:		partSettings.dClef,
				dLabel:		partSettings.dLabel,					
			}
			partsSettings.push(newPartSettings);
		}
		
		var clone:TBarDisplaySettings = {
			dTime:				settings.dTime,
			dBarline:			settings.dBarline,
			dBarlineLeft:		settings.dBarlineLeft,
			dAckolade:			settings.dAckolade,
			dIndentLeft:		settings.dIndentLeft,
			dIndentRight:		settings.dIndentRight,
			
			partsDisplaySettings: partsSettings,			
		}
		
		return clone;
		
		
	}
	
	
}