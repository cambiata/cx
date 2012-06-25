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
		Void __construct(hx::Null< ::String >  __o_inTitle,hx::Null< int >  __o_inFlags);

	public:
		static hx::ObjectPtr< Menu_obj > __new(hx::Null< ::String >  __o_inTitle,hx::Null< int >  __o_inFlags);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~Menu_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("Menu"); }

		virtual Void HandleEvent( Dynamic event);

		virtual int append( int inID,hx::Null< ::String >  inItem,hx::Null< ::String >  inHelp,hx::Null< int >  inKind);
		Dynamic append_dyn();

		virtual Void appendSeparator( );
		Dynamic appendSeparator_dyn();

		static int NORMAL; /* REM */ 
		static int SEPARATOR; /* REM */ 
		static int CHECK; /* REM */ 
		static int RADIO; /* REM */ 
		static Dynamic wx_menu_create; /* REM */ 
		static Dynamic &wx_menu_create_dyn() { return wx_menu_create;}
		static Dynamic wx_menu_append; /* REM */ 
		static Dynamic &wx_menu_append_dyn() { return wx_menu_append;}
		static Dynamic wx_menu_append_separator; /* REM */ 
		static Dynamic &wx_menu_append_separator_dyn() { return wx_menu_append_separator;}
};

} // end namespace wx

#endif /* INCLUDED_wx_Menu */ 
