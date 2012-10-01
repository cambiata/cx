class ApplicationMain
{

	#if waxe
	static public var frame : wx.Frame;
	static public var autoShowFrame : Bool = true;
	#if nme
	static public var nmeStage : wx.NMEStage;
	#end
	#end
	
	public static function main()
	{
		#if nme
		nme.Lib.setPackage("waxe", "Main", "test.waxe.nme", "1.0");
		
		#end
		
		#if waxe
		wx.App.boot(function()
		{
			
			frame = wx.Frame.create(null, null, "Main", null, { width: 600, height: 400 });
			
			#if nme
			var stage = wx.NMEStage.create(frame, null, null, { width: 600, height: 400 });
			#end
			
			test.waxe.nme.Main.main();
			
			if (autoShowFrame)
			{
				wx.App.setTopWindow(frame);
				frame.shown = true;
			}
		});
		#else
		
		nme.Lib.create(function()
			{ 
				if (600 == 0 && 400 == 0)
				{
					nme.Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
					nme.Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
				}
				
				var hasMain = false;
				
				for (methodName in Type.getClassFields(test.waxe.nme.Main))
				{
					if (methodName == "main")
					{
						hasMain = true;
						break;
					}
				}
				
				if (hasMain)
				{
					Reflect.callMethod (test.waxe.nme.Main, Reflect.field (test.waxe.nme.Main, "main"), []);
				}
				else
				{
					nme.Lib.current.addChild(cast (Type.createInstance(test.waxe.nme.Main, []), nme.display.DisplayObject));	
				}
			},
			600, 400, 
			24, 
			0xffffff,
			(true ? nme.Lib.HARDWARE : 0) |
			(false ? nme.Lib.ALLOW_SHADERS : 0) |
			(true ? nme.Lib.RESIZABLE : 0) |
			(false ? nme.Lib.BORDERLESS : 0) |
			(false ? nme.Lib.VSYNC : 0) |
			(false ? nme.Lib.FULLSCREEN : 0) |
			(1 == 4 ? nme.Lib.HW_AA_HIRES : 0) |
			(1 == 2 ? nme.Lib.HW_AA : 0),
			"Main"
			
		);
		#end
		
	}
	
	
	public static function getAsset(inName:String):Dynamic
	{
		#if nme
		
		#end
		return null;
	}
	
	
}
