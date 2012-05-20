import wx.Button;
import wx.ComboBox;
import wx.Frame;
import wx.Panel;
import wx.StaticText;
import wx.TextCtrl;


class HelloWaxe {	

	public function new() {
		var frame = ApplicationMain.frame;				
		var panel = Panel.create(frame);		
		var staticText = StaticText.create(panel, null, 'Hello Waxe!', { x:20, y:10 } );
		var btnQuit = Button.create(panel, null, 'Quit', { x:500, y:320 } );
		btnQuit.onClick = function(_) { 
			wx.App.quit();
		}
		
		var textCtrl = TextCtrl.create(panel, null, 'Hello World', { x:20, y:80 }, { width:200, height:22 } );
		textCtrl.onTextUpdated = function(_) {
			staticText.label = textCtrl.getValue();
		}
		
	}
	
	static public function main() {
		new HelloWaxe();
	}
}