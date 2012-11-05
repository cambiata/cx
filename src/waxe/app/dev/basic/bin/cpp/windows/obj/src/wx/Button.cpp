#include <hxcpp.h>

#ifndef INCLUDED_wx_Button
#include <wx/Button.h>
#endif
#ifndef INCLUDED_wx_Error
#include <wx/Error.h>
#endif
#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_EventID
#include <wx/EventID.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif
namespace wx{

Void Button_obj::__construct(Dynamic inHandle)
{
HX_STACK_PUSH("Button::new","wx/Button.hx",23);
{
	HX_STACK_LINE(23)
	super::__construct(inHandle);
}
;
	return null();
}

Button_obj::~Button_obj() { }

Dynamic Button_obj::__CreateEmpty() { return  new Button_obj; }
hx::ObjectPtr< Button_obj > Button_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< Button_obj > result = new Button_obj();
	result->__construct(inHandle);
	return result;}

Dynamic Button_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Button_obj > result = new Button_obj();
	result->__construct(inArgs[0]);
	return result;}

::String Button_obj::getLabel( ){
	HX_STACK_PUSH("Button::getLabel","wx/Button.hx",35);
	HX_STACK_THIS(this);
	HX_STACK_LINE(35)
	return ::wx::Button_obj::wx_button_get_label(this->wxHandle);
}


HX_DEFINE_DYNAMIC_FUNC0(Button_obj,getLabel,return )

::String Button_obj::setLabel( ::String inString){
	HX_STACK_PUSH("Button::setLabel","wx/Button.hx",30);
	HX_STACK_THIS(this);
	HX_STACK_ARG(inString,"inString");
	HX_STACK_LINE(31)
	::wx::Button_obj::wx_button_set_label(this->wxHandle,inString);
	HX_STACK_LINE(32)
	return inString;
}


HX_DEFINE_DYNAMIC_FUNC1(Button_obj,setLabel,return )

Dynamic Button_obj::setOnClick( Dynamic f){
	HX_STACK_PUSH("Button::setOnClick","wx/Button.hx",27);
	HX_STACK_THIS(this);
	HX_STACK_ARG(f,"f");
	HX_STACK_LINE(27)
	this->setHandler(::wx::EventID_obj::COMMAND_BUTTON_CLICKED_dyn(),f);
	HX_STACK_LINE(27)
	return f;
}


HX_DEFINE_DYNAMIC_FUNC1(Button_obj,setOnClick,return )

::wx::Button Button_obj::create( ::wx::Window inParent,Dynamic inID,::String __o_inLabel,Dynamic inPosition,Dynamic inSize,Dynamic inStyle){
::String inLabel = __o_inLabel.Default(HX_CSTRING(""));
	HX_STACK_PUSH("Button::create","wx/Button.hx",13);
	HX_STACK_ARG(inParent,"inParent");
	HX_STACK_ARG(inID,"inID");
	HX_STACK_ARG(inLabel,"inLabel");
	HX_STACK_ARG(inPosition,"inPosition");
	HX_STACK_ARG(inSize,"inSize");
	HX_STACK_ARG(inStyle,"inStyle");
{
		HX_STACK_LINE(14)
		if (((inParent == null()))){
			HX_STACK_LINE(15)
			hx::Throw (::wx::Error_obj::INVALID_PARENT);
		}
		HX_STACK_LINE(16)
		Dynamic handle = ::wx::Button_obj::wx_button_create(Dynamic( Array_obj<Dynamic>::__new().Add(inParent->wxHandle).Add(inID).Add(inLabel).Add(inPosition).Add(inSize).Add(inStyle)));		HX_STACK_VAR(handle,"handle");
		HX_STACK_LINE(18)
		return ::wx::Button_obj::__new(handle);
	}
}


STATIC_HX_DEFINE_DYNAMIC_FUNC6(Button_obj,create,return )

Dynamic Button_obj::wx_button_create;

Dynamic Button_obj::wx_button_get_label;

Dynamic Button_obj::wx_button_set_label;


Button_obj::Button_obj()
{
}

void Button_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Button);
	HX_MARK_MEMBER_NAME(onClick,"onClick");
	HX_MARK_MEMBER_NAME(label,"label");
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void Button_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(onClick,"onClick");
	HX_VISIT_MEMBER_NAME(label,"label");
	super::__Visit(HX_VISIT_ARG);
}

Dynamic Button_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"label") ) { return inCallProp ? getLabel() : label; }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return create_dyn(); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"onClick") ) { return onClick; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"getLabel") ) { return getLabel_dyn(); }
		if (HX_FIELD_EQ(inName,"setLabel") ) { return setLabel_dyn(); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"setOnClick") ) { return setOnClick_dyn(); }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"wx_button_create") ) { return wx_button_create; }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"wx_button_get_label") ) { return wx_button_get_label; }
		if (HX_FIELD_EQ(inName,"wx_button_set_label") ) { return wx_button_set_label; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic Button_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"label") ) { if (inCallProp) return setLabel(inValue);label=inValue.Cast< ::String >(); return inValue; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"onClick") ) { if (inCallProp) return setOnClick(inValue);onClick=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"wx_button_create") ) { wx_button_create=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"wx_button_get_label") ) { wx_button_get_label=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_button_set_label") ) { wx_button_set_label=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void Button_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("label"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("create"),
	HX_CSTRING("wx_button_create"),
	HX_CSTRING("wx_button_get_label"),
	HX_CSTRING("wx_button_set_label"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("getLabel"),
	HX_CSTRING("setLabel"),
	HX_CSTRING("setOnClick"),
	HX_CSTRING("onClick"),
	HX_CSTRING("label"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Button_obj::__mClass,"__mClass");
	HX_MARK_MEMBER_NAME(Button_obj::wx_button_create,"wx_button_create");
	HX_MARK_MEMBER_NAME(Button_obj::wx_button_get_label,"wx_button_get_label");
	HX_MARK_MEMBER_NAME(Button_obj::wx_button_set_label,"wx_button_set_label");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Button_obj::__mClass,"__mClass");
	HX_VISIT_MEMBER_NAME(Button_obj::wx_button_create,"wx_button_create");
	HX_VISIT_MEMBER_NAME(Button_obj::wx_button_get_label,"wx_button_get_label");
	HX_VISIT_MEMBER_NAME(Button_obj::wx_button_set_label,"wx_button_set_label");
};

Class Button_obj::__mClass;

void Button_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.Button"), hx::TCanCast< Button_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void Button_obj::__boot()
{
	wx_button_create= ::wx::Loader_obj::load(HX_CSTRING("wx_button_create"),(int)1);
	wx_button_get_label= ::wx::Loader_obj::load(HX_CSTRING("wx_button_get_label"),(int)1);
	wx_button_set_label= ::wx::Loader_obj::load(HX_CSTRING("wx_button_set_label"),(int)2);
}

} // end namespace wx
