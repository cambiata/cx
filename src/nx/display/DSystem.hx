package nx.display;

import nme.geom.Rectangle;
import nme.ObjectHash;
import nx.display.type.TBarDisplaySettings;
import nx.display.type.TDBarSystemMeasurments;
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
	public var width(default, null) 					: Float;
	public var stretch(default, set_stretch)		: Bool;
	
	//private var systemBreakWidth:Float = 250;
	
	public function new(width:Float, stretch:Bool = false) {				
		this.width = width;
		this.stretch = stretch;
		this.dbars = [];
		this.settings = [];
	}
	
	public function checkAddingDBar(dbar:DBar, newbarSettings:TBarDisplaySettings, prevbarSettings:TBarDisplaySettings=null):TCheckReturn {						
		var settings = this.checkSettings(this.currentSettings, newbarSettings, prevbarSettings);		
		dbar.setDisplaySettings(settings);
		//dbar._calcColumnsRects();
		
		var dbarWidth:Float = dbar.getTotalWidthAlloted().totalWidth;
		
		if (this.dbarsWidthAlloted + dbarWidth > this.width) {
			// system must accept at least one bar!
			if (this.dbars.length > 0) {
				//trace('bar is rejected!');
				return {settings:null, success:false};
			}
		}
		return {settings:settings, success:true};
	}
	
	public function tryAddingDBar(dbar:DBar, newbarSettings:TBarDisplaySettings, prevbarSettings:TBarDisplaySettings=null):Bool {						

		/*
		var settings = this.checkSettings(this.currentSettings, newbarSettings, prevbarSettings);		
		dbar.setDisplaySettings(settings);
		
		var dbarWidth:Float = dbar.getTotalWidthAlloted().totalWidth;
		
		if (this.dbarsWidthAlloted + dbarWidth > systemBreakWidth) {
			// system must accept at least one bar!
			if (this.dbars.length > 0) {
				//trace('bar is rejected!');
				return false;
			}
		}
		*/
		
		var check:TCheckReturn = this.checkAddingDBar(dbar, newbarSettings, prevbarSettings);
		if (!check.success) return false;
		

		this.dbars.push(dbar);
		this.currentSettings = check.settings;
		
		/// Should this be here..? 
		this.calcDbarsTopPositionX();
		
		return true;
	}

	
	//-----------------------------------------------------------------------------------------------------
	
	
	private var currentSettings:TBarDisplaySettings;	
	private function checkSettings(currentbarSettings: TBarDisplaySettings, newbarSettings:TBarDisplaySettings, prevbarSettings:TBarDisplaySettings=null) {
		if (this.dbars.length == 0) {
			if (prevbarSettings == null) {
				//trace ('The very first bar, show Clef, Key, Time');
				currentbarSettings = newbarSettings;
			} else {
				//trace ('The first bar on system, show Clef, Key');
				//trace(newbarSettings);
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
	
	//-----------------------------------------------------------------------------------------------------
	// alloted:
	
	private var _dbarsWidthAlloted:Null<Float>;
	public var dbarsWidthAlloted(get_dbarsWidthAlloted, null):Float;
	private function get_dbarsWidthAlloted(): Float {
		if (this._dbarsWidthAlloted != null) return this._dbarsWidthAlloted;
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
	
	//-----------------------------------------------------------------------------------------------------
	// stretched:

	private var _dbarsPositionXStrecthed:Array<Float>;
	public var dbarsPositionXStrecthed(get_dbarsPositionXStrecthed, null):Array<Float>;
	private function get_dbarsPositionXStrecthed():Array<Float> {
		if (this._dbarsPositionXStrecthed != null) return this._dbarsPositionXStrecthed;
		this._dbarsPositionXStrecthed = [];
		//this._dbarWidthStretched = new ObjectHash<DBar, Float>();
		
		var distributeWidth = this.width - this.dbarsWidthAlloted;
		
		// Calc sum value...
		var dbarsSumWeight:Float = 0.0;
		for (dbar in this.dbars) {
			dbarsSumWeight += dbar.getTotalWidthAlloted().columnsWidth;
		}
		
		//trace('');
		var sumBarWidth = 0.0;
		var barIdx = 0;
		for (dbar in this.dbars) {
			//trace('BAR ' + barIdx  + ' -----------------------------------------------');
			
			var barWeigthFactor = dbar.getTotalWidthAlloted().columnsWidth / dbarsSumWeight;
			var barAddWidth = barWeigthFactor * distributeWidth;
			var barAllotedWidth = dbar.getTotalWidthAlloted().totalWidth;			
			var barContentWidth = dbar.getTotalWidthAlloted().columnsWidth;
			
			var barStretchToWidth = barAllotedWidth + barAddWidth;			
			this._dbarWidthStretched.set(dbar, barStretchToWidth);
			var barStretchContentToWidth = barContentWidth + barAddWidth;
			
			this._dbarsPositionXStrecthed[barIdx++] = sumBarWidth;
			sumBarWidth += barStretchToWidth;
		}
		
		return _dbarsPositionXStrecthed;
	}
	
	public function getDbarPositionXStretched(dbar:DBar) :Float {
		var idx = this.dbars.index(dbar);
		var positionX = this._dbarsPositionXStrecthed[idx];
		return positionX;		
	}		
	
	private var _dbarWidthStretched:ObjectHash<DBar, Float>;
	public function getDbarStretchedWidth(dbar:DBar) : Float {
		// invoke!
		if (_dbarWidthStretched != null) return this._dbarWidthStretched.get(dbar);
		
		this._dbarWidthStretched = new ObjectHash<DBar, Float>();
		this.dbarsPositionXStrecthed;
		return this._dbarWidthStretched.get(dbar);
	}
	
	
	//-----------------------------------------------------------------------------------------------------

	private function set_stretch(val:Bool):Bool {
		this._dbarMeasurments = null;		
		return this.stretch = val;		
	}
	
	//-----------------------------------------------------------------------------------------------------
	
	private var _dbarMeasurments:nme.ObjectHash<DBar, TDBarSystemMeasurments>;
	public function getDbarMeasurments(dbar:DBar):TDBarSystemMeasurments {
		if (this._dbarMeasurments != null) return this._dbarMeasurments.get(dbar);		
		
		///trace('CALC DBAR MEASURMENTS');
		///trace('STRETCH:' + this.stretch);
		
		this._dbarMeasurments = new ObjectHash<DBar, TDBarSystemMeasurments>();
		this.calcDbarsTopPositionX();
		
		for (dbar in this.dbars) {
			var meas:TDBarSystemMeasurments = { x:0, width:0, stretch:false };
			meas.width = 	(this.stretch) ?		this.getDbarStretchedWidth(dbar) : 		dbar.getTotalWidthAlloted().totalWidth;		
			meas.x = 			(this.stretch) ?		this.getDbarPositionXStretched(dbar) :	this.getDbarPositionXAlloted(dbar);
			//meas.y = 12345;
			this._dbarMeasurments.set(dbar, meas);
		}
		
		return this._dbarMeasurments.get(dbar);
	}
	
	//-----------------------------------------------------------------------------------------------------
	 
	
	/// CHANGE THIS LOGIC that sets the top position values TO THE DBAR instead of keeping them in a system property
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


typedef TCheckReturn = {
	settings:TBarDisplaySettings,
	success:Bool,
}

