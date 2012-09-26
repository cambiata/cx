package smd.server.sxjs.controller;
import smd.server.sxjs.MainController;
import smd.server.sxjs.widget.alert.Alert;
/**
 * ...
 * @author Jonas Nyström
 */
using Detox;
using dtx.Tools;
class AlertController extends Controller
{
	private var divAlerts:DOMCollection;
	
	
	public function new(main:MainController) {
		trace('AlertsController');
		super(main);
		this.divAlerts = this.findElement('#divAlerts');
		this.divAlerts.setText('Hello from AlertController');
		
		"#path".find().setText(Tools.window.location.href);
		
		"#test".find().setText('Javascript engine ok!');	

		"#addError".find().click(function (e) {			
			var alert = new Alert('Error', 'This is an Error Alert!.', 'alert-error');
			this.divAlerts.append(alert);
		});

		"#addInfo".find().click(function (e) {			
			var alert = new Alert('Information', 'This is some information about something.', 'alert-info');
			this.divAlerts.append(alert);
		});		
		
	}
	
}