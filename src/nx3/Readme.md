## nx3 readme

### 1. Data/persistence layer - N* classes

As a starting point, the data is structured in a hierarchial tree representing the information neccessary for describing the enteties of the score - its the bars with its time signatures, the parts with their clefs and key signatures, the notes with their noteheads and accidentals etc.

These data classes are named with beginning N*: 

 * a root level **NScore** that holds an array of **NBar**(s)
 * each **NBar** holds an array of **NPart**(s)
 * each **NPart** holds an array of NPart **NVoice**(s)
 * each **NVoice** holds an array of NPart **NNote**(s)
 * each **NNote** holds an array of NPart **NHead**(s)
 
The relation between the elements is illustrated in the following overview:

![My image](https://raw2.github.com/cambiata/cx/master/src/nx3/img/NHierarchy.png)

The relation between NBar, NPart, NVoice and NNote is illustrated here:

![My image](https://raw2.github.com/cambiata/cx/master/src/nx3/img/RelationNPartNVoice.png)




	 
 
 
 

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



 
