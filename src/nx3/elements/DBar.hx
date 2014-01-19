package nx3.elements;

import nx3.elements.ConfigDPart;
import nx3.elements.ConfigDBar;

/**
 * ...
 * @author Jonas Nyström
 */
class DBar
{
	public var nbar					(default, null)	:	NBar;
	public var config					(default, null) :	ConfigDBar;
	public var dparts					(default, null)	:	Array<DPart>;
	public var columns				(default, null)	:	Array<DColumn>;
	
	public var type					(default, null)	:	EBarType;
	public var time					(default, null)	:	ETime;
	public var barline				(default, null)	:	EBarline;
	public var barlineLeft			(default, null)	:	EBarlineLeft;
	public var ackolade				(default, null)	:	EAckolade;
	public var indentLeft			(default, null)	:	Null<Float>;
	public var indentRight			(default, null)	:	Null<Float>;
	public var allotment			(default, null)	:	EAllotment;
	
	
	public function new(nbar:NBar, config:ConfigDBar) 
	{
		this.nbar = nbar;
		this.config = (config == null)? ConfigDBarDefaults.getDefaults() : config;
		
		this.type = config.type;
		this.time = config.time;
		this.barline = config.barline;
		this.barlineLeft = config.barlineLeft;
		this.ackolade = config.ackolade;
		this.indentLeft = config.IndentLeft;
		this.indentRight = config. IndentRight;
		this.allotment = config.allotment; 
		
		this.createChildren();
	}
	
	public function createChildren()
	{
		var configParts:Array<ConfigDPart> = this.config.configParts;
		if (configParts == null) configParts = [];
		var configLength = configParts.length;
		
		if (this.nbar.parts.length > configLength)
			for (i in configLength...this.nbar.parts.length)
				configParts.push(ConfigDPartDefaults.getDefaults());
		
		this.dparts = [];
		
		var i = 0;
		for (npart in this.nbar.parts)
		{
			this.dparts.push(new DPart(npart, configParts[i]));
			i++;
		}
		
		this.columns = new GenerateColumns(this, null);
	}
}