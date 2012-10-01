#include <hxcpp.h>

#ifndef INCLUDED_haxe_Resource
#include <haxe/Resource.h>
#endif
#ifndef INCLUDED_haxe_io_Bytes
#include <haxe/io/Bytes.h>
#endif
#ifndef INCLUDED_wx_Bitmap
#include <wx/Bitmap.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
namespace wx{

Void Bitmap_obj::__construct(Dynamic inHandle)
{
HX_STACK_PUSH("Bitmap::new","wx/Bitmap.hx",7);
{
	HX_STACK_LINE(7)
	this->wxHandle = inHandle;
}
;
	return null();
}

Bitmap_obj::~Bitmap_obj() { }

Dynamic Bitmap_obj::__CreateEmpty() { return  new Bitmap_obj; }
hx::ObjectPtr< Bitmap_obj > Bitmap_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< Bitmap_obj > result = new Bitmap_obj();
	result->__construct(inHandle);
	return result;}

Dynamic Bitmap_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Bitmap_obj > result = new Bitmap_obj();
	result->__construct(inArgs[0]);
	return result;}

::wx::Bitmap Bitmap_obj::fromBytes( ::haxe::io::Bytes inBytes){
	HX_STACK_PUSH("Bitmap::fromBytes","wx/Bitmap.hx",10);
	HX_STACK_ARG(inBytes,"inBytes");
	HX_STACK_LINE(11)
	if (((inBytes == null()))){
		HX_STACK_LINE(12)
		hx::Throw (HX_CSTRING("Bad bitmap data"));
	}
	HX_STACK_LINE(13)
	return ::wx::Bitmap_obj::__new(::wx::Bitmap_obj::wx_bitmap_from_bytes(inBytes->b));
}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(Bitmap_obj,fromBytes,return )

::wx::Bitmap Bitmap_obj::fromResource( ::String inResorceName){
	HX_STACK_PUSH("Bitmap::fromResource","wx/Bitmap.hx",17);
	HX_STACK_ARG(inResorceName,"inResorceName");
	HX_STACK_LINE(17)
	return ::wx::Bitmap_obj::fromBytes(::haxe::Resource_obj::getBytes(inResorceName));
}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(Bitmap_obj,fromResource,return )

Dynamic Bitmap_obj::wx_bitmap_from_bytes;


Bitmap_obj::Bitmap_obj()
{
}

void Bitmap_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Bitmap);
	HX_MARK_MEMBER_NAME(wxHandle,"wxHandle");
	HX_MARK_END_CLASS();
}

void Bitmap_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(wxHandle,"wxHandle");
}

Dynamic Bitmap_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 8:
		if (HX_FIELD_EQ(inName,"wxHandle") ) { return wxHandle; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"fromBytes") ) { return fromBytes_dyn(); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"fromResource") ) { return fromResource_dyn(); }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"wx_bitmap_from_bytes") ) { return wx_bitmap_from_bytes; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic Bitmap_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 8:
		if (HX_FIELD_EQ(inName,"wxHandle") ) { wxHandle=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"wx_bitmap_from_bytes") ) { wx_bitmap_from_bytes=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void Bitmap_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("wxHandle"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("fromBytes"),
	HX_CSTRING("fromResource"),
	HX_CSTRING("wx_bitmap_from_bytes"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("wxHandle"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Bitmap_obj::__mClass,"__mClass");
	HX_MARK_MEMBER_NAME(Bitmap_obj::wx_bitmap_from_bytes,"wx_bitmap_from_bytes");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Bitmap_obj::__mClass,"__mClass");
	HX_VISIT_MEMBER_NAME(Bitmap_obj::wx_bitmap_from_bytes,"wx_bitmap_from_bytes");
};

Class Bitmap_obj::__mClass;

void Bitmap_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.Bitmap"), hx::TCanCast< Bitmap_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void Bitmap_obj::__boot()
{
	wx_bitmap_from_bytes= ::wx::Loader_obj::load(HX_CSTRING("wx_bitmap_from_bytes"),(int)1);
}

} // end namespace wx
