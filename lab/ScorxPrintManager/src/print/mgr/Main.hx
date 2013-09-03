package print.mgr;

import flash.Lib;
import flash.filesystem.File;
import flash.desktop.NativeApplication;
import flash.display.Sprite;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.InvokeEvent;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{
	static function main() 
	{
		var app = NativeApplication.nativeApplication;
			
		// new to AIR? please read *carefully* the readme.txt files!
		
		app.addEventListener(InvokeEvent.INVOKE, function(e : InvokeEvent) 
		{
			
			var button = makeBtn('Welcome to AIR, please click me!', function() 
			{
				trace("Your app storage dir: " + File.applicationStorageDirectory.nativePath);
			});
			
			button.x = NativeApplication.nativeApplication.activeWindow.width / 2 - button.width / 2;
			button.y = NativeApplication.nativeApplication.activeWindow.height / 2 - button.height;
			
			Lib.current.addChild(button);			
		});
	}

	static function makeBtn(txt: String, onClick: Void -> Void): Sprite 
	{
		var textField = new flash.text.TextField();
		textField.text = txt;
		textField.autoSize = flash.text.TextFieldAutoSize.LEFT;

		textField.x = 2;
		textField.y = 2;		
		textField.selectable = false;

		var btn = new Sprite();
		var width = textField.width + 4;
		var height = textField.height + 4;
		
		btn.graphics.beginFill(0xFFCC00);
		btn.graphics.drawRoundRect(0, 0, width, height, 5);
		
		if(onClick != null) 
		{
			btn.buttonMode = true;
			btn.mouseChildren = false;
			btn.useHandCursor = true;
			btn.addEventListener(MouseEvent.CLICK, function (e: MouseEvent) { onClick(); } );
		}
		
		btn.addChild(textField);

		return btn;
	}
}