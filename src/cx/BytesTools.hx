package cx;
import haxe.io.BytesData;
import haxe.io.Bytes;

/**
 * ...
 * @author Jonas Nyström
 */

	
class BytesTools {	
	
	//----------------------------------------------------------------------------------------------------------
	/*
	static public function filesegmentsTest() {
		trace(Cx.filesNamesInDirectory('files'));
		var bytesList = Cx.filesBytesInDirectory('files/');
		var bytes = Cx.filesegmentsJoinBytes(bytesList);
		Cx.putContentBinary('join.files', bytes.toString());
		var bytesList2 = Cx.filesegmentsSplitBytes(bytes, bytesList.length);
		
		var i = 0;
		for (bytes in bytesList2) {
			Cx.putContentBinary('file-' + i + '.file', bytes.toString());
			i++;
		}	
	}	
	*/
	
	static var SEGMENT_LENGTH:Int = 128;
	
	
	public static function join(bytesList:List<haxe.io.Bytes>, ?segmentLength:Int=0):haxe.io.Bytes {
		if (segmentLength == 0) segmentLength = SEGMENT_LENGTH;
		bytesList = fillUp(bytesList, segmentLength);
		var channelsLength:Int = bytesList.length;
		var bytesLength = bytesList.first().length;
		var totalLength = channelsLength * bytesLength;		
		var totalSegmentsCount = Std.int(totalLength / segmentLength);
		var totalIterations:Int = Std.int(totalSegmentsCount / channelsLength);
		var resultBB = new haxe.io.BytesBuffer();
		for (pos in 0...totalIterations) {
			for (bytes in bytesList) {
				var sub = bytes.sub(pos * segmentLength, segmentLength);
				resultBB.add(sub);
			}
		}		
		return return resultBB.getBytes();
	}
	
	
	/*
	public static function joinBytesDataList(bytesList:List<BytesData>, ?segmentLength:Int = 4):BytesData {		
		bytesList = fillUpByteDatas(bytesList, segmentLength);
		var channelsLength:Int = bytesList.length;
		var bytesLength = BytesData.length(bytesList.first());
		var totalLength = channelsLength * bytesLength;		
		var totalSegmentsCount = Std.int(totalLength / segmentLength);
		var totalIterations:Int = Std.int(totalSegmentsCount / channelsLength);
		
		
		//var resultBB = new haxe.io.BytesBuffer();
		var resultString = '';
		
		for (pos in 0...totalIterations) {
			for (bytes in bytesList) {
				trace(BytesData.toString(bytes));

				var seg = BytesData.toString(bytes).substr(pos * segmentLength, segmentLength);
				
				resultString += seg; // BytesData.toString(seg);
			}
		}		
		return return BytesData.ofString(resultString);
	}
	*/

	
	
	public static function fillUp(bytesList:List<Bytes>, ?segmentsLength:Int=0):List<Bytes> {
		if (segmentsLength == 0) segmentsLength = SEGMENT_LENGTH;
		var longest:Float = 0;			
		bytesList.map(function(bytes:Bytes):Void { longest = Math.max(bytes.length, longest); } ); 
		var nrOfSegments  = Math.ceil(longest / segmentsLength);
		var filledBytesLength = nrOfSegments * segmentsLength;
		var result = new List<haxe.io.Bytes>();
		for (bytes in bytesList) {
			var fillCount = filledBytesLength - bytes.length;
			var fillString = StringTools.lpad('', '0', fillCount);
			var bb = new haxe.io.BytesBuffer();
			bb.add(bytes);
			bb.add(haxe.io.Bytes.ofString(fillString)); 
			var newBytes = bb.getBytes();
			result.add(newBytes);
		}
		return result;
	}	
	
	/*
	public static function fillUpByteDatas(bytesList:List<BytesData>, ?segmentLength:Int = 4):List<haxe.io.BytesData> {
		var longest:Float = 0;			
		bytesList.map(function(bytes:haxe.io.BytesData):Void { longest = Math.max(BytesData.length(bytes), longest); } ); 
		var nrOfSegments  = Math.ceil(longest / segmentLength);
		var filledBytesLength = nrOfSegments * segmentLength;
		var result = new List<haxe.io.BytesData>();
		for (bytes in bytesList) {
			var fillCount = filledBytesLength - BytesData.length(bytes);
			
			var fillString = StringTools.lpad('', '.', fillCount);
			var bytesString = BytesData.toString(bytes);
			var filledString = bytesString + fillString;
			//trace(filledString);
			result.add(BytesData.ofString(filledString));
		}
		return result;
	}	
	*/
	
	
	static public function split(bytes:haxe.io.Bytes, nrOfChannels:Int, segmentsLength:Int=0):List<haxe.io.Bytes> {
		if (segmentsLength == 0) segmentsLength = SEGMENT_LENGTH;
		var iterations = Std.int(bytes.length / (segmentsLength * nrOfChannels));
		var bbList = new Array<haxe.io.BytesBuffer>();
		for (ch in 0...nrOfChannels) {
			bbList.push(new haxe.io.BytesBuffer());
		}
		for (i in 0...iterations) {
			for (ch in 0...nrOfChannels) {
				var pos:Int = (i * nrOfChannels * segmentsLength) +  (ch * segmentsLength);
				var sub:haxe.io.Bytes = bytes.sub(pos, segmentsLength);
				var chPos:Int = i * segmentsLength;
				bbList[ch].addBytes(bytes, pos, segmentsLength);
			}
		}
		var ret = new List<haxe.io.Bytes>();
		for (ch in 0...nrOfChannels) {
			ret.add(bbList[ch].getBytes());
		}
		return ret;
	}
	
	
	/*
	static public function splitBytesData(bytes:BytesData, nrOfChannels:Int, segmentsLength:Int = 4): List<BytesData> {
		var bytesStr = BytesData.toString(bytes);
		
		var strs = new Array<String>();
		
		for (ch in 0...nrOfChannels) strs[ch] = '';

		while(bytesStr.length > 0) {
			for (ch in 0...nrOfChannels) {
				var seg = bytesStr.substr(0, segmentsLength);
				bytesStr = bytesStr.substr(segmentsLength);
				//trace([seg, bytesStr]);
				strs[ch] += seg;
			}
		}
		//trace(byteStrings);
		var res = new List<BytesData>();
		for (ch in 0...nrOfChannels) res.add(BytesData.ofString(strs[ch]));
		return res;
	}
	*/

	//-----------------------------------------------------------------------------------------------------------------------
	
#if flash 
	static public function splitByteArray(bytes:flash.utils.ByteArray, nrOfChannels:Int, segmentsLength:Int=0):Array<flash.utils.ByteArray> {
		if (segmentsLength == 0) segmentsLength = SEGMENT_LENGTH;
		var iterations = Std.int(bytes.length / (segmentsLength * nrOfChannels));
		var bbList = new Array<flash.utils.ByteArray>();
		for (ch in 0...nrOfChannels) {
			bbList.push(new flash.utils.ByteArray());
		}
		for (i in 0...iterations) {
			for (ch in 0...nrOfChannels) {
				var pos:Int = (i * nrOfChannels * segmentsLength) +  (ch * segmentsLength);
				bbList[ch].writeBytes(bytes, pos, segmentsLength);
			}
		}
		return bbList;		
	}		
#end 
	
	
}