package cx;

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
	public static function join(bytesList:List<haxe.io.Bytes>, ?segmentLength:Int = 4):haxe.io.Bytes {
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

	public static function fillUp(bytesList:List<haxe.io.Bytes>, ?segmentLength:Int = 4):List<haxe.io.Bytes> {
		var longest:Float = 0;			
		bytesList.map(function(bytes:haxe.io.Bytes):Void { longest = Math.max(bytes.length, longest); } ); 
		var nrOfSegments  = Math.ceil(longest / segmentLength);
		var filledBytesLength = nrOfSegments * segmentLength;
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
	
	static public function split(bytes:haxe.io.Bytes, nrOfChannels:Int, segmentsLength:Int=4):List<haxe.io.Bytes> {
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

	//-----------------------------------------------------------------------------------------------------------------------
	#if flash 
	static public function splitByteArray(bytes:flash.utils.ByteArray, nrOfChannels:Int, segmentsLength:Int=4):Array<flash.utils.ByteArray> {
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