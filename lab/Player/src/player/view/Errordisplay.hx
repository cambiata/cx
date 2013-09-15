package player.view;

import flash.text.TextFormat;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.widgets.Text;
import scorx.data.Errors;
import sx.mvc.view.HBoxView;
import sx.mvc.view.BoxView;
import sx.mvc.view.VBoxView;
import sx.mvc.view.WidgetView;

/**
 * ...
 * @author 
 */
class ErrordisplayView extends WidgetView 
 {

	public var btn:Button;	
	public var tf:Text;
	
	
	override public function createChildren() 
	 {
		this.w = 500;
		this.h = 260;

		this.btn = UIBuilder.create(Button);
		this.btn.text = "Close";		
		this.addChild(this.btn);
		this.btn.y = this.h - 40;
		this.btn.x = this.w - 110;
		
		this.tf = UIBuilder.create(Text);
		this.tf.format = new TextFormat('Arial', 12, 0xFFFFFF);
		this.tf.text = 'Error';
		this.tf.x = this.tf.y = 10;
		
		this.addChild(this.tf);
		
		this.visible = false;
	}
	
	override public function addSkin()
	 {
		
		var skin = new Paint();
		skin.color = 0x800000;
		skin.corners = [8, 8];
		skin.apply(this);				
	}
}

class ErrordisplayMediator extends mmvc.impl.Mediator<ErrordisplayView>
{
	@inject public var errors:Errors;
	
	
	override function onRegister() 
	 {
		trace('ErrordisplayMediator registered');	
		
		this.view.btn.onPress = function(e)
		{
			this.view.visible = false;
		};		
		
		this.errors.status.add(function(status:ErrorStatus) {			
			switch (status)
			{
				case ErrorStatus.Added(message, messages):
					this.view.visible = true;
					this.view.tf.text = '';
					for (mess in messages)
					{
						this.view.tf.text += mess + '\n';						
					}
					this.view.tf.refresh();
					
				case ErrorStatus.None:
					this.view.visible = false;				
			}
		});
		
	}	
}



/*

import player.view.Errordisplay.ErrordisplayView;
import player.view.Errordisplay.ErrordisplayMediator;


		var viewErrordisplayView:ErrordisplayView = new ErrordisplayView();
		this.view.addChild(viewErrordisplayView);



		mediatorMap.mapView(ErrordisplayView, ErrordisplayMediator);

*/