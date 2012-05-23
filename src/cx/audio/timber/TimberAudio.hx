package cx.audio.timber;

import flash.events.SampleDataEvent;
import flash.utils.ByteArray;
import flash.events.Event;
import flash.media.Microphone;
import flash.Memory;

/**
 * ...
 * @author Jonas Nyström
 */
 
class TimberAudio
{	
	static var mic : flash.media.Microphone;
	static var filterLP = new OnePoleLowPassFilter(0.4);
	static var filterHP = new OnePoleHighPassFilter(0.99);
	static var byteStore : flash.utils.ByteArray;
	static var lastDetectedWavelength = 1;	
	static inline var FLOATS = 4;
	static inline var DOUBLES = 8;
	static inline var SEMITONE = 0.0594630943592953;
	static inline var SECONDS = 1000;
	static inline var MEMORY_OFFSET_EPS = 65536;
	static inline var MEMORY_OFFSET_AEPS = 65536 + 1000 * DOUBLES;
	
	static var detectionCallback: Float->Float->Float->Void;
	
	static public function initMemory() {
		byteStore = new ByteArray();
		byteStore.length = 128 * 1024;
		Memory.select(byteStore);				
	}
	
	static public function initMicrophone() {
		mic = Microphone.getMicrophone();
        mic.setLoopBack(false);
		mic.rate = Std.int(44);
		mic.setSilenceLevel(0);
		mic.gain = 100;
		mic.setUseEchoSuppression(false);		
	}
	
	static public function startDetection() {		
		mic.addEventListener(SampleDataEvent.SAMPLE_DATA, onMicSampleData);		
	}
	
	static public function stopDetection() {		
		mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, onMicSampleData);		
	}
	
	static dynamic public function setDetectionCallback(func: Float->Float->Float->Void) {
		detectionCallback = func;
	}
	
	//-----------------------------------------------------------------------------------------------------
	
	static public function onMicSampleData(e) {
		e.data.position = 0;
		var REQUIRED_SAMPLES = 2000;
		if (e.data.bytesAvailable > REQUIRED_SAMPLES * FLOATS) {
			var samples = 0;
			var amplitude : Float = 0.0;
			
			while(samples < REQUIRED_SAMPLES) {
				var sample : Float = e.data.readFloat();
				amplitude += (sample * sample);
				samples++;
				Memory.setDouble(samples * DOUBLES, sample);
			}
			
			amplitude /= samples;
			if(amplitude > 0.01) {
				processSamples(samples, amplitude);
			}
		}	
	}		
	
	static public inline function wavelengthError(wavelength, samples) {
		var totalDifference = 0.0;
		for(i in 0...wavelength) {
			var diff1 = Memory.getDouble(i * DOUBLES) - Memory.getDouble((i + wavelength) * DOUBLES);
			var diff2 = Memory.getDouble(i * DOUBLES) - Memory.getDouble((i + 2 * wavelength) * DOUBLES);
			var offset = samples - 2 * wavelength - 1;
			var diff3 = Memory.getDouble((i + offset) * DOUBLES) - Memory.getDouble((i + offset + wavelength) * DOUBLES);
			totalDifference += (diff1 * diff1) + (diff2 * diff2) + (diff3 * diff3);
		}
		return totalDifference / (3 * wavelength);
	}

	static public function bestWavelength(samples) {
		var bestWavelength = 0;
		var bestErrorPerSample = 666.0;
		for(wavelength in 0...10) {
			Memory.setDouble(MEMORY_OFFSET_EPS + wavelength * DOUBLES, 0.0);
		}
		for(wavelength in 800...1000) {
			Memory.setDouble(MEMORY_OFFSET_EPS + wavelength * DOUBLES, 2.0);
		}
		for(wavelength in 10...800) {
			Memory.setDouble(MEMORY_OFFSET_EPS + wavelength * DOUBLES, wavelengthError(wavelength, samples));
		}
		for(wavelength in 10...800) {
			var sum = Memory.getDouble(MEMORY_OFFSET_EPS + wavelength * DOUBLES);
			for(delta in 1...5) {
				sum += Memory.getDouble(MEMORY_OFFSET_EPS + (wavelength + delta) * DOUBLES);
				sum += Memory.getDouble(MEMORY_OFFSET_EPS + (wavelength - delta) * DOUBLES);
			}
			Memory.setDouble(MEMORY_OFFSET_AEPS + wavelength * DOUBLES, sum / 9);
		}
		bestWavelength = postProcess();
		bestErrorPerSample = wavelengthError(bestWavelength, samples);
		return bestWavelength;
	}

	static public function postProcess() {
		var runningSum = 0.0;
		var runningTotal = 0;
		for(wavelength in 10...800) {
			var errorPerSample = Memory.getDouble(MEMORY_OFFSET_AEPS + wavelength * DOUBLES);
			runningSum += errorPerSample;
			runningTotal++;
			var runningAverage = runningSum / runningTotal;
			errorPerSample /= runningAverage;
			Memory.setDouble(MEMORY_OFFSET_AEPS + wavelength * DOUBLES, errorPerSample);
		}
		// done.
		var min = 666.0;
		for(wavelength in 10...800) {
			var errorPerSample = Memory.getDouble(MEMORY_OFFSET_AEPS + wavelength * DOUBLES);
			if(errorPerSample < min) {
				min = errorPerSample;
			}
		}
		var firstMinimumStart = -1;
		var firstMinimumEnd = -1;
		var detectedWavelength = -1;
		var confident = false;
		for(wavelength in 10...800) {
			var errorPerSample = Memory.getDouble(MEMORY_OFFSET_AEPS + wavelength * DOUBLES);
			if(errorPerSample < 1.2 * min) {
				if(firstMinimumStart == -1) {
					firstMinimumStart = wavelength;
				}
			} else {
				if(firstMinimumStart != -1 && firstMinimumEnd == -1) {
					firstMinimumEnd = wavelength;
					detectedWavelength = Std.int((firstMinimumStart + firstMinimumEnd) / 2);
					confident = (Math.max(detectedWavelength, lastDetectedWavelength) <
								 Math.min(detectedWavelength, lastDetectedWavelength) * (1 + SEMITONE));
					lastDetectedWavelength = detectedWavelength;
				}
			}
		}
		if(confident) {
			return detectedWavelength;
		} else {
			return -1;
		}
	}

	static public function processSamples(samples, amplitude : Float) {
		for(index in 0...samples) {
			var sample = Memory.getDouble(index * DOUBLES);
			sample = 0.93 * filterLP.process(filterHP.process(sample));
		}
		var wavelength = bestWavelength(samples);
		
		if (wavelength > 0) {
			var frequency = TimberTools.secondsToFrequency(TimberTools.samplesToSeconds(wavelength));
			var noteNumber = TimberTools.noteNumber(frequency);

			// OUTPUT!
			if (detectionCallback != null) detectionCallback(frequency, noteNumber, amplitude);
		}
	}


	
	
	
	
}