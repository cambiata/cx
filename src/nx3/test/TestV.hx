package nx3.test;
import cx.ArrayTools;
import haxe.unit.TestCase;
import nx3.elements.EDirectionUD;
import nx3.elements.ENoteValue;
import nx3.elements.ESign;
import nx3.elements.NPart;
import nx3.elements.NVoice;
import nx3.elements.VTree;
import nx3.elements.VTree.VNote;
import nx3.elements.VTree.VVoice;
import nx3.test.QNote.QNote2;
import nx3.test.QNote.QNote4;
import nx3.test.QNote.QNote8;

using nx3.elements.VTree.VMapTools;
/**
 * ...
 * @author Jonas Nyström
 */
@:access(nx3.elements.VVoice)
@:access(nx3.elements.VBeamgroupDirectionCalculator)
@:access(nx3.elements.VBeamgroupFrameCalculator)
@:access(nx3.elements.VBeamgroup)
@:access(nx3.elements.VPartComplexesGenerator)
@:access(nx3.elements.VBarColumnsGenerator)
class TestV extends TestCase
{
	
	public function testVNote1() 
	{
		var vnote = new VNote(new QNote([ 1, -2]));
		this.assertEquals(2, vnote.nnote.nheads.length);
		this.assertEquals([ -2, 1].toString(), vnote.nnote.getHeadLevels().toString());
		this.assertEquals(ENoteValue.Nv4, vnote.nnote.value);
	}

	public function testVVoice1()
	{
		var vvoice = new VVoice(new QVoice([4, 8, 8, 2]));
		this.assertEquals(4, vvoice.nvoice.nnotes.length);
		this.assertEquals(4, vvoice.getVNotes().length);
		this.assertEquals(ENoteValue.Nv8, vvoice.getVNotes()[1].nnote.value);
		this.assertEquals(ENoteValue.Nv2, vvoice.getVNotes()[3].nnote.value);
		
		this.assertEquals(0, vvoice.getVNotePosition(vvoice.getVNotes()[0]));
		this.assertEquals(ENoteValue.Nv4.value, vvoice.getVNotePosition(vvoice.getVNotes()[1]));
		this.assertEquals(ENoteValue.Nv4.value+ENoteValue.Nv8.value, vvoice.getVNotePosition(vvoice.getVNotes()[2]));
		this.assertEquals(ENoteValue.Nv4.value+ENoteValue.Nv8.value+ENoteValue.Nv8.value, vvoice.getVNotePosition(vvoice.getVNotes()[3]));
	}
	
	// Test lazy instatioation (private variables!)
	public function testVVoice2()
	{
		var vvoice = new VVoice(new QVoice([4, 8, 8, 2]));
		this.assertTrue(vvoice.vnotes == null);
		vvoice.getVNotes();
		this.assertTrue(vvoice.vnotes != null);

		this.assertTrue(vvoice.vnotePositions == null);
		vvoice.getVNotePosition(vvoice.getVNotes()[0]);
		this.assertTrue(vvoice.vnotePositions != null);
		
		var vvoice = new VVoice(new QVoice([4, 8, 8, 2]));
		this.assertTrue(vvoice.vnotes == null);
		this.assertTrue(vvoice.value == null);
		var value = vvoice.getValue();
		this.assertTrue(vvoice.vnotes != null);
		this.assertTrue(vvoice.value != null);
		this.assertEquals(ENoteValue.Nv4.value * 4, vvoice.value);
	}
	
