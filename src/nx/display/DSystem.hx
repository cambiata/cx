package nx.display;

import nme.geom.Rectangle;
import nme.ObjectHash;
import nx.display.type.TBarDisplaySettings;
import nx.enums.ETime;
/**
 * ...
 * @author Jonas Nyström
 */
using cx.ArrayTools;
class DSystem 
{
	
	public var dbars(default, null)					: DBars;
	public var settings(default, null)				: Array<TBarDisplaySettings>;
	public var isFirst(default, null)					: Bool;

	//public var dbarSettings(default, null)			: ObjectHash<DBar, TBarDisplaySettings>;
	//public var dbarWidth(default, null)				: Array<Float>;
	public var dbarsWidth(get_dbarsWidth, null): Float;
	
	private var systemBreakWidth:Float = 250;
	
	public function new(isFirst:Bool=false) {		
		this.isFirst = isFirst;
		this.dbars = [];
		this.settings = [];
		//this.dbarWidth = [];
	
		//this.dbarSettings = new ObjectHash<DBar, TBarDisplaySettings>();
	}
	
	public function tryAddingDBar(dbar:DBar, newbarSettings:TBarDisplaySettings, prevbarSettings:TBarDisplaySettings=null):Bool {						
		var settings = this.checkSettings(this.currentSettings, newbarSettings, prevbarSettings);		
		dbar.setDisplaySettings(settings);
		
		var dbarWidth:Float = dbar.getTotalWidthAlloted().totalWidth;
		
		if (this.dbarsWidth + dbarWidth > systemBreakWidth) {
			// system must accept at least one bar!
			if (this.dbars.length > 0) {
				//trace('bar is rejected!');
				return false;
			}
		}

		this.dbars.push(dbar);
		this.currentSettings = settings;
		
		/// Should this be here..? 
		this.calcDbarsTopPositionX();
		
		return true;
	}

	private var currentSettings:TBarDisplaySettings;	
	private function checkSettings(currentbarSettings: TBarDisplaySettings, newbarSettings:TBarDisplaySettings, prevbarSettings:TBarDisplaySettings=null) {
		
		if (this.dbars.length == 0) {
			
			if (prevbarSettings == null) {
				//trace ('The very first bar, show Clef, Key, Time');
				currentbarSettings = newbarSettings;
			} else {
				//trace ('The first bar on system, show Clef, Key');
				trace(newbarSettings);
				
				currentbarSettings = newbarSettings;
				
				// Göm time bara om det inte skiljer sig från föregående takt
				if (newbarSettings.dTime == prevbarSettings.dTime) {
					//trace('this should hide time');
					currentbarSettings.dTime = null;
				}
				
			}
			
		} else {
			//trace ('Cont bars on system, hide clef, key, time...');

			if (newbarSettings.dTime == prevbarSettings.dTime) currentbarSettings.dTime = null;
			if (newbarSettings.dAckolade == prevbarSettings.dAckolade) currentbarSettings.dAckolade = null;
			
			
			
			for (i in 0...newbarSettings.partsDisplaySettings.length) {
				
				if ((i < prevbarSettings.partsDisplaySettings.length) && (i < currentbarSettings.partsDisplaySettings.length)){					
					// Hide clefs for cont bars
					if (newbarSettings.partsDisplaySettings[i].dClef == prevbarSettings.partsDisplaySettings[i].dClef)  {
						currentbarSettings.partsDisplaySettings[i].dClef = null;
					}
					
					// Hide keys for cont bars
					if (newbarSettings.partsDisplaySettings[i].dKey == prevbarSettings.partsDisplaySettings[i].dKey)  {
						currentbarSettings.partsDisplaySettings[i].dKey = null;
					}									
					
					// Hide labels for cont bars
					if (newbarSettings.partsDisplaySettings[i].dLabel == prevbarSettings.partsDisplaySettings[i].dLabel)  {
						currentbarSettings.partsDisplaySettings[i].dLabel = null;
					}								
					
				}
			}				
		}
		return currentbarSettings;
	}
	
	private function get_dbarsWidth(): Float {
		var ret = 0.0;
		for (dbar in this.dbars) 
			ret += dbar.getTotalWidthAlloted().totalWidth;
		return ret;
	}

	private var _dbarsPostionXAlloted:Array<Float>;
	public var dbarsPostionXAlloted(get_dbarsPostionXAlloted, null):Array<Float>;
	

	private function get_dbarsPostionXAlloted():Array<Float> 
	{
		if (this._dbarsPostionXAlloted != null) return this._dbarsPostionXAlloted;
		
		this._dbarsPostionXAlloted = [];
		
		var x = 0.0;
		
		for (dbar in this.dbars) {
			var dbarWidth = dbar.getTotalWidthAlloted().totalWidth;
			this._dbarsPostionXAlloted.push(x);			
			x += dbarWidth;
		}
		
		return _dbarsPostionXAlloted;
	}
	
	public function getDbarPositionXAlloted(dbar:DBar) :Float {
		var idx = this.dbars.index(dbar);
		var positionX = this.dbarsPostionXAlloted[idx];
		return positionX;		
	}
	
	
	public function calcDbarsTopPositionX() {
		var systemPartsRect:Array<Rectangle> = [];
		
		for (i in 0...dbars.first().dparts.length) systemPartsRect.push(new Rectangle(0, 0, 10, 0));
		
		for (dbar in dbars) {
			for (dpart in dbar.dparts) {
				var pidx = dbar.dparts.index(dpart);
				systemPartsRect[pidx] = systemPartsRect[pidx].union(dpart.rectDPartHeight);
			}
		}
		
		for (dbar in dbars) {			
			for (dpart in dbar.dparts) {		
				var pidx = dbar.dparts.index(dpart);
				dpart.setRectDPartHeight(systemPartsRect[pidx]);
			}
		}
	}

	
}