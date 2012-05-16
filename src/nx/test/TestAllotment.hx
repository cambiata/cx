package nx.test;
import haxe.unit.TestCase;
import nx.display.layout.AllotmentEven;
import nx.display.layout.AllotmentLinear;
import nx.display.layout.AllotmentLogaritmic;
import nx.display.layout.IAllotment;
import nx.enums.ENoteValue;

/**
 * ...
 * @author Jonas Nyström
 */

class TestAllotment extends TestCase
{

	public function test0() {
		
		assertTrue(true);
		var aEv:IAllotment = new AllotmentEven();
		var aLo:IAllotment = new AllotmentLogaritmic();
		var aLi:IAllotment = new AllotmentLinear();		
		
		var factor = aEv.getAFactor(ENoteValue.Nv4.value);
		assertEquals(1.0, factor);
		var factor = aLi.getAFactor(ENoteValue.Nv4.value);
		assertEquals(1.0, factor);
		var factor = aLo.getAFactor(ENoteValue.Nv4.value);
		assertEquals(1.0, factor);
	
		
		var factor = aEv.getAFactor(ENoteValue.Nv2.value);
		assertEquals(1.0, factor);
		var factor = aLi.getAFactor(ENoteValue.Nv2.value);
		assertEquals(2.0, factor);
		
		var factor = aLo.getAFactor(ENoteValue.Nv2.value);
		assertEquals(1.5, factor);
		
		var v = aLo.getAFactor(ENoteValue.Nv8.value);
		trace(v);		
		var v = aLo.getAFactor(ENoteValue.Nv1.value);
		trace(v);		
	}
	
}