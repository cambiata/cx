package nx3.test;

import cx.ArrayTools;
import haxe.ds.IntMap.IntMap;
import nx3.Constants;
import nx3.elements.EClef;
import nx3.elements.EDirectionUAD;
import nx3.elements.EDirectionUD;
import nx3.elements.EDisplayALN;
import nx3.elements.EKey;
import nx3.elements.ENoteType;
import nx3.elements.ENoteVal;
import nx3.elements.ENoteVal;
import nx3.elements.ETime;
//import nx3.elements.ENoteValue;
import nx3.elements.ESign;
import nx3.elements.NBar;
import nx3.elements.NNote;
import nx3.elements.NPart;
import nx3.elements.NVoice;
import nx3.elements.VTree;
import nx3.elements.VTree.VNote;
import nx3.elements.VTree.VVoice;
import nx3.geom.Rectangle;
import nx3.test.QNote.QNote16;
import nx3.test.QNote.QNote2;
import nx3.test.QNote.QNote4;
import nx3.test.QNote.QNote8;

using nx3.elements.VTree.VMapTools;
using cx.ArrayTools;
using nx3.elements.ENoteValTools;
/**
 * ...
 * @author Jonas Nyström
 */

@:access(nx3.elements.VBar)
@:access(nx3.elements.VNote)
@:access(nx3.elements.VVoice)
@:access(nx3.elements.VBeamgroupDirectionCalculator)
@:access(nx3.elements.VBeamgroupFrameCalculator)
@:access(nx3.elements.VBeamgroup)
@:access(nx3.elements.VPartComplexesGenerator)
@:access(nx3.elements.VBarColumnsGenerator)

class TestV extends  haxe.unit.TestCase 
{
	/*
	public function testENoteVal()
	{
		this.assertEquals(ENoteValue.Nv1.value, ENoteVal.Nv1.value());
		this.assertEquals(ENoteValue.Nv1dot.value, ENoteVal.Nv1dot.value());
		this.assertEquals(ENoteValue.Nv1ddot.value, ENoteVal.Nv1ddot.value());
		this.assertEquals(ENoteValue.Nv1tri.value, ENoteVal.Nv1tri.value());
		
		this.assertEquals(ENoteValue.Nv2.value, ENoteVal.Nv2.value());
		this.assertEquals(ENoteValue.Nv2dot.value, ENoteVal.Nv2dot.value());
		this.assertEquals(ENoteValue.Nv2ddot.value, ENoteVal.Nv2ddot.value());
		this.assertEquals(ENoteValue.Nv2tri.value, ENoteVal.Nv2tri.value());				

		this.assertEquals(ENoteValue.Nv4.value, ENoteVal.Nv4.value());
		this.assertEquals(ENoteValue.Nv4dot.value, ENoteVal.Nv4dot.value());
		this.assertEquals(ENoteValue.Nv4ddot.value, ENoteVal.Nv4ddot.value());
		this.assertEquals(ENoteValue.Nv4tri.value, ENoteVal.Nv4tri.value());				

		this.assertEquals(ENoteValue.Nv8.value, ENoteVal.Nv8.value());
		this.assertEquals(ENoteValue.Nv8dot.value, ENoteVal.Nv8dot.value());
		this.assertEquals(ENoteValue.Nv8ddot.value, ENoteVal.Nv8ddot.value());
		this.assertEquals(ENoteValue.Nv8tri.value, ENoteVal.Nv8tri.value());		
		
		this.assertEquals(ENoteValue.Nv16.value, ENoteVal.Nv16.value());
		this.assertEquals(ENoteValue.Nv16dot.value, ENoteVal.Nv16dot.value());
		this.assertEquals(ENoteValue.Nv16ddot.value, ENoteVal.Nv16ddot.value());
		this.assertEquals(ENoteValue.Nv16tri.value, ENoteVal.Nv16tri.value());		
		
		//------------------------------------------------------------------------------------------------------------
		
		this.assertEquals(ENoteValue.Nv1.head, ENoteVal.Nv1.head());
		this.assertEquals(ENoteValue.Nv2.head, ENoteVal.Nv2.head());
		this.assertEquals(ENoteValue.Nv4.head, ENoteVal.Nv4.head());
		this.assertEquals(ENoteValue.Nv8.head, ENoteVal.Nv8.head());
		
		this.assertEquals(ENoteValue.Nv1.stavingLevel, ENoteVal.Nv1.stavinglevel());
		this.assertEquals(ENoteValue.Nv2.stavingLevel, ENoteVal.Nv2.stavinglevel());
		this.assertEquals(ENoteValue.Nv4.stavingLevel, ENoteVal.Nv4.stavinglevel());
		this.assertEquals(ENoteValue.Nv8.stavingLevel, ENoteVal.Nv8.stavinglevel());
		
		this.assertEquals(ENoteValue.Nv1.beamingLevel, ENoteVal.Nv1.beaminglevel());
		this.assertEquals(ENoteValue.Nv2.beamingLevel, ENoteVal.Nv2.beaminglevel());
		this.assertEquals(ENoteValue.Nv4.beamingLevel, ENoteVal.Nv4.beaminglevel());
		this.assertEquals(ENoteValue.Nv8.beamingLevel, ENoteVal.Nv8.beaminglevel());
		this.assertEquals(ENoteValue.Nv16.beamingLevel, ENoteVal.Nv16.beaminglevel());
		this.assertEquals(ENoteValue.Nv32.beamingLevel, ENoteVal.Nv32.beaminglevel());
	}
	*/
	
