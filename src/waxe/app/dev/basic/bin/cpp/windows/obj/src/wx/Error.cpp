#include <hxcpp.h>

#ifndef INCLUDED_wx_Error
#include <wx/Error.h>
#endif
namespace wx{

Void Error_obj::__construct()
{
	return null();
}

Error_obj::~Error_obj() { }

Dynamic Error_obj::__CreateEmpty() { return  new Error_obj; }
hx::ObjectPtr< Error_obj > Error_obj::__new()
{  hx::ObjectPtr< Error_obj > result = new Error_obj();
	result->__construct();
	return result;}

Dynamic Error_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Error_obj > result = new Error_obj();
	result->__construct();
	return result;}

::String Error_obj::INVALID_PARENT;


Error_obj::Error_obj()
{
}

void Error_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Error);
	HX_MARK_END_CLASS();
}

Dynamic Error_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 14:
		if (HX_FIELD_EQ(inName,"INVALID_PARENT") ) { return INVALID_PARENT; }
	}
	return super::__Field(inName);
}

Dynamic Error_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	switch(inName.length) {
	case 14:
		if (HX_FIELD_EQ(inName,"INVALID_PARENT") ) { INVALID_PARENT=inValue.Cast< ::String >(); return inValue; }
	}
	return super::__SetField(inName,inValue);
}

void Error_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("INVALID_PARENT"),
	String(null()) };

static ::String sMemberFields[] = {
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Error_obj::INVALID_PARENT,"INVALID_PARENT");
};

Class Error_obj::__mClass;

void Error_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.Error"), hx::TCanCast< Error_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void Error_obj::__boot()
{
	hx::Static(INVALID_PARENT) = HX_CSTRING("Invalid Parent");
}

} // end namespace wx
