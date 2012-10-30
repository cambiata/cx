package waxe.ui;
import cx.ReflectTools;
import cx.StrTools;
import cx.TimerTools;
import wx.App;
import wx.BoxSizer;
import wx.Button;
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

class WaxeUI 
{

	private var eventTarget:Dynamic;
	private var applicationFrame:Frame;
	
	public function new(eventTarget:Dynamic) {
		this.eventTarget = eventTarget;		
		this.applicationFrame = ApplicationMain.frame;
		
		
		this.createUI();
		TimerTools.timeout(function() {
			//this.callEventTargetHandler('onUICreated', { } );
			this.initData();
			this.initUI();
		}, 500);
	}
	

	
	private function createUI() {
		throw "WaxeUI.createUI() should be overridden";
	}

	private function initData() {
		throw "WaxeUI.initData() should be overridden";
	}
	
	private function initUI() {
		throw "WaxeUI.initUI() should be overridden";
	}
	
	
	public function uiCreateNotebookPageFlex(notebook:Notebook, label:String) :{ page:Window, sizer:FlexGridSizer } {
		
		var page = Window.create(notebook);		
		var sizer = FlexGridSizer.create(null, 2);
		sizer.addGrowableCol(1,1);				
		page.sizer = sizer;
		//sizer.setSizeHints(page);
		notebook.addPage(page, label);				
		return { page:page, sizer:sizer };
	}
	
	public function uiCreateNotebookPageBox(notebook:Notebook, label:String, vertical:Bool=true) :{ page:Window, sizer:BoxSizer } {
		var page = Window.create(notebook);		
		var sizer = BoxSizer.create(vertical);
		page.sizer = sizer;
		sizer.setSizeHints(page);
		notebook.addPage(page, label);				
		return { page:page, sizer:sizer };
	}	
		
	
	private function uiCreateButton(parent:Window, name:String, label:String=null) {
		if (label == null) label = name;
		var btn = Button.create(parent, null, label);
		btn.name = name;
		btn.onClick = this.onUIButtonClick;
		return btn;
	}
	
	private function uiCreateTextctrl(parent:Window, name:String, text:String=null) {
		if (text == null) text = name;
		var textctrl = TextCtrl.create(parent, null, text);
		textctrl.name = name;		
		textctrl.onTextUpdated = this.onUITextctrlUpdated;
		return textctrl;
	}
	
	private function uiCreateListbox(parent:Window, name:String, values:Array<String>=null, width = 200, height = 400, x=0, y=0 ) {		
		var listbox = ListBox.create(parent, null, { x:x, y:y }, { width:width, height:height }, values);
		listbox.name = name;
		listbox.onSelected = this.onUIListboxSelected;
		listbox.onDClick = this.onUIListboxDClicked;
		return listbox;
	}
	
	
	///--------------------------------------------------------------------------------------------------------------
	
	private function onUIButtonClick(event:Dynamic) {
		if (event.name == 'button') throw "wx.Button.name must be set, and can't be 'button'";
		var name:String = StrTools.firstUpperCase(Std.string(event.name), false);		
		var eventHandlerName = 'on' + name + 'Click';
		this.uiCallEventTargetHandler(eventHandlerName, event);
	}
	
	private function onUITextctrlUpdated(event:Dynamic) {		
		var text:String = null;
		try {
			var control:TextCtrl = cast(Reflect.field(this, event.name), TextCtrl);
			if (control != null) {
				text = control.getValue();
			}
		} catch(e:Dynamic) {}
		Reflect.setField(event, 'text', text);
		
		var name:String = StrTools.firstUpperCase(Std.string(event.name), false);		
		var eventHandlerName = 'on' + name + 'Update';	
		this.uiCallEventTargetHandler(eventHandlerName, event);
		
	}
	
	private function onUIListboxSelected(event:Dynamic) {
		var value:String = null;
		var index:Int = null;
		try {
			var control:ListBox = cast(Reflect.field(this, event.name), ListBox);
			if (control != null) {
				index = control.getSelection();
				value = control.getString(index);		
			}
		} catch(e:Dynamic) {}
		Reflect.setField(event, 'value', value);
		Reflect.setField(event, 'index', index);
		
		var name:String = StrTools.firstUpperCase(Std.string(event.name), false);		
		var eventHandlerName = 'on' + name + 'Selected';	
		this.uiCallEventTargetHandler(eventHandlerName, event);		
	}

	private function onUIListboxDClicked(event:Dynamic) {
		var value:String = null;
		var index:Int = null;
		try {
			var control:ListBox = cast(Reflect.field(this, event.name), ListBox);
			if (control != null) {
				index = control.getSelection();
				value = control.getString(index);		
			}
		} catch(e:Dynamic) {}
		Reflect.setField(event, 'value', value);
		Reflect.setField(event, 'index', index);
		
		var name:String = StrTools.firstUpperCase(Std.string(event.name), false);		
		var eventHandlerName = 'on' + name + 'DoubleClick';	
		this.uiCallEventTargetHandler(eventHandlerName, event);			
	}	
	
	
	private function uiCallEventTargetHandler(eventHandlerName:String, event:Dynamic) {
		if  (ReflectTools.hasMethod(this.eventTarget, eventHandlerName)) {
			ReflectTools.callMethod(this.eventTarget, eventHandlerName, [event]);
		} else {
			trace("Event target doesn't have method " + eventHandlerName);
			trace(event);
		}
	}
		
	///---------------------------------------------------------------------------------------------
	
	public function setApplicationSize(width:Int, height:Int) {
		this.applicationFrame.setSize( { width:width, height:height } );
	}
	
}