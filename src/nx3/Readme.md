nx3 readme
==========

## 1. Data/persistence object tree - N* classes

As a starting point, the notation data is structured in a hierarchial tree representing the information neccessary to describe the enteties needed to build the score - the bars with its parts, the parts with their clefs and key signatures, the notes with their noteheads and accidentals etc.

These data classes are named with beginning N*: 

 * a root level **NScore** that holds an array of **NBar**(s)
 * each [**NBar**](https://github.com/cambiata/cx/blob/master/src/nx3/elements/NBar.hx) holds an array of **NPart**(s)
 * each [**NPart**](https://github.com/cambiata/cx/blob/master/src/nx3/elements/NPart.hx) holds an array of **NVoice**(s)
 * each [**NVoice**](https://github.com/cambiata/cx/blob/master/src/nx3/elements/NVoice.hx) holds an array of **NNote**(s)
 * each [**NNote**](https://github.com/cambiata/cx/blob/master/src/nx3/elements/NNote.hx) holds an array of [**NHead**](https://github.com/cambiata/cx/blob/master/src/nx3/elements/NHead.hx)(s)
 
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

The [**NNote**](https://github.com/cambiata/cx/blob/master/src/nx3/elements/NNote.hx) is created with an array of one [**NHead**](https://github.com/cambiata/cx/blob/master/src/nx3/elements/NHead.hx)(s) passed into the constructor as the first parameter. The NHead is passed an integer value reperesenting the note level relative to the middle line - in this case -1 wich translates to one position above the middle line.
The second parameter passed into NNote represents the note value, in this case ENoteValue.Nv2dot.

Having created this single note we can pass it into an instace of [**NVoice**](https://github.com/cambiata/cx/blob/master/src/nx3/elements/NVoice.hx):

```
var voiceUpper = new NVoice([note0], EDirectionUD.Up);
```

On to the lower voice of the upper part:

![My image](https://raw2.github.com/cambiata/cx/master/src/nx3/img/Example1c.png)

It has three notes with note values of a dotted quarter note, an eight note and a quarter note respectively. The third of the notes has a sharp accidental, passed as second parameter into NHead:

```
var note0 = new NNote([new NHead(1)], ENoteValue.Nv4dot);
var note1 = new NNote([new NHead(2)], ENoteValue.Nv8);
var note2 = new NNote([new NHead(3, ESign.Sharp)] /*, ENoteValue.NV4 */); 
```
Please note the note value of quarter note is default, so we don't need to pass that into the third note above.

Now we can create the lower voice, passing an array of above notes into the constructor:
```
var voiceLower = new NVoice([note0, note1, note2], EDirectionUD.Down);
```
Now, when we have the two voices for the upper part, it's time to create the [**NPart**](https://github.com/cambiata/cx/blob/master/src/nx3/elements/NPart.hx) itself. In the same manner as above, we pass the children (here the two voices) as an array into the NPart constructor:

```
var partUpper = new NPart([voiceUpper, voiceLower], EClef.ClefG, EKey.Flat1);
```
We also set the clef to EClef.ClefG (actually not needed as G-clef is default) and the key to EKey.Flat1.

Now for the lower part and its single voice:

![My image](https://raw2.github.com/cambiata/cx/master/src/nx3/img/Example1d.png)

Please note that the first NNote has two noteheads, wich means that two NHead instances are passed into the NNote constructor:

```
var note0 = new NNote([new NHead(-2), new Head(5)], ENoteValue.Nv2);
var note1 = new NNote([new NHead(0)]); // No note value passed as quarter note is default
var voice = new NVoice([note0, note1]);
```
Here's the code for creating the lower NPart. Note the F-clef:

```
var partLower = new NPart([voice], EClef.ClefF, EKey.Flat1);	
```
Finally, we can create the [**NBar**](https://github.com/cambiata/cx/blob/master/src/nx3/elements/NBar.hx) by passing the two NParts. We also set the time signature for the bar to 3/4:

```
var bar = new NBar([partUpper, partLower], ETime.Time3_4);
```
Done!

#### XML Serialisation

The N* tree can be saved to and rebuilt from XML. As an example, the bar created above can be serialized to an xml string like this:

```
var barXmlStr = nx3.io.BarXML.toXml(bar);
```
Here's the result:

```
<bar time="3/4">
	<part key="-1">
		<voice direction="Up">
			<note value="9072">
				<head level="-1" />
			</note>
		</voice>
		<voice direction="Down">
			<note value="4536">
				<head level="1" />
			</note>
			<note value="1512">
				<head level="2" />
			</note>
			<note>
				<head level="3" sign="Sharp" />
			</note>
		</voice>
	</part>
	<part clef="ClefF" key="-1">
		<voice>
			<note value="6048">
				<head level="-2" />
				<head level="5" />
			</note>
			<note>
				<head level="0" />
			</note>
		</voice>
	</part>
</bar>
```

Recreating a bar tree is just as simple:

```
var recreatedBar = nx3.io.BarXML.fromXmlStr(barXmlStr);
```

## 2. Display object tree(s) (TODO!)

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


## 3. Rendering solutions (TODO!)









 
