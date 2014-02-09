package format.svg;

import Xml;

// To help old code...

class SVG2Gfx
{
   var renderer : SVGRenderer;

   public function new (inXml:Xml)
   {
      renderer = new SVGRenderer(new SVGData(inXml));
   }

   public function createShape()
   {
      return renderer.createShape();
   }

}