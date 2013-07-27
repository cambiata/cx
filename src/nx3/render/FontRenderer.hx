package nx3.render;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Rectangle;
import nx3.elements.DComplex;
import nx3.elements.DNote;
import nx3.elements.tools.SignsTools;
import nx3.elements.EDirectionUD;
import nx3.elements.EHeadValuetype;
import nx3.elements.ENoteType;
import nx3.elements.ENoteVariant;
import nx3.elements.ESign;
import nx3.elements.EVoiceType;
import nx3.render.scaling.TScaling;
import nx3.render.svg.Elements;
import nx3.render.svg.ShapeTools;
import nx3.Constants;

#if nme
import nme.geom.Rectangle;
import nme.display.Sprite;
import nme.display.Shape;

#else
import flash.geom.Rectangle;
import flash.display.Sprite;
import flash.display.Shape;
#end



/**
 * ...
 * @author 
 */
class FontRenderer implements IRenderer
{

	var scaling:TScaling;
	var target:Sprite;	
	
	function initTargetSprite(target:Sprite, scaling:TScaling): Void
	{
		this.target = target;
		this.scaling = scaling;
	}	
	
	public function new(target:Sprite,  scaling:TScaling) 
	{
		this.initTargetSprite(target, scaling);
	}
	
	/* INTERFACE nx3.render.IRenderer */
	
	public function notelines(x:Float, y:Float, width:Float):Void 
	{
		
		this.target.graphics.lineStyle(this.scaling.linesWidth, 0xAAAAAA);			
		for (i in -2...3)
		{
			var cy = y + i * scaling.space;
			this.target.graphics.moveTo(x, cy);
			this.target.graphics.lineTo(x + width, cy);			
		}	
		
	}
	
	public function stave(x:Float, y:Float, dnote:DNote):Void 
	{ 
		if (dnote.value.head == EHeadValuetype.HVT1) return;
		
		this.target.graphics.lineStyle(this.scaling.linesWidth, 0x000000);			
		var topY:Float = y + dnote.headTop.level * scaling.halfSpace;
		var bottomY:Float = y + dnote.headBottom.level * scaling.halfSpace;		
		var staveLength:Float = Constants.STAVE_LENGTH * scaling.halfSpace;
		var staveX:Float = x;		
		switch (dnote.direction)
		{
			case EDirectionUD.Up:
				//staveX += dnote.headsRect.x.toFloat() * this.scaling.halfNoteWidth + 2 * this.scaling.halfNoteWidth;
				staveX = x + (dnote.xAdjust + dnote.stemX) *scaling.halfNoteWidth;
				target.graphics.moveTo(staveX, bottomY);
				target.graphics.lineTo(staveX, topY - staveLength);
				
			case EDirectionUD.Down:
				//staveX += dnote.headsRect.x.toFloat() * this.scaling.halfNoteWidth;
				staveX = x  +  (dnote.xAdjust + dnote.stemX) *scaling.halfNoteWidth;
				target.graphics.moveTo(staveX, topY);
				target.graphics.lineTo(staveX, bottomY + staveLength);
		}
	}
	
	public function heads(x:Float, y:Float, dnote:DNote):Void 
	{
		for (r in dnote.headRects)
		{
			var xmlStr:String = null;
			switch (dnote.value.head)
			{
				case EHeadValuetype.HVT1: xmlStr = Elements.noteWhole;
				case EHeadValuetype.HVT2: xmlStr = Elements.noteWhite;
				default: xmlStr = Elements.noteBlack;
			}
			
			var shape:Shape = ShapeTools.getShape(xmlStr, this.scaling);
			if (shape == null) return;
			
			
			var shapeX =x + r.x * scaling.halfNoteWidth + this.scaling.svgX ;
			var shapeY = y + (r.y * scaling.halfSpace) + this.scaling.svgY ;
			shape.x = shapeX;
			shape.y = shapeY;
			this.target.addChild(shape);			
		}			
	}
	
	public function note(x:Float, y:Float, dnote:DNote):Void 
	{
		this.stave(x, y, dnote);
		this.heads(x, y, dnote); 		
	}
	
	public function complex(x:Float, y:Float, dcomplex:DComplex):Void 
	{
		for (dnote in dcomplex.dnotes)
		{
			this.note(x, y, dnote);			
		}	
		this.signs(x, y, dcomplex);
	}
	
	/* INTERFACE nx3.render.IRenderer */
	
	public function signs(x:Float, y:Float, dcomplex:DComplex):Void 
	{
		if (dcomplex.signRects == null) return;
		var signsX = x + dcomplex.signsFrame.x * scaling.halfNoteWidth;
		
		for (i in 0...dcomplex.signRects.length)
		{		
			var signRect = dcomplex.signRects[i];
			var sign:ESign = dcomplex.signs[i].sign;
			var signStr = 'sign' + Std.string(sign);
			var xmlStr:String = ShapeTools.getElementStr(signStr);			
			if (xmlStr == null) continue;
			var shape:Shape = ShapeTools.getShape(xmlStr, this.scaling);			
			if (shape == null) return;
			var r:Rectangle = signRect;
			var shapeX = signsX + ((r.x  + SignsTools.adjustSignFontX(sign))* scaling.halfNoteWidth) + this.scaling.svgX ;
			var shapeY = y + ((r.y + 2) * scaling.halfSpace) + this.scaling.svgY ;
			shape.x = shapeX;
			shape.y = shapeY;
			this.target.addChild(shape);					
		}					
	}
	
}