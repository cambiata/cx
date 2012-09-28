import wx.BoxSizer;
import wx.Button;
import wx.Frame;
import wx.Panel;
import wx.Sizer;
import wx.ListBox;

class SizerTest {	
	public function new() {
		var frame = ApplicationMain.frame;				
		var panel = Panel.create(frame);
		
		var btnBig = Button.create(panel, null, 'A really really big button');
		var btnTiny = Button.create(panel, null, 'Tiny button');
		
		var sizer = BoxSizer.create(true);
		panel.setSizer(sizer);
		sizer.add(btnBig, 1);
		sizer.add(btnTiny, 3, wx.Sizer.EXPAND | wx.Sizer.BORDER_ALL, 8);
		sizer.setSizeHints(frame);
		
		var listBox = ListBox.create(frame, null, { x:400, y:10 }, { width:300, height:400 }, ['one', 'two'] );
		//sizer.add(listBox, 4);
		
		panel.add(listBox, 3, wx.Sizer.EXPAND | wx.Sizer.BORDER_ALL, 8);
		
		
	}
	
	static public function main() {
		new SizerTest();
	}
}