package nx3.dci;
import haxe.unit.TestCase;
import haxe.unit.TestRunner;
import nx3.elements.NBar;
import nx3.elements.VTree;
//import nx3.dci.Main.TestSystemGenerator;
import nx3.dci.PopulateSystem;
import nx3.elements.EClef;
import nx3.elements.EDisplayALN;
import nx3.elements.EKey;
import nx3.elements.ETime;
import nx3.elements.NPart;
import nx3.test.QVoice;

using cx.ArrayTools;
/**
 * ...
 * @author Jonas Nyström
 */
class Main
{

	static public function main() 
	{
		var runner = new  TestRunner(); 
		//runner.add(new TestSystemGenerator());		
		runner.add(new TestSystemGenerator2());		
		var success = runner.run();
		
	}
	
}

class TestSystemGenerator2 extends TestCase
{
	public function test0()
	{
		var n0 = new NPart([new QVoice([4, 4, 4])], EClef.ClefC, EKey.Flat2);
		var n1 = new NPart([new QVoice([4, 4, 4])], EClef.ClefF, EKey.Sharp3);
		var b0 = new VBar(new NBar([n0, n1], ETime.Time3_4));
		var n1 = new NPart([new QVoice([4, 4, 4])]);
		var b1 = new VBar(new NBar([n1]));
		var n2 = new NPart([new QVoice([4, 4, 4])]);
		var b2 = new VBar(new NBar([n2]));
		var bars:Array<VBar> = [b0, b1, b2];
		this.assertEquals(true, true);
		
	}
	
}
/*
class TestSystemGenerator  extends TestCase
{
	public function testOneBar()
	{
		var bars = new Array<Bar>();
		bars.push(new Bar(EClef.ClefC, EKey.Sharp2, ETime.Time3_4, 100));
		var generator = new SystemGenerator(bars, { showFirstClef:true, showFirstKey:true, showFirstTime:true }, null, { width:400, height:600 } );
		var system:System = generator.getSystem();
		this.assertEquals(system.status, SystemStatus.Ok);
		this.assertEquals(system.bars.length, 1);
		var firstbar:SystemBar = system.bars.first();
		this.assertEquals(firstbar.barConfig.showClef, true);
		this.assertEquals(firstbar.barConfig.showKey, true);
		this.assertEquals(firstbar.barConfig.showTime, true);
		
		var bars = new Array<Bar>();
		bars.push(new Bar(EClef.ClefC, EKey.Sharp2, ETime.Time3_4, 100));
		var generator = new SystemGenerator(bars, { showFirstClef:false, showFirstKey:true, showFirstTime:false }, null, { width:400, height:600 } );
		var system:System = generator.getSystem();
		this.assertEquals(system.status, SystemStatus.Ok);
		this.assertEquals(system.bars.length, 1);
		var firstbar:SystemBar = system.bars.first();
		this.assertEquals(firstbar.barConfig.showClef, false);
		this.assertEquals(firstbar.barConfig.showKey, true);
		this.assertEquals(firstbar.barConfig.showTime, false);		

		var bars = new Array<Bar>();
		bars.push(new Bar(EClef.ClefC, EKey.Sharp2, ETime.Time3_4, 100));
		var generator = new SystemGenerator(bars, { showFirstClef:false, showFirstKey:false, showFirstTime:false }, {clef:EClef.ClefF, key:null, time:null}, { width:400, height:600 } );
		var system:System = generator.getSystem();
		this.assertEquals(system.status, SystemStatus.Ok);
		this.assertEquals(system.bars.length, 1);
		var firstbar:SystemBar = system.bars.first();
		this.assertEquals(firstbar.barConfig.showClef, true);
		this.assertEquals(firstbar.barConfig.showKey, false);
		this.assertEquals(firstbar.barConfig.showTime, false);		
		
		var bars = new Array<Bar>();
		bars.push(new Bar(null, null, null, 100));
		var generator = new SystemGenerator(bars, { showFirstClef:false, showFirstKey:true, showFirstTime:false }, {clef:EClef.ClefF, key:null, time:null}, { width:400, height:600 } );
		var system:System = generator.getSystem();
		this.assertEquals(system.status, SystemStatus.Ok);
		this.assertEquals(system.bars.length, 1);
		var firstbar:SystemBar = system.bars.first();
		this.assertEquals(firstbar.barConfig.showClef, false);
		this.assertEquals(firstbar.barConfig.showKey, false);
		this.assertEquals(firstbar.barConfig.showTime, false);				

		var bars = new Array<Bar>();
		bars.push(new Bar(EClef.ClefC, EKey.Sharp2, ETime.Time3_4, 100, EDisplayALN.Always, EDisplayALN.Never, EDisplayALN.Never));
		var generator = new SystemGenerator(bars, { showFirstClef:false, showFirstKey:false, showFirstTime:false }, {clef:EClef.ClefF, key:null, time:null}, { width:400, height:600 } );
		var system:System = generator.getSystem();
		this.assertEquals(system.status, SystemStatus.Ok);

		this.assertEquals(system.bars.length, 1);
		var firstbar:SystemBar = system.bars.first();
		this.assertEquals(firstbar.barConfig.showClef, true);
		this.assertEquals(firstbar.barConfig.showKey, false);
		this.assertEquals(firstbar.barConfig.showTime, false);		
		
		
	}
	
	
	
	public function testOneBarWithPrevBarConfig()
	{
		var bars = new Array<Bar>();
		bars.push(new Bar());
		var generator = new SystemGenerator(bars, { showFirstClef:false, showFirstKey:false, showFirstTime:false }, {clef:EClef.ClefF, key:EKey.Flat3, time:ETime.Time3_8}, { width:400, height:600 } );
		var system:System = generator.getSystem();
		this.assertEquals(system.status, SystemStatus.Ok);
		this.assertEquals(system.bars.length, 1);
		var firstbar:SystemBar = system.bars.first();
		this.assertEquals(firstbar.actAttributes.clef, EClef.ClefF);
		
		
		
	}
	
	public function testTwoBars()
	{
		var bars = new Array<Bar>();
		bars.push(new Bar(EClef.ClefC, EKey.Sharp2, ETime.Time3_4, 100));
		bars.push(new Bar());
		
		var generator = new SystemGenerator(bars, { showFirstClef:true, showFirstKey:true, showFirstTime:true }, null, { width:400, height:600 } );
		var system:System = generator.getSystem();
		this.assertEquals(system.status, SystemStatus.Ok);

		this.assertEquals(system.bars.length, 2);
		var firstbar:SystemBar = system.bars.first();
		var secondbar:SystemBar = system.bars.second();
		this.assertEquals(secondbar.actAttributes.clef, firstbar.bar.clef);
		this.assertEquals(secondbar.actAttributes.key, firstbar.bar.key);
		this.assertEquals(secondbar.actAttributes.time, firstbar.bar.time);
	}	

	public function testBarsWidth()
	{
		var bars = new Array<Bar>();
		bars.push(new Bar(EClef.ClefC, EKey.Sharp2, ETime.Time3_4, 100));
		bars.push(new Bar(EClef.ClefF));
		var generator = new SystemGenerator(bars, { showFirstClef:true, showFirstKey:true, showFirstTime:true }, null, { width:400, height:600 } );
		var system:System = generator.getSystem();
		this.assertEquals(system.status, SystemStatus.Ok);
		this.assertEquals(system.bars.length, 2);
		this.assertEquals(system.width, 270);
		this.assertEquals(system.bars.first().width, 150);
		this.assertEquals(system.bars.second().width, 120);
		
	}	
	
	public function testOverflow1()
	{
		var bars = new Array<Bar>();
		bars.push(new Bar(EClef.ClefC, EKey.Sharp2, ETime.Time3_4, 100));
		bars.push(new Bar(50));
		var generator = new SystemGenerator(bars, { showFirstClef:true, showFirstKey:true, showFirstTime:true }, null, { width:200, height:600 } );
		var system:System = generator.getSystem();		
		this.assertEquals(system.bars.length, 2);
		this.assertEquals(system.width, 200);
		this.assertEquals(system.status, SystemStatus.Ok);

		
		var bars = new Array<Bar>();
		bars.push(new Bar(EClef.ClefC, EKey.Sharp2, ETime.Time3_4, 100));
		bars.push(new Bar(51));
		var generator = new SystemGenerator(bars, { showFirstClef:true, showFirstKey:true, showFirstTime:true }, null, { width:200, height:600 } );
		var system:System = generator.getSystem();		
		this.assertEquals(system.bars.length, 1);
		this.assertEquals(system.width, 150);
		this.assertEquals(system.status, SystemStatus.Ok);
		
	}	

	
	public function testCautionary1()
	{
		var bars = new Array<Bar>();
		bars.push(new Bar(EClef.ClefC, EKey.Sharp2, ETime.Time3_4, 100));
		bars.push(new Bar(EClef.ClefF, 50));
		var generator = new SystemGenerator(bars, { showFirstClef:true, showFirstKey:true, showFirstTime:true }, null, { width:200, height:600 } );
		var system:System = generator.getSystem();		
		this.assertEquals(system.bars.length, 1);
		this.assertEquals(system.width, 170);
		this.assertEquals(system.status, SystemStatus.Ok);
		
		// this should cause a one pixel overflow because of the cautions, and a SystemStatus.Problem 102 because there's only one bar in the system
		var bars = new Array<Bar>();
		bars.push(new Bar(EClef.ClefC, EKey.Sharp2, ETime.Time3_4, 131));
		bars.push(new Bar(EClef.ClefF, 50));
		var generator = new SystemGenerator(bars, { showFirstClef:true, showFirstKey:true, showFirstTime:true }, null, { width:200, height:600 } );
		var system:System = generator.getSystem();		
		this.assertEquals(system.bars.length, 1);
		this.assertEquals(system.status.getIndex(), 1);
		this.assertEquals(system.status.getParameters().first(), 102);
		
		
	}	

	public function testThreeBars()
	{
		var bars = new Array<Bar>();
		bars.push(new Bar(EClef.ClefC, EKey.Sharp2, ETime.Time3_4, 130));
		bars.push(new Bar(100));
		bars.push(new Bar(EClef.ClefF, 100));
		var generator = new SystemGenerator(bars, { showFirstClef:true, showFirstKey:true, showFirstTime:true }, null, { width:400, height:600 } );
		var system:System = generator.getSystem();		
		this.assertEquals(system.bars.length, 3);
		this.assertEquals(system.width, 400);
		
		this.assertEquals(system.bars.first().width, 180);
		this.assertEquals(system.bars.second().width, 100);
		this.assertEquals(system.bars.third().width, 120);
		
		this.assertEquals(system.bars.first().barConfig.showClef, true);
		this.assertEquals(system.bars.first().barConfig.showKey, true);
		this.assertEquals(system.bars.first().barConfig.showTime, true);
		this.assertEquals(system.bars.second().barConfig.showClef, false);
		this.assertEquals(system.bars.second().barConfig.showKey, false);
		this.assertEquals(system.bars.second().barConfig.showTime, false);
		this.assertEquals(system.bars.third().barConfig.showClef, true);
		this.assertEquals(system.bars.third().barConfig.showKey, false);
		this.assertEquals(system.bars.third().barConfig.showTime, false);

		
		
		var bars = new Array<Bar>();
		bars.push(new Bar(EClef.ClefC, EKey.Sharp2, ETime.Time3_4, 131));
		bars.push(new Bar(100));
		bars.push(new Bar(EClef.ClefF, 100));
		var generator = new SystemGenerator(bars, { showFirstClef:true, showFirstKey:true, showFirstTime:true }, null, { width:400, height:600 } );
		var system:System = generator.getSystem();		
		this.assertEquals(system.bars.length, 2);
		this.assertEquals(system.status, SystemStatus.Ok);
		this.assertEquals(system.width, 301);
		this.assertEquals(system.bars.first().width, 181);
		this.assertEquals(system.bars.second().width, 120);
		this.assertEquals(system.bars.second().barConfig.showCautClef, true);

		
		
		
		
		
		
	}

	public function testOverflow2()
	{
		var bars = new Array<Bar>();
		bars.push(new Bar(EClef.ClefC, EKey.Sharp2, ETime.Time3_4, 140));
		bars.push(new Bar(100));
		bars.push(new Bar( 100));
		var generator = new SystemGenerator(bars, { showFirstClef:true, showFirstKey:true, showFirstTime:true }, null, { width:300, height:600 } );
		var system:System = generator.getSystem();		
		this.assertEquals(system.bars.length, 2);
		this.assertEquals(system.status, SystemStatus.Ok);
		this.assertEquals(system.width, 290);
		this.assertEquals(system.bars.first().width, 190);
		this.assertEquals(system.bars.second().width, 100);
		this.assertEquals(bars.length, 1);
		
		var bars = new Array<Bar>();
		bars.push(new Bar(EClef.ClefC, EKey.Sharp2, ETime.Time3_4, 140));
		bars.push(new Bar(100));
		bars.push(new Bar(EClef.ClefF, 100));
		var generator = new SystemGenerator(bars, { showFirstClef:true, showFirstKey:true, showFirstTime:true }, null, { width:300, height:600 } );
		var system:System = generator.getSystem();		
		this.assertEquals(system.status, SystemStatus.Ok);
		this.assertEquals(system.bars.length, 1);
		this.assertEquals(system.width, 190);
		this.assertEquals(bars.length, 2);
		
		
	}
	
	
}
*/