package nx3.render;
import nx3.display.DComplex;
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

 
class FrameRenderer implements IRenderer implements ISpriteRenderer
{
	var scaling:TScaling;
	var target:Sprite;

	 
	public function initTargetSprite(target:Sprite, scaling:TScaling): Void
	{
		this.target = target;
		this.scaling = scaling;
	}
	
	
	public function new(target:Sprite,  scaling:TScaling) 
	{
		this.initTargetSprite(target, scaling);
	}
	
	public function note(x:Float, y:Float, dnote:DNote)
	{		
		//trace(dnote.xAdjust);
		//trace(dnote.headsRect.toRectangle()); 
		this.heads(x, y, dnote);
		this.stave(x, y, dnote);
		
		
		// Frame
		this.target.graphics.lineStyle(1, 0xFFAAAA);	
		var r:Rectangle = dnote.headsRect.toRectangle();
		var r2:Rectangle = new Rectangle(x + r.x * scaling.halfNoteWidth , y + r.y * scaling.halfSpace, r.width * scaling.halfNoteWidth, r.height * scaling.halfSpace);
		r2.inflate(2, 2);		
		this.target.graphics.drawRect(r2.x, r2.y, r2.width, r2.height);		

		// Center spot
		this.target.graphics.lineStyle(1, 0xAAAAAA);			
		//this.target.graphics.drawEllipse(x-2, y-2, 4, 4);
		this.target.graphics.moveTo(x, y + scaling.space * 6);
		this.target.graphics.lineTo(x, y - scaling.space * 6);
		
	}
	
	public function complex(x:Float, y:Float, dcomplex:DComplex)
	{
		
		for (dnote in dcomplex.dnotes)
		{
			this.note(x, y, dnote);			
		}
		
		this.signs(x, y, dcomplex);
		// Heads frame
		this.target.graphics.lineStyle(1, 0x0000FF);	
		var r:Rectangle = dcomplex.headsRect.toRectangle();
		var r2:Rectangle = new Rectangle(x + r.x * scaling.halfNoteWidth , y + r.y * scaling.halfSpace, r.width * scaling.halfNoteWidth, r.height * scaling.halfSpace);
		r2.inflate(2, 2);
		this.target.graphics.drawRect(r2.x, r2.y, r2.width, r2.height);		
		
		// each sign...		
		//trace (dcomplex.signRects);		

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
				staveX += (dnote.headsRect.x.toFloat() + dnote.headsRect.width.toFloat())*this.scaling.halfNoteWidth;
				target.graphics.moveTo(staveX, bottomY);
				target.graphics.lineTo(staveX, topY - staveLength);
				
			case EDirectionUD.Down:
				staveX += dnote.headsRect.x.toFloat()*this.scaling.halfNoteWidth;
				target.graphics.moveTo(staveX, topY);
				target.graphics.lineTo(staveX, bottomY + staveLength);
		}
		
	}
	
	public function heads(x:Float, y:Float, dnote:DNote)
	{
			
		var headsX = x; // + dnote.xAdjust.toFloat() * scaling.halfNoteWidth;
		this.target.graphics.lineStyle(1, 0xAAAAFF);	
		//this.target.graphics.beginFill(0xFF00000);
		for (rect in dnote.headRects)
		{
			var r:Rectangle = rect.toRectangle();
			var rx = headsX + r.x  * scaling.halfNoteWidth;
			this.target.graphics.drawRect(rx , y + r.y * scaling.halfSpace, r.width * scaling.halfNoteWidth, r.height * scaling.halfSpace);
		}		
		//this.target.graphics.endFill();
		
	}
	
	/* INTERFACE nx3.render.IRenderer */
	
	public function signs(x:Float, y:Float, dcomplex:DComplex):Void 
	{
		
		// signsFrame
		if (dcomplex.signsFrame != null)
		{
			this.target.graphics.lineStyle(1, 0xFF0000);
			
			var r:Rectangle = dcomplex.signsFrame.toRectangle();
			var signsX = x + r.x * scaling.halfNoteWidth;
			var r2:Rectangle = new Rectangle(signsX , y + r.y * scaling.halfSpace, r.width * scaling.halfNoteWidth, r.height * scaling.halfSpace);
			r2.inflate(2, 2);
			this.target.graphics.drawRect(r2.x, r2.y, r2.width, r2.height);				
		}
		
		if (dcomplex.signRects != null)
		{
			this.target.graphics.lineStyle(1, 0x000000);	
			var signsX = x + dcomplex.signsFrame.x.toFloat() * scaling.halfNoteWidth;
			for (signRect in dcomplex.signRects)
			{		
				var r:Rectangle = signRect.toRectangle();
				var r2:Rectangle = new Rectangle(signsX + r.x * scaling.halfNoteWidth , y + r.y * scaling.halfSpace, r.width * scaling.halfNoteWidth, r.height * scaling.halfSpace);
				this.target.graphics.drawRect(r2.x, r2.y, r2.width, r2.height);					
			}
		}		
		
	}
}