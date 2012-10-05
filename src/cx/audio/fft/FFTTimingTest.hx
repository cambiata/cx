package cx.audio.fft;

/**
* Simple program for testing the performance of an FFT implementation.
*
* Typical output be something like this:
*    1000 fwd-inv pairs of 1024 pt FFTs took 659 ms, or 0.330 ms per FFT.
* @author Gerry Beauregard
* @haxe Rigondo
*/



class FFTTimingTest {
	static inline var LOG_N = 10;			// Log2 of the FFT length
	static inline var N = 1 << LOG_N;		// FFT Length (2^LOG_N)
	static inline var NUM_LOOPS = // Float of forward-inverse FFT iterations for timing test
	#if js
		20;
	#elseif neko
		30;
	#elseif php
		10;
	#else
		1000;
	#end

	public static function main() { 		new FFTTimingTest(); 	}
	public function new() {
		initTest();

		print('Performing FFTs...');

		// Create vectors for the real & imaginary
		// components of the input/output data.
		var xRe = FFT.newArray(N);
		var xIm = FFT.newArray(N);

		// Initialize with some data.
		for ( i in 0...N)
		{
			xRe[i] = Math.cos(2*Math.PI*2*i/N);
			xIm[i] = 0.0;
		}

		// Create and initial the FFT class
		var fft = new FFT();
		fft.init(LOG_N);

		// Do repeated forward & inverse FFTs
		var startTime = getTimer();
		for ( i in 0...NUM_LOOPS)
		{
			fft.run( xRe, xIm, FFT.FORWARD );
			fft.run( xRe, xIm, FFT.INVERSE );
		}
		var endTime = getTimer();

		// Compute and display the elapsed time
		var elapsed = endTime - startTime;
		var timePerFFT = elapsed / (2.0*NUM_LOOPS);
		print(NUM_LOOPS + " fwd-inv pairs of " + N + " pt FFTs took " + elapsed + " ms, or " +
			(Std.int(timePerFFT * 1000) / 1000) + " ms per FFT.");

		checkIfHaxeTranslationIsCorrect();
	}
	inline function getTimer() { return Std.int(haxe.Timer.stamp() * 1000); }

	inline function checkIfHaxeTranslationIsCorrect() {
		// vectors:
		var xRe = FFT.newArray(N);
		var xIm = FFT.newArray(N);

		// copies for test:
		var xRe2 = FFT.newArray(N);
		var xIm2 = FFT.newArray(N);

		// data:
		for ( i in 0...N){
			xRe[i] = xRe2[i] = Math.cos(2*Math.PI*2*i/N);
			xIm[i] = xIm2[i] = 0.0;
		}

		// class:
		var fft = new FFT();
		fft.init(LOG_N);

		// run:
		fft.run( xRe, xIm, FFT.FORWARD );
		fft.run( xRe, xIm, FFT.INVERSE );

		// check:
		var ok = true;
		for (i in 0...N)
			if (!almostEqual(xRe[i], xRe2[i])) {
				ok = false;
				break;
			}

		print('Haxe translation is '+(ok?'':'in')+'correct.');
	}
	inline function almostEqual(a:Float, b:Float) {
		return a < b+PRECISION && a > b-PRECISION;
	}
	inline static var PRECISION = .0001;

	#if flash
		var textField:flash.text.TextField;
		function initTest() {
			var c = flash.Lib.current;
				c.stage.align = flash.display.StageAlign.TOP_LEFT;
				c.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
				textField = new flash.text.TextField();
				textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
				textField.selectable = false;
				textField.multiline = true;
				textField.defaultTextFormat = new flash.text.TextFormat( 'Verdana', 12, 0xFFFFFF );

				c.addChild( textField );
				textField.text =	'';
		}
	#else
		function initTest(){}
	#end

	function print(s) {
		#if flash
			textField.text +=	s + '\n';
		#else
			trace(s);
		#end
	}

}
