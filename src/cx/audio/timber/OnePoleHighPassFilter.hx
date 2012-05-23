package cx.audio.timber;
/*
  This is part of Timber - see http://abstractnonsense.com/timber

  By Bill Moorier.  Licence is BSD.
 */

class OnePoleHighPassFilter {
	var out : Float;
	var r : Float;
	var lastS : Float;

	public function new(param) {
		r = param;
		out = 0.0;
		lastS = 0.0;
	}

	public function process(s : Float) {
		out = s - lastS + r * out;
		lastS = s;
		return out;
	}
}
