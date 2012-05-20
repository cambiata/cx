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
{
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/TextCtrl.hx",22)
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

::String TextCtrl_obj::setValue( ::String inString){
	HX_SOURCE_PUSH("TextCtrl_obj::setValue")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/TextCtrl.hx",28)
	::wx::TextCtrl_obj::wx_text_ctrl_set_value(this->wxHandle,inString);
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/TextCtrl.hx",29)
	return inString;
}


HX_DEFINE_DYNAMIC_FUNC1(TextCtrl_obj,setValue,return )

::String TextCtrl_obj::getValue( ){
	HX_SOURCE_PUSH("TextCtrl_obj::getValue")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/TextCtrl.hx",32)
	return ::wx::TextCtrl_obj::wx_text_ctrl_get_value(this->wxHandle);
}


HX_DEFINE_DYNAMIC_FUNC0(TextCtrl_obj,getValue,return )

Dynamic TextCtrl_obj::setOnTextUpdated( Dynamic f){
	HX_SOURCE_PUSH("TextCtrl_obj::setOnTextUpdated")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/TextCtrl.hx",38)
	this->setHandler(::wx::EventID_obj::COMMAND_TEXT_UPDATED_dyn(),f);
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/TextCtrl.hx",38)
	return f;
}


HX_DEFINE_DYNAMIC_FUNC1(TextCtrl_obj,setOnTextUpdated,return )

::wx::TextCtrl TextCtrl_obj::create( ::wx::Window inParent,Dynamic inID,Dynamic __o_inText,Dynamic inPosition,Dynamic inSize,Dynamic inStyle){
::String inText = __o_inText.Default(HX_CSTRING(""));
	HX_SOURCE_PUSH("TextCtrl_obj::create");
{
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/TextCtrl.hx",13)
		if (((inParent == null()))){
			HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/TextCtrl.hx",14)
			hx::Throw (::wx::Error_obj::INVALID_PARENT);
		}
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/TextCtrl.hx",15)
		Dynamic handle = ::wx::TextCtrl_obj::wx_text_ctrl_create(Dynamic( Array_obj<Dynamic>::__new().Add(inParent->wxHandle).Add(inID).Add(inText).Add(inPosition).Add(inSize).Add(inStyle)));
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/TextCtrl.hx",17)
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
	HX_MARK_MEMBER_NAME(value,"value");
	HX_MARK_MEMBER_NAME(onTextUpdated,"onTextUpdated");
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic TextCtrl_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"value") ) { return getValue(); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return create_dyn(); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"setValue") ) { return setValue_dyn(); }
		if (HX_FIELD_EQ(inName,"getValue") ) { return getValue_dyn(); }
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
	return super::__Field(inName);
}

Dynamic TextCtrl_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"value") ) { return setValue(inValue); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"onTextUpdated") ) { return setOnTextUpdated(inValue); }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"wx_text_ctrl_create") ) { wx_text_ctrl_create=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 22:
		if (HX_FIELD_EQ(inName,"wx_text_ctrl_get_value") ) { wx_text_ctrl_get_value=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_text_ctrl_set_value") ) { wx_text_ctrl_set_value=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue);
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
	HX_CSTRING("value"),
	HX_CSTRING("setValue"),
	HX_CSTRING("getValue"),
	HX_CSTRING("onTextUpdated"),
	HX_CSTRING("setOnTextUpdated"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(TextCtrl_obj::wx_text_ctrl_create,"wx_text_ctrl_create");
	HX_MARK_MEMBER_NAME(TextCtrl_obj::wx_text_ctrl_get_value,"wx_text_ctrl_get_value");
	HX_MARK_MEMBER_NAME(TextCtrl_obj::wx_text_ctrl_set_value,"wx_text_ctrl_set_value");
};

Class TextCtrl_obj::__mClass;

void TextCtrl_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.TextCtrl"), hx::TCanCast< TextCtrl_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void TextCtrl_obj::__boot()
{
	hx::Static(wx_text_ctrl_create) = ::wx::Loader_obj::load(HX_CSTRING("wx_text_ctrl_create"),(int)1);
	hx::Static(wx_text_ctrl_get_value) = ::wx::Loader_obj::load(HX_CSTRING("wx_text_ctrl_get_value"),(int)1);
	hx::Static(wx_text_ctrl_set_value) = ::wx::Loader_obj::load(HX_CSTRING("wx_text_ctrl_set_value"),(int)2);
}

} // end namespace wx
