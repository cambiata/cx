package sx.player.grid;
import cx.flash.layout.DocumentLayout.DocInfo;
import cx.XmlTools;
import flash.geom.Rectangle;

/**
 * ...
 * @author Jonas Nyström
 */
class GridProcessor
{
	private var gridSystems:GridSystems;
	private var pageSystems:PageSystems;
	private var pageBars:PageBars;
	
	public function new() 
	{
		this.gridSystems = this.xmlToGridSystems(this.testXml());
		trace(this.gridSystems);
		//this.gridSystems = createGridSystems();
		//trace(this.gridSystems);
		this.debugGridSystems(this.gridSystems);
	}
	
	public function getPageBars(docInfo:DocInfo):PageBars
	{		
		this.pageBars = [];
		
		for (gridSystem in gridSystems.systems)
		{		
			var pageNr:Int = gridSystem.pageNr;
			if (pageNr > docInfo.pageInfos.length) throw "GRID PAGE NR OVERFLOW";
			
			//trace(pageNr + ' ' + docInfo.pageInfos[pageNr].rect);
			var pageRect = docInfo.pageInfos[pageNr].rect;
			var pageHeight = pageRect.height;
			var pageWidth = pageRect.width;
			
			var systemRect:Rectangle = new Rectangle(
				pageRect.x + gridSystem.x * pageWidth, 
				pageRect.y + gridSystem.y * pageHeight, 
				gridSystem.width * pageWidth,
				gridSystem.height * pageHeight
				);
			
			if (gridSystem.bars == null || gridSystem.bars.length == 0)
			{
				var pageBar:PageBar = { pos: gridSystem.pos, rect:systemRect  };
				this.pageBars.push(pageBar);
			} 
			else
			{	
				// first bar...
				var barRect:Rectangle = systemRect.clone();
				barRect.width = gridSystem.bars[0].x * pageWidth;
				var pageBar:PageBar = { pos: gridSystem.pos, rect:barRect  };
				trace('first bar');
				this.pageBars.push(pageBar);
				
				for (i in 0...gridSystem.bars.length)
				{
					var gridBar:GridBar = gridSystem.bars[i];
					var barX = systemRect.x + gridBar.x * pageWidth;
					var barX2:Float = 0;
					if (i < gridSystem.bars.length-1)
					{
						trace('Other bar');
						var nextGridBar:GridBar = gridSystem.bars[i + 1];
						barX2 = systemRect.x + nextGridBar.x * pageWidth;						
					}
					else
					{
						trace('Last bar on system');
						barX2 = systemRect.x + systemRect.width;
					}										
					var barRect:Rectangle = new Rectangle(barX, systemRect.y, barX2 - barX, systemRect.height);
					var pageBar:PageBar = { pos: gridBar.pos, rect: barRect };
					this.pageBars.push(pageBar);					
				}				
			}			
		}		
		return this.pageBars;
	}
	
	public function handleMouseDown(pageNr: Int, x:Float, y:Float)
	{
		
		
	}
	
	
	private function createGridSystems():GridSystems
	{
		var gridSystems:GridSystems = { systems: new Array<GridSystem>()};
		var gridSystem:GridSystem = { pos: 0.1, pageNr: 0, x: 0.2, y: 0.2, width: 0.7, height: 0.3, bars: [] };
		gridSystems.systems.push(gridSystem);
		var gridBar:GridBar = { pos: 0.3, x: 0.5 };
		gridSystem.bars.push(gridBar);
		
		var gridSystem:GridSystem = { pos: 0.5, pageNr: 0, x: 0.2, y: 0.6, width: 0.6, height: 0.3, bars: [] };
		gridSystems.systems.push(gridSystem);
		var gridBar:GridBar = { pos: 0.6, x: 0.3 };
		gridSystem.bars.push(gridBar);
		var gridBar:GridBar = { pos: 0.7, x: 0.7 };
		gridSystem.bars.push(gridBar);
		
		var gridSystem:GridSystem = { pos: 0.8, pageNr: 1, x: 0.2, y: 0.3, width: 0.7, height: 0.4, bars: [] };
		gridSystems.systems.push(gridSystem);
		var gridBar:GridBar = { pos: 0.9, x: 0.6 };
		gridSystem.bars.push(gridBar);		
		
		return gridSystems;
	}
	
	private function debugGridSystems(gridSystems:GridSystems)
	{
		for (gridSystem in gridSystems.systems)
		{
			//trace(' - sys ' + gridSystem.pos);
			for (gridBar in gridSystem.bars)
			{
				//trace(' - bar ' + gridBar.pos);
			}
		}
	}
	
