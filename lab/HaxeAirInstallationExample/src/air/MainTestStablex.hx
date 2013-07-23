package air;
import flash.Lib;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;

/**
 * ...
 * @author 
 */
class MainTestStablex
{

	static public function main() 
	{
		trace('Hello');
		UIBuilder.init("../../assets/ui/scorx-defaults.xml");
		UIBuilder.regSkins("../../assets/ui/scorx-skins.xml");
		var sxBtn:Button = UIBuilder.create(Button);
		sxBtn.x = 200;
		sxBtn.y = 200;
		Lib.current.addChild(sxBtn);		
	}
	
}