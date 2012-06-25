#ifndef INCLUDED_wx_Panel
#define INCLUDED_wx_Panel

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <wx/Window.h>
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,Panel)
HX_DECLARE_CLASS1(wx,Window)
namespace wx{


class Panel_obj : public ::wx::Window_obj{
	public:
		typedef ::wx::Window_obj super;
		typedef Panel_obj OBJ_;
		Panel_obj();
		Void __construct(Dynamic inHandle);

	public:
		static hx::ObjectPtr< Panel_obj > __new(Dynamic inHandle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~Panel_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("Panel"); }

		static ::wx::Panel create( ::wx::Window inParent,Dynamic inID,Dynamic inPosition,Dynamic inSize,Dynamic inStyle);
		static Dynamic create_dyn();

		static Dynamic wx_panel_create; /* REM */ 
		static Dynamic &wx_panel_create_dyn() { return wx_panel_create;}
};

} // end namespace wx

#endif /* INCLUDED_wx_Panel */ 
