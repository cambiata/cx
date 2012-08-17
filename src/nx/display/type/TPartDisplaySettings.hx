package nx.display.type;
import nx.enums.EClef;
import nx.enums.EKey;
import nx.enums.EPartType;

/**
 * ...
 * @author Jonas Nyström
 */

typedef TPartDisplaySettings = {	
	dType		:EPartType,
	dKey			:EKey,
	dClef			:EClef,
	dLabel		:Null<String>,
}