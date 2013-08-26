package scorx.ui;
import flash.events.Event;
import flash.text.TextFormat;
import ru.stablex.ui.events.WidgetEvent;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Text;
import ru.stablex.ui.widgets.Progress;
import ru.stablex.ui.widgets.Widget;

/**
 * ...
 * @author 
 */
class ChannelWidget extends Widget
{

	 var progress:Progress;	
	 var label:Text;
	 var channelId:String;
	
	public function new(channelLabel:String, channelId:String) 
	{
		super();
		this.channelId = channelId;		
		
		this.w = 100;
		this.h = 30;
		
		 this.label = UIBuilder.create(Text);
		 label.text = channelLabel;
		 this.label.format = new TextFormat("Arial", 12, 0xFFFFFF, true);
		 label.w = 100;
		 this.addChild(label);
		
		progress = UIBuilder.create(Progress);
		 progress.defaults = "Default";
		 progress.interactive = true;
		 progress.w = 100;
		 progress.h = 16;
		 progress.y = 20;
		 progress.max = 1;
		 progress.value = 0.7;
		 this.addChild(progress);
		 
		 progress.addEventListener(WidgetEvent.CHANGE, onChange);
		 
	}
	
	private function onChange(e:WidgetEvent):Void 
	{
		this.onChangeValue(this.channelId, this.progress.value);
	}
	
	public dynamic function  onChangeValue(channelId:String, value:Float)
	{
		trace([channelId, value]);
	}
	
}