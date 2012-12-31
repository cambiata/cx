cx
==

My everyday Haxe toolsets and unsorted experiments. 


nx Music Notation basic usage:
==============================

	// sprite to hold the example
	var s = new Sprite(); 
	this.addChild(s);		
	
	// get a test score
	var score = nx.test.Examples.scoreComplex1(); 
	
	// format score data to displayable notation data
	var systems = new nx.display.DSystems(score.bars, 600); 
	
	// render notation data to sprite
	nx.output.Render.systems2(s, nx.output.Scaling.getNormal(), 20, 20, systems); 
