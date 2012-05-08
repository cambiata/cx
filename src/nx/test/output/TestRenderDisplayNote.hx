package nx.test.output;
import nx.element.Note;
import nx.element.Head;
import nx.enums.ESign;
import nx.enums.ENoteValue;
import nx.display.DisplayNote;
import nx.output.Scaling;
import nx.test.base.RenderBase;

/**
 * ...
 * @author Jonas Nyström
 */

class TestRenderDisplayNote extends RenderBase
{
	override public function init() {
		setScaling(Scaling.getMid());
		super.init();
	}
	public function test0() {
		var dn = new DisplayNote(Note.getNew([Head.getNew( -2, ESign.Flat), Head.getNew(-1, ESign.None), Head.getNew(0, ESign.None), Head.getNew(1, ESign.Sharp), Head.getNew( 5, ESign.Natural)], ENoteValue.Nv4));		
		
		var y = RenderBase.Y100;
		var x = 150;
		render.note(x, y, dn);			
	}
	
	public function test1() {
		
		
	}
	
}