	public function testVNote1() 
	{
		var vnote = new VNote(new QNote([ 1, -2]));
		this.assertEquals(2, vnote.nnote.nheads.length);
		this.assertEquals([ -2, 1].toString(), vnote.nnote.getHeadLevels().toString());
		this.assertEquals(ENoteVal.Nv4, vnote.nnote.value);
	}

	public function testVNoteInternalDirection()
	{
		var calculator = new VNoteInternalDirectionCalculator(new VNote(new QNote([ 0])).getVHeads());
		this.assertEquals(EDirectionUD.Down, calculator.getDirection());
		var calculator = new VNoteInternalDirectionCalculator(new VNote(new QNote([ 1])).getVHeads());
		this.assertEquals(EDirectionUD.Up, calculator.getDirection());
		
		var calculator = new VNoteInternalDirectionCalculator(new VNote(new QNote([ -5, 5 ])).getVHeads());
		this.assertEquals(EDirectionUD.Down, calculator.getDirection());
		var calculator = new VNoteInternalDirectionCalculator(new VNote(new QNote([ -4, 5])).getVHeads());
		this.assertEquals(EDirectionUD.Up, calculator.getDirection());

		var calculator = new VNoteInternalDirectionCalculator(new VNote(new QNote([ -5, 1, 2, 3, 4, 5 ])).getVHeads());
		this.assertEquals(EDirectionUD.Down, calculator.getDirection());
		var calculator = new VNoteInternalDirectionCalculator(new VNote(new QNote([ -4, 1, 2, 5])).getVHeads());
		this.assertEquals(EDirectionUD.Up, calculator.getDirection());
	}
	
	public function testVHeadsPlacementsCalculator() 
	{
		var vnote = new VNote(new QNote([ 1, 2]));
		var calculator = new VHeadPlacementCalculator(vnote.getVHeads(), EDirectionUD.Down);
		var placements = calculator.getHeadsPlacements();
		this.assertEquals(1, placements[0].level);
		this.assertEquals(EHeadPosition.Center, placements[0].pos);
		this.assertEquals(2, placements[1].level);
		this.assertEquals(EHeadPosition.Left, placements[1].pos);

		var calculator = new VHeadPlacementCalculator(vnote.getVHeads(), EDirectionUD.Up);
		var placements = calculator.getHeadsPlacements();
		this.assertEquals(1, placements[0].level);
		this.assertEquals(EHeadPosition.Right, placements[0].pos);
		this.assertEquals(2, placements[1].level);
		this.assertEquals(EHeadPosition.Center, placements[1].pos);
	}
	
	
	public function testVNoteHeadPlacement()
	{
		var vnote = new VNote(new QNote([-1, 0, 1]));
		var placements = vnote.getVHeadsPlacements();
		this.assertEquals(EHeadPosition.Center, placements[0].pos);
		this.assertEquals(EHeadPosition.Left, placements[1].pos);
		this.assertEquals(EHeadPosition.Center, placements[2].pos);

		var vnote = new VNote(new QNote([0, 1, 2]));
		var placements = vnote.getVHeadsPlacements();
		this.assertEquals(EHeadPosition.Center, placements[0].pos);
		this.assertEquals(EHeadPosition.Right, placements[1].pos);
		this.assertEquals(EHeadPosition.Center, placements[2].pos);
		
		var vnote = new VNote(new QNote([-2, -1, 0, 1]));
		var placements = vnote.getVHeadsPlacements();
		this.assertEquals(EHeadPosition.Center, placements[0].pos);
		this.assertEquals(EHeadPosition.Left, placements[1].pos);
		this.assertEquals(EHeadPosition.Center, placements[2].pos);
		this.assertEquals(EHeadPosition.Left, placements[3].pos);
		
		var vnote = new VNote(new QNote([0, 1, 2, 3]));
		var placements = vnote.getVHeadsPlacements();
		this.assertEquals(EHeadPosition.Right, placements[0].pos);
		this.assertEquals(EHeadPosition.Center, placements[1].pos);
		this.assertEquals(EHeadPosition.Right, placements[2].pos);
		this.assertEquals(EHeadPosition.Center, placements[3].pos);
		
		var vnote = new VNote(new QNote([0, 1, 2, 3]));
		this.assertTrue(vnote.vheadsPlacements == null);
		vnote.getVHeadsPlacements();
		this.assertTrue(vnote.vheadsPlacements  != null);
		vnote.setConfig( { direction: EDirectionUD.Down } );
		this.assertTrue(vnote.vheadsPlacements == null);
		var placements = vnote.getVHeadsPlacements();
		this.assertEquals(EHeadPosition.Center, placements[0].pos);
		this.assertEquals(EHeadPosition.Left, placements[1].pos);
		this.assertEquals(EHeadPosition.Center, placements[2].pos);
		this.assertEquals(EHeadPosition.Left, placements[3].pos);		
	}
	
