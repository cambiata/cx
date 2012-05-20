#ifndef INCLUDED_wx_DC
#define INCLUDED_wx_DC

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS1(wx,Bitmap)
HX_DECLARE_CLASS1(wx,Brush)
HX_DECLARE_CLASS1(wx,DC)
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,Font)
HX_DECLARE_CLASS1(wx,Pen)
HX_DECLARE_CLASS1(wx,Window)
namespace wx{


class DC_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef DC_obj OBJ_;
		DC_obj();
		Void __construct(Dynamic handle);

	public:
		static hx::ObjectPtr< DC_obj > __new(Dynamic handle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~DC_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("DC"); }

		::wx::Pen pen; /* REM */ 
		::wx::Brush brush; /* REM */ 
		::wx::Brush background; /* REM */ 
		::wx::Font font; /* REM */ 
		Dynamic wxHandle; /* REM */ 
		virtual Void destroy( );
		Dynamic destroy_dyn();

		virtual Void drawLine( int x1,int y1,int x2,int y2);
		Dynamic drawLine_dyn();

		virtual Void clear( );
		Dynamic clear_dyn();

		virtual ::wx::Pen setPen( ::wx::Pen inPen);
		Dynamic setPen_dyn();

		virtual ::wx::Brush setBrush( ::wx::Brush inBrush);
		Dynamic setBrush_dyn();

		virtual ::wx::Brush setBackground( ::wx::Brush inBrush);
		Dynamic setBackground_dyn();

		virtual ::wx::Font setFont( ::wx::Font inFont);
		Dynamic setFont_dyn();

		virtual Void drawRectangle( int x,int y,int width,int height);
		Dynamic drawRectangle_dyn();

		virtual Void drawCircle( int x,int y,int rad);
		Dynamic drawCircle_dyn();

		virtual Void drawEllipse( int x,int y,int width,int height);
		Dynamic drawEllipse_dyn();

		virtual Void drawText( ::String text,int x,int y);
		Dynamic drawText_dyn();

		virtual Void drawBitmap( ::wx::Bitmap bitmap,int x,int y,bool inTransparent);
		Dynamic drawBitmap_dyn();

		static ::wx::DC createPaintDC( ::wx::Window inWindow);
		static Dynamic createPaintDC_dyn();

		static Dynamic wx_dc_create_paint; /* REM */ 
	Dynamic &wx_dc_create_paint_dyn() { return wx_dc_create_paint;}
		static Dynamic wx_dc_draw_line; /* REM */ 
	Dynamic &wx_dc_draw_line_dyn() { return wx_dc_draw_line;}
		static Dynamic wx_object_destroy; /* REM */ 
	Dynamic &wx_object_destroy_dyn() { return wx_object_destroy;}
		static Dynamic wx_dc_clear; /* REM */ 
	Dynamic &wx_dc_clear_dyn() { return wx_dc_clear;}
		static Dynamic wx_dc_set_pen; /* REM */ 
	Dynamic &wx_dc_set_pen_dyn() { return wx_dc_set_pen;}
		static Dynamic wx_dc_set_font; /* REM */ 
	Dynamic &wx_dc_set_font_dyn() { return wx_dc_set_font;}
		static Dynamic wx_dc_set_brush; /* REM */ 
	Dynamic &wx_dc_set_brush_dyn() { return wx_dc_set_brush;}
		static Dynamic wx_dc_set_background; /* REM */ 
	Dynamic &wx_dc_set_background_dyn() { return wx_dc_set_background;}
		static Dynamic wx_dc_draw_rectangle; /* REM */ 
	Dynamic &wx_dc_draw_rectangle_dyn() { return wx_dc_draw_rectangle;}
		static Dynamic wx_dc_draw_circle; /* REM */ 
	Dynamic &wx_dc_draw_circle_dyn() { return wx_dc_draw_circle;}
		static Dynamic wx_dc_draw_ellipse; /* REM */ 
	Dynamic &wx_dc_draw_ellipse_dyn() { return wx_dc_draw_ellipse;}
		static Dynamic wx_dc_draw_text; /* REM */ 
	Dynamic &wx_dc_draw_text_dyn() { return wx_dc_draw_text;}
		static Dynamic wx_dc_draw_bitmap; /* REM */ 
	Dynamic &wx_dc_draw_bitmap_dyn() { return wx_dc_draw_bitmap;}
};

} // end namespace wx

#endif /* INCLUDED_wx_DC */ 
