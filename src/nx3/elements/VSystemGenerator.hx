package nx3.elements;
import cx.EncodeTools;
import cx.EnumTools;
import nx3.elements.VSystemGenerator.IBarWidthCalculator;
import nx3.elements.VSystemGenerator.Pagesize;
import nx3.elements.VSystemGenerator.SimpleBarWidthCalculator;
import nx3.elements.VTree;
using cx.ArrayTools;

/**
 * ...
 * @author Jonas Nyström
 */

 typedef Pagesize = { width:Float, height:Float };
 
class VSystemGenerator
{
	static public var defaultClef:EClef = EClef.ClefF;
	static public var defaultKey:EKey = EKey.Flat2;
	static public var defaultTime:ETime = ETime.Time6_4;
	
	var bars:VBars;
	var systemConfig:VSystemConfig;
	var prevBarAttributes:VBarAttributes;
	var pagesize:Pagesize;
	var system:VSystem;
	var barWidthCalculator:IBarWidthCalculator;

	public function new(bars:VBars, systemConfig:VSystemConfig, prevBarAttributes:VBarAttributes, pagesize:Pagesize, barWidthCalculator:IBarWidthCalculator=null) 
	{
		this.bars = bars;
		this.systemConfig = systemConfig;
		this.prevBarAttributes = prevBarAttributes;
		this.pagesize = pagesize;
		this.system = new VSystem();
		this.barWidthCalculator = (barWidthCalculator != null) ? barWidthCalculator : new SimpleBarWidthCalculator();
	}
	
	public function getSystem():VSystem
	{
		var tryAnotherBar = true;
		
		while (tryAnotherBar)
		{
			var currentBar:VBar = this.bars.first();
			var currentBarConfig:VBarConfig = new VBarConfig();
			var currentBarAttributes:VBarAttributes = getBarAttributes(currentBar);
			
			if (this.prevBarAttributes != null) 
				this.overrideActualAttributesFromPrevBarAttributes(currentBarAttributes, currentBar, this.prevBarAttributes);			
			
			this.overrideActualAttributesWithDefaultsIfStillNotSet(currentBarAttributes);
			
			// Set config display data...
			if (this.system.bars.length == 0)
			{
				this.adaptBarConfig(currentBar, currentBarConfig, this.prevBarAttributes, this.systemConfig.showFirstClef, this.systemConfig.showFirstKey, this.systemConfig.showFirstTime);
			}
			else
			{
				this.adaptBarConfig(currentBar, currentBarConfig, this.prevBarAttributes, this.systemConfig.showFollowingClef, this.systemConfig.showFollowingKey, this.systemConfig.showFollowingTime);
			}
			
			var currentBarWidth = getBarWidth(currentBar, currentBarAttributes, currentBarConfig);
			
			var testSystemWidth = this.system.width + currentBarWidth;
			if (testSystemWidth > this.pagesize.width) 
			{
				this.takeCareOfLastBarCautions();
				return this.system;
			}
			
			this.system.width += currentBarWidth;
			this.system.bars.push({bar:currentBar, barConfig:currentBarConfig, width:currentBarWidth, actAttributes:currentBarAttributes, caAttributes:null});
			this.bars.shift();
			
			this.prevBarAttributes =  this.copyBarAttributes(currentBarAttributes);
			if (this.bars.length < 1) tryAnotherBar = false;
		}
		
		this.system.status = VSystemStatus.Ok;		
		return this.system;
		
	}
	
