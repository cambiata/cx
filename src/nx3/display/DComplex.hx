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
		this.headsRect;
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
	
	public var signsFrame(get, null):NRect;
	var signsFrame_:NRect;
	function get_signsFrame():NRect
	{
		if (this.signsFrame_ != null) return this.signsFrame_;		
		
		if (this.signRects == null) return null;
		//this.get_signRects();				
		
		for (rect in this.signRects)
		{
			if (this.signsFrame_ == null) 
			{
				this.signsFrame_ = rect.clone();
			}
			else 
			{
				this.signsFrame_ = this.signsFrame_.union(rect);				
			}
		}
		
		// Offset signsFrame_
		//var headsRect = this.headsRect;
		this.signsFrame_.x = this.headsRect.x - this.signsFrame_.width - NX.fromFloat(Constants.SIGN_TO_NOTE_DISTANCE);		
		//this.signsFrame_ = new NRect( -4, -5, 3, 10);
		
		return this.signsFrame_;
	}
	
	
	
	
	public var signRects(get, null):Array<NRect>;
	var signRects_:Array<NRect>;	
	function get_signRects():Array<NRect>
	{
		
		if (this.signRects_ != null) return this.signRects_;
		if (this.signs.length == 0) return null;
		
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
		
		// no signs?
		if (this.signRects_.length == 0) 
		{
			this.signRects_ = null;
			return this.signRects_;
		}
		
		// Combine into singsRect_	
		var combineRect:NRect = signRects_[0];
		
		for (rect in this.signRects_)
		{
			
			if (combineRect == rect) 
			{
				//combineRect = rect;
			}
			else 
			{
				combineRect = combineRect.union(rect);				
			}			
		}

		for (rect in this.signRects_)
		{
			rect.offset(combineRect.width, 0);			
		}
		
		return this.signRects_;
	}
	
	//------------------------------------------------------------------------------------------------------
	
	private function get_dnotesXAdjust():Array<NX>
	{
		return null;
	}
	
	//----------------------------------------------------------------------------------------------------------
	
	private function avoidCollisions_() {
		
		if (this.dnotes.length > 1) {
			var diff = this.dnotes[1].headTop.level - this.dnotes[0].headBottom.level;
			
			if (diff == 1) 
			{				
				this.dnotes[1].xAdjust = Constants.COMPLEX_COLLISION_ADJUST_X;
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
						this.dnotes[1].xAdjust =  -NX.fromFloat(Constants.COMPLEX_COLLISION_OVERLAP_XTRA);
					}
				}
				else 
				{
					this.dnotes[1].xAdjust = this.dnotes[0].headsRect.x + this.dnotes[0].headsRect.width  - this.dnotes[1].headsRect.x  + NX.fromFloat(Constants.COMPLEX_COLLISION_OVERLAP_XTRA);
				}				
			} else {
				//trace('no overlap');
			}
		}				
	}		
	
	
	
	
}