

import cx.ArrayTools;
import cx.EncodeTools;
import cx.StrTools;
import cx.tink.devtools.Lorem;
import cx.Tools;
import neko.Utf8;
import wx.BoxSizer;
import wx.Button;
import wx.FlexGridSizer;
import wx.Frame;
import wx.ListBox;
import wx.Menu;
import wx.Notebook;
import wx.Panel;
import wx.MenuBar;
import wx.Sizer;
import wx.StaticText;
import wx.TextCtrl;
import wx.Window;


/**
 * ...
 * @author Jonas Nyström
 */

class KalleWinBase extends KalleWinData
{
	
	private var frame:Frame;
		
	public function new() {
		super();
		frame = ApplicationMain.frame;
		this.createUI(frame);
	}

	
	private var txtFornamn:TextCtrl;
	private var txtEfternamn:TextCtrl;
	private var txtPersonnr:TextCtrl;
	private var txtEpost:TextCtrl;
	
	private var btnInitData:Button;
	private var labelPersonRow:StaticText;
	private var btnPersonUpdate:Button;
	
	
	
	private function createUI(frame:wx.Frame) {
		
		var framePanel = Panel.create(frame);		
		var frameSizer = BoxSizer.create(true);		
		frame.setSizer(frameSizer);
		frameSizer.add(framePanel, 4, Sizer.EXPAND);
		//frameSizer.setSizeHints(frame);

		logPanel = Panel.create(frame);		
		frameSizer.add(logPanel, 1, Sizer.EXPAND);
		
		logSizer = BoxSizer.create(false);
		this.addLogBox(logPanel, logSizer, Utf8.decode('Körakademins administrativa verktyg KALLE'));
		logPanel.setSizer(logSizer);
		
		
		
		var menuBar = new MenuBar();
		frame.menuBar = menuBar;
		
        var menuFile = new Menu();
        menuBar.append(menuFile, 'File');		
		
        menuFile.append(0, 'Test');
        menuFile.appendSeparator();
        menuFile.append(999, 'Quit');		
		
        frame.handle(0, function(_) { trace('Menu test clicked'); } );
        frame.handle(999, function(_) { wx.App.quit(); } );		
		
		//-----------------------------------------------------------------------------------------------------
		var mainSizer = BoxSizer.create(false);
		framePanel.setSizer(mainSizer);

		//-----------------------------------------------------------------------------------------------------		
	 	var notebook = Notebook.create(framePanel, null, null, {width:300, height:500});		
		mainSizer.add(notebook, 4, Sizer.EXPAND | Sizer.BORDER_ALL, 4);
		
		var personPage = Window.create(notebook);
		notebook.addPage(personPage, 'Page1');
		
		var personSizer = FlexGridSizer.create(null, 2);
		personPage.setSizer(personSizer);
		
		
		personSizer.addGrowableCol(1, 1);
		var label = StaticText.create(personPage, null, Utf8.decode('Rad'));
		personSizer.add(label, 0, Sizer.ALIGN_CENTRE_VERTICAL | Sizer.BORDER_ALL, 8);		
		labelPersonRow = StaticText.create(personPage, null, '0');		
		personSizer.add(labelPersonRow, 0, Sizer.ALIGN_CENTRE_VERTICAL | Sizer.BORDER_ALL, 4);		
		
		personSizer.addGrowableCol(1, 1);
		var label = StaticText.create(personPage, null, Utf8.decode('Förnamn'));
		personSizer.add(label, 0, Sizer.ALIGN_CENTRE_VERTICAL | Sizer.BORDER_ALL, 8);		
		txtFornamn = TextCtrl.create(personPage);
		personSizer.add(txtFornamn, 0, Sizer.EXPAND | Sizer.BORDER_ALL, 4);		
		
		personSizer.addGrowableCol(1, 1);
		var label = StaticText.create(personPage, null, 'Efternamn');
		personSizer.add(label, 0, Sizer.ALIGN_CENTRE_VERTICAL | Sizer.BORDER_ALL, 8);		
		txtEfternamn = TextCtrl.create(personPage);
		personSizer.add(txtEfternamn, 0, Sizer.EXPAND | Sizer.BORDER_ALL, 4);	
		
		// personnr
		personSizer.addGrowableCol(1, 1);
		var label = StaticText.create(personPage, null, 'Personnummer');
		personSizer.add(label, 0, Sizer.ALIGN_CENTRE_VERTICAL | Sizer.BORDER_ALL, 8);		
		txtPersonnr = TextCtrl.create(personPage, null, null, null, {width: 120, height: 24});
		personSizer.add(txtPersonnr, 0, Sizer.EXPAND | Sizer.BORDER_ALL, 4);				
		
		// epost
		personSizer.addGrowableCol(1, 1);
		var label = StaticText.create(personPage, null, 'E-post');
		personSizer.add(label, 0, Sizer.ALIGN_CENTRE_VERTICAL | Sizer.BORDER_ALL, 8);		
		txtEpost = TextCtrl.create(personPage, null, null, null);
		personSizer.add(txtEpost, 0,  Sizer.EXPAND | Sizer.BORDER_ALL, 4);				
		
		
		personSizer.addGrowableCol(1, 1);
		var label = StaticText.create(personPage, null, '');
		personSizer.add(label, 0, Sizer.ALIGN_CENTRE_VERTICAL | Sizer.BORDER_ALL, 8);		
		btnPersonUpdate = Button.create(personPage, null, '');
		personSizer.add(btnPersonUpdate, 0, Sizer.ALIGN_RIGHT | Sizer.BORDER_ALL, 20);
		
		
		
		
		var notebookPage2 = Window.create(notebook);
		notebook.addPage(notebookPage2, 'Page2');		
		
		//-----------------------------------------------------------------------------------------------------
		midPanel = Panel.create(framePanel);
		mainSizer.add(midPanel, 4, Sizer.EXPAND | Sizer.BORDER_ALL, 4);		
		
		//var midSizer = FlexGridSizer.create(null, 2);
		//midSizer.addGrowableCol(1, 1);
		midSizer = BoxSizer.create(true);		
		midPanel.setSizer(midSizer);
		
		//var label = StaticText.create(midPanel, null, 'Label');
		//midSizer.add(label, 0, Sizer.ALIGN_CENTRE_VERTICAL | Sizer.BORDER_ALL, 8);		
		
		txtSearch = TextCtrl.create(midPanel, null, '');
		midSizer.add(txtSearch, 0, Sizer.EXPAND | Sizer.BORDER_ALL, 4);		
		
		//this.addListBox(midPanel, midSizer);
		
		//-----------------------------------------------------------------------------------------------------
		
		var rightPanel = Panel.create(framePanel);
		mainSizer.add(rightPanel, 0, Sizer.EXPAND | Sizer.BORDER_ALL, 4);				
		
		var rightSizer = BoxSizer.create(true);
		rightPanel.setSizer(rightSizer);

		btnInitData = Button.create(rightPanel, null, Tools.stringAscii('Hämta data'));
		rightSizer.add(btnInitData);

		
		/*
		var btnRUpdate = Button.create(rightPanel, null, 'Update');
		rightSizer.add(btnRUpdate, 0);
		
		rightSizer.addSpacer(10);	
		
		var btnRLogg = Button.create(rightPanel, null, 'Logg');
		rightSizer.add(btnRLogg, 0);
		
		var btnRDisplay = Button.create(rightPanel, null, 'Display');
		rightSizer.add(btnRDisplay);
		btnRDisplay.onClick = function(_) {
			displayPersoner(dataPersoner);
		}
		*/
		
		//-----------------------------------------------------------------------------------------------------
		
		setHandlers();
		
	}
	