	function takeCareOfLastBarCautions() 
	{
		
		this.system.status = VSystemStatus.Ok;
		var sysBar:VBar = this.system.bars.last().bar;
		var sysBarAttributes:VBarAttributes = this.system.bars.last().actAttributes; // getBarAttributes(sysBar);
		
		if (sysBar != this.bars.last()) 
		{
			var nextBar:VBar = this.bars.first();
			var nextBarAttributes:VBarAttributes = getBarAttributes(nextBar);
			
			var newClef:Bool = arrayBNullOrDiffers(sysBarAttributes.clefs, nextBarAttributes.clefs);
			var newKey:Bool = arrayBNullOrDiffers(sysBarAttributes.keys, nextBarAttributes.keys);
			var newTime:Bool = nullOrDiffers(sysBarAttributes.time, nextBarAttributes.time);
			
			if (newClef || newKey || newTime)
			{
				//var cautAttributes:VBarAttributes = removeRedundantAttributes(sysBarAttributes, nextBarAttributes);
				var sysBarCautAttributes:VBarAttributes = copyAndRemoveRedundantAttributes(sysBarAttributes, nextBarAttributes);
				var sysBarConfig = this.system.bars.last().barConfig;
				var sysBarWidth = this.system.bars.last().width;
				
				var systemWidthWithoutLastBar = system.width - sysBarWidth;
				
				var sysBarConfigWithCautions = new VBarConfig(sysBarConfig.showClef, sysBarConfig.showKey, sysBarConfig.showTime);
				if (newClef) sysBarConfigWithCautions.showCautClef = true;
				if (newKey) sysBarConfigWithCautions.showCautKey = true;
				if (newTime) sysBarConfigWithCautions.showCautTime = true;
				
				var sysBarWidthWithCautions = getBarWidth(sysBar, sysBarAttributes, sysBarConfigWithCautions, sysBarCautAttributes);
				
				if (systemWidthWithoutLastBar + sysBarWidthWithCautions <= this.pagesize.width)
				{
					this.system.bars.last().caAttributes = sysBarCautAttributes;
					this.system.bars.last().barConfig = sysBarConfigWithCautions;
					this.system.bars.last().width = sysBarWidthWithCautions;
					this.system.width = this.system.width - sysBarWidth + sysBarWidthWithCautions;
				}
				else
				{
					this.system.status = VSystemStatus.Problem(101, 'Last bar fits without caution attributes but not with them');
					if (this.system.bars.length == 1)
					{
						this.system.status = VSystemStatus.Problem(102, 'First bar doesn\'t fit when adding required cational attributes');
						return;
					}
					
					// remove last bar of current system...
					this.system.bars.pop();
					// ...and put it back on the feeding bars array top
					this.bars.unshift(sysBar);
					this.system.width = this.system.width - sysBarWidth;
					this.system.status = VSystemStatus.Ok;
				}
			}
		}		
	}
	
	function copyAndRemoveRedundantAttributes(sysBarAttributes:VBarAttributes, nextBarAttributes:VBarAttributes) 
	{
		var result:VBarAttributes = copyBarAttributes(nextBarAttributes);
		for (i in 0...sysBarAttributes.clefs.length) if (result.clefs[i] == sysBarAttributes.clefs[i]) result.clefs[i] = null;
		for (i in 0...sysBarAttributes.keys.length) if (result.keys[i] == sysBarAttributes.keys[i]) result.keys[i] = null;
		if (result.time == sysBarAttributes.time) result.time = null;
		return result;
	}
	
