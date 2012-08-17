package nx.layout;
import nx.display.DBars;
import nx.display.DSystem;
import nx.display.type.TBarDisplaySettings;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.ArrayTools;
using nx.display.type.TBarDisplaySettings.BarDisplayTools;
class LayoutTest extends LayoutBase, implements ILayoutProcessor
{

	/*
	 * *********************************************************
	 * CONSTRUCTOR
	 * *********************************************************
	 *
	*/
	public var systems(default, null)		: Array<DSystem>;
	
	
	public function new() {
		super();
		this.systems = [];
	}
	
	/* INTERFACE nx.layout.ILayoutProcessor */
	
	
	public function doLayout(dbars:DBars, firstBarNr:Int=0):Array<DSystem> {
		
		
		var dsystem = new DSystem(true);
		this.systems.push(dsystem);
		
		var prevbarSettings:TBarDisplaySettings = null;
		//var prevbarSettings:TBarDisplaySettings = dbars.first().getDisplaySettings();
		
		for (dbar in dbars) {
			
			this.updateSettings(dbar.getDisplaySettings());			
			
			var success = dsystem.tryAddingDBar(dbar, this.currentSettings.clone(), prevbarSettings);
			if (success) {
				//trace('dbar successfully added!');
				
			} else {
				//trace('dbar couldnt be added');
				//trace('create a new system...');
				dsystem = new DSystem(false);
				this.systems.push(dsystem);
				dsystem.tryAddingDBar(dbar, this.currentSettings.clone(), prevbarSettings);				
			}
			
			prevbarSettings = this.currentSettings;
		}
		
		return this.systems;
	}
	
	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	


	
}