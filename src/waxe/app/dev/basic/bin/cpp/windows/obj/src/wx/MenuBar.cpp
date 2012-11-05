#include <hxcpp.h>

#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
#ifndef INCLUDED_wx_Menu
#include <wx/Menu.h>
#endif
#ifndef INCLUDED_wx_MenuBar
#include <wx/MenuBar.h>
#endif
namespace wx{

Void MenuBar_obj::__construct()
{
HX_STACK_PUSH("MenuBar::new","wx/MenuBar.hx",6);
{
	HX_STACK_LINE(6)
	super::__construct(::wx::MenuBar_obj::wx_menu_bar_create());
}
;
	return null();
}

MenuBar_obj::~MenuBar_obj() { }

Dynamic MenuBar_obj::__CreateEmpty() { return  new MenuBar_obj; }
hx::ObjectPtr< MenuBar_obj > MenuBar_obj::__new()
{  hx::ObjectPtr< MenuBar_obj > result = new MenuBar_obj();
	result->__construct();
	return result;}

Dynamic MenuBar_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< MenuBar_obj > result = new MenuBar_obj();
	result->__construct();
	return result;}

Void MenuBar_obj::append( ::wx::Menu inMenu,::String inTitle){
{
		HX_STACK_PUSH("MenuBar::append","wx/MenuBar.hx",14);
		HX_STACK_THIS(this);
		HX_STACK_ARG(inMenu,"inMenu");
		HX_STACK_ARG(inTitle,"inTitle");
		HX_STACK_LINE(14)
		::wx::MenuBar_obj::wx_menu_bar_append(this->wxHandle,inMenu->wxHandle,inTitle);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC2(MenuBar_obj,append,(void))

Void MenuBar_obj::HandleEvent( Dynamic event){
{
		HX_STACK_PUSH("MenuBar::HandleEvent","wx/MenuBar.hx",11);
		HX_STACK_THIS(this);
		HX_STACK_ARG(event,"event");
	}
return null();
}


Dynamic MenuBar_obj::wx_menu_bar_create;

Dynamic MenuBar_obj::wx_menu_bar_append;


MenuBar_obj::MenuBar_obj()
{
}

void MenuBar_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(MenuBar);
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void MenuBar_obj::__Visit(HX_VISIT_PARAMS)
{
	super::__Visit(HX_VISIT_ARG);
}

Dynamic MenuBar_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"append") ) { return append_dyn(); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"HandleEvent") ) { return HandleEvent_dyn(); }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"wx_menu_bar_create") ) { return wx_menu_bar_create; }
		if (HX_FIELD_EQ(inName,"wx_menu_bar_append") ) { return wx_menu_bar_append; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic MenuBar_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 18:
		if (HX_FIELD_EQ(inName,"wx_menu_bar_create") ) { wx_menu_bar_create=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_menu_bar_append") ) { wx_menu_bar_append=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void MenuBar_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("wx_menu_bar_create"),
	HX_CSTRING("wx_menu_bar_append"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("append"),
	HX_CSTRING("HandleEvent"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(MenuBar_obj::__mClass,"__mClass");
	HX_MARK_MEMBER_NAME(MenuBar_obj::wx_menu_bar_create,"wx_menu_bar_create");
	HX_MARK_MEMBER_NAME(MenuBar_obj::wx_menu_bar_append,"wx_menu_bar_append");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(MenuBar_obj::__mClass,"__mClass");
	HX_VISIT_MEMBER_NAME(MenuBar_obj::wx_menu_bar_create,"wx_menu_bar_create");
	HX_VISIT_MEMBER_NAME(MenuBar_obj::wx_menu_bar_append,"wx_menu_bar_append");
};

Class MenuBar_obj::__mClass;

void MenuBar_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.MenuBar"), hx::TCanCast< MenuBar_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void MenuBar_obj::__boot()
{
	wx_menu_bar_create= ::wx::Loader_obj::load(HX_CSTRING("wx_menu_bar_create"),(int)0);
	wx_menu_bar_append= ::wx::Loader_obj::load(HX_CSTRING("wx_menu_bar_append"),(int)3);
}

} // end namespace wx
