#include <hxcpp.h>

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
#ifndef INCLUDED_wx_TextCtrl
#include <wx/TextCtrl.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif
namespace wx{

Void TextCtrl_obj::__construct(Dynamic inHandle)
{
HX_STACK_PUSH("TextCtrl::new","wx/TextCtrl.hx",22);
{
	HX_STACK_LINE(22)
	super::__construct(inHandle);
}
;
	return null();
}

TextCtrl_obj::~TextCtrl_obj() { }

Dynamic TextCtrl_obj::__CreateEmpty() { return  new TextCtrl_obj; }
hx::ObjectPtr< TextCtrl_obj > TextCtrl_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< TextCtrl_obj > result = new TextCtrl_obj();
	result->__construct(inHandle);
	return result;}

Dynamic TextCtrl_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< TextCtrl_obj > result = new TextCtrl_obj();
	result->__construct(inArgs[0]);
	return result;}

Dynamic TextCtrl_obj::setOnTextUpdated( Dynamic f){
	HX_STACK_PUSH("TextCtrl::setOnTextUpdated","wx/TextCtrl.hx",44);
	HX_STACK_THIS(this);
	HX_STACK_ARG(f,"f");
	HX_STACK_LINE(44)
	this->setHandler(::wx::EventID_obj::COMMAND_TEXT_UPDATED_dyn(),f);
	HX_STACK_LINE(44)
	return f;
}


HX_DEFINE_DYNAMIC_FUNC1(TextCtrl_obj,setOnTextUpdated,return )

::String TextCtrl_obj::getValue( ){
	HX_STACK_PUSH("TextCtrl::getValue","wx/TextCtrl.hx",32);
	HX_STACK_THIS(this);
	HX_STACK_LINE(32)
	return ::wx::TextCtrl_obj::wx_text_ctrl_get_value(this->wxHandle);
}


HX_DEFINE_DYNAMIC_FUNC0(TextCtrl_obj,getValue,return )

::String TextCtrl_obj::setValue( ::String inString){
	HX_STACK_PUSH("TextCtrl::setValue","wx/TextCtrl.hx",27);
	HX_STACK_THIS(this);
	HX_STACK_ARG(inString,"inString");
	HX_STACK_LINE(28)
	::wx::TextCtrl_obj::wx_text_ctrl_set_value(this->wxHandle,inString);
	HX_STACK_LINE(29)
	return inString;
}


HX_DEFINE_DYNAMIC_FUNC1(TextCtrl_obj,setValue,return )

::wx::TextCtrl TextCtrl_obj::create( ::wx::Window inParent,Dynamic inID,::String __o_inText,Dynamic inPosition,Dynamic inSize,Dynamic inStyle){
::String inText = __o_inText.Default(HX_CSTRING(""));
	HX_STACK_PUSH("TextCtrl::create","wx/TextCtrl.hx",12);
	HX_STACK_ARG(inParent,"inParent");
	HX_STACK_ARG(inID,"inID");
	HX_STACK_ARG(inText,"inText");
	HX_STACK_ARG(inPosition,"inPosition");
	HX_STACK_ARG(inSize,"inSize");
	HX_STACK_ARG(inStyle,"inStyle");
{
		HX_STACK_LINE(13)
		if (((inParent == null()))){
			HX_STACK_LINE(14)
			hx::Throw (::wx::Error_obj::INVALID_PARENT);
		}
		HX_STACK_LINE(15)
		Dynamic handle = ::wx::TextCtrl_obj::wx_text_ctrl_create(Dynamic( Array_obj<Dynamic>::__new().Add(inParent->wxHandle).Add(inID).Add(inText).Add(inPosition).Add(inSize).Add(inStyle)));		HX_STACK_VAR(handle,"handle");
		HX_STACK_LINE(17)
		return ::wx::TextCtrl_obj::__new(handle);
	}
}


STATIC_HX_DEFINE_DYNAMIC_FUNC6(TextCtrl_obj,create,return )

