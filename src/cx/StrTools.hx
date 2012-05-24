package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class StrTools 
{

	static public function stringRepeater(repString:String, count:Int) {
		var result = '';
		for (i in 0...count) result += repString;
		return result;
	}
	
	static public function fillString(str:String, toLength:Int = 32, ?with :String = ' ', ?replaceNull:String='-') {
		if (str == null) str = replaceNull;
		do { str += with; } while (str.length < toLength);
		return str.substr(0, toLength);
	}	
	
	static public function splitTrim(str:String, delimiter:String=','):Array<String> {
		var a = str.split(delimiter);
		var a2 = Lambda.array(Lambda.map(a, function(item) { return StringTools.trim(item); } ));
		return a2;
	}	
	
	static public function replaceNull(str:String, with:String = '-'):String {
		return (str == null) ? with : str;
	}	
	
	static public var SIM_CASE_EQUAL = 'simCaseEqual';
	static public var SIM_CASE_BALANCE = 'simCaseBalance';
	static public var SIM_CASE_UNEQUAL = 'simCaseUnequal';
	
	static public function similarity(strA:String, strB:String, caseMode:String = null):Float {
		if (strA == strB) return 1;
		
		if (caseMode == null) caseMode = SIM_CASE_UNEQUAL;
		
		if (caseMode == SIM_CASE_EQUAL) {
			strA = strA.toLowerCase();
			strB = strB.toLowerCase();
		}

		function core(strA:String, strB:String) {
			var lengthA = strA.length;
			var lengthB = strB.length;
			var i = 0;
			var segmentCount = 0;
			var segmentsInfos = new Array<SegmentInfo>();
			var segment = '';
			while (i < lengthA) {
				var char = strA.charAt(i);
				if (strB.indexOf(char) > -1) {
					segment += char;
					if (strB.indexOf(segment) > -1) {
						var segmentPosA = i - segment.length + 1;
						var segmentPosB = strB.indexOf(segment);
						var positionDiff = Math.abs(segmentPosA - segmentPosB);
						var posFactor = (lengthA - positionDiff) / lengthB;
						var lengthFactor = segment.length / lengthA;
						segmentsInfos[segmentCount] = { segment:segment, score:posFactor * lengthFactor };
					} else {
						segment = '';
						segmentCount++;
						i--;
					}
				} else {
					segment = '';
					segmentCount++;
				}
				i++;
			}
			
			var usedSegmentsCount = -2;
			var totalScore = 0.0;
			//trace(segmentsInfos);
			for (si in segmentsInfos) {
				if (si != null) {
					totalScore += si.score;
					usedSegmentsCount++;
				}
			}
			totalScore = totalScore - (Math.max(usedSegmentsCount, 0) * 0.02);
			return Math.max(0, Math.min(totalScore, 1));
		}
		
		function sim(strA:String, strB:String) {
			var score = core(strA, strB);
			// if different length, swap and run a second pass...	
			if (strA.length != strB.length) score = (score + core(strB, strA)) / 2;
			return score;
		}
		
		// first pass
		var score = sim(strA, strB);
		
		
		// if balance, run a second pass with alts set to lowercase and combine the scores...
		if (caseMode == SIM_CASE_BALANCE) score = (score + sim(strA.toLowerCase(), strB.toLowerCase())) / 2;
		
		// debug...
		trace(strA + '\t' + strB + '\t' + caseMode + '\t' + score);
		
		return score;
	}
	
}

/*
static public function string_compare($str_a, $str_b)
{
    $length = strlen($str_a);
    $length_b = strlen($str_b);

<code>    $i = 0;
    $segmentcount = 0;
    $segmentsinfo = array();
    $segment = '';
    while ($i < $length)
    {
        $char = substr($str_a, $i, 1);
        if (strpos($str_b, $char) !== FALSE)
        {
            $segment = $segment.$char;
            if (strpos($str_b, $segment) !== FALSE)
            {
                $segmentpos_a = $i - strlen($segment) + 1;
                $segmentpos_b = strpos($str_b, $segment);
                $positiondiff = abs($segmentpos_a - $segmentpos_b);
                $posfactor = ($length - $positiondiff) / $length_b; // <-- ?
                $lengthfactor = strlen($segment)/$length;
                $segmentsinfo[$segmentcount] = array( 'segment' => $segment, 'score' => ($posfactor * $lengthfactor));
            }
            else
            {
                 $segment = '';
                 $i--;
                 $segmentcount++;
             }
         }
         else
         {
             $segment = '';
            $segmentcount++;
         }
         $i++;
     }

     // PHP 5.3 lambda in array_map
     $totalscore = array_sum(array_map(function($v) { return $v['score'];  }, $segmentsinfo));
     return $totalscore;
}
*/

typedef SegmentInfo = {
	segment:String,
	score:Float
}