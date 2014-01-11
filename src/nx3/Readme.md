## nx3 readme

### 1. Data/persistence layer - N* classes

As a starting point, the data is structured in a hierarchial tree representing the information neccessary for describing the enteties of the score - its the bars with its time signatures, the parts with their clefs and key signatures, the notes with their noteheads and accidentals etc.

These data classes are named with beginning N*: 

 * a root level **NScore** that holds an array of **NBar**(s)
 * each **NBar** holds an array of **NPart**(s)
 * each **NPart** holds an array of NPart **NVoice**(s)
 * each **NVoice** holds an array of NPart **NNote**(s)
 * each **NNote** holds an array of NPart **NHead**(s)
 
The relation between the elements is illustrated in the following overview, together with some example properties associated with each class:

![My image](https://raw2.github.com/cambiata/cx/master/src/nx3/img/NHierarchy.png)

The relation between NBar, NPart, NVoice and NNote is illustrated here:

![My image](https://raw2.github.com/cambiata/cx/master/src/nx3/img/RelationNPartNVoice.png)

Let's examine the following example to see how it's described in code:

![My image](https://raw2.github.com/cambiata/cx/master/src/nx3/img/Example1.png)

The upper part has two voices where the upper voice (NVoice0) has a single NNote with the note value of a dotted half note:

![My image](https://raw2.github.com/cambiata/cx/master/src/nx3/img/Example1b.png)

This single dotted half note in the upper part's upper voice is created like the following:

```
var note0 = new NNote([new NHead(-1)], ENoteValue.Nv2dot);

```
One NNote is created with an array of one NHead passed into the constructor as the first parameter. The NHead is passed an integer value reperesenting the note level relative to the middle line - in this case -1 wich translates to one position above the middle line.
The second parameter passed into NNote represents the note value, in this case ENoteValue.Nv2dot.

Having created this single note we can pass it into an instace of NVoice:

```
var voice0 = new NVoice([note0], EDirectionUD.Up);

```

On to the lower voice of upper part:
![My image](https://raw2.github.com/cambiata/cx/master/src/nx3/img/Example1c.png)

It has three notes with note values of a dotted quarter note, an eight note and a quarter note respectively. The third of the notes has a sharp accidental, passed as second parameter into NHead:

```
var note0 = new NNote([new NHead(1)], ENoteValue.Nv4dot);
var note1 = new NNote([new NHead(2)], ENoteValue.Nv8);
var note2 = new NNote([new NHead(3, ESign.Sharp)], /* ENoteValue.NV4 */); 
```
Please note the note value of quarter note is default, so we don't need to pass that into the third note above.

Now we can create voice1, passing an array of above notes into the constructor:
```
var voice1 = new NVoice([note0, note1, note2], EDirectionUD.Down);
```
Now, when we have the two voices for the upper part, it's time to create the NPart itself. In the same manner as above, we pass the children (here the two voices) as an array into the NPart constructor:

```
var part0 = new NPart([voice0, voice1], EClef.ClefG, EKey.Flat1);
```
We also set the clef to EClef.ClefG (actually not needed as G-clef is default) and the key to EKey.Flat1.






Please note the following:
 * It's one single bar, set in 3/4 time signature.
 * It has two parts, both of them set to key signature with 2 sharps. The upper part (NPart0) is set to G-clef, and the lower part (NPart1) is set to F-clef.
 * The upper part has two voices: 
* the upper voice (NVoice0) has a single NNote with the note value of a dotted half note. 
* The lower voice has three notes with note values of a dotted quarter note, an eight note and a quarter note respectively. The third of the notes has a sharp accidental.
 * The lower part has one single voice, where the first note has two noteheads.

Let's see how this is described in code:



 
 

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



 
