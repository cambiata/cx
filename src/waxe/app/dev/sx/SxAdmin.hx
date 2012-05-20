import sx.type.TFiles;
import sx.type.TListExamples;
import sx.util.ScorxExamples;
import wx.App;
import wx.BoxSizer;
import wx.Button;
import wx.Dialog;
import wx.DirDialog;
import wx.FlexGridSizer;
import wx.Frame;
import wx.ListBox;
import wx.Notebook;
import wx.Panel;
import wx.Sizer;
import wx.StaticText;
import wx.TextCtrl;
import wx.Window;

/**
 * ...
 * @author Jonas Nyström
 */

class SxAdmin 
{
	private var frame:Frame;
	//private var window:Window;
	private var listBox:ListBox;
	private var firstrun: Bool;
	private var scorxExamples:ScorxExamples;
	private var listExamples:TListExamples;
	
	public function new() {
		frame = ApplicationMain.frame;
		//window = Panel.create(frame);
		this.firstrun = true;
		//window.onPaint = init;
		//frame.onPaint = init;
		
		//listBox = ListBox.create(window, null, { x:400, y:10 }, { width:300, height:400 } );
		//this.updateListBox(['Hello']);
		
		//frame.onDropFiles = function(_) { trace('Drop files'); };
		
		/*
		var button = Button.create(frame, null, 'Hello', { x:100, y:20 } );
		button.onClick = function(_) {
			trace('click');			
		}
		*/
		
		//sizer = BoxSizer.create(true);
		//frame.setSizer
		
		var notebook:Notebook = Notebook.create(frame, null, { x:0, y:0 }, { width:200, height:200 } );
				
		var page = Window.create(notebook);
		var sizer = FlexGridSizer.create(null, 2);
		sizer.addGrowableCol(1, 1);		
		var label = StaticText.create(page, null, 'Label');
		sizer.add(label, 0, Sizer.ALIGN_CENTRE_VERTICAL | Sizer.BORDER_ALL, 2);
		var textCtrl = TextCtrl.create(page, null, "800" );
		sizer.add(textCtrl, 1, Sizer.EXPAND | Sizer.BORDER_ALL, 4);
		page.sizer = sizer;
		sizer.setSizeHints(page);
		notebook.addPage(page, 'Test');		
		
		var page = Window.create(notebook);
		
		/*
		var sizer = FlexGridSizer.create(null, 2);
		sizer.addGrowableCol(1, 1);		
		var label = StaticText.create(page, null, 'Label');
		sizer.add(label, 0, Sizer.ALIGN_CENTRE_VERTICAL | Sizer.BORDER_ALL, 2);
		var width = TextCtrl.create(page, null, "800" );
		sizer.add(width, 1, Sizer.EXPAND | Sizer.BORDER_ALL, 4);
		page.sizer = sizer;
		sizer.setSizeHints(page);
		*/
		
		notebook.addPage(page, 'Page 2');				
		
		
		
		
	}
	
	private function init(_) {
		if (!this.firstrun) return;
		this.firstrun = false;
		trace('onPaint');
		var dir = 'D:/dropbox_scorxmedia/My Dropbox/smd/smdfiles/scorx';		
		scorxExamples = new ScorxExamples(dir);
		listExamples = scorxExamples.getListExamples();
		//trace(filenames);
		this.updateListBox(scorxExamples.getFilenames());
		
		trace('onPaint2');
	}
	
	private function updateListBox(items:Array<String>) {
		if (listBox != null) listBox.destroy();
		listBox = ListBox.create(this.frame, null, { x:400, y:10 }, { width:300, height:400 }, items );
		listBox.onSelected = onListBoxSelect;
	}
	
	private function onListBoxSelect(_) {
		trace('select');
		trace(listBox.getSelection());
		trace(listBox.getString(listBox.getSelection()));
		trace(Lambda.array(scorxExamples.getFiles())[listBox.getSelection()]);
	}
	
	static public function main() {
		new SxAdmin();
	}
	
	
	
}