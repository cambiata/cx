package nx3.test;
import haxe.unit.TestCase;
import nx3.elements.ENoteValue;
import nx3.elements.NVoice;
import nx3.elements.VTree;
import nx3.elements.VTree.VNote;
import nx3.elements.VTree.VVoice;
import nx3.test.QNote.QNote2;
import nx3.test.QNote.QNote4;
import nx3.test.QNote.QNote8;

/**
 * ...
 * @author Jonas Nyström
 */
@:access(nx3.elements.VVoice)
class TestVTree extends TestCase
{
	
	public function test1() 
	{
		var qnote = new QNote([ -2, 1]);
		var vnote = new VNote(qnote);
		this.assertEquals(ENoteValue.Nv4, vnote.nnote.value);
		
	}

	public function test2()
	{
		var qvoice = new QVoice([4, 8, 8, 2]);
		var vvoice = new VVoice(qvoice);
		this.assertEquals(4, vvoice.nvoice.notes.length);
		this.assertEquals(4, vvoice.getVNotes().length);
		this.assertEquals(ENoteValue.Nv8, vvoice.getVNotes()[1].nnote.value);
		this.assertEquals(ENoteValue.Nv2, vvoice.getVNotes()[3].nnote.value);
		
		this.assertEquals(0, vvoice.getVNotePosition(vvoice.getVNotes()[0]));
		this.assertEquals(ENoteValue.Nv4.value, vvoice.getVNotePosition(vvoice.getVNotes()[1]));
		this.assertEquals(ENoteValue.Nv4.value+ENoteValue.Nv8.value, vvoice.getVNotePosition(vvoice.getVNotes()[2]));
		this.assertEquals(ENoteValue.Nv4.value+ENoteValue.Nv8.value+ENoteValue.Nv8.value, vvoice.getVNotePosition(vvoice.getVNotes()[3]));
	}
	
	// Test lazy instatioation (private variables!)
	public function test3()
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
	
}