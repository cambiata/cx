
import cx.ArrayTools;
import cx.ObjectTools;
import cx.tink.devtools.Lorem;
import ka.tools.Integrity;
import ka.tools.PersonTools;
import ka.types.Person;
import ka.types.Personer;
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

class KalleWin extends KalleWinBase
{

	static public function main() {
		new KalleWin();
	}
	
	override private function log(message:String) {
		this.logMessage(message);		
	}
	
	var listPerson:Person;
	var editPerson:Person;
	
	override private function setHandlers() {		
		if (this.listBox != null)
		this.listBox.onSelected = function(_) {
			trace('listBox selected');
			trace(listBox.getSelection());
			log(listBox.getString(listBox.getSelection()));
			
			this.listPerson = this.listPersoner[listBox.getSelection()];
			this.editPerson = ObjectTools.clone(this.listPerson); 
			
			this.displayListPerson();
		}	
		
		if (this.txtSearch != null) 
		this.txtSearch.onTextUpdated = function(_) {
			this.searchListPersoner(this.txtSearch.getValue());
		}
			
		
		
		
		if (this.btnInitData != null)
		this.btnInitData.onClick = function(_) {
			this.initData();
			displayPersoner(dataPersoner);
			checkSavePerson();
		};		
		
		if (this.txtFornamn != null) 
		this.txtFornamn.onTextUpdated = function(_) {
			this.editPerson.fornamn = this.txtFornamn.getValue();
			trace(this.editPerson);
			this.checkSavePerson();
		}

		if (this.txtEfternamn != null) 
		this.txtEfternamn.onTextUpdated = function(_) {
			this.editPerson.efternamn = this.txtEfternamn.getValue();
			trace(this.editPerson);
			this.checkSavePerson();
		}	
		
		if (this.txtPersonnr != null) 
		this.txtPersonnr.onTextUpdated = function(_) {
			this.editPerson.personnr = this.txtPersonnr.getValue();
			trace(this.editPerson);
			this.checkSavePerson();
		}		
		
		if (this.txtEpost != null) 
		this.txtEpost.onTextUpdated = function(_) {
			this.editPerson.epost = this.txtEpost.getValue();
			trace(this.editPerson);
			this.checkSavePerson();
		}			
		
		
		if (this.btnPersonUpdate != null) 
		this.btnPersonUpdate.onClick = function(_) {
			if (checkChangedPerson()) {
				this.savePerson();
			}
		}
	}
	
	private function checkChangedPerson() {
		if (this.listPerson == null) return false;
		if (this.editPerson == null) return false;		
		
		var errors = Integrity.check([editPerson]);
		displayErrors(errors);
		if (errors.length > 0) return false;
		return (Std.string(this.editPerson) != Std.string(this.listPerson));
	}
	
	private function checkSavePerson() {		
		btnPersonUpdate.setLabel((checkChangedPerson()) ? Utf8.decode('Spara') : '');
	}
	
	private function savePerson() {
		var diffFields = PersonTools.compare(editPerson, listPerson);
		trace(editPerson.studieterminer);
		trace(listPerson.studieterminer);
		
		for (field in diffFields) {
			this.updatePersonField(editPerson, field);
		}
	}
	
	private function searchListPersoner(search:String) {		
		this.listBox.setSelection( -1);
		this.listPersoner = PersonTools.searchPersoner(this.dataPersoner, search);		
		this.displayPersoner(this.listPersoner);
	}
	
	/*
	private var frame:Frame;
		
	public function new() {
		frame = ApplicationMain.frame;
		this.createUI(frame);
	}
	
	private function createUI(frame:wx.Frame) {
		//var mainPanel = Panel.create(frame);
		
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
		frame.setSizer(mainSizer);

		//-----------------------------------------------------------------------------------------------------		
	 	var notebook = Notebook.create(frame, null, null, {width:300, height:500});		
		mainSizer.add(notebook, 4, Sizer.EXPAND | Sizer.BORDER_ALL, 4);
		
		var notebookPage1 = Window.create(notebook);
		notebook.addPage(notebookPage1, 'Page1');
		
		var notebookPage2 = Window.create(notebook);
		notebook.addPage(notebookPage2, 'Page2');		
		
		//-----------------------------------------------------------------------------------------------------
		var midPanel = Panel.create(frame);
		mainSizer.add(midPanel, 4, Sizer.EXPAND | Sizer.BORDER_ALL, 4);		
		
		//var midSizer = FlexGridSizer.create(null, 2);
		//midSizer.addGrowableCol(1, 1);
		var midSizer = BoxSizer.create(true);		
		midPanel.setSizer(midSizer);
		
		//var label = StaticText.create(midPanel, null, 'Label');
		//midSizer.add(label, 0, Sizer.ALIGN_CENTRE_VERTICAL | Sizer.BORDER_ALL, 8);		
		
		var textCtrl = TextCtrl.create(midPanel, null, 'Some text here...');
		midSizer.add(textCtrl, 0, Sizer.EXPAND | Sizer.BORDER_ALL, 4);		
		
		//this.addListBox(midPanel, midSizer);
		
		//-----------------------------------------------------------------------------------------------------
		
		var rightPanel = Panel.create(frame);
		mainSizer.add(rightPanel, 0, Sizer.EXPAND | Sizer.BORDER_ALL, 4);				
		
		var btnRUpdate = Button.create(rightPanel, null, 'Update');
		var rightSizer = BoxSizer.create(true);
		rightPanel.setSizer(rightSizer);
		rightSizer.add(btnRUpdate, 0);
		rightSizer.addSpacer(10);	
		
		//-----------------------------------------------------------------------------------------------------
		
		btnRUpdate.onClick = function(_) {
			trace('click');
			this.addListBox(midPanel, midSizer, ArrayTools.shuffle(Lorem.text.words));
		}
		
	}
	
	private var listBox:ListBox;

	private function addListBox(parent:Window, sizer:Sizer, items:Array<String>) {
		if (this.listBox != null) this.listBox.destroy();		
		
		var size = parent.getSize();
		size.width = size.width - 8;
		size.height = size.height - 36;
		
		this.listBox = ListBox.create(parent, null, {x:4, y:33}, size, items);
		sizer.add(this.listBox, 1, Sizer.EXPAND | Sizer.BORDER_ALL, 4);		
	}
	
	
	private function forceResize() {
		var size = frame.getSize();
		size.width++;		
		frame.setSize(size);
	}
	*/
	
	private var listPersoner:Personer;
	override public function displayPersoner(personer:Personer) {		
		if (personer == null) return;		
		this.listPersoner = personer;		
		this.listPersoner.sort(function(a, b) { return Reflect.compare(a.efternamn + a.fornamn, b.efternamn + b.fornamn); } );
		
		var p = Lambda.map(this.listPersoner, function(p) { return Utf8.decode(p.efternamn + ', ' + p.fornamn + ' (' + p.personnr + ')'); } );		
		
		this.addListBox(this.midPanel, this.midSizer, Lambda.array(p));				
	}

	private function displayListPerson() {
		trace(this.listPerson);
		this.txtFornamn.setValue(Utf8.decode(this.listPerson.fornamn));
		this.txtEfternamn.setValue(Utf8.decode(this.listPerson.efternamn));
		this.txtPersonnr.setValue(this.listPerson.personnr);
		this.txtEpost.setValue(this.listPerson.epost);
		this.labelPersonRow.setLabel(Std.string(this.listPerson.sheetrow));		
	}
	
	
	
	
	
}