	function adaptBarConfig(bar:VBar, barConfig:VBarConfig, prevBarAttributes:VBarAttributes, showClef:Bool, showKey:Bool, showTime:Bool) 
	{
		//showClef = (showClef == null) ? false : showClef;
		//showKey = (showKey == null) ? false : showKey;
		//showTime = (showTime == null) ? false : showTime;
		var barAttributes:VBarAttributes = getBarAttributes(bar);
		
		switch bar.displayClefs
		{
			case EDisplayALN.Never: barConfig.showClef = false;
			case EDisplayALN.Always: barConfig.showClef = true;
		default:
			//barConfig.showClef = false;
			barConfig.showClef = showClef;	
			if (showClef == false && prevBarAttributes != null)
			{
				for (i in 0...prevBarAttributes.clefs.length)
				{
					if (bar.clefs[i] == null) continue;
					if (bar.clefs[i] == prevBarAttributes.clefs[i]) continue;
					barConfig.showClef = true;
					break;
				}
			}
		}
		
		switch bar.displayKeys
		{
			case EDisplayALN.Never: barConfig.showKey = false;
			case EDisplayALN.Always: barConfig.showKey = true;
		default:
			//barConfig.showKey = false;
			barConfig.showKey = showKey;		
			if (showKey == false && prevBarAttributes != null)
			{
				for (i in 0...prevBarAttributes.keys.length)
				{
					if (bar.keys[i] == null) continue;
					if (bar.keys[i] == prevBarAttributes.keys[i]) continue;
					barConfig.showKey = true;
					break;
				}
			}
		}		
		
		switch bar.displayTime
		{
			case EDisplayALN.Never: barConfig.showTime = false;
			case EDisplayALN.Always: barConfig.showTime = true;
		default:
			barConfig.showTime = showTime;		
			if (showTime == false && prevBarAttributes != null)
			{
				if (bar.time == null) 
				{
				}
				else  if (bar.time == prevBarAttributes.time)
				{
				}
				else
					barConfig.showTime = true;
			}
		}				
	}
	
	function getBarWidth(bar:VBar, barAttributes:VBarAttributes, barConfig:VBarConfig, cautAttributes:VBarAttributes=null) : Float
	{
		var width = 0.0;

		var clefsWidth = 0.0;
		if (barConfig.showClef)
		{
			
			for (clef in barAttributes.clefs) clefsWidth = Math.max(clefsWidth, this.barWidthCalculator.getClefWidth(clef));			
		}
		width += clefsWidth;
		//trace(width);
		
		var keysWidth = 0.0;
		if (barConfig.showKey)
		{
			for (key in barAttributes.keys) keysWidth = Math.max(keysWidth, this.barWidthCalculator.getKeyWidth(key));			
		}
		width += keysWidth;
		//trace(width);
		
		var timeWidth = 0.0;
		if (barConfig.showTime) timeWidth += this.barWidthCalculator.getTimeWidth(barAttributes.time);		
		width += timeWidth;
		//trace(width);		
		
		//------------------------------------------------------------------------------------------
		//trace(bar.getValue());
		var contentWidth:Float = this.barWidthCalculator.getContentWidth(bar);
		width += contentWidth;
		//trace(width);
		
		//-------------------------------------------------------------------------------------------
		
		var clefsWidth = 0.0;
		if (barConfig.showCautClef && cautAttributes != null)
		{
			for (clef in cautAttributes.clefs) clefsWidth = Math.max(clefsWidth, this.barWidthCalculator.getClefWidth(clef));			
		}
		width += clefsWidth;
		//trace(width);
		
		var keysWidth = 0.0;
		if (barConfig.showCautKey && cautAttributes != null)
		{
			for (key in cautAttributes.keys) keysWidth = Math.max(keysWidth, this.barWidthCalculator.getKeyWidth(key));			
		}
		width += keysWidth;
		//trace(width);
		
		var timeWidth = 0.0;
		if (barConfig.showCautTime && cautAttributes != null) 
			timeWidth += this.barWidthCalculator.getTimeWidth(cautAttributes.time);		
		width += timeWidth;
		
		
		return width;
	}
	
	function copyBarAttributes(barAttributes:VBarAttributes) :VBarAttributes
	{
		var result = { clefs:new EClefs(), keys:new EKeys(), time: null };
		result.clefs = barAttributes.clefs.copy();
		result.keys = barAttributes.keys.copy();
		result.time = barAttributes.time;
		return result;
		//return { clefs:currentBarAttributes.clefs, keys:currentBarAttributes.keys, time:currentBarAttributes.time };
	}
	