	public function testBeamgroups()
	{
		var vvoice = new VVoice(new QVoice([8, 8, 8, 8, 8, 8]));
		this.assertTrue(vvoice.beamgroups == null);
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteValue.Nv4]);
		this.assertEquals(3, beamgroups.length);
		this.assertEquals(2, beamgroups[0].vnotes.length);
		this.assertEquals(2, beamgroups[1].vnotes.length);
		this.assertEquals(2, beamgroups[2].vnotes.length);
		this.assertTrue(vvoice.beamgroups != null);
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteValue.Nv4dot]);
		this.assertEquals(2, beamgroups.length);
		this.assertEquals(3, beamgroups[0].vnotes.length);
		this.assertEquals(3, beamgroups[1].vnotes.length);
		
		var vvoice = new VVoice(new QVoice([4, 8, 8, 8, 8]));		
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteValue.Nv4]);
		this.assertEquals(3, beamgroups.length);
		this.assertEquals(1, beamgroups[0].vnotes.length);
		this.assertEquals(2, beamgroups[1].vnotes.length);
		this.assertEquals(2, beamgroups[2].vnotes.length);
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteValue.Nv4dot]);
		this.assertEquals(3, beamgroups.length);
		this.assertEquals(1, beamgroups[0].vnotes.length);
		this.assertEquals(1, beamgroups[1].vnotes.length);
		this.assertEquals(3, beamgroups[2].vnotes.length);

		var vvoice = new VVoice(new QVoice([8, 4, 8, 8, 8]));		
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteValue.Nv4]);
		this.assertEquals(4, beamgroups.length);
		this.assertEquals(1, beamgroups[0].vnotes.length);
		this.assertEquals(1, beamgroups[1].vnotes.length);
		this.assertEquals(1, beamgroups[2].vnotes.length);
		this.assertEquals(2, beamgroups[3].vnotes.length);
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteValue.Nv4dot]);
		this.assertEquals(3, beamgroups.length);
		this.assertEquals(1, beamgroups[0].vnotes.length);
		this.assertEquals(1, beamgroups[1].vnotes.length);
		this.assertEquals(3, beamgroups[2].vnotes.length);
		
		
		var vvoice = new VVoice(new QVoice([.2, 16, 16, 16, 16]));		
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteValue.Nv4]);
		
		this.assertEquals(2, beamgroups.length);
		this.assertEquals(1, beamgroups[0].vnotes.length);
		this.assertEquals(4, beamgroups[1].vnotes.length);	
	}
	
	public function testBeamgroupDirection()
	{
		var calculator = new VBeamgroupDirectionCalculator(new VBeamgroup([new VNote(new QNote4(0))]));
		var direction = calculator.getDirection();
		this.assertEquals(calculator.getDirection(), EDirectionUD.Down);
		this.assertEquals(0, calculator.topLevel);
		this.assertEquals(0, calculator.bottomLevel);
		
		var calculator = new VBeamgroupDirectionCalculator(new VBeamgroup([new VNote(new QNote4(5))]));
		var direction = calculator.getDirection();
		this.assertEquals(calculator.getDirection(), EDirectionUD.Up);
		this.assertEquals(5, calculator.topLevel);
		this.assertEquals(5, calculator.bottomLevel);		
		
		var calculator = new VBeamgroupDirectionCalculator(new VBeamgroup([new VNote(new QNote4(-2))]));
		var direction = calculator.getDirection();
		this.assertEquals(calculator.getDirection(), EDirectionUD.Down);
		this.assertEquals(-2, calculator.topLevel);
		this.assertEquals(-2, calculator.bottomLevel);		
		
		var vnotes = [new VNote(new QNote8([-2, 3]))];
		var calculator = new VBeamgroupDirectionCalculator(new VBeamgroup(vnotes));
		var direction = calculator.getDirection();
		this.assertEquals(calculator.getDirection(), EDirectionUD.Up);
		this.assertEquals(-2, calculator.topLevel);
		this.assertEquals(3, calculator.bottomLevel);		

		var vnotes = [new VNote(new QNote8([3])), new VNote(new QNote8([-2]))];
		var calculator = new VBeamgroupDirectionCalculator(new VBeamgroup(vnotes));
		var direction = calculator.getDirection();
		this.assertEquals(calculator.getDirection(), EDirectionUD.Up);
		this.assertEquals(-2, calculator.topLevel);
		this.assertEquals(3, calculator.bottomLevel);		
		
		var vnotes = [new VNote(new QNote8([3])), new VNote(new QNote8([-5])), new VNote(new QNote8([4]))];
		var calculator = new VBeamgroupDirectionCalculator(new VBeamgroup(vnotes));
		var direction = calculator.getDirection();
		this.assertEquals(calculator.getDirection(), EDirectionUD.Down);
		this.assertEquals(-5, calculator.topLevel);
		this.assertEquals(4, calculator.bottomLevel);		
		
		var calculator = new VBeamgroupDirectionCalculator(new VBeamgroup([new VNote(new QNote4(0))]));
		this.assertEquals(EDirectionUD.Down, calculator.getDirection());	
	}
	
	public function testBeamgroupDirectionSetter()
	{
		var beamgroup = new VBeamgroup([new VNote(new QNote4(0))]);
		this.assertEquals(EDirectionUD.Down, beamgroup.getDirection());

		var beamgroup = new VBeamgroup([new VNote(new QNote4(0))]);
		beamgroup.setDirection(EDirectionUD.Up);
		this.assertEquals(EDirectionUD.Up, beamgroup.getDirection());
	}
	
	
	public function testBeamgroupCalculator()
	{
		var vnotes = [new VNote(new QNote8([-2, 2]))];
		var calc = new VBeamgroupFrameCalculator(new VBeamgroup(vnotes));
		var frame = calc.getFrame();
		this.assertEquals([-2].toString(), calc.getTopLevels().toString());
		this.assertEquals([2].toString(), calc.getBottomLevels().toString());

		var vnotes = [new VNote(new QNote8([-2, 4])), new VNote(new QNote8([5, -3]))];
		var calc = new VBeamgroupFrameCalculator(new VBeamgroup(vnotes));
		var frame = calc.getFrame();
		this.assertEquals([-2, -3].toString(), calc.getTopLevels().toString());
		this.assertEquals([4, 5].toString(), calc.getBottomLevels().toString());
		
		var vnotes = [new VNote(new QNote8([-2, 4])), new VNote(new QNote8([6])), new VNote(new QNote8([-4])), new VNote(new QNote8([-3, 5])), new VNote(new QNote8([0]))];
		var calc = new VBeamgroupFrameCalculator(new VBeamgroup(vnotes));
		var frame = calc.getFrame();
		this.assertEquals([-2, 6, -4, -3, 0].toString(), calc.getTopLevels().toString());
		this.assertEquals([4, 6, -4, 5, 0].toString(), calc.getBottomLevels().toString());

	}
	
	public function testBeamgroupFrame() 
	{
		var vnotes = [new VNote(new QNote8([ -2, 1])), new VNote(new QNote8([ -4, 3]))];
		var beamgroup = new VBeamgroup(vnotes);
		var frame = beamgroup.getFrame();
		this.assertEquals(EDirectionUD.Down, beamgroup.getDirection());
		beamgroup.getFrame();
		this.assertEquals([1, 3].toString(), beamgroup.calculator.outerLevels.toString());
		this.assertEquals([-2, -4].toString(), beamgroup.calculator.innerLevels.toString());

		// OBS TODO!
		this.assertEquals(-2, frame.leftInnerY);
		this.assertEquals(1, frame.leftOuterY);
		this.assertEquals(-4, frame.rightInnerY);
		this.assertEquals(3, frame.rightOuterY);
		
		var vnotes = [new VNote(new QNote8([ -2, 1])), new VNote(new QNote8([ -4, 3]))];
		var beamgroup = new VBeamgroup(vnotes);
		beamgroup.setDirection(EDirectionUD.Up);
		var frame = beamgroup.getFrame();		
		this.assertEquals(EDirectionUD.Up, beamgroup.getDirection());
		this.assertEquals([1, 3].toString(), beamgroup.calculator.innerLevels.toString());
		this.assertEquals([ -2, -4].toString(), beamgroup.calculator.outerLevels.toString());
		
		// OBS TODO!
		this.assertEquals(1, frame.leftInnerY);
		this.assertEquals(-2, frame.leftOuterY);
		this.assertEquals(3, frame.rightInnerY);
		this.assertEquals(-4, frame.rightOuterY);
	}
	
	public function testVComplexSigns()
	{
		var vcomplex = new VComplex([new VNote(new QNote4(0))]);
		this.assertEquals(1, vcomplex.vnotes.length);
		var signs = vcomplex.getSigns();
		this.assertEquals(signs[0].sign, ESign.None);
		this.assertEquals(signs[0].level, 0);
		
		var vcomplex = new VComplex([new VNote(new QNote4(2, '#')), new VNote(new QNote4(-3, 'n'))]);
		this.assertEquals(2, vcomplex.vnotes.length);
		var signs = vcomplex.getSigns();
		this.assertEquals(signs.length, 2);
		this.assertEquals(signs[0].level, -3);
		this.assertEquals(signs[0].sign, ESign.Natural);
		this.assertEquals(signs[1].level, 2);
		this.assertEquals(signs[1].sign, ESign.Sharp);

		var vcomplex = new VComplex([new VNote(new QNote4([-4, 1, 3], 'b.#'))]);
		var signs = vcomplex.getSigns();
		this.assertEquals(signs.length, 3);
		this.assertEquals(signs[0].level, -4);
		this.assertEquals(signs[0].sign, ESign.Flat);
		this.assertEquals(signs[1].level, 1);
		this.assertEquals(signs[1].sign, ESign.None);
		this.assertEquals(signs[2].level, 3);
		this.assertEquals(signs[2].sign, ESign.Sharp);
		
		var vcomplex = new VComplex([new VNote(new QNote4([-2, 0, 2], 'n#.')), new VNote(new QNote4([-4, 1, 3], 'b.#'))]);
		var signs = vcomplex.getSigns();
		this.assertEquals(signs.length, 6);
		this.assertEquals(signs[0].level, -4);
		this.assertEquals(signs[0].sign, ESign.Flat);
		this.assertEquals(signs[1].level,-2);
		this.assertEquals(signs[1].sign, ESign.Natural);
		this.assertEquals(signs[2].level, 0);
		this.assertEquals(signs[2].sign, ESign.Sharp);
		this.assertEquals(signs[3].level, 1);
		this.assertEquals(signs[3].sign, ESign.None);
		this.assertEquals(signs[4].level, 2);
		this.assertEquals(signs[4].sign, ESign.None);
		this.assertEquals(signs[5].level, 3);
		this.assertEquals(signs[5].sign, ESign.Sharp);

		//--------------------------------------------------------------------
		
		var vcomplex = new VComplex([new VNote(new QNote4(0))]);
		var signs = vcomplex.getVisibleSigns();
		this.assertEquals(0, signs.length);
		
		var vcomplex = new VComplex([new VNote(new QNote4(2, '#')), new VNote(new QNote4(-3, '.'))]);
		this.assertEquals(2, vcomplex.vnotes.length);
		var signs = vcomplex.getVisibleSigns();
		this.assertEquals(signs.length, 1);
		this.assertEquals(signs[0].level, 2);
		this.assertEquals(signs[0].sign, ESign.Sharp);
		
		var vcomplex = new VComplex([new VNote(new QNote4([-2, 0, 2], 'n#.')), new VNote(new QNote4([-4, 1, 3], 'b.#'))]);
		var signs = vcomplex.getVisibleSigns();
		this.assertEquals(signs.length, 4);
		this.assertEquals(signs[0].level, -4);
		this.assertEquals(signs[0].sign, ESign.Flat);
		this.assertEquals(signs[1].level,-2);
		this.assertEquals(signs[1].sign, ESign.Natural);
		this.assertEquals(signs[2].level, 0);
		this.assertEquals(signs[2].sign, ESign.Sharp);
		this.assertEquals(signs[3].level, 3);
		this.assertEquals(signs[3].sign, ESign.Sharp);		
		
	}
	
	public function testVPartComplexesGenerator()
	{
		var vvoice = new VVoice(new QVoice([4, 8, 8, 2]));
		var generator = new VPartComplexesGenerator([vvoice]);
		var complexes = generator.getComplexes();
		this.assertEquals(generator.positionsMap.keys().keysToArray().toString(), [0, 3024, 4536, 6048].toString());
		this.assertEquals(complexes.length, 4);

		var vvoice0 = new VVoice(new QVoice([4, 8, 8, 2]));
		var vvoice1 = new VVoice(new QVoice([4, 4, 2]));
		var generator = new VPartComplexesGenerator([vvoice0, vvoice1]);
		var complexes = generator.getComplexes();
		this.assertEquals(generator.positionsMap.keys().keysToArray().toString(), [0, 3024, 4536, 6048].toString());
		this.assertEquals(complexes.length, 4);
		this.assertEquals(complexes[0].vnotes.length, 2);
		this.assertEquals(complexes[1].vnotes.length, 2);
		this.assertEquals(complexes[2].vnotes.length, 1);
		this.assertEquals(complexes[3].vnotes.length, 2);
		
		var vvoice0 = new VVoice(new QVoice([4, 8, 8, 4, 4]));
		var vvoice1 = new VVoice(new QVoice([.4, .4, 4]));
		var generator = new VPartComplexesGenerator([vvoice0, vvoice1]);
		var complexes = generator.getComplexes();
		this.assertEquals(generator.positionsMap.keys().keysToArray().toString(), [0, 3024, 4536, 6048, 9072].toString());	
		this.assertEquals(complexes.length, 5);
		this.assertEquals(complexes[0].vnotes.length, 2);
		this.assertEquals(complexes[1].vnotes.length, 1);
		this.assertEquals(complexes[2].vnotes.length, 2);
		this.assertEquals(complexes[3].vnotes.length, 1);
		this.assertEquals(complexes[4].vnotes.length, 2);
		
		var vvoice0 = new VVoice(new QVoice([4, 8, 8, 2]));
		var vvoice1 = new VVoice(new QVoice([4, 4, 2]));
		var generator = new VPartComplexesGenerator([vvoice0, vvoice1]);
		var positionsComplexes = generator.getPositionsComplexes();
		this.assertEquals([0, 3024, 4536, 6048].toString(), positionsComplexes.keys().keysToArray().toString());
		var vcomplex1 = generator.getComplexes()[1];
		var vcomplex2 = positionsComplexes.get(3024);
		this.assertEquals(vcomplex1, vcomplex2);
		var vcomplex1pos = generator.getComplexesPositions().get(vcomplex1);
		this.assertEquals(vcomplex1pos, 3024);
		
	}
	
	public function testVPartComplexes()
	{
		var vpart = new VPart(new NPart([
			new QVoice([4, 8, 8, 2]),
			new QVoice([4, 4, 2]),
		]));
		
		var vcomplexes = vpart.getComplexes();
		this.assertEquals(vcomplexes.length, 4);
		var positions = vpart.getPositionsVComplexes().keys().keysToArray();
		this.assertEquals([0, 3024, 4536, 6048].toString(), positions.toString());
	}
	
	public function testBarColumnsGenerator()
	{
		var vpart = new VPart(new NPart([
			new QVoice([4, 8, 8, 2]),
			new QVoice([4, 4, 2]),
		]));
		var generator = new VBarColumnsGenerator([vpart]);
		var columns = generator.getColumns();
		this.assertFalse(false);
		this.assertEquals(generator.positions.toString(), [0, 3024, 4536, 6048].toString());
		this.assertEquals(columns.length, 4);
		
		
		var vpart0 = new VPart(new NPart([
			new QVoice([.4, .4, 4]),
		]));
		var vpart1 = new VPart(new NPart([
			new QVoice([4, 8, 8, 4, 4]),
		]));
		var generator = new VBarColumnsGenerator([vpart0, vpart1]);
		var columns = generator.getColumns();
		this.assertFalse(false);
		this.assertEquals(generator.positions.toString(), [0, 3024, 4536, 6048, 9072].toString());
		
		
		
		
	}
	
	
	public function testVBar()
	{
		
		
		
	}
	
	
}