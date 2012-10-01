#include <hxcpp.h>

#ifndef INCLUDED_wx_ControlWithItems
#include <wx/ControlWithItems.h>
#endif
#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif
namespace wx{

Void ControlWithItems_obj::__construct(Dynamic inHandle)
{
HX_STACK_PUSH("ControlWithItems::new","wx/ControlWithItems.hx",7);
{
	HX_STACK_LINE(7)
	super::__construct(inHandle);
}
;
	return null();
}

ControlWithItems_obj::~ControlWithItems_obj() { }

Dynamic ControlWithItems_obj::__CreateEmpty() { return  new ControlWithItems_obj; }
hx::ObjectPtr< ControlWithItems_obj > ControlWithItems_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< ControlWithItems_obj > result = new ControlWithItems_obj();
	result->__construct(inHandle);
	return result;}

Dynamic ControlWithItems_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< ControlWithItems_obj > result = new ControlWithItems_obj();
	result->__construct(inArgs[0]);
	return result;}


ControlWithItems_obj::ControlWithItems_obj()
{
}

void ControlWithItems_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(ControlWithItems);
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void ControlWithItems_obj::__Visit(HX_VISIT_PARAMS)
{
	super::__Visit(HX_VISIT_ARG);
}

Dynamic ControlWithItems_obj::__Field(const ::String &inName,bool inCallProp)
{
	return super::__Field(inName,inCallProp);
}

Dynamic ControlWithItems_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	return super::__SetField(inName,inValue,inCallProp);
}

void ControlWithItems_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	String(null()) };

static ::String sMemberFields[] = {
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(ControlWithItems_obj::__mClass,"__mClass");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(ControlWithItems_obj::__mClass,"__mClass");
};

Class ControlWithItems_obj::__mClass;

void ControlWithItems_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.ControlWithItems"), hx::TCanCast< ControlWithItems_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void ControlWithItems_obj::__boot()
{
}

} // end namespace wx
