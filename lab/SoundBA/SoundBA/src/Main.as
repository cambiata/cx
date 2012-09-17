package 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Jonas Nyström
	 */
	public class Main extends Sprite 
	{
		private var s:Sound;
		private var sound2:Sound;
		private var byteArray:ByteArray;
		private var file:FileReference;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
	private function init(e:Event = null):void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);
		// entry point
		
		/*
		s = new Sound();			
		s.addEventListener(Event.COMPLETE, onComplete);
		s.load(new URLRequest('short.mp3'));
		*/
		

		
		
		file = new FileReference();
		file.addEventListener(Event.COMPLETE, onLoaded);
		file.addEventListener(Event.SELECT, onSelected);
		file.browse();
		
		
	}
	
	private function onSelected(e:Event):void 
	{
		file.load();
	}
	
	private function onLoaded(e:Event):void 
	{
		trace('loaded');
		trace(file.data.length);
		byteArray = file.data;
		
		sound2 = new Sound();
		sound2.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);		
		sound2.play();		
	}
	
	
	private function onSampleData(e:SampleDataEvent):void 
	{
		trace(e.position);
		for (var i:int = 0; i < 2048; i++) 
		{
			var left:Number = byteArray.readFloat();
			var right:Number = byteArray.readFloat();				
			e.data.writeFloat(left * 0.2);
			e.data.writeFloat(right * 0.2);
			//e.data.writeFloat(0);
			//e.data.writeFloat(0);
		}
	}
	
	private function onComplete(e:Event):void 
	{
		trace('complete');
		//this.s.play();
		byteArray = new ByteArray();
		this.s.extract(byteArray, 100000000);			
		trace(byteArray.length);
		byteArray.position = 0;
		//p.play();
		var file:FileReference = new FileReference();
		file.save(byteArray, 'short.data');				
	}
		
	}
	
}


/*
			var fileName:String = "hello.txt";
			var fileData:ByteArray = new ByteArray();
			fileData.writeUTF("Hello World!");

			var zipOut:ZipOutput = new ZipOutput();
			var ze:ZipEntry = new ZipEntry(fileName);
			zipOut.putNextEntry(ze);
			zipOut.write(fileData);
			zipOut.closeEntry();
			zipOut.finish();
			
			var zipData:ByteArray = zipOut.byteArray;					
			try
			{
				var file:FileReference = new FileReference();
				file.save(zipData);	
			} 
			catch(error:Error) 
			{
				trace(error);	
			}


*/