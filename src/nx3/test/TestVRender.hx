package nx3.test;


import haxe.ds.IntMap.IntMap;

import nx3.elements.EDirectionUAD;
import nx3.elements.ENoteValue;
import nx3.elements.NBar;
import nx3.elements.NHead;
import nx3.elements.NNote;
import nx3.elements.NPart;
import nx3.elements.NVoice;
import nx3.elements.VTree;
import nx3.geom.Rectangle;
import nx3.render.FrameRenderer;
import nx3.render.scaling.Scaling;
import nx3.render.scaling.TScaling;
import nx3.render.tools.RenderTools;
import nx3.test.QNote.QNote2;
import nx3.test.TestVRender.DevRenderer;

#if (nme)
import nme.text.TextFormat;
import nme.text.TextField;
import nme.display.Sprite;
import nme.Lib;
#else
import flash.text.TextFormat;
import flash.text.TextField;
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
		this.renderer = new DevRenderer(this.target, Scaling.BIG);
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
			new QVoice([2], [-2]),
			new QVoice([.4, 8], [2, 2]),
		]);
		var npart1 = new NPart([
			new QVoice([8, .4], [-2, -2]),
			new QVoice([4, 4], [2, 2])
		]);
		
		var vbar = new VBar(new NBar([npart0, npart1]));
		
		//this.assertEquals(positionsColumns.keys().keysToArray().toString(), [0, 1512, 3024, 4536].toString());
		this.renderer.setDefaultXY(200, 80);
		this.renderer.drawVBarNotelines(vbar, 400, -30);
		this.renderer.drawVBarColumns(vbar);
		this.renderer.drawVBarComplexes(vbar);
		this.renderer.drawVBarVoices(vbar);		
	
	}
	
	public function testVBar1()
	{
		this.assertTrue(true);
		
		var npart0 = new NPart([
			new NVoice([
				//new QNote2([ -2, -3]),
				new NNote([new NHead( -2), new NHead( -3)], ENoteValue.Nv1, EDirectionUAD.Up),
			]),
			
			new QVoice([.4, 8], [2, 2]),
		]);
		var npart1 = new NPart([
			new QVoice([8, .4], [-2, -2]),
			new QVoice([4, 4], [2, 2])
		]);
		
		var vbar = new VBar(new NBar([npart0, npart1]));
		
		//this.assertEquals(positionsColumns.keys().keysToArray().toString(), [0, 1512, 3024, 4536].toString());
	
		
		this.renderer.setDefaultXY(700, 80);
		this.renderer.drawVBarNotelines(vbar, 400, -30);
		this.renderer.drawVBarColumns(vbar);
		this.renderer.drawVBarComplexes(vbar);
		this.renderer.drawVBarVoices(vbar);
	
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
	public var partdistance(default, default):Float = 120;
	public var defaultX(default, default):Float = 40;
	public var defaultY(default, default):Float = 80;
	
	public function setDefaultXY(x:Float, y:Float)
	{
		this.defaultX = x;
		this.defaultY = y;
	}
	
	public function vnoteheads(vnote:VNote, x:Float, y:Float, fill:Int = 0x00FF00)
	{
		this.target.graphics.beginFill(fill);
		//this.target.graphics.drawCircle(x, y, this.scaling.space);
		for (rect in vnote.getVHeadsRectangles())
		{
			this.drawRect(rect, x, y);
		}
	}
	
	public function drawVBarNotelines(vbar:VBar, width:Float=800, xMinus:Float=-50)
	{
		var y = this.defaultY;
		
		for (vpart in vbar.getVParts())
		{
			this.notelines(this.defaultX+xMinus, y, width);
			y += this.partdistance;
		}
	}
	
	public function drawVBarColumns(vbar:VBar)
	{
		var height = (vbar.getVParts().length-1) * this.partdistance;
		var positionsColumns : IntMap<VColumn> = vbar.getPositionsColumns();
		for (pos in positionsColumns.keys())
		{
			var colx = pos  / 20;			
			//var r = new Rectangle(colx - 2, this.defaultY, 4, height);
			this.target.graphics.endFill();
			this.target.graphics.lineStyle(1, 0x0000ff);
			this.target.graphics.moveTo(this.defaultX + colx, this.defaultY - this.scaling.space*3);
			this.target.graphics.lineTo(this.defaultX + colx, this.defaultY + height + this.scaling.space*3);
			
			//this.target.graphics.drawRect(this.defaultX + colx - 2, this.defaultY, 4, height);
			//this.drawRect(new Rectangle( -2, 0,  4, height), colx, this.defaultY, 0x0000ff); 
		}
	}
	
	public function drawVBarComplexes(vbar:VBar)
	{
		var party = this.defaultY;
		for (vpart in vbar.getVParts())
		{
			for (vcomplex in vpart.getVComplexes())
			{
				var vcolumn = vbar.getVComplexesVColumns().get(vcomplex);
				var pos = vbar.getVColumnsPositions().get(vcolumn);
				var colx = this.defaultX + pos  / 20;
				this.target.graphics.endFill();
				this.target.graphics.lineStyle(1, 0xFF0000);
				this.target.graphics.drawRect(colx - 5, party - 5, 10, 10); 
				for (vnote in vcomplex.getVNotes())
				{
					var vvoice = vpart.getVNotesVVoices().get(vnote);
					var vvoiceIdx = vpart.getVVoices().index(vvoice);
					var color = (vvoiceIdx == 0) ? 0x00FF00 : 0x0000FF;
					this.vnoteheads(vnote, colx, party, color);
				}
			}
			party += this.partdistance;
		}
	}
	
	public function drawVBarVoices(vbar:VBar)
	{
		var party = this.defaultY;
		for (vpart in vbar.getVParts())
		{
			for (beamgroups in vpart.getPartbeamgroups())
			{
				var vvoiceIdx = vpart.getPartbeamgroups().index(beamgroups);
			//}
			//for (vvoice in vpart.getVVoices())
			//{
				///var vvoiceIdx = vpart.getVVoices().index(vvoice);
				for (beamgroup in beamgroups)
				{
					var beamgroupIdx =beamgroups.index(beamgroup);
					
					for (vnote in beamgroup.vnotes)
					{
						var vnoteIdx = beamgroup.vnotes.index(vnote);
						var vcolumn = vbar.getVNotesVColumns().get(vnote);
						var pos = vbar.getVColumnsPositions().get(vcolumn);
						var colx = this.defaultX + pos  / 20;
						var tf = new TextField();
						tf.defaultTextFormat = new TextFormat('Arial', 10);
						tf.text = '$beamgroupIdx';
						tf.x = colx;
						tf.y = party + ((vvoiceIdx == 0) ? this.scaling.space * -3 :  this.scaling.space * 3)-this.scaling.halfSpace;
						this.target.addChild(tf);						
					}
				}
			}
			party += this.partdistance;
		}
	}
}


