#include <hxcpp.h>

#ifndef INCLUDED_wx_Font
#include <wx/Font.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
namespace wx{

Void Font_obj::__construct(int size,hx::Null< int >  __o_family,hx::Null< int >  __o_style,hx::Null< int >  __o_weight,hx::Null< bool >  __o_underline,::String __o_faceName)
{
HX_STACK_PUSH("Font::new","wx/Font.hx",29);
int family = __o_family.Default(70);
int style = __o_style.Default(90);
int weight = __o_weight.Default(90);
bool underline = __o_underline.Default(false);
::String faceName = __o_faceName.Default(HX_CSTRING(""));
{
	HX_STACK_LINE(29)
	this->wxHandle = ::wx::Font_obj::wx_font_create(size,family,style,weight,underline,faceName);
}
;
	return null();
}

Font_obj::~Font_obj() { }

Dynamic Font_obj::__CreateEmpty() { return  new Font_obj; }
hx::ObjectPtr< Font_obj > Font_obj::__new(int size,hx::Null< int >  __o_family,hx::Null< int >  __o_style,hx::Null< int >  __o_weight,hx::Null< bool >  __o_underline,::String __o_faceName)
{  hx::ObjectPtr< Font_obj > result = new Font_obj();
	result->__construct(size,__o_family,__o_style,__o_weight,__o_underline,__o_faceName);
	return result;}

Dynamic Font_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Font_obj > result = new Font_obj();
	result->__construct(inArgs[0],inArgs[1],inArgs[2],inArgs[3],inArgs[4],inArgs[5]);
	return result;}

Dynamic Font_obj::wxGetHandle( ){
	HX_STACK_PUSH("Font::wxGetHandle","wx/Font.hx",32);
	HX_STACK_THIS(this);
	HX_STACK_LINE(32)
	return this->wxHandle;
}


HX_DEFINE_DYNAMIC_FUNC0(Font_obj,wxGetHandle,return )

int Font_obj::FAMILY_DEFAULT;

int Font_obj::FAMILY_DECORATIVE;

int Font_obj::FAMILY_ROMAN;

int Font_obj::FAMILY_SCRIPT;

int Font_obj::FAMILY_SWISS;

int Font_obj::FAMILY_MODERN;

int Font_obj::FAMILY_TELETYPE;

int Font_obj::STYLE_NORMAL;

int Font_obj::STYLE_SLANT;

int Font_obj::STYLE_ITALIC;

int Font_obj::WEIGHT_NORMAL;

int Font_obj::WEIGHT_LIGHT;

int Font_obj::WEIGHT_BOLD;

Dynamic Font_obj::wx_font_create;


Font_obj::Font_obj()
{
}

void Font_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Font);
	HX_MARK_MEMBER_NAME(wxHandle,"wxHandle");
	HX_MARK_END_CLASS();
}

void Font_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(wxHandle,"wxHandle");
}

