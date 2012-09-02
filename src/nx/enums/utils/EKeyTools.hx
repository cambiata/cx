package nx.enums.utils;

/**
 * ...
 * @author Jonas Nyström
 */

class EKeyTools 
{

	static public function nextKey(key:EKey):EKey {
		var result:EKey = EKey.Natural;
		switch (key) {
			case EKey.Flat6: result = EKey.Flat5;
			case EKey.Flat5: result = EKey.Flat4;
			case EKey.Flat4: result = EKey.Flat3;
			case EKey.Flat3: result = EKey.Flat2;
			case EKey.Flat2: result = EKey.Flat1;
			case EKey.Flat1: result = EKey.Natural;
			case EKey.Natural: result = EKey.Sharp1;
			case EKey.Sharp1: result = EKey.Sharp2;
			case EKey.Sharp2: result = EKey.Sharp3;
			case EKey.Sharp3: result = EKey.Sharp4;
			case EKey.Sharp4: result = EKey.Sharp5;
			case EKey.Sharp5: result = EKey.Sharp6;
			case EKey.Sharp6: result = EKey.Flat6;
		}
		return result;
	}
	
	static public function prevKey(key:EKey):EKey {
		var result:EKey = EKey.Natural;
		switch (key) {
			case EKey.Sharp6: result = EKey.Sharp5;
			case EKey.Sharp5: result = EKey.Sharp4;
			case EKey.Sharp4: result = EKey.Sharp3;
			case EKey.Sharp3: result = EKey.Sharp2;
			case EKey.Sharp2: result = EKey.Sharp1;
			case EKey.Sharp1: result = EKey.Natural;
			case EKey.Natural: result = EKey.Flat1;
			case EKey.Flat1: result = EKey.Flat2;
			case EKey.Flat2: result = EKey.Flat3;
			case EKey.Flat3: result = EKey.Flat4;
			case EKey.Flat4: result = EKey.Flat5;
			case EKey.Flat5: result = EKey.Flat6;
			case EKey.Flat6: result = EKey.Sharp6;
		}
		return result;
	}
	
}