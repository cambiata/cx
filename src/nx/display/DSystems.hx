package nx.display;
import nx.display.type.TBarDisplaySettings;
import nx.element.Bars;
import nx.layout.ILayoutProcessor;
import nx.layout.LayoutBase;
/**
 * ...
 * @author Jonas Nyström
 */
using cx.ArrayTools;
using nx.display.type.TBarDisplaySettings.BarDisplayTools;
class DSystems extends LayoutBase
{

	public var dbars(default, null):				DBars;
	public var systems(default, null):			Array<DSystem>;
	public var systemWidth(default, null):	Float;
	
	public function new(bars:Bars, systemWidth:Float, firstBarNr:Int=0, nrOfBars:Int=999) {
		//super();
		this.dbars = [];
		this.systemWidth = systemWidth;
		for (bar in bars.bars) {
			var dbar = new DBar(bar);		
			this.dbars.push(dbar);
		}
		this.systems = getLayoutSystems(firstBarNr, nrOfBars);		
	}
	
	public function doLayout(firstBarNr:Int = 0, nrOfBars=999) {
		this.systems = getLayoutSystems(firstBarNr, nrOfBars);		
	}
	
	private var prevFirstBarNr:Int = -1;
	
	public function getLayoutSystems(firstBarNr:Int=0, nrOfBars=999):Array<DSystem> {		
		firstBarNr = Std.int(Math.min(Math.max(firstBarNr, 0), this.dbars.length-1));
		nrOfBars = Std.int(Math.max(1, nrOfBars));
		
		if (firstBarNr == prevFirstBarNr) return systems;
		
		var dsystem = new DSystem(this.systemWidth, false);
		var systems:Array<DSystem> = [];		
		systems.push(dsystem);		
		var prevbarSettings:TBarDisplaySettings = null;
		
		var barIdx = 0;		
		for (dbar in dbars) {
			
			dbar.setDisplaySettings();
			
			this.updateSettings(dbar.getDisplaySettings());			
			
			if (barIdx >= firstBarNr) {
				var success = dsystem.tryAddingDBar(dbar, this.currentSettings.clone(), prevbarSettings);
				if (success) {
					//trace('dbar successfully added!');
				} else {
					//trace('dbar couldnt be added');
					
					dsystem.stretch = true;
					
					//trace('create a new system...');
					dsystem = new DSystem(this.systemWidth, false);
					systems.push(dsystem);
					dsystem.tryAddingDBar(dbar, this.currentSettings.clone(), prevbarSettings);				
				}
			}
			
			prevbarSettings = this.currentSettings;
			barIdx++;
			
			if (barIdx-firstBarNr >= nrOfBars) return systems;
			
		}		
		

		
		prevFirstBarNr = firstBarNr;
		return systems;
	}	
	
	
	
	
}
