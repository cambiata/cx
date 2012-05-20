#include <hxcpp.h>

#ifndef INCLUDED_wx_Brush
#include <wx/Brush.h>
#endif
#ifndef INCLUDED_wx_Colour
#include <wx/Colour.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
namespace wx{

Void Brush_obj::__construct(::wx::Colour inColour,Dynamic __o_inStyle)
{
int inStyle = __o_inStyle.Default(100);
{
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Brush.hx",19)
	this->wxHandle = ::wx::Brush_obj::wx_brush_create(inColour->getCombined(),inStyle);
}
;
	return null();
}

Brush_obj::~Brush_obj() { }

Dynamic Brush_obj::__CreateEmpty() { return  new Brush_obj; }
hx::ObjectPtr< Brush_obj > Brush_obj::__new(::wx::Colour inColour,Dynamic __o_inStyle)
{  hx::ObjectPtr< Brush_obj > result = new Brush_obj();
	result->__construct(inColour,__o_inStyle);
	return result;}

Dynamic Brush_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Brush_obj > result = new Brush_obj();
	result->__construct(inArgs[0],inArgs[1]);
	return result;}

Dynamic Brush_obj::wxGetHandle( ){
	HX_SOURCE_PUSH("Brush_obj::wxGetHandle")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Brush.hx",22)
	return this->wxHandle;
}


HX_DEFINE_DYNAMIC_FUNC0(Brush_obj,wxGetHandle,return )

int Brush_obj::SOLID;

int Brush_obj::TRANSPARENT;

int Brush_obj::STIPPLE;

int Brush_obj::BDIAGONAL_HATCH;

int Brush_obj::CROSSDIAG_HATCH;

int Brush_obj::FDIAGONAL_HATCH;

int Brush_obj::CROSS_HATCH;

int Brush_obj::HORIZONTAL_HATCH;

int Brush_obj::VERTICAL_HATCH;

Dynamic Brush_obj::wx_brush_create;


Brush_obj::Brush_obj()
{
}

void Brush_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Brush);
	HX_MARK_MEMBER_NAME(wxHandle,"wxHandle");
	HX_MARK_END_CLASS();
}

Dynamic Brush_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"SOLID") ) { return SOLID; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"STIPPLE") ) { return STIPPLE; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"wxHandle") ) { return wxHandle; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"TRANSPARENT") ) { return TRANSPARENT; }
		if (HX_FIELD_EQ(inName,"CROSS_HATCH") ) { return CROSS_HATCH; }
		if (HX_FIELD_EQ(inName,"wxGetHandle") ) { return wxGetHandle_dyn(); }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"VERTICAL_HATCH") ) { return VERTICAL_HATCH; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"BDIAGONAL_HATCH") ) { return BDIAGONAL_HATCH; }
		if (HX_FIELD_EQ(inName,"CROSSDIAG_HATCH") ) { return CROSSDIAG_HATCH; }
		if (HX_FIELD_EQ(inName,"FDIAGONAL_HATCH") ) { return FDIAGONAL_HATCH; }
		if (HX_FIELD_EQ(inName,"wx_brush_create") ) { return wx_brush_create; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"HORIZONTAL_HATCH") ) { return HORIZONTAL_HATCH; }
	}
	return super::__Field(inName);
}

Dynamic Brush_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"SOLID") ) { SOLID=inValue.Cast< int >(); return inValue; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"STIPPLE") ) { STIPPLE=inValue.Cast< int >(); return inValue; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"wxHandle") ) { wxHandle=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"TRANSPARENT") ) { TRANSPARENT=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"CROSS_HATCH") ) { CROSS_HATCH=inValue.Cast< int >(); return inValue; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"VERTICAL_HATCH") ) { VERTICAL_HATCH=inValue.Cast< int >(); return inValue; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"BDIAGONAL_HATCH") ) { BDIAGONAL_HATCH=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"CROSSDIAG_HATCH") ) { CROSSDIAG_HATCH=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"FDIAGONAL_HATCH") ) { FDIAGONAL_HATCH=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_brush_create") ) { wx_brush_create=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"HORIZONTAL_HATCH") ) { HORIZONTAL_HATCH=inValue.Cast< int >(); return inValue; }
	}
	return super::__SetField(inName,inValue);
}

void Brush_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("wxHandle"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("SOLID"),
	HX_CSTRING("TRANSPARENT"),
	HX_CSTRING("STIPPLE"),
	HX_CSTRING("BDIAGONAL_HATCH"),
	HX_CSTRING("CROSSDIAG_HATCH"),
	HX_CSTRING("FDIAGONAL_HATCH"),
	HX_CSTRING("CROSS_HATCH"),
	HX_CSTRING("HORIZONTAL_HATCH"),
	HX_CSTRING("VERTICAL_HATCH"),
	HX_CSTRING("wx_brush_create"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("wxHandle"),
	HX_CSTRING("wxGetHandle"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Brush_obj::SOLID,"SOLID");
	HX_MARK_MEMBER_NAME(Brush_obj::TRANSPARENT,"TRANSPARENT");
	HX_MARK_MEMBER_NAME(Brush_obj::STIPPLE,"STIPPLE");
	HX_MARK_MEMBER_NAME(Brush_obj::BDIAGONAL_HATCH,"BDIAGONAL_HATCH");
	HX_MARK_MEMBER_NAME(Brush_obj::CROSSDIAG_HATCH,"CROSSDIAG_HATCH");
	HX_MARK_MEMBER_NAME(Brush_obj::FDIAGONAL_HATCH,"FDIAGONAL_HATCH");
	HX_MARK_MEMBER_NAME(Brush_obj::CROSS_HATCH,"CROSS_HATCH");
	HX_MARK_MEMBER_NAME(Brush_obj::HORIZONTAL_HATCH,"HORIZONTAL_HATCH");
	HX_MARK_MEMBER_NAME(Brush_obj::VERTICAL_HATCH,"VERTICAL_HATCH");
	HX_MARK_MEMBER_NAME(Brush_obj::wx_brush_create,"wx_brush_create");
};

Class Brush_obj::__mClass;

void Brush_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.Brush"), hx::TCanCast< Brush_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void Brush_obj::__boot()
{
	hx::Static(SOLID) = (int)100;
	hx::Static(TRANSPARENT) = (int)106;
	hx::Static(STIPPLE) = (int)110;
	hx::Static(BDIAGONAL_HATCH) = (int)111;
	hx::Static(CROSSDIAG_HATCH) = (int)112;
	hx::Static(FDIAGONAL_HATCH) = (int)113;
	hx::Static(CROSS_HATCH) = (int)114;
	hx::Static(HORIZONTAL_HATCH) = (int)115;
	hx::Static(VERTICAL_HATCH) = (int)116;
	hx::Static(wx_brush_create) = ::wx::Loader_obj::load(HX_CSTRING("wx_brush_create"),(int)2);
}

} // end namespace wx
