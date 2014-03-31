package nme;


import openfl.Assets;


class AssetData {

	
	public static var className = new #if haxe3 Map <String, #else Hash <#end Dynamic> ();
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();
	
	private static var initialized:Bool = false;
	
	
	public static function initialize ():Void {
		
		if (!initialized) {
			
			className.set ("img/checkboxChecked.png", nme.NME_img_checkboxchecked_png);
			type.set ("img/checkboxChecked.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/play-round-light.png", nme.NME_img_play_round_light_png);
			type.set ("img/play-round-light.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/play-round.png", nme.NME_img_play_round_png);
			type.set ("img/play-round.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/stop-round-light.png", nme.NME_img_stop_round_light_png);
			type.set ("img/stop-round-light.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/stop-round.png", nme.NME_img_stop_round_png);
			type.set ("img/stop-round.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/zoom-full-light.png", nme.NME_img_zoom_full_light_png);
			type.set ("img/zoom-full-light.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/zoom-full.png", nme.NME_img_zoom_full_png);
			type.set ("img/zoom-full.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/zoom-minus-light.png", nme.NME_img_zoom_minus_light_png);
			type.set ("img/zoom-minus-light.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/zoom-minus.png", nme.NME_img_zoom_minus_png);
			type.set ("img/zoom-minus.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/zoom-plus-light.png", nme.NME_img_zoom_plus_light_png);
			type.set ("img/zoom-plus-light.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/zoom-plus.png", nme.NME_img_zoom_plus_png);
			type.set ("img/zoom-plus.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		}
		
	}
	
	
}


class NME_img_checkboxchecked_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_play_round_light_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_play_round_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_stop_round_light_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_stop_round_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_zoom_full_light_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_zoom_full_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_zoom_minus_light_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_zoom_minus_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_zoom_plus_light_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_zoom_plus_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
