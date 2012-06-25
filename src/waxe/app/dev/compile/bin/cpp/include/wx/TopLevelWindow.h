#ifndef INCLUDED_wx_TopLevelWindow
#define INCLUDED_wx_TopLevelWindow

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <wx/Window.h>
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,TopLevelWindow)
HX_DECLARE_CLASS1(wx,Window)
namespace wx{


class TopLevelWindow_obj : public ::wx::Window_obj{
	public:
		typedef ::wx::Window_obj super;
		typedef TopLevelWindow_obj OBJ_;
		TopLevelWindow_obj();
		Void __construct(Dynamic inHandle);

	public:
		static hx::ObjectPtr< TopLevelWindow_obj > __new(Dynamic inHandle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~TopLevelWindow_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("TopLevelWindow"); }

};

} // end namespace wx

#endif /* INCLUDED_wx_TopLevelWindow */ 
