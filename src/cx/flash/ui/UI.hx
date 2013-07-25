package cx.flash.ui;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

/**
 * ...
 * @author 
 */
class UI
{

	
	
	
	static public function createButton(txt: String, onClick: Void -> Void, x:Float=0, y:Float=0, color:Int=0xFFCC00,  width:Float=0, height:Float=0, margin:Float=4, format:TextFormat=null, round:Bool=false): Sprite 
	{		
		
		var textField = new TextField();
		//trace(format);
		if (format != null) textField.defaultTextFormat = format;
		textField.text = txt;
		textField.autoSize = TextFieldAutoSize.LEFT;		
		textField.selectable = false;
		
		if (width == 0) width = textField.width + margin;
		if (height == 0) height = textField.height + margin;

		textField.x = width / 2 - textField.width / 2;
		textField.y = height / 2 - textField.height / 2;
		
		var btn = new Sprite();
		btn.graphics.beginFill(color);
		if (!round)
			btn.graphics.drawRoundRect(0, 0, width, height, 9);
		else
			btn.graphics.drawEllipse(0, 0, width, height);
		
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
	
	static public function createText(txt, x:Float = 0, y:Float = 0, format:TextFormat=null):TextField
	{
		var textField = new TextField();
		if (format != null) textField.defaultTextFormat = format;
		textField.text = txt;
		textField.autoSize = TextFieldAutoSize.LEFT;

		textField.x = x;
		textField.y = y;		
		textField.selectable = false;
		return textField;		
	}
	
}