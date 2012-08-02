package nx.display.beam;
import nx.Constants;
import nx.enums.EDirectionUD;
import nx.enums.ETime;

/**
 * ...
 * @author Jonas Nyström
 */

class BeamTools 
{
	static public function getBeamingForTime(time:ETime):IBeamingProcessor {
		var ret:IBeamingProcessor = null;
		switch (time) {
			case ETime.T2_4:
			case ETime.T3_4:
			case ETime.T4_4:
				ret = new BeamingProcessor_4();
			
			case ETime.T3_8:
			case ETime.T6_8:
			case ETime.T9_8:
			case ETime.T12_8:
				ret = new BeamingProcessor_4dot();
		}
		return ret;
	}
	
	static public function getSlope(beamGroup:IBeamGroup):Int {
		var levels = beamGroup.getTopHeadsLevels();
		if (beamGroup.count() > 2) trace('låångä');
		return 0;
	}
	
	static public function test(beamGroup:IBeamGroup):BeamGroupFrame {
		return null;
	}
	
	static public function getDimensions(beamGroup:IBeamGroup):BeamGroupFrame {
		
		var directionUp:Bool = (beamGroup.getDirection() == EDirectionUD.Up);
		
		var levels = (directionUp) ? beamGroup.getTopHeadsLevels() : beamGroup.getBottomHeadsLevels();
		var count = levels.length;
		var levelFirst:Float = levels[0];
		var levelLast:Float = levels[count - 1];
		
		var levels2 = (directionUp) ? beamGroup.getBottomHeadsLevels () : beamGroup.getTopHeadsLevels ();
		var level2First:Float = levels2[0];
		var level2Last:Float = levels2[count - 1];
		
		var frame:BeamGroupFrame = {			
			direction:beamGroup.getDirection(),
			adjustX: (directionUp) ? 1.0 : -1.0,
			count:count,
			firstStave:null,
			innerStaves: null,
			lastStave:null,
			slope:0.0,
		};
		
		/*
		trace(levels);
		trace(levelFirst);
		trace(levelLast);
		*/
		var slopeV:Float = levelLast - levelFirst;
		
		//trace('slopeV 1: '+ slopeV);		
		
		var levelMin = Math.min(levelFirst, levelLast);
		var levelMax = Math.max(levelFirst, levelLast);
		
		if (directionUp) {
			//trace('STÄMMA UP');
			if (count > 2) {
				var innerLevels = levels.copy();
				innerLevels.pop();
				innerLevels.shift();
				//trace('innerLevels' + innerLevels);
				var innerMin:Float = innerLevels[0];
				for (il in innerLevels) {
					innerMin = Math.min(il, innerMin);
				}
				//trace('innerMin' + innerMin);
				if (innerMin <= levelMin) {
					trace('flat');
					slopeV = 0;
				}			
				slopeV = Math.min(2, Math.max( -2, slopeV));			
			} else {
				slopeV = Math.min(1, Math.max( -1, slopeV));			
			}
		} else {
			//trace('STÄMMA DOWN');
			if (count > 2) {
				var innerLevels = levels.copy();
				innerLevels.pop();
				innerLevels.shift();
				//trace('innerLevels' + innerLevels);
				var innerMax:Float = innerLevels[0];
				for (il in innerLevels) {
					innerMax = Math.max(il, innerMax);
				}
				//trace('innerMax' + innerMax);
				if (innerMax >= levelMax) {
					trace('flat');
					slopeV = 0;
				}			
				slopeV = Math.min(2, Math.max( -2, slopeV));			
			} else {
				slopeV = Math.min(1, Math.max( -1, slopeV));			
			}			
		}
		
		//trace('slopeV 2: '+ slopeV);		

		var bLevelLast = 0.0;
		var bLevelFirst = 0.0;
		
		if (directionUp) {
			
			if (slopeV < 0) { // lutar uppåt
				bLevelLast = levelLast;
				bLevelFirst = bLevelLast - slopeV;			
			} else if (slopeV > 0) {
				bLevelFirst = levelFirst;	
				bLevelLast = bLevelFirst + slopeV;			
			} else {
				bLevelFirst = levelMin;	
				bLevelLast = levelMin;
			}			
			frame.firstStave = {topY: bLevelFirst - Constants.STAVE_LENGTH, bottomY: level2First - Constants.STAVE_HEADADJUST };
			frame.lastStave = { topY: bLevelLast - Constants.STAVE_LENGTH, bottomY: level2Last - Constants.STAVE_HEADADJUST };
			
		} else {
			
			if (slopeV < 0) { // lutar uppåt
				bLevelFirst = levelFirst;			
				bLevelLast = levelFirst + slopeV;
			} else if (slopeV > 0) {
				bLevelLast = levelLast;
				bLevelFirst = bLevelLast - slopeV;	
			} else {
				bLevelFirst = levelMax;	
				bLevelLast = levelMax;
			}			
			frame.firstStave = {topY: level2First + Constants.STAVE_HEADADJUST , bottomY: bLevelFirst + Constants.STAVE_LENGTH - Constants.STAVE_HEADADJUST};
			frame.lastStave = {topY: level2Last + Constants.STAVE_HEADADJUST, bottomY: bLevelLast + Constants.STAVE_LENGTH - Constants.STAVE_HEADADJUST};			
			
		}
		
		
		/*
		if (levels.length > 2) {
			
			
			
			
			
			
		}
		*/
		
		return frame;
	}
	
}