#ifndef INCLUDED_wx_MenuBar
#define INCLUDED_wx_MenuBar

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <wx/EventHandler.h>
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,Menu)
HX_DECLARE_CLASS1(wx,MenuBar)
namespace wx{


class MenuBar_obj : public ::wx::EventHandler_obj{
	public:
		typedef ::wx::EventHandler_obj super;
		typedef MenuBar_obj OBJ_;
		MenuBar_obj();
		Void __construct();

	public:
		static hx::ObjectPtr< MenuBar_obj > __new();
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~MenuBar_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		::String __ToString() const { return HX_CSTRING("MenuBar"); }

		virtual Void append( ::wx::Menu inMenu,::String inTitle);
		Dynamic append_dyn();

		virtual Void HandleEvent( Dynamic event);

		static Dynamic wx_menu_bar_create; /* REM */ 
		static Dynamic &wx_menu_bar_create_dyn() { return wx_menu_bar_create;}
		static Dynamic wx_menu_bar_append; /* REM */ 
		static Dynamic &wx_menu_bar_append_dyn() { return wx_menu_bar_append;}
};

} // end namespace wx

#endif /* INCLUDED_wx_MenuBar */ 
