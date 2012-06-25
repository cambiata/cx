#include <hxcpp.h>

#ifndef INCLUDED_wx_App
#include <wx/App.h>
#endif
#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
#ifndef INCLUDED_wx_TopLevelWindow
#include <wx/TopLevelWindow.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif
namespace wx{

Void App_obj::__construct()
{
	return null();
}

App_obj::~App_obj() { }

Dynamic App_obj::__CreateEmpty() { return  new App_obj; }
hx::ObjectPtr< App_obj > App_obj::__new()
{  hx::ObjectPtr< App_obj > result = new App_obj();
	result->__construct();
	return result;}

Dynamic App_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< App_obj > result = new App_obj();
	result->__construct();
	return result;}

Void App_obj::boot( Dynamic inOnInit){
{
		HX_SOURCE_PUSH("App_obj::boot")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/App.hx",6)
		::wx::App_obj::wx_boot(inOnInit);
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(App_obj,boot,(void))

Void App_obj::quit( ){
{
		HX_SOURCE_PUSH("App_obj::quit")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/App.hx",24)
		::wx::App_obj::wx_quit();
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(App_obj,quit,(void))

Void App_obj::setTopWindow( ::wx::TopLevelWindow inWindow){
{
		HX_SOURCE_PUSH("App_obj::setTopWindow")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/App.hx",29)
		::wx::App_obj::wx_set_top_window(inWindow->wxHandle);
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(App_obj,setTopWindow,(void))

Dynamic App_obj::wx_set_top_window;

Dynamic App_obj::wx_boot;

Dynamic App_obj::wx_quit;


App_obj::App_obj()
{
}

void App_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(App);
	HX_MARK_END_CLASS();
}

Dynamic App_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"boot") ) { return boot_dyn(); }
		if (HX_FIELD_EQ(inName,"quit") ) { return quit_dyn(); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"wx_boot") ) { return wx_boot; }
		if (HX_FIELD_EQ(inName,"wx_quit") ) { return wx_quit; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"setTopWindow") ) { return setTopWindow_dyn(); }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"wx_set_top_window") ) { return wx_set_top_window; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic App_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 7:
		if (HX_FIELD_EQ(inName,"wx_boot") ) { wx_boot=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_quit") ) { wx_quit=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"wx_set_top_window") ) { wx_set_top_window=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void App_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("boot"),
	HX_CSTRING("quit"),
	HX_CSTRING("setTopWindow"),
	HX_CSTRING("wx_set_top_window"),
	HX_CSTRING("wx_boot"),
	HX_CSTRING("wx_quit"),
	String(null()) };

static ::String sMemberFields[] = {
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(App_obj::wx_set_top_window,"wx_set_top_window");
	HX_MARK_MEMBER_NAME(App_obj::wx_boot,"wx_boot");
	HX_MARK_MEMBER_NAME(App_obj::wx_quit,"wx_quit");
};

Class App_obj::__mClass;

void App_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.App"), hx::TCanCast< App_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void App_obj::__boot()
{
	hx::Static(wx_set_top_window) = ::wx::Loader_obj::load(HX_CSTRING("wx_set_top_window"),(int)1);
	hx::Static(wx_boot) = ::wx::Loader_obj::load(HX_CSTRING("wx_boot"),(int)1);
	hx::Static(wx_quit) = ::wx::Loader_obj::load(HX_CSTRING("wx_quit"),(int)0);
}

} // end namespace wx
