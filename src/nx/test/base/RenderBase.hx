package nx.test.base;
import haxe.unit.TestCase;
import nme.display.Graphics;
import nme.display.Sprite;
import nme.Lib;
import nx.output.Render;
import nx.output.Scaling;
import nx.output.TScaling;

#if neko
import nme.display.BitmapData;
import cx.FileTools;
#end

/**
 * ...
 * @author Jonas Nyström
 */

class RenderBase extends TestCase
{
	public var sprite:Sprite;	
	public var graphics:Graphics;
	public var render:Render;	
	public var scaling:TScaling;
	static public var Y100:Float = 100.0;
	static public var Y200:Float = 200.0;
	static public var Y300:Float = 300.0;
	static public var Y500:Float = 500.0;
	
	public function new(render:Render=null) {		
		super();
		#if neko 
			this.sprite = new Sprite();
		#else
			this.sprite = Lib.current;
		#end			
		this.graphics = this.sprite.graphics;
		this.render = (render != null) ? render : new Render(this.sprite, Scaling.getMid());
		this.scaling = this.render.getScaling();
		this.init();
	}
	
	public function init() {
		render.clef(10, Y100);
		render.lines(10, Y100, 980);		
		render.clef(10, Y300);
		render.lines(10, Y300, 980);		
		render.clef(10, Y500);
		render.lines(10, Y500, 980);	
	}
	
	override public function setup() {
		
	}
	
	public function setScaling(scaling:TScaling) {
		this.render = new Render(this.sprite, scaling);
		this.scaling = this.render.getScaling();
	}
	
	override public function tearDown() {		
		#if neko 
			var filename = Type.getClassName(Type.getClass(this)).split('.').pop() + '.png';
			this.spriteSave(filename);
		#end		
	}	
	
	#if neko
	public function spriteSave(filename:String, width:Int=1000, height:Int=600, execute:Bool=true) {
		var bitmapData = new BitmapData(width, height);
		bitmapData.draw(this.sprite);
		var byteArray = bitmapData.encode('png');	
		
		if (execute) {
			FileTools.putBinaryContentExecute(neko.FileSystem.fullPath(filename), byteArray.asString());			
		} else {
			FileTools.putBinaryContent(neko.FileSystem.fullPath(filename), byteArray.asString());			
		}
	}	
	#end
}