package cx.flash.ui;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

/**
 * ...
 * @author 
 */
class UI
{

	static public function createButton(txt: String, onClick: Void -> Void, x:Float=0, y:Float=0, color:Int=0xFFCC00): Sprite 
	{		
		var textField = new TextField();
		textField.text = txt;
		textField.autoSize = TextFieldAutoSize.LEFT;

		textField.x = 2;
		textField.y = 2;		
		textField.selectable = false;

		var btn = new Sprite();
		var width = textField.width + 4;
		var height = textField.height + 4;
		
		btn.graphics.beginFill(color);
		btn.graphics.drawRoundRect(0, 0, width, height, 5);
		
		if(onClick != null) 
		{
			btn.buttonMode = true;
			btn.mouseChildren = false;
			btn.useHandCursor = true;
			btn.addEventListener(MouseEvent.CLICK, function (e: MouseEvent) { onClick(); } );
		}
		
		btn.addChild(textField);
		btn.x = x;
		btn.y = y;
		
		return btn;
	}	
	
	static public function createText(txt, x:Float = 0, y:Float = 0):TextField
	{
		var textField = new TextField();
		textField.text = txt;
		textField.autoSize = TextFieldAutoSize.LEFT;

		textField.x = x;
		textField.y = y;		
		textField.selectable = false;
		return textField;		
	}
	
}