Dynamic Font_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 8:
		if (HX_FIELD_EQ(inName,"wxHandle") ) { return wxHandle; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"STYLE_SLANT") ) { return STYLE_SLANT; }
		if (HX_FIELD_EQ(inName,"WEIGHT_BOLD") ) { return WEIGHT_BOLD; }
		if (HX_FIELD_EQ(inName,"wxGetHandle") ) { return wxGetHandle_dyn(); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"FAMILY_ROMAN") ) { return FAMILY_ROMAN; }
		if (HX_FIELD_EQ(inName,"FAMILY_SWISS") ) { return FAMILY_SWISS; }
		if (HX_FIELD_EQ(inName,"STYLE_NORMAL") ) { return STYLE_NORMAL; }
		if (HX_FIELD_EQ(inName,"STYLE_ITALIC") ) { return STYLE_ITALIC; }
		if (HX_FIELD_EQ(inName,"WEIGHT_LIGHT") ) { return WEIGHT_LIGHT; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"FAMILY_SCRIPT") ) { return FAMILY_SCRIPT; }
		if (HX_FIELD_EQ(inName,"FAMILY_MODERN") ) { return FAMILY_MODERN; }
		if (HX_FIELD_EQ(inName,"WEIGHT_NORMAL") ) { return WEIGHT_NORMAL; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"FAMILY_DEFAULT") ) { return FAMILY_DEFAULT; }
		if (HX_FIELD_EQ(inName,"wx_font_create") ) { return wx_font_create; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"FAMILY_TELETYPE") ) { return FAMILY_TELETYPE; }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"FAMILY_DECORATIVE") ) { return FAMILY_DECORATIVE; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic Font_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 8:
		if (HX_FIELD_EQ(inName,"wxHandle") ) { wxHandle=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"STYLE_SLANT") ) { STYLE_SLANT=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"WEIGHT_BOLD") ) { WEIGHT_BOLD=inValue.Cast< int >(); return inValue; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"FAMILY_ROMAN") ) { FAMILY_ROMAN=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"FAMILY_SWISS") ) { FAMILY_SWISS=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"STYLE_NORMAL") ) { STYLE_NORMAL=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"STYLE_ITALIC") ) { STYLE_ITALIC=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"WEIGHT_LIGHT") ) { WEIGHT_LIGHT=inValue.Cast< int >(); return inValue; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"FAMILY_SCRIPT") ) { FAMILY_SCRIPT=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"FAMILY_MODERN") ) { FAMILY_MODERN=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"WEIGHT_NORMAL") ) { WEIGHT_NORMAL=inValue.Cast< int >(); return inValue; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"FAMILY_DEFAULT") ) { FAMILY_DEFAULT=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_font_create") ) { wx_font_create=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"FAMILY_TELETYPE") ) { FAMILY_TELETYPE=inValue.Cast< int >(); return inValue; }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"FAMILY_DECORATIVE") ) { FAMILY_DECORATIVE=inValue.Cast< int >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void Font_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("wxHandle"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("FAMILY_DEFAULT"),
	HX_CSTRING("FAMILY_DECORATIVE"),
	HX_CSTRING("FAMILY_ROMAN"),
	HX_CSTRING("FAMILY_SCRIPT"),
	HX_CSTRING("FAMILY_SWISS"),
	HX_CSTRING("FAMILY_MODERN"),
	HX_CSTRING("FAMILY_TELETYPE"),
	HX_CSTRING("STYLE_NORMAL"),
	HX_CSTRING("STYLE_SLANT"),
	HX_CSTRING("STYLE_ITALIC"),
	HX_CSTRING("WEIGHT_NORMAL"),
	HX_CSTRING("WEIGHT_LIGHT"),
	HX_CSTRING("WEIGHT_BOLD"),
	HX_CSTRING("wx_font_create"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("wxGetHandle"),
	HX_CSTRING("wxHandle"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Font_obj::__mClass,"__mClass");
	HX_MARK_MEMBER_NAME(Font_obj::FAMILY_DEFAULT,"FAMILY_DEFAULT");
	HX_MARK_MEMBER_NAME(Font_obj::FAMILY_DECORATIVE,"FAMILY_DECORATIVE");
	HX_MARK_MEMBER_NAME(Font_obj::FAMILY_ROMAN,"FAMILY_ROMAN");
	HX_MARK_MEMBER_NAME(Font_obj::FAMILY_SCRIPT,"FAMILY_SCRIPT");
	HX_MARK_MEMBER_NAME(Font_obj::FAMILY_SWISS,"FAMILY_SWISS");
	HX_MARK_MEMBER_NAME(Font_obj::FAMILY_MODERN,"FAMILY_MODERN");
	HX_MARK_MEMBER_NAME(Font_obj::FAMILY_TELETYPE,"FAMILY_TELETYPE");
	HX_MARK_MEMBER_NAME(Font_obj::STYLE_NORMAL,"STYLE_NORMAL");
	HX_MARK_MEMBER_NAME(Font_obj::STYLE_SLANT,"STYLE_SLANT");
	HX_MARK_MEMBER_NAME(Font_obj::STYLE_ITALIC,"STYLE_ITALIC");
	HX_MARK_MEMBER_NAME(Font_obj::WEIGHT_NORMAL,"WEIGHT_NORMAL");
	HX_MARK_MEMBER_NAME(Font_obj::WEIGHT_LIGHT,"WEIGHT_LIGHT");
	HX_MARK_MEMBER_NAME(Font_obj::WEIGHT_BOLD,"WEIGHT_BOLD");
	HX_MARK_MEMBER_NAME(Font_obj::wx_font_create,"wx_font_create");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Font_obj::__mClass,"__mClass");
	HX_VISIT_MEMBER_NAME(Font_obj::FAMILY_DEFAULT,"FAMILY_DEFAULT");
	HX_VISIT_MEMBER_NAME(Font_obj::FAMILY_DECORATIVE,"FAMILY_DECORATIVE");
	HX_VISIT_MEMBER_NAME(Font_obj::FAMILY_ROMAN,"FAMILY_ROMAN");
	HX_VISIT_MEMBER_NAME(Font_obj::FAMILY_SCRIPT,"FAMILY_SCRIPT");
	HX_VISIT_MEMBER_NAME(Font_obj::FAMILY_SWISS,"FAMILY_SWISS");
	HX_VISIT_MEMBER_NAME(Font_obj::FAMILY_MODERN,"FAMILY_MODERN");
	HX_VISIT_MEMBER_NAME(Font_obj::FAMILY_TELETYPE,"FAMILY_TELETYPE");
	HX_VISIT_MEMBER_NAME(Font_obj::STYLE_NORMAL,"STYLE_NORMAL");
	HX_VISIT_MEMBER_NAME(Font_obj::STYLE_SLANT,"STYLE_SLANT");
	HX_VISIT_MEMBER_NAME(Font_obj::STYLE_ITALIC,"STYLE_ITALIC");
	HX_VISIT_MEMBER_NAME(Font_obj::WEIGHT_NORMAL,"WEIGHT_NORMAL");
	HX_VISIT_MEMBER_NAME(Font_obj::WEIGHT_LIGHT,"WEIGHT_LIGHT");
	HX_VISIT_MEMBER_NAME(Font_obj::WEIGHT_BOLD,"WEIGHT_BOLD");
	HX_VISIT_MEMBER_NAME(Font_obj::wx_font_create,"wx_font_create");
};

Class Font_obj::__mClass;

void Font_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.Font"), hx::TCanCast< Font_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void Font_obj::__boot()
{
	FAMILY_DEFAULT= (int)70;
	FAMILY_DECORATIVE= (int)71;
	FAMILY_ROMAN= (int)72;
	FAMILY_SCRIPT= (int)73;
	FAMILY_SWISS= (int)74;
	FAMILY_MODERN= (int)75;
	FAMILY_TELETYPE= (int)76;
	STYLE_NORMAL= (int)90;
	STYLE_SLANT= (int)92;
	STYLE_ITALIC= (int)93;
	WEIGHT_NORMAL= (int)90;
	WEIGHT_LIGHT= (int)91;
	WEIGHT_BOLD= (int)92;
	wx_font_create= ::wx::Loader_obj::load(HX_CSTRING("wx_font_create"),(int)-1);
}

} // end namespace wx
