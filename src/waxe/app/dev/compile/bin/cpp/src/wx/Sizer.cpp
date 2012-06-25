#include <hxcpp.h>

#ifndef INCLUDED_Reflect
#include <Reflect.h>
#endif
#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
#ifndef INCLUDED_wx_Sizer
#include <wx/Sizer.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif
namespace wx{

Void Sizer_obj::__construct(Dynamic inHandle)
{
{
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Sizer.hx",37)
	this->wxHandle = inHandle;
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Sizer.hx",38)
	if (((this->wxHandle != null()))){
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Sizer.hx",39)
		::wx::Sizer_obj::wx_set_data(this->wxHandle,hx::ObjectPtr<OBJ_>(this));
	}
}
;
	return null();
}

Sizer_obj::~Sizer_obj() { }

Dynamic Sizer_obj::__CreateEmpty() { return  new Sizer_obj; }
hx::ObjectPtr< Sizer_obj > Sizer_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< Sizer_obj > result = new Sizer_obj();
	result->__construct(inHandle);
	return result;}

Dynamic Sizer_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Sizer_obj > result = new Sizer_obj();
	result->__construct(inArgs[0]);
	return result;}

Void Sizer_obj::_wx_deleted( ){
{
		HX_SOURCE_PUSH("Sizer_obj::_wx_deleted")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Sizer.hx",41)
		this->wxHandle = null();
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC0(Sizer_obj,_wx_deleted,(void))

Void Sizer_obj::add( Dynamic sizerOrWindow,hx::Null< int >  __o_proportion,hx::Null< int >  __o_flag,hx::Null< int >  __o_border){
int proportion = __o_proportion.Default(0);
int flag = __o_flag.Default(0);
int border = __o_border.Default(0);
	HX_SOURCE_PUSH("Sizer_obj::add");
{
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Sizer.hx",45)
		Dynamic handle = ::Reflect_obj::field(sizerOrWindow,HX_CSTRING("wxHandle"));
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Sizer.hx",46)
		::wx::Sizer_obj::wx_sizer_add(this->wxHandle,handle,proportion,flag,border);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC4(Sizer_obj,add,(void))

Void Sizer_obj::addSpacer( int inSize){
{
		HX_SOURCE_PUSH("Sizer_obj::addSpacer")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Sizer.hx",49)
		::wx::Sizer_obj::wx_sizer_add_spacer(this->wxHandle,inSize,(int)0);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(Sizer_obj,addSpacer,(void))

Void Sizer_obj::addStretchSpacer( int inProportion){
{
		HX_SOURCE_PUSH("Sizer_obj::addStretchSpacer")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Sizer.hx",53)
		::wx::Sizer_obj::wx_sizer_add_spacer(this->wxHandle,(int)0,inProportion);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(Sizer_obj,addStretchSpacer,(void))

Void Sizer_obj::setSizeHints( ::wx::Window inWindow){
{
		HX_SOURCE_PUSH("Sizer_obj::setSizeHints")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Sizer.hx",60)
		::wx::Sizer_obj::wx_sizer_set_size_hints(this->wxHandle,inWindow->wxHandle);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(Sizer_obj,setSizeHints,(void))

Void Sizer_obj::fit( ::wx::Window inWindow){
{
		HX_SOURCE_PUSH("Sizer_obj::fit")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Sizer.hx",65)
		::wx::Sizer_obj::wx_sizer_fit(this->wxHandle,inWindow->wxHandle);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(Sizer_obj,fit,(void))

Dynamic Sizer_obj::wxGetHandle( ){
	HX_SOURCE_PUSH("Sizer_obj::wxGetHandle")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Sizer.hx",68)
	return this->wxHandle;
}


HX_DEFINE_DYNAMIC_FUNC0(Sizer_obj,wxGetHandle,return )

int Sizer_obj::BORDER_LEFT;

int Sizer_obj::BORDER_RIGHT;

int Sizer_obj::BORDER_UP;

int Sizer_obj::BORDER_DOWN;

int Sizer_obj::BORDER_TOP;

int Sizer_obj::BORDER_BOTTOM;

int Sizer_obj::BORDER_ALL;

int Sizer_obj::EXPAND;

int Sizer_obj::ALIGN_NOT;

int Sizer_obj::ALIGN_CENTER_HORIZONTAL;

int Sizer_obj::ALIGN_CENTRE_HORIZONTAL;

int Sizer_obj::ALIGN_LEFT;

int Sizer_obj::ALIGN_TOP;

int Sizer_obj::ALIGN_RIGHT;

int Sizer_obj::ALIGN_BOTTOM;

int Sizer_obj::ALIGN_CENTER_VERTICAL;

int Sizer_obj::ALIGN_CENTRE_VERTICAL;

int Sizer_obj::ALIGN_CENTER;

int Sizer_obj::ALIGN_CENTRE;

int Sizer_obj::ALIGN_MASK;

Dynamic Sizer_obj::wx_set_data;

Dynamic Sizer_obj::wx_get_data;

Dynamic Sizer_obj::wx_sizer_add;

Dynamic Sizer_obj::wx_sizer_add_spacer;

Dynamic Sizer_obj::wx_sizer_set_size_hints;

Dynamic Sizer_obj::wx_sizer_fit;


Sizer_obj::Sizer_obj()
{
}

void Sizer_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Sizer);
	HX_MARK_MEMBER_NAME(wxHandle,"wxHandle");
	HX_MARK_END_CLASS();
}

Dynamic Sizer_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 3:
		if (HX_FIELD_EQ(inName,"add") ) { return add_dyn(); }
		if (HX_FIELD_EQ(inName,"fit") ) { return fit_dyn(); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"EXPAND") ) { return EXPAND; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"wxHandle") ) { return wxHandle; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"BORDER_UP") ) { return BORDER_UP; }
		if (HX_FIELD_EQ(inName,"ALIGN_NOT") ) { return ALIGN_NOT; }
		if (HX_FIELD_EQ(inName,"ALIGN_TOP") ) { return ALIGN_TOP; }
		if (HX_FIELD_EQ(inName,"addSpacer") ) { return addSpacer_dyn(); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"BORDER_TOP") ) { return BORDER_TOP; }
		if (HX_FIELD_EQ(inName,"BORDER_ALL") ) { return BORDER_ALL; }
		if (HX_FIELD_EQ(inName,"ALIGN_LEFT") ) { return ALIGN_LEFT; }
		if (HX_FIELD_EQ(inName,"ALIGN_MASK") ) { return ALIGN_MASK; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"BORDER_LEFT") ) { return BORDER_LEFT; }
		if (HX_FIELD_EQ(inName,"BORDER_DOWN") ) { return BORDER_DOWN; }
		if (HX_FIELD_EQ(inName,"ALIGN_RIGHT") ) { return ALIGN_RIGHT; }
		if (HX_FIELD_EQ(inName,"wx_set_data") ) { return wx_set_data; }
		if (HX_FIELD_EQ(inName,"wx_get_data") ) { return wx_get_data; }
		if (HX_FIELD_EQ(inName,"_wx_deleted") ) { return _wx_deleted_dyn(); }
		if (HX_FIELD_EQ(inName,"wxGetHandle") ) { return wxGetHandle_dyn(); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"BORDER_RIGHT") ) { return BORDER_RIGHT; }
		if (HX_FIELD_EQ(inName,"ALIGN_BOTTOM") ) { return ALIGN_BOTTOM; }
		if (HX_FIELD_EQ(inName,"ALIGN_CENTER") ) { return ALIGN_CENTER; }
		if (HX_FIELD_EQ(inName,"ALIGN_CENTRE") ) { return ALIGN_CENTRE; }
		if (HX_FIELD_EQ(inName,"wx_sizer_add") ) { return wx_sizer_add; }
		if (HX_FIELD_EQ(inName,"wx_sizer_fit") ) { return wx_sizer_fit; }
		if (HX_FIELD_EQ(inName,"setSizeHints") ) { return setSizeHints_dyn(); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"BORDER_BOTTOM") ) { return BORDER_BOTTOM; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"addStretchSpacer") ) { return addStretchSpacer_dyn(); }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"wx_sizer_add_spacer") ) { return wx_sizer_add_spacer; }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"ALIGN_CENTER_VERTICAL") ) { return ALIGN_CENTER_VERTICAL; }
		if (HX_FIELD_EQ(inName,"ALIGN_CENTRE_VERTICAL") ) { return ALIGN_CENTRE_VERTICAL; }
		break;
	case 23:
		if (HX_FIELD_EQ(inName,"ALIGN_CENTER_HORIZONTAL") ) { return ALIGN_CENTER_HORIZONTAL; }
		if (HX_FIELD_EQ(inName,"ALIGN_CENTRE_HORIZONTAL") ) { return ALIGN_CENTRE_HORIZONTAL; }
		if (HX_FIELD_EQ(inName,"wx_sizer_set_size_hints") ) { return wx_sizer_set_size_hints; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic Sizer_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"EXPAND") ) { EXPAND=inValue.Cast< int >(); return inValue; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"wxHandle") ) { wxHandle=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"BORDER_UP") ) { BORDER_UP=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"ALIGN_NOT") ) { ALIGN_NOT=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"ALIGN_TOP") ) { ALIGN_TOP=inValue.Cast< int >(); return inValue; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"BORDER_TOP") ) { BORDER_TOP=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"BORDER_ALL") ) { BORDER_ALL=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"ALIGN_LEFT") ) { ALIGN_LEFT=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"ALIGN_MASK") ) { ALIGN_MASK=inValue.Cast< int >(); return inValue; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"BORDER_LEFT") ) { BORDER_LEFT=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"BORDER_DOWN") ) { BORDER_DOWN=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"ALIGN_RIGHT") ) { ALIGN_RIGHT=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_set_data") ) { wx_set_data=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_get_data") ) { wx_get_data=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"BORDER_RIGHT") ) { BORDER_RIGHT=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"ALIGN_BOTTOM") ) { ALIGN_BOTTOM=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"ALIGN_CENTER") ) { ALIGN_CENTER=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"ALIGN_CENTRE") ) { ALIGN_CENTRE=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_sizer_add") ) { wx_sizer_add=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_sizer_fit") ) { wx_sizer_fit=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"BORDER_BOTTOM") ) { BORDER_BOTTOM=inValue.Cast< int >(); return inValue; }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"wx_sizer_add_spacer") ) { wx_sizer_add_spacer=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"ALIGN_CENTER_VERTICAL") ) { ALIGN_CENTER_VERTICAL=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"ALIGN_CENTRE_VERTICAL") ) { ALIGN_CENTRE_VERTICAL=inValue.Cast< int >(); return inValue; }
		break;
	case 23:
		if (HX_FIELD_EQ(inName,"ALIGN_CENTER_HORIZONTAL") ) { ALIGN_CENTER_HORIZONTAL=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"ALIGN_CENTRE_HORIZONTAL") ) { ALIGN_CENTRE_HORIZONTAL=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_sizer_set_size_hints") ) { wx_sizer_set_size_hints=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void Sizer_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("wxHandle"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("BORDER_LEFT"),
	HX_CSTRING("BORDER_RIGHT"),
	HX_CSTRING("BORDER_UP"),
	HX_CSTRING("BORDER_DOWN"),
	HX_CSTRING("BORDER_TOP"),
	HX_CSTRING("BORDER_BOTTOM"),
	HX_CSTRING("BORDER_ALL"),
	HX_CSTRING("EXPAND"),
	HX_CSTRING("ALIGN_NOT"),
	HX_CSTRING("ALIGN_CENTER_HORIZONTAL"),
	HX_CSTRING("ALIGN_CENTRE_HORIZONTAL"),
	HX_CSTRING("ALIGN_LEFT"),
	HX_CSTRING("ALIGN_TOP"),
	HX_CSTRING("ALIGN_RIGHT"),
	HX_CSTRING("ALIGN_BOTTOM"),
	HX_CSTRING("ALIGN_CENTER_VERTICAL"),
	HX_CSTRING("ALIGN_CENTRE_VERTICAL"),
	HX_CSTRING("ALIGN_CENTER"),
	HX_CSTRING("ALIGN_CENTRE"),
	HX_CSTRING("ALIGN_MASK"),
	HX_CSTRING("wx_set_data"),
	HX_CSTRING("wx_get_data"),
	HX_CSTRING("wx_sizer_add"),
	HX_CSTRING("wx_sizer_add_spacer"),
	HX_CSTRING("wx_sizer_set_size_hints"),
	HX_CSTRING("wx_sizer_fit"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("wxHandle"),
	HX_CSTRING("_wx_deleted"),
	HX_CSTRING("add"),
	HX_CSTRING("addSpacer"),
	HX_CSTRING("addStretchSpacer"),
	HX_CSTRING("setSizeHints"),
	HX_CSTRING("fit"),
	HX_CSTRING("wxGetHandle"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Sizer_obj::BORDER_LEFT,"BORDER_LEFT");
	HX_MARK_MEMBER_NAME(Sizer_obj::BORDER_RIGHT,"BORDER_RIGHT");
	HX_MARK_MEMBER_NAME(Sizer_obj::BORDER_UP,"BORDER_UP");
	HX_MARK_MEMBER_NAME(Sizer_obj::BORDER_DOWN,"BORDER_DOWN");
	HX_MARK_MEMBER_NAME(Sizer_obj::BORDER_TOP,"BORDER_TOP");
	HX_MARK_MEMBER_NAME(Sizer_obj::BORDER_BOTTOM,"BORDER_BOTTOM");
	HX_MARK_MEMBER_NAME(Sizer_obj::BORDER_ALL,"BORDER_ALL");
	HX_MARK_MEMBER_NAME(Sizer_obj::EXPAND,"EXPAND");
	HX_MARK_MEMBER_NAME(Sizer_obj::ALIGN_NOT,"ALIGN_NOT");
	HX_MARK_MEMBER_NAME(Sizer_obj::ALIGN_CENTER_HORIZONTAL,"ALIGN_CENTER_HORIZONTAL");
	HX_MARK_MEMBER_NAME(Sizer_obj::ALIGN_CENTRE_HORIZONTAL,"ALIGN_CENTRE_HORIZONTAL");
	HX_MARK_MEMBER_NAME(Sizer_obj::ALIGN_LEFT,"ALIGN_LEFT");
	HX_MARK_MEMBER_NAME(Sizer_obj::ALIGN_TOP,"ALIGN_TOP");
	HX_MARK_MEMBER_NAME(Sizer_obj::ALIGN_RIGHT,"ALIGN_RIGHT");
	HX_MARK_MEMBER_NAME(Sizer_obj::ALIGN_BOTTOM,"ALIGN_BOTTOM");
	HX_MARK_MEMBER_NAME(Sizer_obj::ALIGN_CENTER_VERTICAL,"ALIGN_CENTER_VERTICAL");
	HX_MARK_MEMBER_NAME(Sizer_obj::ALIGN_CENTRE_VERTICAL,"ALIGN_CENTRE_VERTICAL");
	HX_MARK_MEMBER_NAME(Sizer_obj::ALIGN_CENTER,"ALIGN_CENTER");
	HX_MARK_MEMBER_NAME(Sizer_obj::ALIGN_CENTRE,"ALIGN_CENTRE");
	HX_MARK_MEMBER_NAME(Sizer_obj::ALIGN_MASK,"ALIGN_MASK");
	HX_MARK_MEMBER_NAME(Sizer_obj::wx_set_data,"wx_set_data");
	HX_MARK_MEMBER_NAME(Sizer_obj::wx_get_data,"wx_get_data");
	HX_MARK_MEMBER_NAME(Sizer_obj::wx_sizer_add,"wx_sizer_add");
	HX_MARK_MEMBER_NAME(Sizer_obj::wx_sizer_add_spacer,"wx_sizer_add_spacer");
	HX_MARK_MEMBER_NAME(Sizer_obj::wx_sizer_set_size_hints,"wx_sizer_set_size_hints");
	HX_MARK_MEMBER_NAME(Sizer_obj::wx_sizer_fit,"wx_sizer_fit");
};

Class Sizer_obj::__mClass;

void Sizer_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.Sizer"), hx::TCanCast< Sizer_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void Sizer_obj::__boot()
{
	hx::Static(BORDER_LEFT) = (int)16;
	hx::Static(BORDER_RIGHT) = (int)32;
	hx::Static(BORDER_UP) = (int)64;
	hx::Static(BORDER_DOWN) = (int)128;
	hx::Static(BORDER_TOP) = (int)64;
	hx::Static(BORDER_BOTTOM) = (int)128;
	hx::Static(BORDER_ALL) = (int)240;
	hx::Static(EXPAND) = (int)8192;
	hx::Static(ALIGN_NOT) = (int)0;
	hx::Static(ALIGN_CENTER_HORIZONTAL) = (int)256;
	hx::Static(ALIGN_CENTRE_HORIZONTAL) = (int)256;
	hx::Static(ALIGN_LEFT) = (int)0;
	hx::Static(ALIGN_TOP) = (int)0;
	hx::Static(ALIGN_RIGHT) = (int)512;
	hx::Static(ALIGN_BOTTOM) = (int)1024;
	hx::Static(ALIGN_CENTER_VERTICAL) = (int)2048;
	hx::Static(ALIGN_CENTRE_VERTICAL) = (int)2048;
	hx::Static(ALIGN_CENTER) = (int)2304;
	hx::Static(ALIGN_CENTRE) = (int)2304;
	hx::Static(ALIGN_MASK) = (int)3840;
	hx::Static(wx_set_data) = ::wx::Loader_obj::load(HX_CSTRING("wx_set_data"),(int)2);
	hx::Static(wx_get_data) = ::wx::Loader_obj::load(HX_CSTRING("wx_get_data"),(int)1);
	hx::Static(wx_sizer_add) = ::wx::Loader_obj::load(HX_CSTRING("wx_sizer_add"),(int)5);
	hx::Static(wx_sizer_add_spacer) = ::wx::Loader_obj::load(HX_CSTRING("wx_sizer_add_spacer"),(int)3);
	hx::Static(wx_sizer_set_size_hints) = ::wx::Loader_obj::load(HX_CSTRING("wx_sizer_set_size_hints"),(int)2);
	hx::Static(wx_sizer_fit) = ::wx::Loader_obj::load(HX_CSTRING("wx_sizer_fit"),(int)2);
}

} // end namespace wx
