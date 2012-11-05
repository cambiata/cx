#include <hxcpp.h>

#ifndef INCLUDED_wx_Error
#include <wx/Error.h>
#endif
#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
#ifndef INCLUDED_wx_Panel
#include <wx/Panel.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif
namespace wx{

Void Panel_obj::__construct(Dynamic inHandle)
{
HX_STACK_PUSH("Panel::new","wx/Panel.hx",5);
{
	HX_STACK_LINE(5)
	super::__construct(inHandle);
}
;
	return null();
}

Panel_obj::~Panel_obj() { }

Dynamic Panel_obj::__CreateEmpty() { return  new Panel_obj; }
hx::ObjectPtr< Panel_obj > Panel_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< Panel_obj > result = new Panel_obj();
	result->__construct(inHandle);
	return result;}

Dynamic Panel_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Panel_obj > result = new Panel_obj();
	result->__construct(inArgs[0]);
	return result;}

::wx::Panel Panel_obj::create( ::wx::Window inParent,Dynamic inID,Dynamic inPosition,Dynamic inSize,Dynamic inStyle){
	HX_STACK_PUSH("Panel::create","wx/Panel.hx",10);
	HX_STACK_ARG(inParent,"inParent");
	HX_STACK_ARG(inID,"inID");
	HX_STACK_ARG(inPosition,"inPosition");
	HX_STACK_ARG(inSize,"inSize");
	HX_STACK_ARG(inStyle,"inStyle");
	HX_STACK_LINE(11)
	if (((inParent == null()))){
		HX_STACK_LINE(12)
		hx::Throw (::wx::Error_obj::INVALID_PARENT);
	}
	HX_STACK_LINE(13)
	Dynamic handle = ::wx::Panel_obj::wx_panel_create(Dynamic( Array_obj<Dynamic>::__new().Add(inParent->wxHandle).Add(inID).Add(HX_CSTRING("")).Add(inPosition).Add(inSize).Add(inStyle)));		HX_STACK_VAR(handle,"handle");
	HX_STACK_LINE(15)
	return ::wx::Panel_obj::__new(handle);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC5(Panel_obj,create,return )

Dynamic Panel_obj::wx_panel_create;


Panel_obj::Panel_obj()
{
}

void Panel_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Panel);
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void Panel_obj::__Visit(HX_VISIT_PARAMS)
{
	super::__Visit(HX_VISIT_ARG);
}

Dynamic Panel_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return create_dyn(); }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"wx_panel_create") ) { return wx_panel_create; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic Panel_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 15:
		if (HX_FIELD_EQ(inName,"wx_panel_create") ) { wx_panel_create=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void Panel_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("create"),
	HX_CSTRING("wx_panel_create"),
	String(null()) };

static ::String sMemberFields[] = {
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Panel_obj::__mClass,"__mClass");
	HX_MARK_MEMBER_NAME(Panel_obj::wx_panel_create,"wx_panel_create");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Panel_obj::__mClass,"__mClass");
	HX_VISIT_MEMBER_NAME(Panel_obj::wx_panel_create,"wx_panel_create");
};

Class Panel_obj::__mClass;

void Panel_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.Panel"), hx::TCanCast< Panel_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void Panel_obj::__boot()
{
	wx_panel_create= ::wx::Loader_obj::load(HX_CSTRING("wx_panel_create"),(int)1);
}

} // end namespace wx
