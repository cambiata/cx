package;

import wx.App;
import wx.Button;
import wx.Frame;
import wx.NMEStage;
import wx.Panel;
import wx.Sizer;
import wx.BoxSizer;

import nme.display.StageAlign;
import nme.display.StageScaleMode;

class Server
{
	private var frame:Frame;
	
	function new()
	{
		// Make an app window
		frame = Frame.create(null, "WaxeApp" , null , { width:400 , height:400 } );
		
		// Make a panel
		var waxePanel:Panel = Panel.create( frame );
		var button:Button = Button.create( waxePanel, null, 'A Button');
		
		// Make an NME stage
		var nmeStage:NMEStage = NMEStage.create( waxePanel );
		nmeStage.stage.align = StageAlign.TOP_LEFT;
		nmeStage.stage.scaleMode = StageScaleMode.NO_SCALE;
		// Draw something on the NMEStage
		nmeStage.stage.graphics.beginFill( 0x000000 );
		nmeStage.stage.graphics.drawCircle( 50 , 50 , 50 );
		nmeStage.stage.graphics.endFill();
		
		// Auto position the panel and NMEStage with a sizer
		var sizer:Sizer = BoxSizer.create(true);
		waxePanel.setSizer(sizer);
		sizer.add( button , 1 , Sizer.EXPAND | Sizer.BORDER_ALL , 5 );
		sizer.add( nmeStage , 3 , Sizer.EXPAND | Sizer.BORDER_ALL , 5);
		
		
		// Show your window
		App.setTopWindow( frame );
		frame.shown = true;
	}

	
	
	// Entry
	public static function main()
	{
		App.boot( function(){ new Server(); } );
	}
}