	private function xmlToGridSystems(xmlString:String): GridSystems
	{
		var gridSystems:GridSystems = { systems: new Array<GridSystem>() };
		
		var xml:Xml = Xml.parse(xmlString);		
		var items = xml.elements().next().elements();
		
		var gridSystem:GridSystem = null;
		
		for (item in items)
		{
			trace(item.get('type'));
			var pos:Float = getFloat(item.get('pos'));
			var pageNr:Int = Std.parseInt(item.get('page'));
			var x:Float = getFloat(item.get('x'));
			var y:Float = getFloat(item.get('y'));
			var w:Float = getFloat(item.get('w'));
			var h:Float = getFloat(item.get('h'));		
			trace(item.get('pos'));
			
			switch (item.get('type'))
			{
				case 'system':
					gridSystem = { pos: pos, pageNr: pageNr, x: x, y: y, width: w, height: h, bars: [] };	
					gridSystems.systems.push(gridSystem);
				case 'bar':
					var gridBar:GridBar = { pos: pos, x: x };
					gridSystem.bars.push(gridBar);
				default:
			}
		}
		return gridSystems;
	}
	
	private function getFloat(floatStr:String):Float
	{
		floatStr = StringTools.replace(floatStr, ',', '.');
		return Std.parseFloat(floatStr);
	}
	
