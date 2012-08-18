package nx.layout;
import nme.ObjectHash;
import nx.display.DBar;
import nx.display.type.TBarDisplaySettings;
/**
 * ...
 * @author Jonas Nyström
 */

class LayoutBase 
{

	/*
	public function new() {
	}
	*/
	
	private var currentSettings:TBarDisplaySettings;
	private function updateSettings(settings:TBarDisplaySettings) {
		if (currentSettings == null) {
			this.currentSettings = settings;
		}
		
		if (settings.dAckolade != null) 		this.currentSettings.dAckolade = settings.dAckolade;
		if (settings.dBarline != null) 		this.currentSettings.dBarline = settings.dBarline;
		if (settings.dBarlineLeft != null) 	this.currentSettings.dBarlineLeft = settings.dBarlineLeft;
		if (settings.dIndentLeft != 0.0) 	this.currentSettings.dIndentLeft = settings.dIndentLeft;
		if (settings.dIndentRight != 0.0) 	this.currentSettings.dIndentRight = settings.dIndentRight;
		if (settings.dTime != null) 			this.currentSettings.dTime = settings.dTime;
		
		
		for (i in 0...settings.partsDisplaySettings.length) {
			var partSettings = settings.partsDisplaySettings[i];			
			if (i < this.currentSettings.partsDisplaySettings.length) {
				if (partSettings.dClef != null) 	this.currentSettings.partsDisplaySettings[i].dClef = partSettings.dClef;
				if (partSettings.dKey != null) 	this.currentSettings.partsDisplaySettings[i].dKey = partSettings.dKey;
				if (partSettings.dLabel != null) 	this.currentSettings.partsDisplaySettings[i].dLabel = partSettings.dLabel;
				if (partSettings.dType != null) 	this.currentSettings.partsDisplaySettings[i].dType = partSettings.dType;
			}
		}
		
	}	

	
}