#include <hxcpp.h>

#ifndef INCLUDED_wx_Colour
#include <wx/Colour.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
#ifndef INCLUDED_wx_Pen
#include <wx/Pen.h>
#endif
namespace wx{

Void Pen_obj::__construct(::wx::Colour inColour,hx::Null< int >  __o_inWidth,hx::Null< int >  __o_inStyle)
{
HX_STACK_PUSH("Pen::new","wx/Pen.hx",16);
int inWidth = __o_inWidth.Default(1);
int inStyle = __o_inStyle.Default(100);
{
	HX_STACK_LINE(16)
	this->wxHandle = ::wx::Pen_obj::wx_pen_create(inColour->getCombined(),inWidth,inStyle);
}
;
	return null();
}

Pen_obj::~Pen_obj() { }

Dynamic Pen_obj::__CreateEmpty() { return  new Pen_obj; }
hx::ObjectPtr< Pen_obj > Pen_obj::__new(::wx::Colour inColour,hx::Null< int >  __o_inWidth,hx::Null< int >  __o_inStyle)
{  hx::ObjectPtr< Pen_obj > result = new Pen_obj();
	result->__construct(inColour,__o_inWidth,__o_inStyle);
	return result;}

Dynamic Pen_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Pen_obj > result = new Pen_obj();
	result->__construct(inArgs[0],inArgs[1],inArgs[2]);
	return result;}

Dynamic Pen_obj::wxGetHandle( ){
	HX_STACK_PUSH("Pen::wxGetHandle","wx/Pen.hx",19);
	HX_STACK_THIS(this);
	HX_STACK_LINE(19)
	return this->wxHandle;
}


HX_DEFINE_DYNAMIC_FUNC0(Pen_obj,wxGetHandle,return )

int Pen_obj::SOLID;

int Pen_obj::DOT;

int Pen_obj::LONG_DASH;

int Pen_obj::SHORT_DASH;

int Pen_obj::DOT_DASH;

int Pen_obj::USER_DASH;

int Pen_obj::TRANSPARENT;

Dynamic Pen_obj::wx_pen_create;


Pen_obj::Pen_obj()
{
}

void Pen_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Pen);
	HX_MARK_MEMBER_NAME(wxHandle,"wxHandle");
	HX_MARK_END_CLASS();
}

void Pen_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(wxHandle,"wxHandle");
}

Dynamic Pen_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 3:
		if (HX_FIELD_EQ(inName,"DOT") ) { return DOT; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"SOLID") ) { return SOLID; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"DOT_DASH") ) { return DOT_DASH; }
		if (HX_FIELD_EQ(inName,"wxHandle") ) { return wxHandle; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"LONG_DASH") ) { return LONG_DASH; }
		if (HX_FIELD_EQ(inName,"USER_DASH") ) { return USER_DASH; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"SHORT_DASH") ) { return SHORT_DASH; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"TRANSPARENT") ) { return TRANSPARENT; }
		if (HX_FIELD_EQ(inName,"wxGetHandle") ) { return wxGetHandle_dyn(); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"wx_pen_create") ) { return wx_pen_create; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic Pen_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 3:
		if (HX_FIELD_EQ(inName,"DOT") ) { DOT=inValue.Cast< int >(); return inValue; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"SOLID") ) { SOLID=inValue.Cast< int >(); return inValue; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"DOT_DASH") ) { DOT_DASH=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wxHandle") ) { wxHandle=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"LONG_DASH") ) { LONG_DASH=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"USER_DASH") ) { USER_DASH=inValue.Cast< int >(); return inValue; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"SHORT_DASH") ) { SHORT_DASH=inValue.Cast< int >(); return inValue; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"TRANSPARENT") ) { TRANSPARENT=inValue.Cast< int >(); return inValue; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"wx_pen_create") ) { wx_pen_create=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void Pen_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("wxHandle"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("SOLID"),
	HX_CSTRING("DOT"),
	HX_CSTRING("LONG_DASH"),
	HX_CSTRING("SHORT_DASH"),
	HX_CSTRING("DOT_DASH"),
	HX_CSTRING("USER_DASH"),
	HX_CSTRING("TRANSPARENT"),
	HX_CSTRING("wx_pen_create"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("wxGetHandle"),
	HX_CSTRING("wxHandle"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Pen_obj::__mClass,"__mClass");
	HX_MARK_MEMBER_NAME(Pen_obj::SOLID,"SOLID");
	HX_MARK_MEMBER_NAME(Pen_obj::DOT,"DOT");
	HX_MARK_MEMBER_NAME(Pen_obj::LONG_DASH,"LONG_DASH");
	HX_MARK_MEMBER_NAME(Pen_obj::SHORT_DASH,"SHORT_DASH");
	HX_MARK_MEMBER_NAME(Pen_obj::DOT_DASH,"DOT_DASH");
	HX_MARK_MEMBER_NAME(Pen_obj::USER_DASH,"USER_DASH");
	HX_MARK_MEMBER_NAME(Pen_obj::TRANSPARENT,"TRANSPARENT");
	HX_MARK_MEMBER_NAME(Pen_obj::wx_pen_create,"wx_pen_create");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Pen_obj::__mClass,"__mClass");
	HX_VISIT_MEMBER_NAME(Pen_obj::SOLID,"SOLID");
	HX_VISIT_MEMBER_NAME(Pen_obj::DOT,"DOT");
	HX_VISIT_MEMBER_NAME(Pen_obj::LONG_DASH,"LONG_DASH");
	HX_VISIT_MEMBER_NAME(Pen_obj::SHORT_DASH,"SHORT_DASH");
	HX_VISIT_MEMBER_NAME(Pen_obj::DOT_DASH,"DOT_DASH");
	HX_VISIT_MEMBER_NAME(Pen_obj::USER_DASH,"USER_DASH");
	HX_VISIT_MEMBER_NAME(Pen_obj::TRANSPARENT,"TRANSPARENT");
	HX_VISIT_MEMBER_NAME(Pen_obj::wx_pen_create,"wx_pen_create");
};

Class Pen_obj::__mClass;

void Pen_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.Pen"), hx::TCanCast< Pen_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void Pen_obj::__boot()
{
	SOLID= (int)100;
	DOT= (int)101;
	LONG_DASH= (int)102;
	SHORT_DASH= (int)103;
	DOT_DASH= (int)104;
	USER_DASH= (int)105;
	TRANSPARENT= (int)106;
	wx_pen_create= ::wx::Loader_obj::load(HX_CSTRING("wx_pen_create"),(int)3);
}

} // end namespace wx
