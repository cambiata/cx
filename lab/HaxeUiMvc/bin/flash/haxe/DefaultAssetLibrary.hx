package;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.text.Font;
import flash.media.Sound;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import haxe.Unserializer;
import openfl.Assets;

#if (flash || js)
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLLoader;
#end

#if ios
import openfl.utils.SystemPath;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public static var className (default, null) = new Map <String, Dynamic> ();
	public static var path (default, null) = new Map <String, String> ();
	public static var type (default, null) = new Map <String, AssetType> ();
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("styles/gradient/arrow_down.png", __ASSET__styles_gradient_arrow_down_png);
		type.set ("styles/gradient/arrow_down.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/gradient/arrow_down_dark.png", __ASSET__styles_gradient_arrow_down_dark_png);
		type.set ("styles/gradient/arrow_down_dark.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/gradient/arrow_left.png", __ASSET__styles_gradient_arrow_left_png);
		type.set ("styles/gradient/arrow_left.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/gradient/arrow_right.png", __ASSET__styles_gradient_arrow_right_png);
		type.set ("styles/gradient/arrow_right.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/gradient/arrow_right2.png", __ASSET__styles_gradient_arrow_right2_png);
		type.set ("styles/gradient/arrow_right2.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/gradient/arrow_right_dark.png", __ASSET__styles_gradient_arrow_right_dark_png);
		type.set ("styles/gradient/arrow_right_dark.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/gradient/arrow_up.png", __ASSET__styles_gradient_arrow_up_png);
		type.set ("styles/gradient/arrow_up.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/gradient/circle_dark.png", __ASSET__styles_gradient_circle_dark_png);
		type.set ("styles/gradient/circle_dark.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/gradient/cross_dark.png", __ASSET__styles_gradient_cross_dark_png);
		type.set ("styles/gradient/cross_dark.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/gradient/gradient.css", __ASSET__styles_gradient_gradient_css);
		type.set ("styles/gradient/gradient.css", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("styles/gradient/gradient_mobile.css", __ASSET__styles_gradient_gradient_mobile_css);
		type.set ("styles/gradient/gradient_mobile.css", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("styles/gradient/gripper_horizontal.png", __ASSET__styles_gradient_gripper_horizontal_png);
		type.set ("styles/gradient/gripper_horizontal.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/gradient/gripper_vertical.png", __ASSET__styles_gradient_gripper_vertical_png);
		type.set ("styles/gradient/gripper_vertical.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/accordion.css", __ASSET__styles_windows_accordion_css);
		type.set ("styles/windows/accordion.css", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("styles/windows/button.png", __ASSET__styles_windows_button_png);
		type.set ("styles/windows/button.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/buttons.css", __ASSET__styles_windows_buttons_css);
		type.set ("styles/windows/buttons.css", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("styles/windows/calendar.css", __ASSET__styles_windows_calendar_css);
		type.set ("styles/windows/calendar.css", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("styles/windows/checkbox.png", __ASSET__styles_windows_checkbox_png);
		type.set ("styles/windows/checkbox.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/container.png", __ASSET__styles_windows_container_png);
		type.set ("styles/windows/container.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/glyphs/down_arrow.png", __ASSET__styles_windows_glyphs_down_arrow_png);
		type.set ("styles/windows/glyphs/down_arrow.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/glyphs/hscroll_thumb_gripper_down.png", __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_down_png);
		type.set ("styles/windows/glyphs/hscroll_thumb_gripper_down.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/glyphs/hscroll_thumb_gripper_over.png", __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_over_png);
		type.set ("styles/windows/glyphs/hscroll_thumb_gripper_over.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/glyphs/hscroll_thumb_gripper_up.png", __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_up_png);
		type.set ("styles/windows/glyphs/hscroll_thumb_gripper_up.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/glyphs/left_arrow.png", __ASSET__styles_windows_glyphs_left_arrow_png);
		type.set ("styles/windows/glyphs/left_arrow.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/glyphs/right_arrow.png", __ASSET__styles_windows_glyphs_right_arrow_png);
		type.set ("styles/windows/glyphs/right_arrow.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/glyphs/up_arrow.png", __ASSET__styles_windows_glyphs_up_arrow_png);
		type.set ("styles/windows/glyphs/up_arrow.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/glyphs/vscroll_thumb_gripper_down.png", __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_down_png);
		type.set ("styles/windows/glyphs/vscroll_thumb_gripper_down.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/glyphs/vscroll_thumb_gripper_over.png", __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_over_png);
		type.set ("styles/windows/glyphs/vscroll_thumb_gripper_over.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/glyphs/vscroll_thumb_gripper_up.png", __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_up_png);
		type.set ("styles/windows/glyphs/vscroll_thumb_gripper_up.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/hprogress.png", __ASSET__styles_windows_hprogress_png);
		type.set ("styles/windows/hprogress.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/hscroll.png", __ASSET__styles_windows_hscroll_png);
		type.set ("styles/windows/hscroll.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/listview.css", __ASSET__styles_windows_listview_css);
		type.set ("styles/windows/listview.css", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("styles/windows/listview.png", __ASSET__styles_windows_listview_png);
		type.set ("styles/windows/listview.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/menus.css", __ASSET__styles_windows_menus_css);
		type.set ("styles/windows/menus.css", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("styles/windows/optionbox.png", __ASSET__styles_windows_optionbox_png);
		type.set ("styles/windows/optionbox.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/popup.png", __ASSET__styles_windows_popup_png);
		type.set ("styles/windows/popup.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/popups.css", __ASSET__styles_windows_popups_css);
		type.set ("styles/windows/popups.css", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("styles/windows/rtf.css", __ASSET__styles_windows_rtf_css);
		type.set ("styles/windows/rtf.css", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("styles/windows/scrolls.css", __ASSET__styles_windows_scrolls_css);
		type.set ("styles/windows/scrolls.css", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("styles/windows/sliders.css", __ASSET__styles_windows_sliders_css);
		type.set ("styles/windows/sliders.css", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("styles/windows/tab.png", __ASSET__styles_windows_tab_png);
		type.set ("styles/windows/tab.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/tabs.css", __ASSET__styles_windows_tabs_css);
		type.set ("styles/windows/tabs.css", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("styles/windows/textinput.png", __ASSET__styles_windows_textinput_png);
		type.set ("styles/windows/textinput.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/vprogress.png", __ASSET__styles_windows_vprogress_png);
		type.set ("styles/windows/vprogress.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/vscroll.png", __ASSET__styles_windows_vscroll_png);
		type.set ("styles/windows/vscroll.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("styles/windows/windows.css", __ASSET__styles_windows_windows_css);
		type.set ("styles/windows/windows.css", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("img/rtfview/edit-alignment-center.png", __ASSET__img_rtfview_edit_alignment_center_png);
		type.set ("img/rtfview/edit-alignment-center.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("img/rtfview/edit-alignment-justify.png", __ASSET__img_rtfview_edit_alignment_justify_png);
		type.set ("img/rtfview/edit-alignment-justify.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("img/rtfview/edit-alignment-left.png", __ASSET__img_rtfview_edit_alignment_left_png);
		type.set ("img/rtfview/edit-alignment-left.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("img/rtfview/edit-alignment-right.png", __ASSET__img_rtfview_edit_alignment_right_png);
		type.set ("img/rtfview/edit-alignment-right.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("img/rtfview/edit-bold.png", __ASSET__img_rtfview_edit_bold_png);
		type.set ("img/rtfview/edit-bold.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("img/rtfview/edit-italic.png", __ASSET__img_rtfview_edit_italic_png);
		type.set ("img/rtfview/edit-italic.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("img/rtfview/edit-list.png", __ASSET__img_rtfview_edit_list_png);
		type.set ("img/rtfview/edit-list.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("img/rtfview/edit-underline.png", __ASSET__img_rtfview_edit_underline_png);
		type.set ("img/rtfview/edit-underline.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		
		#elseif html5
		
		path.set ("styles/gradient/arrow_down.png", "styles/gradient/arrow_down.png");
		type.set ("styles/gradient/arrow_down.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/gradient/arrow_down_dark.png", "styles/gradient/arrow_down_dark.png");
		type.set ("styles/gradient/arrow_down_dark.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/gradient/arrow_left.png", "styles/gradient/arrow_left.png");
		type.set ("styles/gradient/arrow_left.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/gradient/arrow_right.png", "styles/gradient/arrow_right.png");
		type.set ("styles/gradient/arrow_right.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/gradient/arrow_right2.png", "styles/gradient/arrow_right2.png");
		type.set ("styles/gradient/arrow_right2.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/gradient/arrow_right_dark.png", "styles/gradient/arrow_right_dark.png");
		type.set ("styles/gradient/arrow_right_dark.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/gradient/arrow_up.png", "styles/gradient/arrow_up.png");
		type.set ("styles/gradient/arrow_up.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/gradient/circle_dark.png", "styles/gradient/circle_dark.png");
		type.set ("styles/gradient/circle_dark.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/gradient/cross_dark.png", "styles/gradient/cross_dark.png");
		type.set ("styles/gradient/cross_dark.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/gradient/gradient.css", "styles/gradient/gradient.css");
		type.set ("styles/gradient/gradient.css", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("styles/gradient/gradient_mobile.css", "styles/gradient/gradient_mobile.css");
		type.set ("styles/gradient/gradient_mobile.css", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("styles/gradient/gripper_horizontal.png", "styles/gradient/gripper_horizontal.png");
		type.set ("styles/gradient/gripper_horizontal.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/gradient/gripper_vertical.png", "styles/gradient/gripper_vertical.png");
		type.set ("styles/gradient/gripper_vertical.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/accordion.css", "styles/windows/accordion.css");
		type.set ("styles/windows/accordion.css", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("styles/windows/button.png", "styles/windows/button.png");
		type.set ("styles/windows/button.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/buttons.css", "styles/windows/buttons.css");
		type.set ("styles/windows/buttons.css", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("styles/windows/calendar.css", "styles/windows/calendar.css");
		type.set ("styles/windows/calendar.css", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("styles/windows/checkbox.png", "styles/windows/checkbox.png");
		type.set ("styles/windows/checkbox.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/container.png", "styles/windows/container.png");
		type.set ("styles/windows/container.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/glyphs/down_arrow.png", "styles/windows/glyphs/down_arrow.png");
		type.set ("styles/windows/glyphs/down_arrow.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/glyphs/hscroll_thumb_gripper_down.png", "styles/windows/glyphs/hscroll_thumb_gripper_down.png");
		type.set ("styles/windows/glyphs/hscroll_thumb_gripper_down.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/glyphs/hscroll_thumb_gripper_over.png", "styles/windows/glyphs/hscroll_thumb_gripper_over.png");
		type.set ("styles/windows/glyphs/hscroll_thumb_gripper_over.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/glyphs/hscroll_thumb_gripper_up.png", "styles/windows/glyphs/hscroll_thumb_gripper_up.png");
		type.set ("styles/windows/glyphs/hscroll_thumb_gripper_up.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/glyphs/left_arrow.png", "styles/windows/glyphs/left_arrow.png");
		type.set ("styles/windows/glyphs/left_arrow.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/glyphs/right_arrow.png", "styles/windows/glyphs/right_arrow.png");
		type.set ("styles/windows/glyphs/right_arrow.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/glyphs/up_arrow.png", "styles/windows/glyphs/up_arrow.png");
		type.set ("styles/windows/glyphs/up_arrow.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/glyphs/vscroll_thumb_gripper_down.png", "styles/windows/glyphs/vscroll_thumb_gripper_down.png");
		type.set ("styles/windows/glyphs/vscroll_thumb_gripper_down.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/glyphs/vscroll_thumb_gripper_over.png", "styles/windows/glyphs/vscroll_thumb_gripper_over.png");
		type.set ("styles/windows/glyphs/vscroll_thumb_gripper_over.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/glyphs/vscroll_thumb_gripper_up.png", "styles/windows/glyphs/vscroll_thumb_gripper_up.png");
		type.set ("styles/windows/glyphs/vscroll_thumb_gripper_up.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/hprogress.png", "styles/windows/hprogress.png");
		type.set ("styles/windows/hprogress.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/hscroll.png", "styles/windows/hscroll.png");
		type.set ("styles/windows/hscroll.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/listview.css", "styles/windows/listview.css");
		type.set ("styles/windows/listview.css", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("styles/windows/listview.png", "styles/windows/listview.png");
		type.set ("styles/windows/listview.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/menus.css", "styles/windows/menus.css");
		type.set ("styles/windows/menus.css", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("styles/windows/optionbox.png", "styles/windows/optionbox.png");
		type.set ("styles/windows/optionbox.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/popup.png", "styles/windows/popup.png");
		type.set ("styles/windows/popup.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/popups.css", "styles/windows/popups.css");
		type.set ("styles/windows/popups.css", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("styles/windows/rtf.css", "styles/windows/rtf.css");
		type.set ("styles/windows/rtf.css", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("styles/windows/scrolls.css", "styles/windows/scrolls.css");
		type.set ("styles/windows/scrolls.css", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("styles/windows/sliders.css", "styles/windows/sliders.css");
		type.set ("styles/windows/sliders.css", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("styles/windows/tab.png", "styles/windows/tab.png");
		type.set ("styles/windows/tab.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/tabs.css", "styles/windows/tabs.css");
		type.set ("styles/windows/tabs.css", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("styles/windows/textinput.png", "styles/windows/textinput.png");
		type.set ("styles/windows/textinput.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/vprogress.png", "styles/windows/vprogress.png");
		type.set ("styles/windows/vprogress.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/vscroll.png", "styles/windows/vscroll.png");
		type.set ("styles/windows/vscroll.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("styles/windows/windows.css", "styles/windows/windows.css");
		type.set ("styles/windows/windows.css", Reflect.field (AssetType, "text".toUpperCase ()));
		path.set ("img/rtfview/edit-alignment-center.png", "img/rtfview/edit-alignment-center.png");
		type.set ("img/rtfview/edit-alignment-center.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("img/rtfview/edit-alignment-justify.png", "img/rtfview/edit-alignment-justify.png");
		type.set ("img/rtfview/edit-alignment-justify.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("img/rtfview/edit-alignment-left.png", "img/rtfview/edit-alignment-left.png");
		type.set ("img/rtfview/edit-alignment-left.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("img/rtfview/edit-alignment-right.png", "img/rtfview/edit-alignment-right.png");
		type.set ("img/rtfview/edit-alignment-right.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("img/rtfview/edit-bold.png", "img/rtfview/edit-bold.png");
		type.set ("img/rtfview/edit-bold.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("img/rtfview/edit-italic.png", "img/rtfview/edit-italic.png");
		type.set ("img/rtfview/edit-italic.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("img/rtfview/edit-list.png", "img/rtfview/edit-list.png");
		type.set ("img/rtfview/edit-list.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("img/rtfview/edit-underline.png", "img/rtfview/edit-underline.png");
		type.set ("img/rtfview/edit-underline.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		
		#else
		
		try {
			
			var bytes = ByteArray.readFile ("manifest");
			bytes.position = 0;
			
			if (bytes.length > 0) {
				
				var data = bytes.readUTFBytes (bytes.length);
				
				if (data != null && data.length > 0) {
					
					var manifest:Array<AssetData> = Unserializer.run (data);
					
					for (asset in manifest) {
						
						path.set (asset.id, asset.path);
						type.set (asset.id, asset.type);
						
					}
					
				}
				
			}
			
		} catch (e:Dynamic) {
			
			trace ("Warning: Could not load asset manifest");
			
		}
		
		#end
		
	}
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = DefaultAssetLibrary.type.get (id);
		
		#if pixi
		
		if (assetType == IMAGE) {
			
			return true;
			
		} else {
			
			return false;
			
		}
		
		#end
		
		if (assetType != null) {
			
			if (assetType == type || type == SOUND && (assetType == MUSIC || assetType == SOUND)) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && type == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (type == BINARY || type == null) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		#if pixi
		
		return BitmapData.fromImage (path.get (id));
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if pixi
		
		return null;
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		#if flash
		
		if (type != AssetType.MUSIC && type != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		#if pixi
		
		handler (getBitmapData (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBitmapData (id));
			
		}
		
		#else
		
		handler (getBitmapData (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if pixi
		
		handler (getBytes (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getFont (id));
			
		//}
		
		#else
		
		handler (getFont (id));
		
		#end
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getSound (id));
			
		//}
		
		#else
		
		handler (getSound (id));
		
		#end
		
	}
	
	
}


#if pixi
#elseif flash

class __ASSET__styles_gradient_arrow_down_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_gradient_arrow_down_dark_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_gradient_arrow_left_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_gradient_arrow_right_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_gradient_arrow_right2_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_gradient_arrow_right_dark_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_gradient_arrow_up_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_gradient_circle_dark_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_gradient_cross_dark_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_gradient_gradient_css extends flash.utils.ByteArray { }
class __ASSET__styles_gradient_gradient_mobile_css extends flash.utils.ByteArray { }
class __ASSET__styles_gradient_gripper_horizontal_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_gradient_gripper_vertical_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_accordion_css extends flash.utils.ByteArray { }
class __ASSET__styles_windows_button_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_buttons_css extends flash.utils.ByteArray { }
class __ASSET__styles_windows_calendar_css extends flash.utils.ByteArray { }
class __ASSET__styles_windows_checkbox_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_container_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_glyphs_down_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_down_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_over_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_up_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_glyphs_left_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_glyphs_right_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_glyphs_up_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_down_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_over_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_up_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_hprogress_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_hscroll_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_listview_css extends flash.utils.ByteArray { }
class __ASSET__styles_windows_listview_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_menus_css extends flash.utils.ByteArray { }
class __ASSET__styles_windows_optionbox_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_popup_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_popups_css extends flash.utils.ByteArray { }
class __ASSET__styles_windows_rtf_css extends flash.utils.ByteArray { }
class __ASSET__styles_windows_scrolls_css extends flash.utils.ByteArray { }
class __ASSET__styles_windows_sliders_css extends flash.utils.ByteArray { }
class __ASSET__styles_windows_tab_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_tabs_css extends flash.utils.ByteArray { }
class __ASSET__styles_windows_textinput_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_vprogress_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_vscroll_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__styles_windows_windows_css extends flash.utils.ByteArray { }
class __ASSET__img_rtfview_edit_alignment_center_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__img_rtfview_edit_alignment_justify_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__img_rtfview_edit_alignment_left_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__img_rtfview_edit_alignment_right_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__img_rtfview_edit_bold_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__img_rtfview_edit_italic_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__img_rtfview_edit_list_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__img_rtfview_edit_underline_png extends flash.display.BitmapData { public function new () { super (0, 0); } }


#elseif html5

























































#end