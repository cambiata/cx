#ifndef INCLUDED_wx_Button
#define INCLUDED_wx_Button

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <wx/Window.h>
HX_DECLARE_CLASS1(wx,Button)
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,Window)
namespace wx{


class Button_obj : public ::wx::Window_obj{
	public:
		typedef ::wx::Window_obj super;
		typedef Button_obj OBJ_;
		Button_obj();
		Void __construct(Dynamic inHandle);

	public:
		static hx::ObjectPtr< Button_obj > __new(Dynamic inHandle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~Button_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		::String __ToString() const { return HX_CSTRING("Button"); }

		virtual ::String getLabel( );
		Dynamic getLabel_dyn();

		virtual ::String setLabel( ::String inString);
		Dynamic setLabel_dyn();

		virtual Dynamic setOnClick( Dynamic f);
		Dynamic setOnClick_dyn();

		Dynamic onClick; /* REM */ 
		Dynamic &onClick_dyn() { return onClick;}
		::String label; /* REM */ 
		static ::wx::Button create( ::wx::Window inParent,Dynamic inID,::String inLabel,Dynamic inPosition,Dynamic inSize,Dynamic inStyle);
		static Dynamic create_dyn();

		static Dynamic wx_button_create; /* REM */ 
		static Dynamic &wx_button_create_dyn() { return wx_button_create;}
		static Dynamic wx_button_get_label; /* REM */ 
		static Dynamic &wx_button_get_label_dyn() { return wx_button_get_label;}
		static Dynamic wx_button_set_label; /* REM */ 
		static Dynamic &wx_button_set_label_dyn() { return wx_button_set_label;}
};

} // end namespace wx

#endif /* INCLUDED_wx_Button */ 
