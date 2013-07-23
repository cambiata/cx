package nx3.display;
import nx3.display.tools.HeadsTool;
import nx3.display.tools.SignsTools;
import nx3.enums.ESign;
import nx3.types.TSignRects;
import nx3.types.TSigns;
import nx3.units.Constants;
import nx3.units.NRect;
import nx3.units.NX;

/**
 * ...
 * @author 
 */

 using nx3.display.tools.SignsTools;
 
class DComplex
{

	public var dnotes(default, null):Array<DNote>;
	public var signs(default, null):TSigns;
	
	//public var signsRect(get, null):NRect;
	
	
	public var dnotesXAdjust(get, null):Array<NX>;

	public function new(dnotes:Array<DNote>) 
	{
		this.dnotes = dnotes;
		this.signs = getSigns_(dnotes);
		this.avoidCollisions_();
	}
	
	//--------------------------------------------------------------------------------------------------------------------------
	var headsRect_:NRect = null;
	public var headsRect(get, null):NRect;
	
	function get_headsRect():NRect
	{
		if (this.headsRect_ != null) return this.headsRect_;

		this.headsRect_ = this.dnotes[0].headsRect;
		this.headsRect_.offset(this.dnotes[0].xAdjust, 0);
		//trace(this.dnotes[0].xAdjust);
		if (this.dnotes.length == 1) return this.headsRect_;
		
		for (i  in 1...this.dnotes.length)
		{
			var dnoteRect:NRect = dnotes[i].headsRect;
			dnoteRect.offset(dnotes[i].xAdjust, 0);
			this.headsRect_ = this.headsRect_.union(dnoteRect);
		}
		//trace(this.headsRect_.toRectangle());
		return this.headsRect_;
	}
	 
	//-------------------------------------------------------------------------------------------------------------------------
	
	function getSigns_(dnotes:Array<DNote>) :TSigns
	{
		var signs:TSigns = new TSigns();
		for (dnote in dnotes)
		{
			for (head in dnote.heads)
			{
				signs.push( { sign:head.sign, level:head.level, position: 0 } );
			}		
		}		
		return SignsTools.adjustPositions(signs);
	}
	
	public var signsRect(get, null):NRect;
	var signsRect_:NRect;
	function get_signsRect():NRect
	{
		if (this.signsRect_ != null) return this.signsRect_;		
		this.get_signRects();				
		return this.signsRect_;
	}
	
	public var signRects(get, null):Array<NRect>;
	var signRects_:Array<NRect>;	
	function get_signRects():Array<NRect>
	{
		if (this.signRects_ != null) return this.signRects_;
		
		this.signRects_ = [];
		
		var currentRect:NRect = null;
		for (sign in signs)
		{
			currentRect = sign.sign.getSignRect();
			currentRect.offset(0, sign.level);
			
			if (currentRect == null) continue;			
			currentRect.offset( -currentRect.width, 0 );
			
			var xMove:NX = 0;
			for (checkRect in this.signRects_)
			{
				var isect:NRect = checkRect.intersection(currentRect);					
				if (checkRect.intersects(currentRect)) 
				{
					//trace('intersects ' + checkRect.rect.x); 
					currentRect.x = checkRect.x - currentRect.width;
				}
			}
			this.signRects_.push(currentRect);			
		}			

		// Combine into singsRect_
		for (rect in this.signRects_)
		{
			if (this.signsRect_ == null) 
			{
				this.signsRect_ = rect;
			}
			else 
			{
				this.signsRect_ = this.signsRect_.union(rect);				
			}
		}

		
		// Offset signsRect_
		var headsRect = this.headsRect;
		this.signsRect_.x = this.headsRect.x - this.signsRect_.width - NX.fromFloat(Constants.SIGN_TO_NOTE_DISTANCE);
		
		// Offset each sign rect
		for (rect in this.signRects_)
		{
			rect.offset(this.signsRect_.width, 0);			
		}
		
		
		
		return this.signRects_;
	}
	
	//------------------------------------------------------------------------------------------------------
	
	private function get_dnotesXAdjust():Array<NX>
	{
		return null;
	}
	
	//----------------------------------------------------------------------------------------------------------
	
	static var SECOND_CLASH_ADJUST_X = 3.0;
	static var THIRD_CLASH_ADJUST_X = 4.0;
	
	private function avoidCollisions_() {
		
		if (this.dnotes.length > 1) {
			var diff = this.dnotes[1].headTop.level - this.dnotes[0].headBottom.level;
			
			if (diff == 1) {				
				//trace('second clash');		
				/*
				if (this.dnote(0).notevalue.dotLevel > 0) {
					var isect = GeomUtils.overlapX(checkRect, this.dnote(1).rectHeads);
					this._setDnoteX(1, isect.x);
				} else {
					this._setDnoteX(1, 	Constants.COMPLEX_COLLISION_SECOND_XSHIFT);					
				}
				*/
				this.dnotes[1].xAdjust = SECOND_CLASH_ADJUST_X;
			} 
			else if (diff == 0)
			{
				// If different values, then adjust
				if (this.dnotes[1].value != this.dnotes[0].value)
				{
					this.dnotes[1].xAdjust = this.dnotes[0].headsRect.x + this.dnotes[0].headsRect.width  - this.dnotes[1].headsRect.x + NX.fromFloat(Constants.COMPLEX_COLLISION_OVERLAP_XTRA);
				}	
				
			}			
			else if (diff < 1) 
			{
				if (this.dnotes[1].value == this.dnotes[0].value)
				{				
					if (HeadsTool.headsCollide(this.dnotes[0].heads, this.dnotes[1].heads))
					{
						this.dnotes[1].xAdjust = this.dnotes[0].headsRect.x + this.dnotes[0].headsRect.width  - this.dnotes[1].headsRect.x + NX.fromFloat(Constants.COMPLEX_COLLISION_OVERLAP_XTRA);
					}
					else
					{
						// do nothing						
						this.dnotes[0].xAdjust =  NX.fromFloat(Constants.COMPLEX_COLLISION_OVERLAP_XTRA);
					}
				}
				else 
					this.dnotes[1].xAdjust = this.dnotes[0].headsRect.x + this.dnotes[0].headsRect.width  - this.dnotes[1].headsRect.x  + NX.fromFloat(Constants.COMPLEX_COLLISION_OVERLAP_XTRA);
				
				
			} else {
				//trace('no overlap');
			}
		}				
	}		
	
	
	
	
}