#include <hxcpp.h>

#ifndef INCLUDED_haxe_Log
#include <haxe/Log.h>
#endif
#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
#ifndef INCLUDED_wx_Menu
#include <wx/Menu.h>
#endif
namespace wx{

Void Menu_obj::__construct(hx::Null< ::String >  __o_inTitle,hx::Null< int >  __o_inFlags)
{
::String inTitle = __o_inTitle.Default(HX_CSTRING(""));
int inFlags = __o_inFlags.Default(0);
{
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Menu.hx",12)
	super::__construct(::wx::Menu_obj::wx_menu_create(inTitle,inFlags));
}
;
	return null();
}

Menu_obj::~Menu_obj() { }

Dynamic Menu_obj::__CreateEmpty() { return  new Menu_obj; }
hx::ObjectPtr< Menu_obj > Menu_obj::__new(hx::Null< ::String >  __o_inTitle,hx::Null< int >  __o_inFlags)
{  hx::ObjectPtr< Menu_obj > result = new Menu_obj();
	result->__construct(__o_inTitle,__o_inFlags);
	return result;}

Dynamic Menu_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Menu_obj > result = new Menu_obj();
	result->__construct(inArgs[0],inArgs[1]);
	return result;}

Void Menu_obj::HandleEvent( Dynamic event){
{
		HX_SOURCE_PUSH("Menu_obj::HandleEvent")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Menu.hx",17)
		::haxe::Log_obj::trace(HX_CSTRING("Menu Event!"),hx::SourceInfo(HX_CSTRING("Menu.hx"),18,HX_CSTRING("wx.Menu"),HX_CSTRING("HandleEvent")));
	}
return null();
}


int Menu_obj::append( int inID,hx::Null< ::String >  __o_inItem,hx::Null< ::String >  __o_inHelp,hx::Null< int >  __o_inKind){
::String inItem = __o_inItem.Default(HX_CSTRING(""));
::String inHelp = __o_inHelp.Default(HX_CSTRING(""));
int inKind = __o_inKind.Default(0);
	HX_SOURCE_PUSH("Menu_obj::append");
{
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Menu.hx",22)
		::wx::Menu_obj::wx_menu_append(this->wxHandle,inID,inItem,inHelp,inKind);
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Menu.hx",23)
		return inID;
	}
}


HX_DEFINE_DYNAMIC_FUNC4(Menu_obj,append,return )

Void Menu_obj::appendSeparator( ){
{
		HX_SOURCE_PUSH("Menu_obj::appendSeparator")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Menu.hx",26)
		::wx::Menu_obj::wx_menu_append_separator(this->wxHandle);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC0(Menu_obj,appendSeparator,(void))

int Menu_obj::NORMAL;

int Menu_obj::SEPARATOR;

int Menu_obj::CHECK;

int Menu_obj::RADIO;

Dynamic Menu_obj::wx_menu_create;

Dynamic Menu_obj::wx_menu_append;

Dynamic Menu_obj::wx_menu_append_separator;


Menu_obj::Menu_obj()
{
}

void Menu_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Menu);
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic Menu_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"CHECK") ) { return CHECK; }
		if (HX_FIELD_EQ(inName,"RADIO") ) { return RADIO; }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"NORMAL") ) { return NORMAL; }
		if (HX_FIELD_EQ(inName,"append") ) { return append_dyn(); }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"SEPARATOR") ) { return SEPARATOR; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"HandleEvent") ) { return HandleEvent_dyn(); }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"wx_menu_create") ) { return wx_menu_create; }
		if (HX_FIELD_EQ(inName,"wx_menu_append") ) { return wx_menu_append; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"appendSeparator") ) { return appendSeparator_dyn(); }
		break;
	case 24:
		if (HX_FIELD_EQ(inName,"wx_menu_append_separator") ) { return wx_menu_append_separator; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic Menu_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"CHECK") ) { CHECK=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"RADIO") ) { RADIO=inValue.Cast< int >(); return inValue; }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"NORMAL") ) { NORMAL=inValue.Cast< int >(); return inValue; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"SEPARATOR") ) { SEPARATOR=inValue.Cast< int >(); return inValue; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"wx_menu_create") ) { wx_menu_create=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_menu_append") ) { wx_menu_append=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 24:
		if (HX_FIELD_EQ(inName,"wx_menu_append_separator") ) { wx_menu_append_separator=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void Menu_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("NORMAL"),
	HX_CSTRING("SEPARATOR"),
	HX_CSTRING("CHECK"),
	HX_CSTRING("RADIO"),
	HX_CSTRING("wx_menu_create"),
	HX_CSTRING("wx_menu_append"),
	HX_CSTRING("wx_menu_append_separator"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("HandleEvent"),
	HX_CSTRING("append"),
	HX_CSTRING("appendSeparator"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Menu_obj::NORMAL,"NORMAL");
	HX_MARK_MEMBER_NAME(Menu_obj::SEPARATOR,"SEPARATOR");
	HX_MARK_MEMBER_NAME(Menu_obj::CHECK,"CHECK");
	HX_MARK_MEMBER_NAME(Menu_obj::RADIO,"RADIO");
	HX_MARK_MEMBER_NAME(Menu_obj::wx_menu_create,"wx_menu_create");
	HX_MARK_MEMBER_NAME(Menu_obj::wx_menu_append,"wx_menu_append");
	HX_MARK_MEMBER_NAME(Menu_obj::wx_menu_append_separator,"wx_menu_append_separator");
};

Class Menu_obj::__mClass;

void Menu_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.Menu"), hx::TCanCast< Menu_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void Menu_obj::__boot()
{
	hx::Static(NORMAL) = (int)0;
	hx::Static(SEPARATOR) = (int)1;
	hx::Static(CHECK) = (int)2;
	hx::Static(RADIO) = (int)3;
	hx::Static(wx_menu_create) = ::wx::Loader_obj::load(HX_CSTRING("wx_menu_create"),(int)2);
	hx::Static(wx_menu_append) = ::wx::Loader_obj::load(HX_CSTRING("wx_menu_append"),(int)5);
	hx::Static(wx_menu_append_separator) = ::wx::Loader_obj::load(HX_CSTRING("wx_menu_append_separator"),(int)1);
}

} // end namespace wx
