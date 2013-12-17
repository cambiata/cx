package print.mgr.view;

import flash.text.TextFormat;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Text;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;
import sx.mvc.view.WidgetView;

/**
 * ...
 * @author 
 */
class MgrStartupView extends VBoxView 
 {

	public var btn:Button;	
	
	public var label:Text;		
	public var label2:Text;		
	override public function createChildren() 
	{		 
		label = UIBuilder.create(Text);		
		label.format = new TextFormat('Arial', 14, 0xFFFFFF);
		label.text = 'Scorx Print-installation genomförd.';		
		label.h = 14;
		this.addChild(label);

		label2 = UIBuilder.create(Text);		
		label2.format = new TextFormat('Arial', 14, 0xFFFFFF);
		label2.text = 'Utskrift kan nu startas med Skriv ut-knappen på webbläsarens Scorxspelar-sida.';		
		this.addChild(label2);
		
		
		btn = UIBuilder.create(Button);
		btn.w = 140;
		btn.text = 'Stäng Scorx Print';
		this.addChild(btn);
		btn.onPress = function(e)
		{
			flash.desktop.NativeApplication.nativeApplication.exit();			
		}
		
		this.w = Constants.MANAGER_VIEW_W;
		this.h = Constants.MANAGER_VIEW_H_COVER;

	}
	
	override public function addSkin() 
	{
		trace('D as');
		var skin:Paint = new Paint();
		skin.color = Constants.MANAGER_VIEW_COLOR;
		skin.apply(this);
	}	
	
}

class MgrStartupMediator extends mmvc.impl.Mediator<MgrStartupView>
{
	override function onRegister() 
	 {
		trace('MgrStartupMediator registered');		
	}	
}