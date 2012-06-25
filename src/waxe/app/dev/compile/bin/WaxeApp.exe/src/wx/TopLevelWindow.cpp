#include <hxcpp.h>

#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_TopLevelWindow
#include <wx/TopLevelWindow.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif
namespace wx{

Void TopLevelWindow_obj::__construct(Dynamic inHandle)
{
{
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/TopLevelWindow.hx",6)
	super::__construct(inHandle);
}
;
	return null();
}

TopLevelWindow_obj::~TopLevelWindow_obj() { }

Dynamic TopLevelWindow_obj::__CreateEmpty() { return  new TopLevelWindow_obj; }
hx::ObjectPtr< TopLevelWindow_obj > TopLevelWindow_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< TopLevelWindow_obj > result = new TopLevelWindow_obj();
	result->__construct(inHandle);
	return result;}

Dynamic TopLevelWindow_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< TopLevelWindow_obj > result = new TopLevelWindow_obj();
	result->__construct(inArgs[0]);
	return result;}


TopLevelWindow_obj::TopLevelWindow_obj()
{
}

void TopLevelWindow_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(TopLevelWindow);
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic TopLevelWindow_obj::__Field(const ::String &inName,bool inCallProp)
{
	return super::__Field(inName,inCallProp);
}

Dynamic TopLevelWindow_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	return super::__SetField(inName,inValue,inCallProp);
}

void TopLevelWindow_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	String(null()) };

static ::String sMemberFields[] = {
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
};

Class TopLevelWindow_obj::__mClass;

void TopLevelWindow_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.TopLevelWindow"), hx::TCanCast< TopLevelWindow_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void TopLevelWindow_obj::__boot()
{
}

} // end namespace wx