	private function testXml():String
	{
		return 
		'
<grid id="43" title="Waldesnacht">
<item  pos="0,042894192382784"  type="system"  page="0"   x="0,1765625"  y="0,11335578002245"  w="0,74761904761905" h="0,23456790123457"  />
<item  pos="0,059678876358656"  type="bar"  page="0"   x="0,095238095238095"  y="0,11335578002245"  w="0" h="0,23456790123457"  />
<item  pos="0,076463560334528"  type="bar"  page="0"   x="0,20634920634921"  y="0,11335578002245"  w="0" h="0,23456790123457"  />
<item  pos="0,0932482443104"  type="bar"  page="0"   x="0,29365079365079"  y="0,11335578002245"  w="0" h="0,23456790123457"  />
<item  pos="0,11096541072938"  type="bar"  page="0"   x="0,37301587301587"  y="0,11335578002245"  w="0" h="0,23456790123457"  />
<item  pos="0,12868257714835"  type="bar"  page="0"   x="0,45555555555556"  y="0,11335578002245"  w="0" h="0,23456790123457"  />
<item  pos="0,14266981379491"  type="bar"  page="0"   x="0,56190476190476"  y="0,11335578002245"  w="0" h="0,23456790123457"  />
<item  pos="0,16038698021389"  type="bar"  page="0"   x="0,64603174603175"  y="0,11335578002245"  w="0" h="0,23456790123457"  />
<item  pos="0,17717166418976"  type="system"  page="0"   x="0,1484375"  y="0,4040404040404"  w="0,77777777777778" h="0,23905723905724"  />
<item  pos="0,19768627793805"  type="bar"  page="0"   x="0,11904761904762"  y="0,4040404040404"  w="0" h="0,23905723905724"  />
<item  pos="0,21447096191392"  type="bar"  page="0"   x="0,24761904761905"  y="0,4040404040404"  w="0" h="0,23905723905724"  />
<item  pos="0,23125564588979"  type="bar"  page="0"   x="0,38888888888889"  y="0,4040404040404"  w="0" h="0,23905723905724"  />
<item  pos="0,24710784742256"  type="bar"  page="0"   x="0,51904761904762"  y="0,4040404040404"  w="0" h="0,23905723905724"  />
<item  pos="0,26762246117085"  type="bar"  page="0"   x="0,65873015873016"  y="0,4040404040404"  w="0" h="0,23905723905724"  />
<item  pos="0,28254218026051"  type="system"  page="0"   x="0,1484375"  y="0,69135802469136"  w="0,77619047619048" h="0,25813692480359"  />
<item  pos="0,29932686423638"  type="bar"  page="0"   x="0,11904761904762"  y="0,69135802469136"  w="0" h="0,25813692480359"  />
<item  pos="0,31611154821226"  type="bar"  page="0"   x="0,21746031746032"  y="0,69135802469136"  w="0" h="0,25813692480359"  />
<item  pos="0,33382871463123"  type="bar"  page="0"   x="0,31904761904762"  y="0,69135802469136"  w="0" h="0,25813692480359"  />
<item  pos="0,35154588105021"  type="bar"  page="0"   x="0,41746031746032"  y="0,69135802469136"  w="0" h="0,25813692480359"  />
<item  pos="0,37019552991229"  type="bar"  page="0"   x="0,5047619047619"  y="0,69135802469136"  w="0" h="0,25813692480359"  />
<item  pos="0,38511524900195"  type="bar"  page="0"   x="0,6031746031746"  y="0,69135802469136"  w="0" h="0,25813692480359"  />
<item  pos="0,40096745053472"  type="bar"  page="0"   x="0,6952380952381"  y="0,69135802469136"  w="0" h="0,25813692480359"  />
<item  pos="0,42148206428301"  type="system"  page="1"   x="0,146875"  y="0,088664421997755"  w="0,77619047619048" h="0,25476992143659"  />
<item  pos="0,4419966780313"  type="bar"  page="1"   x="0,077777777777778"  y="0,088664421997755"  w="0" h="0,25476992143659"  />
<item  pos="0,45971384445027"  type="bar"  page="1"   x="0,17619047619048"  y="0,088664421997755"  w="0" h="0,25476992143659"  />
<item  pos="0,47743101086925"  type="bar"  page="1"   x="0,28888888888889"  y="0,088664421997755"  w="0" h="0,25476992143659"  />
<item  pos="0,49235072995891"  type="bar"  page="1"   x="0,3968253968254"  y="0,088664421997755"  w="0" h="0,25476992143659"  />
<item  pos="0,51100037882099"  type="bar"  page="1"   x="0,5047619047619"  y="0,088664421997755"  w="0" h="0,25476992143659"  />
<item  pos="0,53058251012618"  type="bar"  page="1"   x="0,59206349206349"  y="0,088664421997755"  w="0" h="0,25476992143659"  />
<item  pos="0,54923215898826"  type="bar"  page="1"   x="0,69365079365079"  y="0,088664421997755"  w="0" h="0,25476992143659"  />
<item  pos="0,56601684296413"  type="system"  page="1"   x="0,1484375"  y="0,39393939393939"  w="0,77460317460317" h="0,24915824915825"  />
<item  pos="0,58559897426931"  type="bar"  page="1"   x="0,085714285714286"  y="0,39393939393939"  w="0" h="0,24915824915825"  />
<item  pos="0,60584540825247"  type="bar"  page="1"   x="0,15396825396825"  y="0,39393939393939"  w="0" h="0,24915824915825"  />
<item  pos="0,62449505711455"  type="bar"  page="1"   x="0,20952380952381"  y="0,39393939393939"  w="0" h="0,24915824915825"  />
<item  pos="0,64034725864732"  type="bar"  page="1"   x="0,29047619047619"  y="0,39393939393939"  w="0" h="0,24915824915825"  />
<item  pos="0,6589969075094"  type="bar"  page="1"   x="0,38095238095238"  y="0,39393939393939"  w="0" h="0,24915824915825"  />
<item  pos="0,67671407392837"  type="bar"  page="1"   x="0,46190476190476"  y="0,39393939393939"  w="0" h="0,24915824915825"  />
<item  pos="0,69536372279045"  type="bar"  page="1"   x="0,53968253968254"  y="0,39393939393939"  w="0" h="0,24915824915825"  />
<item  pos="0,71401337165253"  type="bar"  page="1"   x="0,61746031746032"  y="0,39393939393939"  w="0" h="0,24915824915825"  />
<item  pos="0,73266302051461"  type="bar"  page="1"   x="0,7031746031746"  y="0,39393939393939"  w="0" h="0,24915824915825"  />
<item  pos="0,7506012417315"  type="system"  page="1"   x="0,146875"  y="0,68799102132435"  w="0,76666666666667" h="0,25813692480359"  />
<item  pos="0,76365599593496"  type="bar"  page="1"   x="0,033333333333333"  y="0,68799102132435"  w="0" h="0,25813692480359"  />
<item  pos="0,79163046922808"  type="bar"  page="1"   x="0,16190476190476"  y="0,68799102132435"  w="0" h="0,25813692480359"  />
<item  pos="0,80934763564706"  type="bar"  page="1"   x="0,23492063492063"  y="0,68799102132435"  w="0" h="0,25813692480359"  />
<item  pos="0,83079473183845"  type="bar"  page="1"   x="0,31587301587302"  y="0,68799102132435"  w="0" h="0,25813692480359"  />
<item  pos="0,85037686314363"  type="bar"  page="1"   x="0,39365079365079"  y="0,68799102132435"  w="0" h="0,25813692480359"  />
<item  pos="0,87182395933502"  type="bar"  page="1"   x="0,47936507936508"  y="0,68799102132435"  w="0" h="0,25813692480359"  />
<item  pos="0,89513602041262"  type="bar"  page="1"   x="0,55555555555556"  y="0,68799102132435"  w="0" h="0,25813692480359"  />
<item  pos="0,90632580972987"  type="bar"  page="1"   x="0,58571428571429"  y="0,68799102132435"  w="0" h="0,25813692480359"  />
<item  pos="0,92404297614885"  type="bar"  page="1"   x="0,63492063492063"  y="0,68799102132435"  w="0" h="0,25813692480359"  />
</grid>		
		';
	}
	
	
}


