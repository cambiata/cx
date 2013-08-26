package nme;


import openfl.Assets;


class AssetData {

	
	public static var className = new #if haxe3 Map <String, #else Hash <#end Dynamic> ();
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();
	
	private static var initialized:Bool = false;
	
	
	public static function initialize ():Void {
		
		if (!initialized) {
			
			className.set ("img/checkbox.png", nme.NME_img_checkbox_png);
			type.set ("img/checkbox.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/checkboxChecked.png", nme.NME_img_checkboxchecked_png);
			type.set ("img/checkboxChecked.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/scorx/scorx-blue.png", nme.NME_img_scorx_scorx_blue_png);
			type.set ("img/scorx/scorx-blue.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/scorx/scorx-green.png", nme.NME_img_scorx_scorx_green_png);
			type.set ("img/scorx/scorx-green.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/scorx/scorx-red.png", nme.NME_img_scorx_scorx_red_png);
			type.set ("img/scorx/scorx-red.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		}
		
	}
	
	
}


class NME_img_checkbox_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_checkboxchecked_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_scorx_scorx_blue_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_scorx_scorx_green_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_scorx_scorx_red_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
