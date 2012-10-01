#include <hxcpp.h>

#ifndef INCLUDED_cpp_Lib
#include <cpp/Lib.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
namespace wx{

Void Loader_obj::__construct()
{
	return null();
}

Loader_obj::~Loader_obj() { }

Dynamic Loader_obj::__CreateEmpty() { return  new Loader_obj; }
hx::ObjectPtr< Loader_obj > Loader_obj::__new()
{  hx::ObjectPtr< Loader_obj > result = new Loader_obj();
	result->__construct();
	return result;}

Dynamic Loader_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Loader_obj > result = new Loader_obj();
	result->__construct();
	return result;}

Dynamic Loader_obj::load( ::String inFunction,int inArgCount){
	HX_STACK_PUSH("Loader::load","wx/Loader.hx",6);
	HX_STACK_ARG(inFunction,"inFunction");
	HX_STACK_ARG(inArgCount,"inArgCount");
	HX_STACK_LINE(6)
	return ::cpp::Lib_obj::load(HX_CSTRING("waxe"),inFunction,inArgCount);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(Loader_obj,load,return )


Loader_obj::Loader_obj()
{
}

void Loader_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Loader);
	HX_MARK_END_CLASS();
}

void Loader_obj::__Visit(HX_VISIT_PARAMS)
{
}

Dynamic Loader_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"load") ) { return load_dyn(); }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic Loader_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	return super::__SetField(inName,inValue,inCallProp);
}

void Loader_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("load"),
	String(null()) };

static ::String sMemberFields[] = {
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Loader_obj::__mClass,"__mClass");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Loader_obj::__mClass,"__mClass");
};

Class Loader_obj::__mClass;

void Loader_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.Loader"), hx::TCanCast< Loader_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void Loader_obj::__boot()
{
}

} // end namespace wx