	function overrideActualAttributesWithDefaultsIfStillNotSet(currentBarAttributes:VBarAttributes) 
	{
		for (i in 0...currentBarAttributes.clefs.length)
		{
			if (currentBarAttributes.clefs[i] == null) currentBarAttributes.clefs[i] = VSystemGenerator.defaultClef; // EClef.ClefC;
		}		
		for (i in 0...currentBarAttributes.keys.length)
		{
			if (currentBarAttributes.keys[i] == null) currentBarAttributes.keys[i] = VSystemGenerator.defaultKey;
		}				
		if (currentBarAttributes.time == null) currentBarAttributes.time = VSystemGenerator.defaultTime;
	}
	
	function overrideActualAttributesFromPrevBarAttributes(currentBarAttributes:VBarAttributes, currentBar:VBar, prevBarAttributes:VBarAttributes) 
	{
		if (! compareBarAttributesValidity(currentBarAttributes, prevBarAttributes)) throw "Attributes non compatible";		
		for (i in 0...currentBar.clefs.length)
		{
			if (currentBar.clefs[i] == null && prevBarAttributes.clefs[i] != null) currentBarAttributes.clefs[i] = prevBarAttributes.clefs[i];
		}
		for (i in 0...currentBar.keys.length)
		{
			if (currentBar.keys[i] == null && prevBarAttributes.keys[i] != null) currentBarAttributes.keys[i] = prevBarAttributes.keys[i];
		}
		if (currentBar.time == null && prevBarAttributes.time != null) currentBarAttributes.time = prevBarAttributes.time;
	}
	
	function getBarAttributes(bar:VBar) :VBarAttributes
	{		
		// OBS Copying!
		var time = [bar.time].copy().first();		
		var result = { clefs:bar.clefs.copy(), keys:bar.keys.copy(), time:time };
		return result;
	}
	
	function compareBarAttributesValidity(barAttributesA:VBarAttributes, barAttributesB:VBarAttributes):Bool
	{		
		if (barAttributesA.clefs.length != barAttributesB.clefs.length) return false;
		if (barAttributesA.keys.length != barAttributesB.keys.length) return false;
		return true;
	}
	
	function arrayBNullOrDiffers<T>(itemA:Array<T>, itemB:Array<T>):Bool
	{		
		if (itemB.allNull()) return false;
		
		for (i in 0...itemA.length)
		{
			if (itemB[i] != null && (itemB[i] != itemA[i])) return true;
		}
		return false;
	}	

	function nullOrDiffers<T>(itemA:T, itemB:T):Bool
	{
		if (itemB == null) return false;
		return (itemB != itemA);
	}	
}

 interface IBarWidthCalculator
 {
	 function getClefWidth(clef:EClef):Float;
	 function getKeyWidth(key:EKey):Float;
	 function getTimeWidth(time:ETime):Float;
	 function getContentWidth(bar:VBar):Float;
 }
 
 class SimpleBarWidthCalculator implements IBarWidthCalculator
 {
	 public function new() { };
	 public function getClefWidth(clef:EClef):Float
	 {
		 if (clef == null) return 0;
		 return 20;		 
	 }
	 
	 public function getKeyWidth(key:EKey):Float
	 {
		 if (key == null) return 0;
		 return switch key
		 {
			case EKey.Sharp1, EKey.Flat1: 10;
			case EKey.Sharp2, EKey.Flat2: 20;
			case EKey.Sharp3, EKey.Flat3: 30;
			case EKey.Sharp4, EKey.Flat4: 40;
			case EKey.Sharp5, EKey.Flat5: 50;
			case EKey.Sharp6, EKey.Flat6: 60;
			 default: 0;
		 }		 
	 }
	 
	 public function getTimeWidth(time:ETime):Float
	 {
		if (time == null) return 0;
		 return 10;		 
	 }
	 
	 public function getContentWidth(bar:VBar):Float
	 {
		 return Std.int(bar.getValue() / 100);		
	 }
	 
 }
 