Dynamic TextCtrl_obj::wx_text_ctrl_create;

Dynamic TextCtrl_obj::wx_text_ctrl_get_value;

Dynamic TextCtrl_obj::wx_text_ctrl_set_value;


TextCtrl_obj::TextCtrl_obj()
{
}

void TextCtrl_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(TextCtrl);
	HX_MARK_MEMBER_NAME(onTextUpdated,"onTextUpdated");
	HX_MARK_MEMBER_NAME(value,"value");
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void TextCtrl_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(onTextUpdated,"onTextUpdated");
	HX_VISIT_MEMBER_NAME(value,"value");
	super::__Visit(HX_VISIT_ARG);
}

Dynamic TextCtrl_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"value") ) { return inCallProp ? getValue() : value; }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return create_dyn(); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"getValue") ) { return getValue_dyn(); }
		if (HX_FIELD_EQ(inName,"setValue") ) { return setValue_dyn(); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"onTextUpdated") ) { return onTextUpdated; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"setOnTextUpdated") ) { return setOnTextUpdated_dyn(); }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"wx_text_ctrl_create") ) { return wx_text_ctrl_create; }
		break;
	case 22:
		if (HX_FIELD_EQ(inName,"wx_text_ctrl_get_value") ) { return wx_text_ctrl_get_value; }
		if (HX_FIELD_EQ(inName,"wx_text_ctrl_set_value") ) { return wx_text_ctrl_set_value; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic TextCtrl_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"value") ) { if (inCallProp) return setValue(inValue);value=inValue.Cast< ::String >(); return inValue; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"onTextUpdated") ) { if (inCallProp) return setOnTextUpdated(inValue);onTextUpdated=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"wx_text_ctrl_create") ) { wx_text_ctrl_create=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 22:
		if (HX_FIELD_EQ(inName,"wx_text_ctrl_get_value") ) { wx_text_ctrl_get_value=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_text_ctrl_set_value") ) { wx_text_ctrl_set_value=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void TextCtrl_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("value"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("create"),
	HX_CSTRING("wx_text_ctrl_create"),
	HX_CSTRING("wx_text_ctrl_get_value"),
	HX_CSTRING("wx_text_ctrl_set_value"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("setOnTextUpdated"),
	HX_CSTRING("onTextUpdated"),
	HX_CSTRING("getValue"),
	HX_CSTRING("setValue"),
	HX_CSTRING("value"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(TextCtrl_obj::__mClass,"__mClass");
	HX_MARK_MEMBER_NAME(TextCtrl_obj::wx_text_ctrl_create,"wx_text_ctrl_create");
	HX_MARK_MEMBER_NAME(TextCtrl_obj::wx_text_ctrl_get_value,"wx_text_ctrl_get_value");
	HX_MARK_MEMBER_NAME(TextCtrl_obj::wx_text_ctrl_set_value,"wx_text_ctrl_set_value");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(TextCtrl_obj::__mClass,"__mClass");
	HX_VISIT_MEMBER_NAME(TextCtrl_obj::wx_text_ctrl_create,"wx_text_ctrl_create");
	HX_VISIT_MEMBER_NAME(TextCtrl_obj::wx_text_ctrl_get_value,"wx_text_ctrl_get_value");
	HX_VISIT_MEMBER_NAME(TextCtrl_obj::wx_text_ctrl_set_value,"wx_text_ctrl_set_value");
};

Class TextCtrl_obj::__mClass;

void TextCtrl_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.TextCtrl"), hx::TCanCast< TextCtrl_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void TextCtrl_obj::__boot()
{
	wx_text_ctrl_create= ::wx::Loader_obj::load(HX_CSTRING("wx_text_ctrl_create"),(int)1);
	wx_text_ctrl_get_value= ::wx::Loader_obj::load(HX_CSTRING("wx_text_ctrl_get_value"),(int)1);
	wx_text_ctrl_set_value= ::wx::Loader_obj::load(HX_CSTRING("wx_text_ctrl_set_value"),(int)2);
}

} // end namespace wx
