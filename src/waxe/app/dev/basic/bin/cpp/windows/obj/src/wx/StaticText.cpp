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
#ifndef INCLUDED_wx_StaticText
#include <wx/StaticText.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif
namespace wx{

Void StaticText_obj::__construct(Dynamic inHandle)
{
HX_STACK_PUSH("StaticText::new","wx/StaticText.hx",22);
{
	HX_STACK_LINE(22)
	super::__construct(inHandle);
}
;
	return null();
}

StaticText_obj::~StaticText_obj() { }

Dynamic StaticText_obj::__CreateEmpty() { return  new StaticText_obj; }
hx::ObjectPtr< StaticText_obj > StaticText_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< StaticText_obj > result = new StaticText_obj();
	result->__construct(inHandle);
	return result;}

Dynamic StaticText_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< StaticText_obj > result = new StaticText_obj();
	result->__construct(inArgs[0]);
	return result;}

::String StaticText_obj::getLabel( ){
	HX_STACK_PUSH("StaticText::getLabel","wx/StaticText.hx",32);
	HX_STACK_THIS(this);
	HX_STACK_LINE(32)
	return ::wx::StaticText_obj::wx_static_text_get_label(this->wxHandle);
}


HX_DEFINE_DYNAMIC_FUNC0(StaticText_obj,getLabel,return )

::String StaticText_obj::setLabel( ::String inString){
	HX_STACK_PUSH("StaticText::setLabel","wx/StaticText.hx",27);
	HX_STACK_THIS(this);
	HX_STACK_ARG(inString,"inString");
	HX_STACK_LINE(28)
	::wx::StaticText_obj::wx_static_text_set_label(this->wxHandle,inString);
	HX_STACK_LINE(29)
	return inString;
}


HX_DEFINE_DYNAMIC_FUNC1(StaticText_obj,setLabel,return )

::wx::StaticText StaticText_obj::create( ::wx::Window inParent,Dynamic inID,::String __o_inText,Dynamic inPosition,Dynamic inSize,Dynamic inStyle){
::String inText = __o_inText.Default(HX_CSTRING(""));
	HX_STACK_PUSH("StaticText::create","wx/StaticText.hx",12);
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
		Dynamic handle = ::wx::StaticText_obj::wx_static_text_create(Dynamic( Array_obj<Dynamic>::__new().Add(inParent->wxHandle).Add(inID).Add(inText).Add(inPosition).Add(inSize).Add(inStyle)));		HX_STACK_VAR(handle,"handle");
		HX_STACK_LINE(17)
		return ::wx::StaticText_obj::__new(handle);
	}
}


STATIC_HX_DEFINE_DYNAMIC_FUNC6(StaticText_obj,create,return )

Dynamic StaticText_obj::wx_static_text_create;

Dynamic StaticText_obj::wx_static_text_get_label;

Dynamic StaticText_obj::wx_static_text_set_label;


StaticText_obj::StaticText_obj()
{
}

void StaticText_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(StaticText);
	HX_MARK_MEMBER_NAME(label,"label");
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void StaticText_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(label,"label");
	super::__Visit(HX_VISIT_ARG);
}

Dynamic StaticText_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"label") ) { return inCallProp ? getLabel() : label; }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return create_dyn(); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"getLabel") ) { return getLabel_dyn(); }
		if (HX_FIELD_EQ(inName,"setLabel") ) { return setLabel_dyn(); }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"wx_static_text_create") ) { return wx_static_text_create; }
		break;
	case 24:
		if (HX_FIELD_EQ(inName,"wx_static_text_get_label") ) { return wx_static_text_get_label; }
		if (HX_FIELD_EQ(inName,"wx_static_text_set_label") ) { return wx_static_text_set_label; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic StaticText_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"label") ) { if (inCallProp) return setLabel(inValue);label=inValue.Cast< ::String >(); return inValue; }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"wx_static_text_create") ) { wx_static_text_create=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 24:
		if (HX_FIELD_EQ(inName,"wx_static_text_get_label") ) { wx_static_text_get_label=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_static_text_set_label") ) { wx_static_text_set_label=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void StaticText_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("label"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("create"),
	HX_CSTRING("wx_static_text_create"),
	HX_CSTRING("wx_static_text_get_label"),
	HX_CSTRING("wx_static_text_set_label"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("getLabel"),
	HX_CSTRING("setLabel"),
	HX_CSTRING("label"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(StaticText_obj::__mClass,"__mClass");
	HX_MARK_MEMBER_NAME(StaticText_obj::wx_static_text_create,"wx_static_text_create");
	HX_MARK_MEMBER_NAME(StaticText_obj::wx_static_text_get_label,"wx_static_text_get_label");
	HX_MARK_MEMBER_NAME(StaticText_obj::wx_static_text_set_label,"wx_static_text_set_label");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(StaticText_obj::__mClass,"__mClass");
	HX_VISIT_MEMBER_NAME(StaticText_obj::wx_static_text_create,"wx_static_text_create");
	HX_VISIT_MEMBER_NAME(StaticText_obj::wx_static_text_get_label,"wx_static_text_get_label");
	HX_VISIT_MEMBER_NAME(StaticText_obj::wx_static_text_set_label,"wx_static_text_set_label");
};

Class StaticText_obj::__mClass;

void StaticText_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.StaticText"), hx::TCanCast< StaticText_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void StaticText_obj::__boot()
{
	wx_static_text_create= ::wx::Loader_obj::load(HX_CSTRING("wx_static_text_create"),(int)1);
	wx_static_text_get_label= ::wx::Loader_obj::load(HX_CSTRING("wx_static_text_get_label"),(int)1);
	wx_static_text_set_label= ::wx::Loader_obj::load(HX_CSTRING("wx_static_text_set_label"),(int)2);
}

} // end namespace wx
