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
{
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ControlWithItems.hx",7)
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

Dynamic ControlWithItems_obj::__Field(const ::String &inName)
{
	return super::__Field(inName);
}

Dynamic ControlWithItems_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	return super::__SetField(inName,inValue);
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
};

Class ControlWithItems_obj::__mClass;

void ControlWithItems_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.ControlWithItems"), hx::TCanCast< ControlWithItems_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void ControlWithItems_obj::__boot()
{
}

} // end namespace wx
