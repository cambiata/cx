#ifndef INCLUDED_wx_Brush
#define INCLUDED_wx_Brush

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS1(wx,Brush)
HX_DECLARE_CLASS1(wx,Colour)
namespace wx{


class Brush_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef Brush_obj OBJ_;
		Brush_obj();
		Void __construct(::wx::Colour inColour,hx::Null< int >  __o_inStyle);

	public:
		static hx::ObjectPtr< Brush_obj > __new(::wx::Colour inColour,hx::Null< int >  __o_inStyle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~Brush_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		::String __ToString() const { return HX_CSTRING("Brush"); }

		virtual Dynamic wxGetHandle( );
		Dynamic wxGetHandle_dyn();

		Dynamic wxHandle; /* REM */ 
		static int SOLID; /* REM */ 
		static int TRANSPARENT; /* REM */ 
		static int STIPPLE; /* REM */ 
		static int BDIAGONAL_HATCH; /* REM */ 
		static int CROSSDIAG_HATCH; /* REM */ 
		static int FDIAGONAL_HATCH; /* REM */ 
		static int CROSS_HATCH; /* REM */ 
		static int HORIZONTAL_HATCH; /* REM */ 
		static int VERTICAL_HATCH; /* REM */ 
		static Dynamic wx_brush_create; /* REM */ 
		static Dynamic &wx_brush_create_dyn() { return wx_brush_create;}
};

} // end namespace wx

#endif /* INCLUDED_wx_Brush */ 
