#include <hxcpp.h>

#ifndef INCLUDED_wx_BoxSizer
#include <wx/BoxSizer.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
#ifndef INCLUDED_wx_Sizer
#include <wx/Sizer.h>
#endif
namespace wx{

Void BoxSizer_obj::__construct(Dynamic inHandle)
{
{
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/BoxSizer.hx",5)
	super::__construct(inHandle);
}
;
	return null();
}

BoxSizer_obj::~BoxSizer_obj() { }

Dynamic BoxSizer_obj::__CreateEmpty() { return  new BoxSizer_obj; }
hx::ObjectPtr< BoxSizer_obj > BoxSizer_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< BoxSizer_obj > result = new BoxSizer_obj();
	result->__construct(inHandle);
	return result;}

Dynamic BoxSizer_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< BoxSizer_obj > result = new BoxSizer_obj();
	result->__construct(inArgs[0]);
	return result;}

::wx::BoxSizer BoxSizer_obj::create( bool inVertical){
	HX_SOURCE_PUSH("BoxSizer_obj::create")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/BoxSizer.hx",8)
	return ::wx::BoxSizer_obj::__new(::wx::BoxSizer_obj::wx_sizer_create_box(inVertical));
}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(BoxSizer_obj,create,return )

Dynamic BoxSizer_obj::wx_sizer_create_box;


BoxSizer_obj::BoxSizer_obj()
{
}

void BoxSizer_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(BoxSizer);
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic BoxSizer_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return create_dyn(); }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"wx_sizer_create_box") ) { return wx_sizer_create_box; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic BoxSizer_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 19:
		if (HX_FIELD_EQ(inName,"wx_sizer_create_box") ) { wx_sizer_create_box=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void BoxSizer_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("create"),
	HX_CSTRING("wx_sizer_create_box"),
	String(null()) };

static ::String sMemberFields[] = {
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(BoxSizer_obj::wx_sizer_create_box,"wx_sizer_create_box");
};

Class BoxSizer_obj::__mClass;

void BoxSizer_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.BoxSizer"), hx::TCanCast< BoxSizer_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void BoxSizer_obj::__boot()
{
	hx::Static(wx_sizer_create_box) = ::wx::Loader_obj::load(HX_CSTRING("wx_sizer_create_box"),(int)1);
}

} // end namespace wx
