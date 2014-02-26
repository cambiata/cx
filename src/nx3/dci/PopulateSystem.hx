package nx3.dci;
import nx3.dci.PopulateSystem.Bar;
import nx3.dci.PopulateSystem.BarAttributes;
import nx3.dci.PopulateSystem.BarConfig;
import nx3.dci.PopulateSystem.Bars;
import nx3.dci.PopulateSystem.Pagesize;
import nx3.dci.PopulateSystem.System;
import nx3.dci.PopulateSystem.SystemConfig;
import nx3.dci.PopulateSystem.SystemStatus;
import nx3.elements.EClef;
import nx3.elements.EDisplayALN;
import nx3.elements.EKey;
import nx3.elements.ETime;


using cx.ArrayTools;

/**
 * ...
 * @author Jonas Nyström
 */

 typedef Pagesize = { width:Float, height:Float };
 
 typedef Bars = Array<Bar>;
 
 class Bar 
 {
	public var clef:EClef;
	public var key:EKey;
	public var time:ETime;
	public var displayClef:EDisplayALN;
	public var displayKey:EDisplayALN;
	public var displayTime:EDisplayALN;
	 
	public var contentWidth:Float; 
	
	public function new (clef:EClef = null, key:EKey = null, time:ETime = null, contentWidth:Float = 100, displayClef:EDisplayALN = null, displayKey:EDisplayALN = null, displayTime:EDisplayALN = null)
	{
		this.clef = clef;
		this.key = key;
		this.time = time;
		this.contentWidth = contentWidth;
		this.displayClef = (displayClef != null) ? EDisplayALN.Layout : displayClef;
		this.displayKey = (displayKey != null) ? EDisplayALN.Layout : displayKey;
		this.displayTime = (displayTime != null) ? EDisplayALN.Layout : displayTime;
	}
 }
  
 class BarConfig 
 {
	 public var showClef:Bool;
	 public var showKey:Bool;
	 public var showTime:Bool;
	
	 public var showCautClef:Bool;
	 public var showCautKey:Bool;
	public var  showCautTime:Bool;
	
	public var calculatedWidth:Float;
	
	public function new(showClef:Bool=false, showKey:Bool=false, showTime:Bool=false, showCautClef:Bool=false, showCautKey:Bool=false, showCautTime:Bool=false) 
	{ 
		this.showClef = showClef;
		this.showKey = showKey;
		this.showTime = showTime;
		this.showCautClef = showCautClef;
		this.showCautKey = showCautKey;
		this.showCautTime = showCautTime;
	};
 }
 
 typedef BarAttributes = 
 {
	 clef:EClef,
	 key:EKey,
	 time:ETime,
 }
  
 typedef SystemBar = 
 {
	 bar:Bar,
	 barConfig:BarConfig,
	 width:Float,
	 actAttributes:BarAttributes,
	 caAttributes:BarAttributes,
 }
  
 class System 
 {
	public var bars:Array<SystemBar>;	
	public var width:Float;
	public function new()
	{
		this.bars = new Array<SystemBar>();
		this.width = 0;
	}
	public var status:SystemStatus;
 }
 
 typedef SystemConfig =
 {
	showFirstClef:Bool, 
	showFirstKey:Bool, 
	showFirstTime:Bool,
	?showFollowingClef:Bool, 
	?showFollowingKey:Bool, 
	?showFollowingTime:Bool,	
	
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
 }
 
 class SystemGenerator
 {
	 public var systemConfig:SystemConfig;
	 public var prevBarAttributes:BarAttributes;
	 public var pagesize:Pagesize;
	 public var bars:Bars;
	 public var system:System;
	 
	public function new(bars:Bars, systemConfig:SystemConfig, prevBarAttributes:BarAttributes, pagesize:Pagesize) 
	{
		this.bars = bars;
		this.systemConfig = systemConfig;
		this.prevBarAttributes = (prevBarAttributes != null) ? prevBarAttributes : {clef:null, key:null, time:null};
		this.pagesize = pagesize;
		this.system = new System();
	}
	 
	public function getSystem():System
	{
		var tryAnotherBar = true;
		
		while (tryAnotherBar)
		{
			var currentBar:Bar = this.bars.first();
			var currentBarConfig:BarConfig = new BarConfig();
			var currentBarAttributes:BarAttributes = getBarAttributes(currentBar);
			
			//currentBarConfig.actualAttributes = currentBarAttributes;
			this.overrideActualAttributesFromPrevBarAttributes(currentBarAttributes, currentBar, this.prevBarAttributes);
			this.overrideActualAttributesWithDefaultsIfStillNotSet(currentBarAttributes);

			// fix attributes for bars...
			if (this.system.bars.length == 0)
			{
				this.adaptCurrentBarConfigToFirstSystemBarConditions(currentBar, currentBarConfig, this.systemConfig, this.prevBarAttributes);
			}
			else
			{
				this.adaptCurrentBarConfigToFollowingSystemBarConditions(currentBar, currentBarConfig, this.systemConfig, this.prevBarAttributes);
			}
			
			var currentBarWidth = getBarWidth(currentBar, currentBarConfig);
			
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
		
		this.system.status = SystemStatus.Ok;
		return this.system;
	}
	
	function copyBarAttributes(currentBarAttributes:BarAttributes) 
	{
		return { clef:currentBarAttributes.clef, key:currentBarAttributes.key, time:currentBarAttributes.time };
	}
	
	function overrideActualAttributesWithDefaultsIfStillNotSet(currentBarAttributes:BarAttributes) 
	{
			if (currentBarAttributes.clef == null) currentBarAttributes.clef = EClef.ClefC;
			if (currentBarAttributes.key == null) currentBarAttributes.key = EKey.Natural;
			if (currentBarAttributes.time == null) currentBarAttributes.time = ETime.Time3_4;
	}
	
	function overrideActualAttributesFromPrevBarAttributes(currentBarAttributes:BarAttributes, currentBar:Bar, prevBarAttributes:BarAttributes) 
	{
			if (currentBar.clef == null && prevBarAttributes.clef != null) currentBarAttributes.clef = prevBarAttributes.clef;
			if (currentBar.key == null && prevBarAttributes.key != null) currentBarAttributes.key = prevBarAttributes.key;
			if (currentBar.time == null && prevBarAttributes.time != null) currentBarAttributes.time = prevBarAttributes.time;
	}
	

	
	function takeCareOfLastBarCautions() 
	{
		this.system.status = SystemStatus.Ok;
		
		var sysBar:Bar = this.system.bars.last().bar;
		var sysBarAttributes:BarAttributes = getBarAttributes(sysBar);
		if (sysBar != this.bars.last()) 
		{
			//trace('checkNextBar');
			var nextBar:Bar = this.bars.first();
			var nextBarAttributes:BarAttributes = getBarAttributes(nextBar);
			var newClef:Bool = nullOrDiffers(sysBar.clef, nextBar.clef);
			var newKey:Bool = nullOrDiffers(sysBar.key, nextBar.key);
			var newTime:Bool = nullOrDiffers(sysBar.time, nextBar.time);
			if (newClef || newKey || newTime)
			{
				var sysBarConfig = this.system.bars.last().barConfig;
				var sysBarWidth = this.system.bars.last().width;
				
				var systemWidthWithoutLastBar = system.width - sysBarWidth;
				
				var sysBarConfigWithCautions = new BarConfig(sysBarConfig.showClef, sysBarConfig.showKey, sysBarConfig.showTime);
				if (newClef) sysBarConfigWithCautions.showCautClef = true;
				if (newKey) sysBarConfigWithCautions.showCautKey = true;
				if (newTime) sysBarConfigWithCautions.showCautTime = true;
				
				var sysBarWidthWithCautions = getBarWidth(sysBar, sysBarConfigWithCautions);
				
				if (systemWidthWithoutLastBar + sysBarWidthWithCautions <= this.pagesize.width)
				{
					this.system.bars.last().barConfig = sysBarConfigWithCautions;
					this.system.bars.last().width = sysBarWidthWithCautions;
					this.system.width = this.system.width - sysBarWidth + sysBarWidthWithCautions;
				}
				else
				{
					this.system.status = SystemStatus.Problem(101, 'Last bar fits without caution attributes but not with them');
					if (this.system.bars.length == 1)
					{
						this.system.status = SystemStatus.Problem(102, 'First bar doesn\'t fit when adding required cational attributes');
						return;
					}
					
					// remove last bar of current system...
					this.system.bars.pop();
					// ...and put it back on the feeding bars array top
					this.bars.unshift(sysBar);
					this.system.width = this.system.width - sysBarWidth;
					this.system.status = SystemStatus.Ok;
				}
			}
		}
	}
	
	function getBarWidth(bar:Bar, barConfig:BarConfig) :Float
	{
		var width:Float = 0;
		if (barConfig.showClef) width += AttributesTools.getClefWidth(bar.clef);
		if (barConfig.showKey) width += AttributesTools.getKeyWidth(bar.key);
		if (barConfig.showTime) width += AttributesTools.getTimeWidth(bar.time);
		
		width += bar.contentWidth;
		// cautions...
		if (barConfig.showCautClef) width += AttributesTools.getClefWidth(bar.clef);
		if (barConfig.showCautKey) width += AttributesTools.getKeyWidth(bar.key);
		if (barConfig.showCautTime) width += AttributesTools.getTimeWidth(bar.time);		

		return width;
	}
	
	private function getBarAttributes(bar:Bar):BarAttributes
	{
		var result = { clef:bar.clef, key:bar.key, time:bar.time };
		return result;
	}
	
	/*
	private function getBarAttributesFromConfigActualAttributes(barConfig:BarConfig):BarAttributes
	{
		if (barConfig == null) throw 'barConfig is null!';
		var result = { clef:null, key:null, time:null };
		result.clef = barConfig.actualAttributes.clef;
		result.key = barConfig.actualAttributes.key;
		result.time = barConfig.actualAttributes.time;
		return result;
	}
	*/
	
	private function adaptCurrentBarConfigToFirstSystemBarConditions(bar:Bar, barConfig:BarConfig, systemConfig:SystemConfig, prevBarAttributes:BarAttributes)
	{
		var barAttributes:BarAttributes = getBarAttributes(bar);
		if (bar.clef != null)
		{
			barConfig.showClef = systemConfig.showFirstClef;
			if (prevBarAttributes.clef != null) if (barAttributes.clef != prevBarAttributes.clef) barConfig.showClef = true;
			if (bar.displayClef == EDisplayALN.Never) barConfig.showClef = false;
		}

		if (bar.key != null)
		{
			barConfig.showKey = systemConfig.showFirstKey;
			if (prevBarAttributes.key != null) if (barAttributes.key != prevBarAttributes.key) barConfig.showKey = true;
			if (bar.displayKey == EDisplayALN.Never) barConfig.showKey = false;
		}

		if (bar.time != null)
		{
			barConfig.showTime = systemConfig.showFirstTime;
			if (prevBarAttributes.time != null) if (barAttributes.time != prevBarAttributes.time) barConfig.showTime = true;
			if (bar.displayTime == EDisplayALN.Never) barConfig.showTime = false;
		}		
	
	}

	private function adaptCurrentBarConfigToFollowingSystemBarConditions(bar:Bar, barConfig:BarConfig, systemConfig:SystemConfig, prevBarAttributes:BarAttributes)
	{
		var barAttributes:BarAttributes = getBarAttributes(bar);
		if (bar.clef != null)
		{
			barConfig.showClef = systemConfig.showFollowingClef;
			if (prevBarAttributes.clef != null) if (barAttributes.clef != prevBarAttributes.clef) barConfig.showClef = true;
			if (bar.displayClef == EDisplayALN.Never) barConfig.showClef = false;
		}

		if (bar.key != null)
		{
			barConfig.showKey = systemConfig.showFollowingKey;
			if (prevBarAttributes.key != null) if (barAttributes.key != prevBarAttributes.key) barConfig.showKey = true;
			if (bar.displayKey == EDisplayALN.Never) barConfig.showKey = false;
		}

		if (bar.time != null)
		{
			barConfig.showTime = systemConfig.showFollowingTime;
			if (prevBarAttributes.time != null) if (barAttributes.time != prevBarAttributes.time) barConfig.showTime = true;
			if (bar.displayTime == EDisplayALN.Never) barConfig.showTime = false;
		}		
	}	
	
	function nullOrDiffers<T>(itemA:T, itemB:T):Bool
	{
		if (itemB == null) return false;
		return (itemB != itemA);
	}
	
 }
 
 enum SystemStatus
 {
	 Ok;
	 Problem(code:Int, msg:String);
 }
 
 
