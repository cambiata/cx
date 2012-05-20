import wx.BoxSizer;
import wx.Button;
import wx.ComboBox;
import wx.EventID;
import wx.FlexGridSizer;
import wx.ListBox;
import wx.Panel;
import wx.Sizer;
import wx.StaticText;
import wx.TextCtrl;

class Basic
{
   var frame:	wx.Frame;
   var winPanel: wx.Window;

   var listBox: ListBox;
   
   function new()
   {
		frame = ApplicationMain.frame;
		winPanel = Panel.create(frame);
		//winPanel = FlexGridSizer.create(3, 3);
		var sizer = FlexGridSizer.create(null, 1);
		sizer.addGrowableCol(0);		
		
		winPanel.setSizer(sizer);
		
		
		var itemsSizer = wx.FlexGridSizer.create(null,2);
		sizer.add(itemsSizer, 0, Sizer.EXPAND);
		
		itemsSizer.addGrowableCol(1,1);
		itemsSizer.add(StaticText.create(winPanel, null, " TextCtrl"), 0, Sizer.ALIGN_CENTRE_VERTICAL);
		var textCtrl = TextCtrl.create(winPanel, null, "Here is some text" );
		itemsSizer.add(textCtrl, 1, Sizer.EXPAND | Sizer.BORDER_ALL, 10);		
		
		
		var boxSizer = BoxSizer.create(false);
		var btnClose = Button.create(winPanel, null, "Close");
		btnClose.onClick = function(_) {
			//wx.App.quit();
			//this.listBox.destroy();
			//this.listBox = ListBox.create(winPanel, null, { x: 200, y:20 }, { width: 200, height:100 }, ['d', 'e']);
		}
		boxSizer.add(btnClose, 0, Sizer.EXPAND | Sizer.BORDER_ALL);
		
		sizer.add(boxSizer,0, Sizer.BORDER_ALL, 10);
		
		/*
		sizer.add(btnClose);
		var staticText = StaticText.create(winPanel, null, "TextCtrl");
		sizer.add(staticText);
		var textCtrl = TextCtrl.create(winPanel, null, 'Hejsan hoppsan textkontroll', { x:100, y:100 } );
		textCtrl.onTextUpdated = function(event:Dynamic) { trace(textCtrl.getValue()); };
		sizer.add(textCtrl);
		*/
		/*
		staticText.setPosition( { x:100, y:50 } );
		staticText.setLabel('Hejsan hoppsan');		
		
		
		var comboBox = ComboBox.create(winPanel, null, 'Test combo', { x:100, y:150 }, 200);
		comboBox.onTextUpdated = function(event:Dynamic) { 
			
				trace(event); 
				trace(comboBox.getValue());
			
			};
		
		listBox = ListBox.create(winPanel, null, { x: 200, y:20 }, { width: 200, height:100 }, ['a', 'b', 'c']);
		trace(listBox.getString(0));
		listBox.setString(0, 'ABC');
		*/
		
   }

   public static function main()
   {
      new Basic();
   }
}
