## nx3 readme

### 1. Data/persistence layer

Starting point: a tree of notation objects (N* classes, the "raw data")
 * a NScore consisting of one or many NBar(s)
 * each NBar consisting of one or many NPart(s)
 * each NPart consisting of one or two NVoice(s)
 * each NVoice consisting of one or many NNote(s)
 * each NNote consisting of one or many NHead(s)
 
 The relation between 
 ![My image](https://raw.github.com/cambiata/cx/blob/master/src/nx3/img/NHierarchy.png)
	 
	 
 ![My image](https://github.com/cambiata/cx/blob/master/src/nx3/img/RelationNPartNVoice.png)
 
 

### 2. Display information layer


### 3. Rendering layer






This single data tree is copied into a one or many tree(s) of corresponding display objects (D* classes).

DVoice - Apply BeamingRule and and connect its DNotes to the resulting BeamGroups. Calcuate up/down directions for each beamgroup, and use that info to set each DNote up/down direction

DPart - assemble its Dvoice(s)'s DNotes into DComplexes

Dpart - calculate DComplexes min distances

DBar - calculate DColumns min distances (watch out for lyric parts!)

DVoice - Calculate Beaming coordinates

DVoice - Calculate Articulation coordinates

DVoice - Calculate coordinates for BarPart stuff like phrasings, textlines, inter-bar ties

DBar - Apply Allotment rule and calculate min alloted width

LayoutEngine uses AttributeRules, BarspacingRules etc produces DSystems
{
	Check each DBar width depending on AttributeRules, Userset attributes, content width - breaks to new DSystem when overflow
	Identify inter-system objects and pass them (dangling phrasings, textlines, inter-bar ties etc to) next DSystem	
}

DSystem - Calculate the stretched width each DBar will get depending on system width overflow

DSystem - draw iterations
{
	draw note lines to full system width
	draw bar content, using correct attributes and using the calculated stretched width
	draw DSystem inter-bar content
	draw inter-system objects
}



 
