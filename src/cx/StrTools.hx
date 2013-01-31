package cx;
import haxe.Utf8;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class StrTools 
{
	static public function tab(str:String) {
		return str + '\t';
	}

	static public function newline(str:String) {
		return str + '\n';
	}
	
	static public function repeat(repeatString:String, count:Int) {
		var result = '';
		for (i in 0...count) result += repeatString;
		return result;
	}
	
	static public function fill(str:String, toLength:Int = 32, with:String=' ', replaceNull:String='-') {
		if (str == null) str = replaceNull;
		do { str += with; } while (str.length < toLength);
		return str.substr(0, toLength);
	}	
	
	static public function splitTrim(str:String, delimiter:String=','):Array<String> {
		if (str == null) return [];
		var a = str.split(delimiter);
		var a2 = new Array<String>();
		for (part in a) {
			var part2 = StringTools.trim(part);
			if (part2.length > 0) a2.push(part2);
		}
		return a2;
		/*
		var a2 = Lambda.array(Lambda.map(a, function(item) { 
			var part = StringTools.trim(item); 
			if (part.length > 0) return part;			
			} ));
		return a2;
		*/
	}	
	
	static public function replaceNull(str:String, with:String = '-'):String {
		return (str == null) ? with : str;
	}	
	
	static public function firstUpperCase(str:String, restToLowercase=true):String {		
		var rest = (restToLowercase) ?  str.substr(1).toLowerCase() : str.substr(1);		
		return str.substr(0, 1).toUpperCase() + rest;
	}
	
	static public function afterLast(str:String, char:String, includeChar:Bool=false):String {
		var idx = str.lastIndexOf(char);
		if (!includeChar) idx += char.length;
		return str.substr(idx);
	}		
	
	static public function similarityCaseIgnore(strA:String, strB:String):Float {
		return similarity(strA.toLowerCase(), strB.toLowerCase());
	}
	
	static public function similarityCaseBalance(strA:String, strB:String):Float {
		return (similarity(strA, strB) + similarity(strA.toLowerCase(), strB.toLowerCase())) / 2;
	}
	
	static public function similarity(strA:String, strB:String):Float {
		if (strA == strB) return 1;
		function sim(strA:String, strB:String) {
			var score = _similarity(strA, strB);
			// if different length, swap and run a second pass...	
			if (strA.length != strB.length) score = (score + _similarity(strB, strA)) / 2;
			return score;
		}
		return sim(strA, strB);
	}
	
	static public function similarityAssymetric(strShorter:String, strLonger:String):Float {
		if (strShorter == strLonger) return 1;
		return  _similarity(strShorter, strShorter);
	}
	
	static public function _similarity(strA:String, strB:String) {
		var lengthA = strA.length;
		var lengthB = strB.length;
		var i = 0;
		var segmentCount = 0;
		var segmentsInfos = new Array<SimilaritySegment>();
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
		for (si in segmentsInfos) {
			if (si != null) {
				totalScore += si.score;
				usedSegmentsCount++;
			}
		}
		// every used segment more than 2 gives a tiny score minus
		totalScore = totalScore - (Math.max(usedSegmentsCount, 0) * 0.02);
		return Math.max(0, Math.min(totalScore, 1));
	}
	
	static public function has(str:String, substr:String):Bool {
		return (str.indexOf(substr) > -1);
	}
	
	static public function reverse(string:String):String {		
		var result = '';
		for (i in 0...string.length) result = string.charAt(i) + result;		
		return result;		
	}
	
	static public function intToChar(int:Int, offset:Int=65):String {
		if (int > 9) throw "int to char error";
		if (int < 0) throw "int to char error";
		var c = int + offset;
		//trace([int, offset, c]);
		var char = String.fromCharCode(c);		
		//trace('char:' + char);
		return char;
	}
	
	static public function charToInt(char:String, offset=65):Int {
		if (char.length > 1) throw "char to int error";
		return char.charCodeAt(0) - offset;
	}	

	static public function numToStr(numStr:String, offset = 65):String {
		var testParse = Std.parseInt(numStr);
		
		var result = '';
		for (i in 0...numStr.length) {
			var int = Std.parseInt(numStr.charAt(i));
			var char = intToChar(int, offset);
			result += char;
		}
		
		return result;		
	}
	
	static public function strToNum(str:String, offset = 65):String {
		var result = '';
		for (i in 0...str.length) {
			var char = str.charAt(i);
			var int = charToInt(char, offset);
			result += Std.string(int);
		}
		
		return result;
		
	}
	
	
	
	
	
	static public function rotate(str:String, positions:Int = 1) {
		var result = str;
		for (i in 0...positions) {
			result = result.substr(1, result.length) + result.substr(0, 1);			
		}
		return result;
	}
	
	static public function rotateBack(str:String, positions:Int = 1) {
		var result = str;
		for (i in 0...positions) {			
			result = result.substr(-1) + result.substr(0, result.length - 1) ;		
		}
		return result;
	}
	
	static public function toLatin1(str:String):String {	
		/*
		str = StringTools.replace(str, 'å', String.fromCharCode(0xe5));
		str = StringTools.replace(str, 'Å', String.fromCharCode(0xc5));
		str = StringTools.replace(str, 'ä', String.fromCharCode(0xe4));
		str = StringTools.replace(str, 'Ä', String.fromCharCode(0xc4));
		str = StringTools.replace(str, 'ö', String.fromCharCode(0xf6));
		str = StringTools.replace(str, 'Ö', String.fromCharCode(0xd6));
		
		str = StringTools.replace(str, 'æ', String.fromCharCode(0xe6));
		str = StringTools.replace(str, 'Æ', String.fromCharCode(0xd6));
		str = StringTools.replace(str, 'œ', String.fromCharCode(0x9c));
		str = StringTools.replace(str, 'Œ', String.fromCharCode(0x8c));
		str = StringTools.replace(str, 'ø', String.fromCharCode(0xf8));
		str = StringTools.replace(str, 'Ø', String.fromCharCode(0xd8));
		
		str = StringTools.replace(str, 'ü', String.fromCharCode(0xfc));
		str = StringTools.replace(str, 'Ü', String.fromCharCode(0xdc));
		str = StringTools.replace(str, 'é', String.fromCharCode(0xe9));
		str = StringTools.replace(str, 'è', String.fromCharCode(0xe8));
		*/
		return Utf8.decode(str);
		
		
		return str;
	}	
	
	static public function lastIdxOf(str:String, search:String, lastPos:Int=0) {
		if (lastPos == 0) return str.lastIndexOf(search);		
		for (i in 0...lastPos ) {
			str = str.substr(0, str.lastIndexOf(search));
		}
		return str.lastIndexOf(search);
	}
	
}

typedef SimilaritySegment = {
	segment:String,
	score:Float
}