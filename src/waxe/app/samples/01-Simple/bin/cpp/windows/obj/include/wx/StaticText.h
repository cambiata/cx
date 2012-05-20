#ifndef INCLUDED_wx_StaticText
#define INCLUDED_wx_StaticText

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <wx/Window.h>
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,StaticText)
HX_DECLARE_CLASS1(wx,Window)
namespace wx{


class StaticText_obj : public ::wx::Window_obj{
	public:
		typedef ::wx::Window_obj super;
		typedef StaticText_obj OBJ_;
		StaticText_obj();
		Void __construct(Dynamic inHandle);

	public:
		static hx::ObjectPtr< StaticText_obj > __new(Dynamic inHandle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~StaticText_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("StaticText"); }

		::String label; /* REM */ 
		virtual ::String setLabel( ::String inString);
		Dynamic setLabel_dyn();

		virtual ::String getLabel( );
		Dynamic getLabel_dyn();

		static ::wx::StaticText create( ::wx::Window inParent,Dynamic inID,Dynamic inText,Dynamic inPosition,Dynamic inSize,Dynamic inStyle);
		static Dynamic create_dyn();

		static Dynamic wx_static_text_create; /* REM */ 
	Dynamic &wx_static_text_create_dyn() { return wx_static_text_create;}
		static Dynamic wx_static_text_get_label; /* REM */ 
	Dynamic &wx_static_text_get_label_dyn() { return wx_static_text_get_label;}
		static Dynamic wx_static_text_set_label; /* REM */ 
	Dynamic &wx_static_text_set_label_dyn() { return wx_static_text_set_label;}
};

} // end namespace wx

#endif /* INCLUDED_wx_StaticText */ 