	public function testVNoteHeadRectanglesCalculator()
	{
		var vnote = new VNote(new QNote(0));
		var calculator = new VNoteHeadsRectsCalculator(vnote);
		var rects = calculator.getHeadsRects();
		assertEquals(rects.length, 1);
		assertEquals(rects.first().x , -Constants.HEAD_HALFWIDTH_NORMAL);

		var vnote = new VNote(new QNote([0, 1]));
		var calculator = new VNoteHeadsRectsCalculator(vnote);
		var rects = calculator.getHeadsRects();
		assertEquals(rects.length, 2);
		assertEquals(vnote.getDirection(), EDirectionUD.Up);
		assertEquals(rects.first().x , Constants.HEAD_HALFWIDTH_NORMAL);
		assertEquals(rects.second().x , -Constants.HEAD_HALFWIDTH_NORMAL);

		var vnote = new VNote(new QNote([0, 1],EDirectionUAD.Down));
		var calculator = new VNoteHeadsRectsCalculator(vnote);
		var rects = calculator.getHeadsRects();		
		assertEquals(rects.length, 2);
		assertEquals(vnote.getDirection(), EDirectionUD.Down);
		assertEquals(rects.first().x , -Constants.HEAD_HALFWIDTH_NORMAL);
		assertEquals(rects.second().x , 3*-Constants.HEAD_HALFWIDTH_NORMAL);

		var vnote = new VNote(new QNote([0, 1]));
		vnote.setConfig( { direction:EDirectionUD.Down } );
		var calculator = new VNoteHeadsRectsCalculator(vnote);
		var rects = calculator.getHeadsRects();		
		assertEquals(rects.length, 2);
		assertEquals(vnote.getDirection(), EDirectionUD.Down);
		assertEquals(rects.first().x , -Constants.HEAD_HALFWIDTH_NORMAL);
		assertEquals(rects.second().x , 3*-Constants.HEAD_HALFWIDTH_NORMAL);		
		
	}
	
	

	public function testVNoteDirectionCalculator() 
	{
		var vnote = new VNote(new QNote([ -1, 0, 1], EDirectionUAD.Auto));
		var calculator = new VNoteDirectionCalculator(vnote);
		this.assertEquals(EDirectionUD.Down, calculator.getDirection(null));

		var vnote = new VNote(new QNote([ -1, 0, 2], EDirectionUAD.Auto));
		var calculator = new VNoteDirectionCalculator(vnote);
		this.assertEquals(EDirectionUD.Up, calculator.getDirection(null));

		var vnote = new VNote(new QNote([ -1, 0, 2], EDirectionUAD.Down));
		var calculator = new VNoteDirectionCalculator(vnote);
		this.assertEquals(EDirectionUD.Down, calculator.getDirection(null));

		var vnote = new VNote(new QNote([ -1, 0, 2]));
		var calculator = new VNoteDirectionCalculator(vnote);
		this.assertEquals(EDirectionUD.Down, calculator.getDirection(EDirectionUD.Down));
		
		var vnote = new VNote(new QNote([ -1, 0, 2], EDirectionUAD.Up));
		var calculator = new VNoteDirectionCalculator(vnote);
		this.assertEquals(EDirectionUD.Up, calculator.getDirection(EDirectionUD.Down));
		
		//----------------------------

		var vnote = new VNote(new QNote([ -1, 0, 2]));
		this.assertEquals(vnote.direction, null);
		this.assertEquals(EDirectionUD.Up, vnote.getDirection());
		vnote.setConfig( { direction:EDirectionUD.Down } );
		this.assertEquals(vnote.direction, null);
		this.assertEquals(EDirectionUD.Down, vnote.getDirection());

		var vnote = new VNote(new QNote([ -1, 0, 2], EDirectionUAD.Down));
		this.assertEquals(EDirectionUD.Down, vnote.getDirection());
		
		var vnote = new VNote(new QNote([ -1, 0, 2]));
		vnote.setConfig( { direction:EDirectionUD.Down } );
		this.assertEquals(EDirectionUD.Down, vnote.getDirection());
		this.assertTrue(vnote.direction != null);
		vnote.setConfig( { direction:null} );
		this.assertTrue(vnote.direction == null);
		this.assertEquals(EDirectionUD.Up, vnote.getDirection());
		
	}
	
	
	public function testVVoice1()
	{
		var vvoice = new VVoice(new QVoice([4, 8, 8, 2]));
		this.assertEquals(4, vvoice.nvoice.nnotes.length);
		this.assertEquals(4, vvoice.getVNotes().length);
		this.assertEquals(ENoteVal.Nv8, vvoice.getVNotes()[1].nnote.value);
		this.assertEquals(ENoteVal.Nv2, vvoice.getVNotes()[3].nnote.value);
		
		this.assertEquals(0, vvoice.getVNotePositions().get(vvoice.getVNotes()[0]));
		this.assertEquals(ENoteVal.Nv4.value(), vvoice.getVNotePositions().get(vvoice.getVNotes()[1]));
		this.assertEquals(ENoteVal.Nv4.value()+ENoteVal.Nv8.value(), vvoice.getVNotePositions().get(vvoice.getVNotes()[2]));
		this.assertEquals(ENoteVal.Nv4.value()+ENoteVal.Nv8.value()+ENoteVal.Nv8.value(), vvoice.getVNotePositions().get(vvoice.getVNotes()[3]));
	}
	
