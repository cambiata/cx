#ifndef INCLUDED_wx_Frame
#define INCLUDED_wx_Frame

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <wx/TopLevelWindow.h>
HX_DECLARE_CLASS0(IntHash)
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,Frame)
HX_DECLARE_CLASS1(wx,MenuBar)
HX_DECLARE_CLASS1(wx,TopLevelWindow)
HX_DECLARE_CLASS1(wx,Window)
namespace wx{


class Frame_obj : public ::wx::TopLevelWindow_obj{
	public:
		typedef ::wx::TopLevelWindow_obj super;
		typedef Frame_obj OBJ_;
		Frame_obj();
		Void __construct(Dynamic inHandle);

	public:
		static hx::ObjectPtr< Frame_obj > __new(Dynamic inHandle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~Frame_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("Frame"); }

		::wx::MenuBar menuBar; /* REM */ 
		::IntHash menuMap; /* REM */ 
		virtual ::wx::MenuBar wxSetMenuBar( ::wx::MenuBar inBar);
		Dynamic wxSetMenuBar_dyn();

		virtual Void handle( int id,Dynamic handler);
		Dynamic handle_dyn();

		virtual Void onMenu( Dynamic event);
		Dynamic onMenu_dyn();

		static ::wx::Frame create( ::wx::Window inParent,Dynamic inID,Dynamic inTitle,Dynamic inPosition,Dynamic inSize,Dynamic inStyle);
		static Dynamic create_dyn();

		static Dynamic wx_frame_create; /* REM */ 
	Dynamic &wx_frame_create_dyn() { return wx_frame_create;}
		static Dynamic wx_frame_set_menu_bar; /* REM */ 
	Dynamic &wx_frame_set_menu_bar_dyn() { return wx_frame_set_menu_bar;}
};

} // end namespace wx

#endif /* INCLUDED_wx_Frame */ 
