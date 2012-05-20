#ifndef INCLUDED_wx_Menu
#define INCLUDED_wx_Menu

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <wx/EventHandler.h>
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,Menu)
namespace wx{


class Menu_obj : public ::wx::EventHandler_obj{
	public:
		typedef ::wx::EventHandler_obj super;
		typedef Menu_obj OBJ_;
		Menu_obj();
		Void __construct(Dynamic __o_inTitle,Dynamic __o_inFlags);

	public:
		static hx::ObjectPtr< Menu_obj > __new(Dynamic __o_inTitle,Dynamic __o_inFlags);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~Menu_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("Menu"); }

		virtual Void HandleEvent( Dynamic event);
		Dynamic HandleEvent_dyn();

		virtual int append( int inID,Dynamic inItem,Dynamic inHelp,Dynamic inKind);
		Dynamic append_dyn();

		virtual Void appendSeparator( );
		Dynamic appendSeparator_dyn();

		static int NORMAL; /* REM */ 
		static int SEPARATOR; /* REM */ 
		static int CHECK; /* REM */ 
		static int RADIO; /* REM */ 
		static Dynamic wx_menu_create; /* REM */ 
	Dynamic &wx_menu_create_dyn() { return wx_menu_create;}
		static Dynamic wx_menu_append; /* REM */ 
	Dynamic &wx_menu_append_dyn() { return wx_menu_append;}
		static Dynamic wx_menu_append_separator; /* REM */ 
	Dynamic &wx_menu_append_separator_dyn() { return wx_menu_append_separator;}
};

} // end namespace wx

#endif /* INCLUDED_wx_Menu */ 
