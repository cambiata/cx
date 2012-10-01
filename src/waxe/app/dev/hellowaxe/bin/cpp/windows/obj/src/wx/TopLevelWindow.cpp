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
HX_STACK_PUSH("TopLevelWindow::new","wx/TopLevelWindow.hx",6);
{
	HX_STACK_LINE(6)
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

void TopLevelWindow_obj::__Visit(HX_VISIT_PARAMS)
{
	super::__Visit(HX_VISIT_ARG);
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
	HX_MARK_MEMBER_NAME(TopLevelWindow_obj::__mClass,"__mClass");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(TopLevelWindow_obj::__mClass,"__mClass");
};

Class TopLevelWindow_obj::__mClass;

void TopLevelWindow_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.TopLevelWindow"), hx::TCanCast< TopLevelWindow_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void TopLevelWindow_obj::__boot()
{
}

} // end namespace wx