	// Test lazy instatioation (private variables!)
	public function testVVoice2()
	{
		var vvoice = new VVoice(new QVoice([4, 8, 8, 2]));
		this.assertTrue(vvoice.vnotes == null);
		vvoice.getVNotes();
		this.assertTrue(vvoice.vnotes != null);

		this.assertTrue(vvoice.vnotePositions == null);
		vvoice.getVNotePositions().get(vvoice.getVNotes()[0]);
		this.assertTrue(vvoice.vnotePositions != null);
		
		var vvoice = new VVoice(new QVoice([4, 8, 8, 2]));
		this.assertTrue(vvoice.vnotes == null);
		this.assertTrue(vvoice.value == null);
		var value = vvoice.getValue();
		this.assertTrue(vvoice.vnotes != null);
		this.assertTrue(vvoice.value != null);
		this.assertEquals(ENoteVal.Nv4.value() * 4, vvoice.value);
	}
	
	public function testBeamgroups()
	{
		var vvoice = new VVoice(new QVoice([8, 8, 8, 8, 8, 8]));
		this.assertTrue(vvoice.beamgroups == null);
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteVal.Nv4]);
		this.assertEquals(3, beamgroups.length);
		this.assertEquals(2, beamgroups[0].vnotes.length);
		this.assertEquals(2, beamgroups[1].vnotes.length);
		this.assertEquals(2, beamgroups[2].vnotes.length);
		this.assertTrue(vvoice.beamgroups != null);
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteVal.Nv4dot]);
		this.assertEquals(2, beamgroups.length);
		this.assertEquals(3, beamgroups[0].vnotes.length);
		this.assertEquals(3, beamgroups[1].vnotes.length);
		
		var vvoice = new VVoice(new QVoice([4, 8, 8, 8, 8]));		
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteVal.Nv4]);
		this.assertEquals(3, beamgroups.length);
		this.assertEquals(1, beamgroups[0].vnotes.length);
		this.assertEquals(2, beamgroups[1].vnotes.length);
		this.assertEquals(2, beamgroups[2].vnotes.length);
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteVal.Nv4dot]);
		this.assertEquals(3, beamgroups.length);
		this.assertEquals(1, beamgroups[0].vnotes.length);
		this.assertEquals(1, beamgroups[1].vnotes.length);
		this.assertEquals(3, beamgroups[2].vnotes.length);

		var vvoice = new VVoice(new QVoice([8, 4, 8, 8, 8]));		
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteVal.Nv4]);
		this.assertEquals(4, beamgroups.length);
		this.assertEquals(1, beamgroups[0].vnotes.length);
		this.assertEquals(1, beamgroups[1].vnotes.length);
		this.assertEquals(1, beamgroups[2].vnotes.length);
		this.assertEquals(2, beamgroups[3].vnotes.length);
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteVal.Nv4dot]);
		this.assertEquals(3, beamgroups.length);
		this.assertEquals(1, beamgroups[0].vnotes.length);
		this.assertEquals(1, beamgroups[1].vnotes.length);
		this.assertEquals(3, beamgroups[2].vnotes.length);
		
		
		var vvoice = new VVoice(new QVoice([.2, 16, 16, 16, 16]));		
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteVal.Nv4]);
		
		this.assertEquals(2, beamgroups.length);
		this.assertEquals(1, beamgroups[0].vnotes.length);
		this.assertEquals(4, beamgroups[1].vnotes.length);	
		
		//-------------------------------------------------------------------
		// pauses...
		
		var vvoice = new VVoice(new NVoice([new NNote(
			ENoteType.Pause(0), ENoteVal.Nv8), 
			new QNote8(),
			new QNote8(),
			new QNote8(),
			new QNote8(), 
			new QNote8(),
			]));
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteVal.Nv4]);
		this.assertEquals(beamgroups.length, 4);
		this.assertEquals(beamgroups.first().vnotes.length, 1);
		this.assertEquals(beamgroups.second().vnotes.length, 1);
		this.assertEquals(beamgroups.third().vnotes.length, 2);
		this.assertEquals(beamgroups.fourth().vnotes.length, 2);

		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteVal.Nv4dot]);
		this.assertEquals(beamgroups.length, 3);
		this.assertEquals(beamgroups.first().vnotes.length, 1);
		this.assertEquals(beamgroups.second().vnotes.length, 2);
		this.assertEquals(beamgroups.third().vnotes.length, 3);

		var vvoice = new VVoice(new NVoice([new NNote(
			ENoteType.Pause(0), ENoteVal.Nv8), 
			new QNote4(),
			new QNote8(),
			new QNote8(), 
			new QNote8(),
			]));
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteVal.Nv4]);
		this.assertEquals(beamgroups.length, 4);
		this.assertEquals(beamgroups.first().vnotes.length, 1);
		this.assertEquals(beamgroups.second().vnotes.length, 1);
		this.assertEquals(beamgroups.third().vnotes.length, 1);
		this.assertEquals(beamgroups.fourth().vnotes.length, 2);

		var vvoice = new VVoice(new NVoice([new NNote(
			ENoteType.Pause(0), ENoteVal.Nv8), 
			new QNote4(),
			new QNote8(),
			new QNote8(), 
			new QNote8(),
			]));
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteVal.Nv4dot]);
		this.assertEquals(beamgroups.length, 3);
		this.assertEquals(beamgroups.first().vnotes.length, 1);
		this.assertEquals(beamgroups.second().vnotes.length, 1);
		this.assertEquals(beamgroups.third().vnotes.length, 3);

		var vvoice = new VVoice(new NVoice([
			new NNote(ENoteType.Pause(0), ENoteVal.Nv16), 
			new QNote16(),
			new QNote16(),
			new QNote16(),
			new QNote16(),
			new QNote8(),
			new QNote16(),
			new QNote8(), 
			new QNote16(),
			new QNote16(),
		]));
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteVal.Nv4]);
		this.assertEquals(beamgroups.length, 4);
		this.assertEquals(beamgroups.first().vnotes.length, 1);
		this.assertEquals(beamgroups.second().vnotes.length, 3);
		this.assertEquals(beamgroups.third().vnotes.length, 3);
		this.assertEquals(beamgroups.last().vnotes.length, 3);
		
		var vvoice = new VVoice(new NVoice([
			new NNote(ENoteType.Pause(0), ENoteVal.Nv16), 
			new QNote16(),
			new QNote16(),
			new QNote16(),
			new QNote16(),
			new QNote8(),
			new NNote(ENoteType.Pause(0), ENoteVal.Nv16),
			new QNote8(), 
			new QNote16(),
			new NNote(ENoteType.Pause(0), ENoteVal.Nv16),
		]));
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteVal.Nv4]);
		this.assertEquals(beamgroups.length, 6);
		
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
	
	public function testBeamgroupValue()
	{
		var vvoice = new VVoice(new QVoice([8, 8, 8, 8, 8, 8]));
		var beamgroups:Array<VBeamgroup> = vvoice.getBeamgroups([ENoteVal.Nv4]);		
		this.assertEquals(beamgroups.length, 3);
		this.assertEquals(beamgroups.first().getValue(), ENoteVal.Nv4.value());
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
		this.assertEquals(1, vcomplex.getVNotes().length);
		var signs = vcomplex.getSigns();
		this.assertEquals(signs[0].sign, ESign.None);
		this.assertEquals(signs[0].level, 0);
		
		var vcomplex = new VComplex([new VNote(new QNote4(2, '#')), new VNote(new QNote4(-3, 'n'))]);
		this.assertEquals(2, vcomplex.getVNotes().length);
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
		this.assertEquals(2, vcomplex.getVNotes().length);
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
		this.assertEquals(complexes[0].getVNotes().length, 2);
		this.assertEquals(complexes[1].getVNotes().length, 2);
		this.assertEquals(complexes[2].getVNotes().length, 1);
		this.assertEquals(complexes[3].getVNotes().length, 2);
		
		var vvoice0 = new VVoice(new QVoice([4, 8, 8, 4, 4]));
		var vvoice1 = new VVoice(new QVoice([.4, .4, 4]));
		var generator = new VPartComplexesGenerator([vvoice0, vvoice1]);
		var complexes = generator.getComplexes();
		
		this.assertEquals(generator.positionsMap.keys().keysToArray().sorta().toString(), [0, 3024, 4536, 6048, 9072].toString());	
		this.assertEquals(complexes.length, 5);
		this.assertEquals(complexes[0].getVNotes().length, 2);
		this.assertEquals(complexes[1].getVNotes().length, 1);
		this.assertEquals(complexes[2].getVNotes().length, 2);
		this.assertEquals(complexes[3].getVNotes().length, 1);
		this.assertEquals(complexes[4].getVNotes().length, 2);
		
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
		
		var vcomplexes = vpart.getVComplexes();
		this.assertEquals(vcomplexes.length, 4);
		var positions = vpart.getPositionsVComplexes().keys().keysToArray();
		this.assertEquals([0, 3024, 4536, 6048].toString(), positions.toString());
	}
	
	public function testPartbeamgroups()
	{
		var vpart = new VPart(new NPart([
			new QVoice([4, 8, 8, 2]),
			new QVoice([.2, 4]),
		]));
		
		this.assertEquals(vpart.getPartbeamgroups().length, 2);
		this.assertEquals(vpart.getPartbeamgroups().first().length, 3);
		this.assertEquals(vpart.getPartbeamgroups().second().length, 2);
	}
	
	public function testPartbeamgroupsDirectionsOneVoice()
	{
		var vpart = new VPart(new NPart([
			new QVoice([8,8,8,8,8,8], [0,0,1,1,-2,-2]),
		]));
		var beamgroupsDirections = vpart.getBeamgroupsDirections();
		var partbeamgroups = vpart.getPartbeamgroups();
		this.assertEquals(partbeamgroups.length, 1);
		this.assertEquals(partbeamgroups.first().length, 3);
		var beamgroups = partbeamgroups.first();
		this.assertEquals(beamgroupsDirections.get(beamgroups.first()), EDirectionUD.Down);
		this.assertEquals(beamgroupsDirections.get(beamgroups.second()), EDirectionUD.Up);
		this.assertEquals(beamgroupsDirections.get(beamgroups.third()), EDirectionUD.Down);
		
		var vpart = new VPart(new NPart([
			new QVoice([8,8,8,8,8,8], [0,0,1,1,-2,-2], EDirectionUAD.Up),
		]));
		var beamgroupsDirections = vpart.getBeamgroupsDirections();
		var partbeamgroups = vpart.getPartbeamgroups();
		this.assertEquals(partbeamgroups.length, 1);
		this.assertEquals(partbeamgroups.first().length, 3);
		var beamgroups = partbeamgroups.first();
		this.assertEquals(beamgroupsDirections.get(beamgroups.first()), EDirectionUD.Up);
		this.assertEquals(beamgroupsDirections.get(beamgroups.second()), EDirectionUD.Up);
		this.assertEquals(beamgroupsDirections.get(beamgroups.third()), EDirectionUD.Up);
	}
	
	public function testPartbeamgroupsDirectionsTwoVoices()
	{
		var vpart = new VPart(new NPart([
			new QVoice([8, 8, 8, 8], [ -1, -1, -1, -1]),
			new QVoice([8,8], [1, 1]),
		]));	
		var beamgroupsDirections = vpart.getBeamgroupsDirections();
		var partbeamgroups = vpart.getPartbeamgroups();		
		var beamgroups0 = partbeamgroups.first();
		var beamgroups1 = partbeamgroups.second();
		this.assertEquals(beamgroups0.length, 2);
		this.assertEquals(beamgroups1.length, 1);
		this.assertEquals(beamgroupsDirections.get(beamgroups0.first()), EDirectionUD.Up);
		this.assertEquals(beamgroupsDirections.get(beamgroups0.second()), EDirectionUD.Down);
		this.assertEquals(beamgroupsDirections.get(beamgroups1.first()), EDirectionUD.Down);
		
		var vpart = new VPart(new NPart([
			new QVoice([8,8], [-1, -1]),
			new QVoice([8, 8, 8, 8], [ 1,1,1,1]),
		]));	
		var beamgroupsDirections = vpart.getBeamgroupsDirections();
		var partbeamgroups = vpart.getPartbeamgroups();		
		var beamgroups0 = partbeamgroups.first();
		var beamgroups1 = partbeamgroups.second();
		this.assertEquals(beamgroups0.length, 1);
		this.assertEquals(beamgroups1.length, 2);
		this.assertEquals(beamgroupsDirections.get(beamgroups0.first()), EDirectionUD.Up);
		this.assertEquals(beamgroupsDirections.get(beamgroups1.first()), EDirectionUD.Down);
		this.assertEquals(beamgroupsDirections.get(beamgroups1.second()), EDirectionUD.Up);
		
		var vpart = new VPart(new NPart([
			new QVoice([8, 8, 8, 8], [ -1, -1, -1, -1]),
			new QVoice([4], [1]),
		]));	
		var beamgroupsDirections = vpart.getBeamgroupsDirections();
		var partbeamgroups = vpart.getPartbeamgroups();		
		var beamgroups0 = partbeamgroups.first();
		var beamgroups1 = partbeamgroups.second();
		this.assertEquals(beamgroups0.length, 2);
		this.assertEquals(beamgroups1.length, 1);
		this.assertEquals(beamgroupsDirections.get(beamgroups0.first()), EDirectionUD.Up);
		this.assertEquals(beamgroupsDirections.get(beamgroups0.second()), EDirectionUD.Down);
		this.assertEquals(beamgroupsDirections.get(beamgroups1.first()), EDirectionUD.Down);		
		
		var vpart = new VPart(new NPart([
			new QVoice([8, 8, 8, 8], [ -1, -1, -1, -1]),
			new QVoice([.4], [1]),
		]));	
		var beamgroupsDirections = vpart.getBeamgroupsDirections();
		var partbeamgroups = vpart.getPartbeamgroups();		
		var beamgroups0 = partbeamgroups.first();
		var beamgroups1 = partbeamgroups.second();
		this.assertEquals(beamgroups0.length, 2);
		this.assertEquals(beamgroups1.length, 1);
		this.assertEquals(beamgroupsDirections.get(beamgroups0.first()), EDirectionUD.Up);
		this.assertEquals(beamgroupsDirections.get(beamgroups0.second()), EDirectionUD.Up);
		this.assertEquals(beamgroupsDirections.get(beamgroups1.first()), EDirectionUD.Down);				
		
		var vpart = new VPart(new NPart([
			new QVoice([8, 8, 8, 8], [ -1, -1, -1, -1]),
			new QVoice([.4, 8], [1, 1]),
		]));	
		var beamgroupsDirections = vpart.getBeamgroupsDirections();
		var partbeamgroups = vpart.getPartbeamgroups();		
		var beamgroups0 = partbeamgroups.first();
		var beamgroups1 = partbeamgroups.second();
		this.assertEquals(beamgroups0.length, 2);
		this.assertEquals(beamgroups1.length, 2);
		this.assertEquals(beamgroupsDirections.get(beamgroups0.first()), EDirectionUD.Up);
		this.assertEquals(beamgroupsDirections.get(beamgroups0.second()), EDirectionUD.Up);
		this.assertEquals(beamgroupsDirections.get(beamgroups1.first()), EDirectionUD.Down);				
		this.assertEquals(beamgroupsDirections.get(beamgroups1.second()), EDirectionUD.Down);				
		
		var vpart = new VPart(new NPart([
			new QVoice([8, 8, 8, 8], [ -1, -1, -1, -1]),
			new QVoice([.4, 8, 8], [1, 1, 1]),
		]));	
		var beamgroupsDirections = vpart.getBeamgroupsDirections();
		var partbeamgroups = vpart.getPartbeamgroups();		
		var beamgroups0 = partbeamgroups.first();
		var beamgroups1 = partbeamgroups.second();
		this.assertEquals(beamgroups0.length, 2);
		this.assertEquals(beamgroups1.length, 3);
		this.assertEquals(beamgroupsDirections.get(beamgroups1.third()), EDirectionUD.Up);				
	
		var vpart = new VPart(new NPart([
			new QVoice([8, 8, 8, 8, 8, 8], [ -1, -1, -1, -1, -1, -1]),
			new QVoice([.4, 8, 8], [1, 1, 1]),
		]));	
		var beamgroupsDirections = vpart.getBeamgroupsDirections();
		var partbeamgroups = vpart.getPartbeamgroups();		
		var beamgroups0 = partbeamgroups.first();
		var beamgroups1 = partbeamgroups.second();
		this.assertEquals(beamgroups0.length, 3);
		this.assertEquals(beamgroups1.length, 3);
		this.assertEquals(beamgroupsDirections.get(beamgroups0.third()), EDirectionUD.Up);			
		this.assertEquals(beamgroupsDirections.get(beamgroups1.third()), EDirectionUD.Down);			
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
		var columns:VColumns = generator.getColumns();
		this.assertFalse(false);
		this.assertEquals(generator.positions.toString(), [0, 3024, 4536, 6048, 9072].toString());
		
		var column0:VColumn = columns[0];
		this.assertEquals(column0.vcomplexes.length, 2);
		this.assertEquals(vpart0.getVVoices()[0].getVNotes()[0], column0.vcomplexes[0].getVNotes()[0]);
		this.assertEquals(vpart1.getVVoices()[0].getVNotes()[0], column0.vcomplexes[1].getVNotes()[0]);
		this.assertTrue(columns[1].vcomplexes[0] == null);
		this.assertEquals(vpart1.getVVoices()[0].getVNotes()[1], columns[1].vcomplexes[1].getVNotes()[0]);
	}

	public function testVBarValue()
	{
		var npart0 = new NPart([
			new QVoice([4]),
			new QVoice([4,4]),
		]);
		var npart1 = new NPart([
			new QVoice([4,4,4,4]),
			new QVoice([4, 4, 4])
		]);
		var vbar = new VBar(new NBar([npart0, npart1]));
		var value = vbar.getValue();
		this.assertEquals(value, ENoteVal.Nv4.value() * 4);
	}
	
	public function testVBar()
	{
		var npart0 = new NPart([
			new QVoice([2]),
			new QVoice([.4, 8]),
		]);
		var npart1 = new NPart([
			new QVoice([8, .4]),
			new QVoice([4, 4])
		]);
		var vbar = new VBar(new NBar([npart0, npart1]));
		var positionsColumns : IntMap<VColumn> = vbar.getPositionsColumns();
		this.assertEquals(positionsColumns.keys().keysToArray().toString(), [0, 1512, 3024, 4536].toString());
	}

	public function testVBarAttributes()
	{
		var n0 = new NPart([new QVoice([4, 4, 4])], EClef.ClefC, EKey.Flat2);
		var n1 = new NPart([new QVoice([4, 4, 4])], EClef.ClefF, EKey.Sharp3);
		var b0 = new VBar(new NBar([n0, n1], ETime.Time12_8));
		this.assertEquals(b0.clefs.toString(), [EClef.ClefC, EClef.ClefF].toString());
		this.assertEquals(b0.keys.toString(), [EKey.Flat2, EKey.Sharp3].toString());
		this.assertEquals(b0.time, ETime.Time12_8);
		
		var n0 = new NPart([new QVoice([4, 4, 4])], EKey.Flat2);
		var n1 = new NPart([new QVoice([4, 4, 4])], EClef.ClefF);
		var b0 = new VBar(new NBar([n0, n1]));
		this.assertEquals(b0.clefs.toString(), [null, EClef.ClefF].toString());
		this.assertEquals(b0.keys.toString(), [EKey.Flat2, null].toString());
		this.assertEquals(b0.time, null);
		this.assertEquals(b0.displayClefs, EDisplayALN.Layout);
		this.assertEquals(b0.displayKeys, EDisplayALN.Layout);
		this.assertEquals(b0.displayTime, EDisplayALN.Layout);
		
		var n0 = new NPart([new QVoice([4, 4, 4])], EClef.ClefC, EDisplayALN.Never, EKey.Flat2, EDisplayALN.Never);
		var n1 = new NPart([new QVoice([4, 4, 4])], EClef.ClefF, EDisplayALN.Never, EKey.Sharp3, EDisplayALN.Never);
		var b0 = new VBar(new NBar([n0, n1], ETime.Time12_8, EDisplayALN.Never));
		this.assertEquals(b0.clefs.toString(), [EClef.ClefC, EClef.ClefF].toString());
		this.assertEquals(b0.keys.toString(), [EKey.Flat2, EKey.Sharp3].toString());
		this.assertEquals(b0.time, ETime.Time12_8);
		this.assertEquals(b0.displayClefs, EDisplayALN.Never);
		this.assertEquals(b0.displayKeys, EDisplayALN.Never);
		this.assertEquals(b0.displayTime, EDisplayALN.Never);

		var n0 = new NPart([new QVoice([4, 4, 4])], EClef.ClefC, EDisplayALN.Never, EKey.Flat2, EDisplayALN.Always);
		var n1 = new NPart([new QVoice([4, 4, 4])], EClef.ClefF, EDisplayALN.Layout, EKey.Sharp3, EDisplayALN.Never);
		var b0 = new VBar(new NBar([n0, n1], ETime.Time12_8, EDisplayALN.Always));
		this.assertEquals(b0.clefs.toString(), [EClef.ClefC, EClef.ClefF].toString());
		this.assertEquals(b0.keys.toString(), [EKey.Flat2, EKey.Sharp3].toString());
		this.assertEquals(b0.time, ETime.Time12_8);
		this.assertEquals(b0.displayClefs, EDisplayALN.Layout);
		this.assertEquals(b0.displayKeys, EDisplayALN.Always);
		this.assertEquals(b0.displayTime, EDisplayALN.Always);
	}
	
	
	
	
	public function testVBarVNoteVColumn()
	{
		var npart0 = new NPart([
			new QVoice([2]),
			new QVoice([.4, 8]),
		]);
		var npart1 = new NPart([
			new QVoice([8, .4]),
			new QVoice([4, 4])
		]);
		var vbar = new VBar(new NBar([npart0, npart1]));
		var vnotesVColumns = vbar.getVNotesVColumns();
		
		var vnote = vbar.getVParts()[0].getVVoices()[0].getVNotes()[0];
		var vcolumn = vbar.getVColumns()[0];
		this.assertEquals(vnotesVColumns.get(vnote), vcolumn);

		var vnote = vbar.getVParts()[0].getVVoices()[1].getVNotes()[1];
		var vcolumn = vbar.getVColumns()[3];
		this.assertEquals(vnotesVColumns.get(vnote), vcolumn);

		var vnote = vbar.getVParts()[1].getVVoices()[0].getVNotes()[1];
		var vcolumn = vbar.getVColumns()[1];
		this.assertEquals(vnotesVColumns.get(vnote), vcolumn);
		
		var vnote = vbar.getVParts()[1].getVVoices()[1].getVNotes()[1];
		var vcolumn = vbar.getVColumns()[2];
		this.assertEquals(vnotesVColumns.get(vnote), vcolumn);
	}
	
	public function testVBarComplexColumn()
	{
		var npart0 = new NPart([
			new QVoice([2]),
			new QVoice([.4, 8]),
		]);
		var npart1 = new NPart([
			new QVoice([8, .4]),
			new QVoice([4, 4])
		]);
		var vbar = new VBar(new NBar([npart0, npart1]));		
		var vcomplexVColumns = vbar.getVComplexesVColumns();
		
		var vcomplex = vbar.getVParts().first().getVComplexes().first();
		this.assertEquals(vcomplex.getVNotes().length, 2);
		var vcolumn = vbar.getVColumns().first();
		this.assertEquals(vcolumn.vcomplexes.length, 2);
		this.assertEquals(vbar.getVColumnsPositions().get(vcolumn), 0);
		this.assertEquals(vbar.getVComplexesVColumns().get(vcomplex), vcolumn);
		
		var vcomplex = vbar.getVParts().second().getVComplexes().second();
		var vcolumn = vbar.getVColumns().second();
		this.assertEquals(vbar.getVComplexesVColumns().get(vcomplex), vcolumn);
	}
	
	
}