	private var listBox:ListBox;

	private var midPanel:Panel;
	private var midSizer:Sizer;
	
	private function addListBox(parent:Window, sizer:Sizer, items:Array<String>) {
		if (this.listBox != null) this.listBox.destroy();		
		var size = parent.getSize();
		size.width = size.width - 8;
		size.height = size.height - 36;
		this.listBox = ListBox.create(parent, null, {x:4, y:33}, size, items);
		sizer.add(this.listBox, 1, Sizer.EXPAND | Sizer.BORDER_ALL, 4);		
		
		this.setHandlers();
	}
	
	private var logItems:Array<String>;
	private var logBox:ListBox;	
	private var logSizer:Sizer;
	private var logPanel:Panel;
	private var txtSearch:TextCtrl;
	
	private function addLogBox(parent:Window, sizer:Sizer, item:String) {
		if (this.logBox != null) this.logBox.destroy();		
		if (logItems == null) this.logItems = [];
		logItems.push(item);		
		var size = parent.getSize();
		size.width = size.width - 16;
		size.height = size.height - 16;
		this.logBox = ListBox.create(parent, null, { x:8, y:8 }, size, logItems);		
		sizer.add(this.logBox, 1, Sizer.EXPAND | Sizer.BORDER_ALL, 8);		
		logBox.setSelection(this.logItems.length-1);
	}
	
	private function logMessage(message:String) {
		this.addLogBox(this.logPanel, this.logSizer, message);		
	}
	
	private function forceResize() {
		var size = frame.getSize();
		size.width++;		
		frame.setSize(size);
	}
	
	private function setHandlers() {
		
	}
	

	
	
}