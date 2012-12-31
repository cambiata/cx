cx
==

My everyday Haxe toolsets and unsorted experiments. 


nx Music Notation basic usage:

	var s = new Sprite(); // sprite to hold the example
	this.addChild(s);		
	var score = nx.test.Examples.scoreComplex1(); // a test score
	var systems = new nx.display.DSystems(score.bars, 600); // format score data to displayable notation data
	nx.output.Render.systems2(s, nx.output.Scaling.getNormal(), 20, 20, systems); // render notation data
