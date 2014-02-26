package nx3.elements;
import cx.EncodeTools;
import cx.EnumTools;
import nx3.dci.PopulateSystem.BarAttributes;
import nx3.elements.VSystemGenerator.Pagesize;
import nx3.elements.VTree;
using cx.ArrayTools;
/**
 * ...
 * @author Jonas Nyström
 */

 typedef Pagesize = { width:Float, height:Float };
 
class VSystemGenerator
{
	var bars:VBars;
	var systemConfig:VSystemConfig;
	var prevBarAttributes:VBarAttributes;
	var pagesize:Pagesize;
	var system:VSystem;

	public function new(bars:VBars, systemConfig:VSystemConfig, prevBarAttributes:VBarAttributes, pagesize:Pagesize) 
	{
		this.bars = bars;
		this.systemConfig = systemConfig;
		this.prevBarAttributes = prevBarAttributes;
		this.pagesize = pagesize;
		this.system = new VSystem();
		
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
				this.adaptCurrentBarConfigToFirstSystemBarConditions(currentBar, currentBarConfig, this.prevBarAttributes, this.systemConfig.showFirstClef, this.systemConfig.showFirstKey, this.systemConfig.showFirstTime);
			}
			else
			{
				this.adaptCurrentBarConfigToFirstSystemBarConditions(currentBar, currentBarConfig, this.prevBarAttributes, this.systemConfig.showFollowingClef, this.systemConfig.showFollowingKey, this.systemConfig.showFollowingTime);
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
		var sysBarAttributes:VBarAttributes = getBarAttributes(sysBar);
		if (sysBar != this.bars.last()) 
		{
			//trace('checkNextBar');
			var nextBar:VBar = this.bars.first();
			var nextBarAttributes:VBarAttributes = getBarAttributes(nextBar);
			
			var newClef:Bool = arrayNullOrDiffers(sysBar.clefs, nextBar.clefs);
			var newKey:Bool = arrayNullOrDiffers(sysBar.keys, nextBar.keys);
			var newTime:Bool = nullOrDiffers(sysBar.time, nextBar.time);
			
			
			if (newClef || newKey || newTime)
			{
				var sysBarConfig = this.system.bars.last().barConfig;
				var sysBarWidth = this.system.bars.last().width;
				
				var systemWidthWithoutLastBar = system.width - sysBarWidth;
				
				var sysBarConfigWithCautions = new VBarConfig(sysBarConfig.showClef, sysBarConfig.showKey, sysBarConfig.showTime);
				if (newClef) sysBarConfigWithCautions.showCautClef = true;
				if (newKey) sysBarConfigWithCautions.showCautKey = true;
				if (newTime) sysBarConfigWithCautions.showCautTime = true;
				
				var sysBarWidthWithCautions = getBarWidth(sysBar, sysBarAttributes, sysBarConfigWithCautions);
				
				if (systemWidthWithoutLastBar + sysBarWidthWithCautions <= this.pagesize.width)
				{
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
	

	
	function adaptCurrentBarConfigToFirstSystemBarConditions(bar:VBar, barConfig:VBarConfig, prevBarAttributes:VBarAttributes, showClef:Bool, showKey:Bool, showTime:Bool) 
	{
		var barAttributes:VBarAttributes = getBarAttributes(bar);
		
		switch bar.displayClefs
		{
			case EDisplayALN.Never: barConfig.showClef = false;
			case EDisplayALN.Always: barConfig.showClef = true;
		default:
			barConfig.showClef = false;
			barConfig.showClef = showClef;	
			if (bar.clefs.allNull()) barConfig.showClef = false;
			if (prevBarAttributes != null)
			{
				for (i in 0...prevBarAttributes.clefs.length)
				{
					if ((bar.clefs[i] == null && prevBarAttributes.clefs[i] != null))
					{					
						barConfig.showClef = true;
						break;
					}			
				}
			}			
		}
		
		switch bar.displayKeys
		{
			case EDisplayALN.Never: barConfig.showKey = false;
			case EDisplayALN.Always: barConfig.showKey = true;
		default:
			barConfig.showKey = false;
			barConfig.showKey = showKey;		
			if (bar.keys.allNull()) barConfig.showKey = false;
			if (prevBarAttributes != null)
			{
				for (i in 0...prevBarAttributes.keys.length)
				{
					if ((bar.keys[i] == null && prevBarAttributes.keys[i] != null))
					{					
						barConfig.showKey = true;
						break;
					}			
				}
			}			
		}		
		
		switch bar.displayTime
		{
			case EDisplayALN.Never: barConfig.showTime = false;
			case EDisplayALN.Always: barConfig.showTime = true;
		default:
			barConfig.showTime = false;
			barConfig.showTime = showTime;		
			if (bar.time == null) barConfig.showTime = false;
			if (prevBarAttributes != null)
			{
				 if ((bar.time == null && prevBarAttributes.time != null))
				{					
					barConfig.showTime = true;
				}
			}			
		}				
	}
	
	function adaptCurrentBarConfigToFollowingSystemBarConditions(bar:VBar, barConfig:VBarConfig, systemConfig:VSystemConfig, prevBarAttributes:VBarAttributes) 
	{

	}	
	
	function getBarWidth(bar:VBar, barAttributes:VBarAttributes, barConfig:VBarConfig) : Float
	{
		var width = 0.0;

		var clefsWidth = 0.0;
		if (barConfig.showClef)
		{
			for (clef in barAttributes.clefs) clefsWidth = Math.max(clefsWidth, AttributesTools.getClefWidth(clef));			
		}
		width += clefsWidth;
		//trace(width);
		
		var keysWidth = 0.0;
		if (barConfig.showKey)
		{
			for (key in barAttributes.keys) keysWidth = Math.max(keysWidth, AttributesTools.getKeyWidth(key));			
		}
		width += keysWidth;
		//trace(width);
		
		var timeWidth = 0.0;
		if (barConfig.showTime) timeWidth += AttributesTools.getTimeWidth(barAttributes.time);		
		width += timeWidth;
		//trace(width);		
		
		//------------------------------------------------------------------------------------------
		//trace(bar.getValue());
		var contentWidth:Float = AttributesTools.quickValueToWidth(bar.getValue());
		width += contentWidth;
		//trace(width);
		return width;
	}
	
	function copyBarAttributes(currentBarAttributes:VBarAttributes) :VBarAttributes
	{
		return { clefs:currentBarAttributes.clefs, keys:currentBarAttributes.keys, time:currentBarAttributes.time };
	}
	
	function overrideActualAttributesWithDefaultsIfStillNotSet(currentBarAttributes:VBarAttributes) 
	{
		for (i in 0...currentBarAttributes.clefs.length)
		{
			if (currentBarAttributes.clefs[i] == null) currentBarAttributes.clefs[i] = EClef.ClefC;
		}		
		for (i in 0...currentBarAttributes.keys.length)
		{
			if (currentBarAttributes.keys[i] == null) currentBarAttributes.keys[i] = EKey.Natural;
		}				
		if (currentBarAttributes.time == null) currentBarAttributes.time = ETime.Time3_4;
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
	
	function arrayNullOrDiffers<T>(itemA:Array<T>, itemB:Array<T>):Bool
	{		
		if (itemB.allNull()) return false;
		return (itemB.toString() != itemA.toString());
	}	

	function nullOrDiffers<T>(itemA:T, itemB:T):Bool
	{
		if (itemB == null) return false;
		return (itemB != itemA);
	}	
	
	
	
}


 class AttributesTools 
 {
	 static public function getClefWidth(clef:EClef):Float
	 {
		 return 20;
	 }
	 
	 static public function getKeyWidth(key:EKey):Float
	 {
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
	 
	 static public function getTimeWidth(time:ETime):Float
	 {
		 return 10;
	 }
	 
	 static public function  quickValueToWidth(value:Int):Float
	 {
		return Std.int(value / 100);				 
	 }
 }