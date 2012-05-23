package cx.audio.timber;

/*
  This is part of Timber - see http://abstractnonsense.com/timber

  By Bill Moorier.  Licence is BSD.
 */

class TimberTools {
	public static inline var SAMPLE_RATE = 44100;

	public static function samplesToSeconds(samples : Int) {
		return (1.0 * samples) / SAMPLE_RATE;
	}

	public static function secondsToSamples(seconds : Float) {
		return Std.int(seconds * SAMPLE_RATE);
	}

	public static function frequencyToSeconds(f : Float) {
		return 1.0 / f;
	}

	public static function secondsToFrequency(seconds : Float) {
		return 1.0 / seconds;
	}

	public static function noteNumber(f: Float) {
		return 12 * ((Math.log(f) - Math.log(440)) / Math.log(2));
	}
	
	public static function scaleNoteNumber(f : Float) {
		while(f < 440) {
			f *= 2;
		}
		while(f >= 880) {
			f /= 2;
		}
		// 440 < f <= 880
		// We want:  f=440 => 0
		//           f=880 => 12
		
		var scaled = 12 * ((Math.log(f) - Math.log(440)) / Math.log(2));
		scaled -= 3; // Make C note #0
		if(scaled < 0) {
			scaled += 12;
		}
		return scaled;
	}

	static var notes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];

	public static function noteName(scaleNoteNumber:Float) {
		return notes[Math.round(scaleNoteNumber) % notes.length];
	}

	public static function scaledFrequencyFromNoteName(noteName) {
		var f = 0;
		for(note in notes) {
			if(note == noteName) {
				return f;
			}
			f++;
		}
		return -1;
	}

	public static function staffPosition(scaledFrequency : Float) {
		switch(Math.round(scaledFrequency)) {
			case 5: // F
				return 0.0;
			case 6: // F#
				return 0.5;
			case 7: // G
				return 1;
			case 8: // G#
				return 1.5;
			case 9: // A
				return 2;
			case 10: // A#
				return 2.5;
			case 11: // B
				return 3;
			case 0: // C
				return 4;
			case 12:
				return 4;
			case 1: // C#
				return 4.5;
			case 2: // D
				return 5;
			case 3: // D#
				return 5.5;
			case 4: // E
				return 6;
		}
		return -1;
	}
}
