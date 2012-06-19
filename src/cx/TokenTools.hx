package cx;
import haxe.Serializer;
import haxe.Unserializer;

/**
 * ...
 * @author Jonas Nyström
 */

class TokenTools 
{	
	static public function getToken(user:TokenUser):String {
		var userSerialized = Serializer.run(user);		
		return CryptTools.teaCrypt(userSerialized);
	}
	
	static public function getUser(token:String):TokenUser {		
		var userUnserialized = Unserializer.run(CryptTools.teaUncrypt(token));
		return userUnserialized;
	}	
}

typedef TokenUser = {	
	u:String,
	p:String,
	e:Date,
}