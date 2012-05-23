package cx.audio.timber;
/*
  This is part of Timber - see http://abstractnonsense.com/timber

  By Bill Moorier.  Licence is BSD.
 */

class OnePoleLowPassFilter {
	var a : Float;
	var b : Float;
	var z : Float;
	var started : Bool;

	public function new(param) {
		a = param;
		b = 1.0 - a;
		z = 0;
		started = false;
	}

	public function process(s : Float) {
		if(!started) {
			z = s;
			started = true;
		}
		z = (s * b) + (z * a);
		return z;
	}
}
