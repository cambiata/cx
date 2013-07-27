package nx3.render;
import nx3.elements.DComplex;
import nx3.elements.DNote;
import nx3.elements.interfaces.IDistanceRects;
import nx3.render.scaling.TScaling;
import nx3.elements.EDirectionUD;
import nx3.Constants;



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
 using nx3.render.scaling.Scaling;
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
		this.heads(x, y, dnote);
		this.stave(x, y, dnote);
		
		// Frame
		drawRect(dnote.headsRect, x, y, 0xFFAAAA, 2);

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

		// ComplexFrame
		drawRect(dcomplex.headsRect, x, y, 0xFF0000, 2);
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
		/*
		this.target.graphics.lineStyle(this.scaling.linesWidth, 0x000000);			
		var topY:Float = y + dnote.headTop.level * scaling.halfSpace;
		var bottomY:Float = y + dnote.headBottom.level * scaling.halfSpace;		
		var staveLength:Float = Constants.STAVE_LENGTH * scaling.halfSpace;
		var staveX:Float = x;		
		switch (dnote.direction)
		{
			case EDirectionUD.Up:
				staveX += dnote.headsRect.x.toFloat()*this.scaling.halfNoteWidth;
				target.graphics.moveTo(staveX, bottomY);
				target.graphics.lineTo(staveX, topY - staveLength);
				
			case EDirectionUD.Down:
				staveX += dnote.headsRect.x.toFloat()*this.scaling.halfNoteWidth;
				target.graphics.moveTo(staveX, topY);
				target.graphics.lineTo(staveX, bottomY + staveLength);
		}
		*/
	}
	
	public function heads(x:Float, y:Float, dnote:DNote)
	{
		for (rect in dnote.headRects)
		{
			drawRect(rect, x, y, 0x0000FF);
		}		
	}
	
	public function signs(x:Float, y:Float, dcomplex:DComplex):Void 
	{
		// signsFrame
		if (dcomplex.signsFrame != null)
		{
			drawRect(dcomplex.signsFrame, x, y, 0xFF0000, 2);
		}

		// each sign
		var signsX = x + dcomplex.signsFrame.x * scaling.halfNoteWidth;
		if (dcomplex.signRects != null)
		{
			for (signRect in dcomplex.signRects)
			{		
				drawRect(signRect, signsX, y,0x000000);
			}
		}				
	}
	
	/* INTERFACE nx3.render.IRenderer */
	
	public function rects(x:Float, y:Float, rects:Array<IDistanceRects>) 
	{
		for (item in rects)
		{
			
			
		}
	}
	
	//--------------------------------------------------------------------------------------------------------
	
	/*
	function drawRect(rect:Rectangle)
	{
		this.target.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
	}
	*/
	function drawRect(rect:Rectangle, x:Float, y:Float, lineColor:UInt=0x000000, inflate:Int=0)
	{
		this.target.graphics.lineStyle(1, lineColor);
		var r:Rectangle = scaling.scaleRect(rect);
		r.offset(x, y);
		if (inflate != 0) r.inflate(inflate, inflate);
		this.target.graphics.drawRect(r.x, r.y, r.width, r.height);
	}
}