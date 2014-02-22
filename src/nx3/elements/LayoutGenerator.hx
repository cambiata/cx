package nx3.elements;
import cx.RandomTools;

/**
 * ...
 * @author Jonas Nyström
 */

 class LBar {
	 public var attributesLeft1Width(default, null): Float;
	 public var clef(default, null):EClef;
	 public var clefVisibility(default, null):EDisplayALN;
	 public var key(default, null):EKey;
	 public var keyVisibility(default, null):EDisplayALN;
	 public var time(default, null):ETime;
	 public var timeVisibility(default, null):EDisplayALN;
	 public var attributesLeft2Width(default, null): Float;
	 public var contentMinWidth(default, null):Float;
	 public var attributesRightWidth(default, null):Float;
	 
	 public function new()
	 {
		 this.attributesLeft1Width = 10;
		 this.attributesLeft2Width = 20;
		 this.attributesRightWidth = 20;
		 
		 this.clefVisibility = this.keyVisibility = this.timeVisibility = EDisplayALN.Layout;
		 RandomTools
	 }
 }
 
  typedef LBars = Array<LBar>;
  
  class LBarConfig  {
	  public var showClef:Bool;
	  public var showKey:Bool;
	  public var showTime: Bool
	  
	  public var showCautionaryClef:Bool;
	  public var showCautionaryKey:Bool;
	  public var showCautionaryTime:Bool;
	  
	  
	  
  }
  
  
 
 class LSystem {
	 public var bars:Array<LBar>;
	 public var barConfigs:Array<LBarConfig>;
 }
 
 
 
class LayoutGenerator
{

	public function new() 
	{
		
	}
	
}