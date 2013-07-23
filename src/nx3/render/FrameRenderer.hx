package nx3.render;
import nx3.display.DNote;
import nx3.render.scaling.TScaling;
import nx3.enums.EDirectionUD;
import nx3.units.Constants;



#if nme
import nme.geom.Rectangle;
import nme.display.Sprite;

#else
import flash.geom.Rectangle;
import flash.display.Sprite;
#end

/**
 * ...
 * @author 
 */

 
class FrameRenderer implements IRenderer
{
	var scaling:TScaling;
	var target:Sprite;

	public function new(target:Sprite,  scaling:TScaling) 
	{
		this.target = target;
		this.scaling = scaling;
	}
	
	public function note(x:Float, y:Float, dnote:DNote)
	{
		this.target.graphics.lineStyle(1, 0xAAAAAA);	
		this.target.graphics.drawCircle(x, y, 2);
		this.target.graphics.moveTo(x, y + scaling.space * 6);
		this.target.graphics.lineTo(x, y - scaling.space * 6);
		
		this.stave(x, y, dnote);
		this.heads( x, y, dnote);
	}
	
	public function notelines(x:Float, y:Float, width:Float)
	{
		this.target.graphics.lineStyle(this.scaling.linesWidth, 0xAAAAAA);	
		
		for (i in -2...3)
		{
			var cy = y + i * scaling.space;
			this.target.graphics.moveTo(x, cy);
			this.target.graphics.lineTo(x + width, cy);			
		}
	}
	
	public function stave(x:Float, y:Float, dnote:DNote)
	{
		this.target.graphics.lineStyle(this.scaling.linesWidth, 0x000000);			
		var topY:Float = y + dnote.headTop.level * scaling.halfSpace;
		var bottomY:Float = y + dnote.headBottom.level * scaling.halfSpace;		
		var staveLength:Float = Constants.STAVE_LENGTH * scaling.halfSpace;
		var staveX:Float = x;		
		switch (dnote.direction)
		{
			case EDirectionUD.Up:
				staveX += scaling.noteWidth;
				target.graphics.moveTo(staveX, bottomY);
				target.graphics.lineTo(staveX, topY - staveLength);
				
			case EDirectionUD.Down:
				staveX -= scaling.noteWidth;
				target.graphics.moveTo(staveX, topY);
				target.graphics.lineTo(staveX, bottomY + staveLength);
		}
	}
	
	public function heads(x:Float, y:Float, dnote:DNote)
	{
		this.target.graphics.lineStyle(1, 0x0000FF);			
		var r:Rectangle = dnote.headsRect.toRectangle();
		var r2:Rectangle = new Rectangle(x + r.x * scaling.halfNoteWidth , y + r.y * scaling.halfSpace, r.width * scaling.halfNoteWidth, r.height * scaling.halfSpace);
		r2.inflate(2, 2);
		this.target.graphics.drawRect(r2.x, r2.y, r2.width, r2.height);
		
		this.target.graphics.lineStyle(1, 0xFF0000);			
		for (rect in dnote.headRects)
		{
			var r:Rectangle = rect.toRectangle();
			this.target.graphics.drawRect(x + r.x * scaling.halfNoteWidth , y + r.y * scaling.halfSpace, r.width * scaling.halfNoteWidth, r.height * scaling.halfSpace);
		}		
		
	}
}