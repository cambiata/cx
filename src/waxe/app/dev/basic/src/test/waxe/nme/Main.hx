package test.waxe.nme;

import wx.App;
import wx.Button;
import wx.Frame;
import wx.Menu;
import wx.MenuBar;
import wx.Panel;
import wx.StaticText;
import wx.TextCtrl;

class Main {
    public function new() {
		var frame:Frame = ApplicationMain.frame;
        var panel = Panel.create(frame);
        var staticText = StaticText.create(panel, null, 'Hello Waxe!', {x:20, y: 10});		
		
		var btnQuit = Button.create(panel, null, 'Quit', { x:500, y:320 } );
		btnQuit.onClick = function(_) { 
            trace('Someone clicked me!');
            App.quit();
        }		
		
		var textCtrl = TextCtrl.create(panel, null, 'Hello World', { x:20, y:80 }, { width:200, height:22 } );
		textCtrl.onTextUpdated = function(_) {
			staticText.label = textCtrl.getValue();
		}	

		var menuBar = new MenuBar();
		frame.menuBar = menuBar;

		var menuFile = new Menu();
		menuBar.append(menuFile, 'File');		
		
		menuFile.append(0, 'Test');
        menuFile.appendSeparator();
        menuFile.append(999, 'Quit');		
		
        frame.handle(0, function(_) { trace('Menu test clicked'); } );
        frame.handle(999, function(_) { wx.App.quit(); } );		
		
    }

    static public function main() {
        new Main();
    }
}