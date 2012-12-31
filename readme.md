cx
==

My everyday Haxe toolsets and unsorted experiments. 


nx Music Notation basic usage:

	var score = nx.test.Examples.scoreComplex1();		
	var systems = new nx.display.DSystems(score.bars, 600);
	nx.output.Render.systems2(s, nx.output.Scaling.getNormal(), 20, 20, systems);
