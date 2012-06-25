#ifndef INCLUDED_wx_App
#define INCLUDED_wx_App

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS1(wx,App)
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,TopLevelWindow)
HX_DECLARE_CLASS1(wx,Window)
namespace wx{


class App_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef App_obj OBJ_;
		App_obj();
		Void __construct();

	public:
		static hx::ObjectPtr< App_obj > __new();
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~App_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("App"); }

		static Void boot( Dynamic inOnInit);
		static Dynamic boot_dyn();

		static Void quit( );
		static Dynamic quit_dyn();

		static Void setTopWindow( ::wx::TopLevelWindow inWindow);
		static Dynamic setTopWindow_dyn();

		static Dynamic wx_set_top_window; /* REM */ 
		static Dynamic &wx_set_top_window_dyn() { return wx_set_top_window;}
		static Dynamic wx_boot; /* REM */ 
		static Dynamic &wx_boot_dyn() { return wx_boot;}
		static Dynamic wx_quit; /* REM */ 
		static Dynamic &wx_quit_dyn() { return wx_quit;}
};

} // end namespace wx

#endif /* INCLUDED_wx_App */ 
