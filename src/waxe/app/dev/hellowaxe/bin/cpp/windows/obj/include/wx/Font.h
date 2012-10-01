#ifndef INCLUDED_wx_Font
#define INCLUDED_wx_Font

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS1(wx,Font)
namespace wx{


class Font_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef Font_obj OBJ_;
		Font_obj();
		Void __construct(int size,hx::Null< int >  __o_family,hx::Null< int >  __o_style,hx::Null< int >  __o_weight,hx::Null< bool >  __o_underline,::String __o_faceName);

	public:
		static hx::ObjectPtr< Font_obj > __new(int size,hx::Null< int >  __o_family,hx::Null< int >  __o_style,hx::Null< int >  __o_weight,hx::Null< bool >  __o_underline,::String __o_faceName);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~Font_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		::String __ToString() const { return HX_CSTRING("Font"); }

		virtual Dynamic wxGetHandle( );
		Dynamic wxGetHandle_dyn();

		Dynamic wxHandle; /* REM */ 
		static int FAMILY_DEFAULT; /* REM */ 
		static int FAMILY_DECORATIVE; /* REM */ 
		static int FAMILY_ROMAN; /* REM */ 
		static int FAMILY_SCRIPT; /* REM */ 
		static int FAMILY_SWISS; /* REM */ 
		static int FAMILY_MODERN; /* REM */ 
		static int FAMILY_TELETYPE; /* REM */ 
		static int STYLE_NORMAL; /* REM */ 
		static int STYLE_SLANT; /* REM */ 
		static int STYLE_ITALIC; /* REM */ 
		static int WEIGHT_NORMAL; /* REM */ 
		static int WEIGHT_LIGHT; /* REM */ 
		static int WEIGHT_BOLD; /* REM */ 
		static Dynamic wx_font_create; /* REM */ 
		static Dynamic &wx_font_create_dyn() { return wx_font_create;}
};

} // end namespace wx

#endif /* INCLUDED_wx_Font */ 
