package nx.test;
import nx.element.Head;
import nx.display.DisplayHead;
import nx.element.Note;
import nx.display.DisplayNote;
import nx.enums.EDirectionUD;
import nx.enums.ESign;

/**
 * ...
 * @author Jonas Nyström
 */

class TestDisplayNote extends haxe.unit.TestCase {
	
	public function test1() {
		var dn = new DisplayNote(Note.getNew([Head.getNew( -2), Head.getNew(2)]));
		assertTrue(dn != null);
		assertEquals(2, dn.getDisplayHeads().length);
		assertEquals( -2, dn.getDisplayHead(0).getLevel());
		assertEquals(0, dn.getLevel());
	}
	
	public function test2() {
		var dn = new DisplayNote(Note.getNew([Head.getNew( -3), Head.getNew(2)]));
		assertEquals( -1, dn.getLevel());		
		assertEquals(EDirectionUD.Down, dn.getDirection());		
		
		var dn = new DisplayNote(Note.getNew([Head.getNew( -2), Head.getNew(3)]));
		assertEquals(EDirectionUD.Up, dn.getDirection());
		
		var dn = new DisplayNote(Note.getNew([Head.getNew( -3), Head.getNew(2)]), EDirectionUD.Up);
		assertEquals(EDirectionUD.Up, dn.getDirection());
	}
	
	public function test3() {
		var dn = new DisplayNote(Note.getNew([Head.getNew(-1), Head.getNew(0)]));
		assertEquals(EDirectionUD.Down, dn.getDirection());
		assertEquals([0, -1].toString(), dn.getDisplayHeadPositions().toString());
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(-1), Head.getNew(0)]), EDirectionUD.Up);
		assertEquals(EDirectionUD.Up, dn.getDirection());
		assertEquals([1, 0].toString(), dn.getDisplayHeadPositions().toString());
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(1), Head.getNew(0)]));
		assertEquals(EDirectionUD.Up, dn.getDirection());
		assertEquals([1, 0].toString(), dn.getDisplayHeadPositions().toString());		
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(1), Head.getNew(0)]), EDirectionUD.Down);
		assertEquals(EDirectionUD.Down, dn.getDirection());
		assertEquals([0, -1].toString(), dn.getDisplayHeadPositions().toString());		
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(1), Head.getNew(0)]));
		assertEquals(EDirectionUD.Up, dn.getDirection());
		assertEquals([1, 0].toString(), dn.getDisplayHeadPositions().toString());		
		dn.setDirection(EDirectionUD.Down);
		assertEquals(EDirectionUD.Down, dn.getDirection());
		assertEquals([0, -1].toString(), dn.getDisplayHeadPositions().toString());			
	}
	
	public function test4() {		
		var dn = new DisplayNote(Note.getNew([Head.getNew(0)]));
		//trace(dn.getSigns());				
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat)]));
		//trace(dn.getSigns());
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat), Head.getNew(1, ESign.Flat)]));
		//trace(dn.getSigns());
		assertEquals(0, dn.getSigns()[0].position);
		assertEquals(1, dn.getSigns()[1].position);

		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat), Head.getNew(5, ESign.Flat)]));
		//trace(dn.getSigns());
		assertEquals(0, dn.getSigns()[0].position);
		assertEquals(1, dn.getSigns()[1].position);		
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat), Head.getNew(6, ESign.Flat)]));
		//trace(dn.getSigns());
		assertEquals(0, dn.getSigns()[0].position);
		assertEquals(0, dn.getSigns()[0].position);
	}
	
	public function test5() {		
		var dn = new DisplayNote(Note.getNew([Head.getNew(0)]));
		assertEquals(0, dn.getDisplayHeadTopPosition());
		assertEquals(0, dn.getDisplayHeadBottomPosition());

		var dn = new DisplayNote(Note.getNew([Head.getNew(0), Head.getNew(1)]));
		assertEquals(1, dn.getDisplayHeadTopPosition());
		assertEquals(0, dn.getDisplayHeadBottomPosition());
		assertEquals(EDirectionUD.Up, dn.getDirection());
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(-1), Head.getNew(0)]));
		assertEquals(0, dn.getDisplayHeadTopPosition());
		assertEquals( -1, dn.getDisplayHeadBottomPosition());
		assertEquals(EDirectionUD.Down, dn.getDirection());		
	}
		
}
