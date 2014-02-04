package nx3.test;
import haxe.ds.IntMap.IntMap;
import nx3.elements.NBar;
import nx3.elements.NPart;
import nx3.elements.VTree;
import nx3.render.FrameRenderer;
import nx3.render.scaling.Scaling;
import nx3.render.scaling.TScaling;
import nx3.render.tools.RenderTools;
import nx3.test.TestVRender.DevRenderer;

#if (nme)
import nme.display.Sprite;
import nme.Lib;
#else
import flash.display.Sprite;
import flash.Lib;
#end

using nx3.elements.VTree.VMapTools;
using cx.ArrayTools;

/**
 * ...
 * @author Jonas Nyström
 */
class TestVRender extends  haxe.unit.TestCase 
{
	var target:Sprite;
	var renderer:DevRenderer;

	public function new() 
	{
		super();
		this.target = Lib.current;
		this.renderer = new DevRenderer(this.target, Scaling.SMALL);
	}

	public function test0()
	{
		this.assertEquals(1, 1);
		//this.renderer.notelines(10, 50, 300);
	}
	
	public function testVBar()
	{
		this.assertTrue(true);
		
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

		var py = 100;
		for (vpart in vbar.getVParts())
		{
			this.renderer.notelines(10, 	py, 500);
			py += 120;
		}

		var py = 100;
		for (vpart in vbar.getVParts())
		{
			for (vvoice in vpart.getVVoices())
			{
				for (vnote in vvoice.getVNotes())
				{
					var vcolumn = vbar.getVNotesVColumns().get(vnote);
					var pos = vbar.getVColumnsPositions().get(vcolumn);
					var x = 10 + pos / 20;
					this.target.graphics.beginFill(0xff0000);
					var space = this.renderer.scaling.space;
					var ydiff =  (vvoice == vpart.getVVoices().first()) ? space : -space;
					this.target.graphics.drawCircle(x, py+ydiff, 5);
				}
			}
			py += 120;
		}	
		
		
	}
	
	
	
	
	
#if (nme)	
	override public function tearDown()
	{
		var filename = Type.getClassName(Type.getClass(this)) + '.png';
		RenderTools.spriteToPng(this.target, filename);
	}
#end	
	
}

class DevRenderer extends FrameRenderer
{
	
	
}