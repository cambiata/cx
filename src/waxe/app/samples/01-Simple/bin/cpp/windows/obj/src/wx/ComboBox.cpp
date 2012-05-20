#include <hxcpp.h>

#ifndef INCLUDED_wx_ComboBox
#include <wx/ComboBox.h>
#endif
#ifndef INCLUDED_wx_ControlWithItems
#include <wx/ControlWithItems.h>
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

Void ComboBox_obj::__construct(Dynamic inHandle)
{
{
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ComboBox.hx",25)
	super::__construct(inHandle);
}
;
	return null();
}

ComboBox_obj::~ComboBox_obj() { }

Dynamic ComboBox_obj::__CreateEmpty() { return  new ComboBox_obj; }
hx::ObjectPtr< ComboBox_obj > ComboBox_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< ComboBox_obj > result = new ComboBox_obj();
	result->__construct(inHandle);
	return result;}

Dynamic ComboBox_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< ComboBox_obj > result = new ComboBox_obj();
	result->__construct(inArgs[0]);
	return result;}

Dynamic ComboBox_obj::setOnSelected( Dynamic f){
	HX_SOURCE_PUSH("ComboBox_obj::setOnSelected")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ComboBox.hx",30)
	this->setHandler(::wx::EventID_obj::COMMAND_COMBOBOX_SELECTED_dyn(),f);
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ComboBox.hx",30)
	return f;
}


HX_DEFINE_DYNAMIC_FUNC1(ComboBox_obj,setOnSelected,return )

Dynamic ComboBox_obj::setOnTextUpdated( Dynamic f){
	HX_SOURCE_PUSH("ComboBox_obj::setOnTextUpdated")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ComboBox.hx",32)
	this->setHandler(::wx::EventID_obj::COMMAND_TEXT_UPDATED_dyn(),f);
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ComboBox.hx",32)
	return f;
}


HX_DEFINE_DYNAMIC_FUNC1(ComboBox_obj,setOnTextUpdated,return )

Dynamic ComboBox_obj::setOnTextEnter( Dynamic f){
	HX_SOURCE_PUSH("ComboBox_obj::setOnTextEnter")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ComboBox.hx",34)
	this->setHandler(::wx::EventID_obj::COMMAND_TEXT_ENTER_dyn(),f);
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ComboBox.hx",34)
	return f;
}


HX_DEFINE_DYNAMIC_FUNC1(ComboBox_obj,setOnTextEnter,return )

::String ComboBox_obj::setValue( ::String inString){
	HX_SOURCE_PUSH("ComboBox_obj::setValue")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ComboBox.hx",48)
	::wx::ComboBox_obj::wx_combo_box_set_value(this->wxHandle,inString);
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ComboBox.hx",49)
	return inString;
}


HX_DEFINE_DYNAMIC_FUNC1(ComboBox_obj,setValue,return )

::String ComboBox_obj::getValue( ){
	HX_SOURCE_PUSH("ComboBox_obj::getValue")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ComboBox.hx",52)
	return ::wx::ComboBox_obj::wx_combo_box_get_value(this->wxHandle);
}


HX_DEFINE_DYNAMIC_FUNC0(ComboBox_obj,getValue,return )

::wx::ComboBox ComboBox_obj::create( ::wx::Window inParent,Dynamic inID,Dynamic __o_inValue,Dynamic inPosition,Dynamic inSize,Array< ::String > inChoices,Dynamic inStyle){
::String inValue = __o_inValue.Default(HX_CSTRING(""));
	HX_SOURCE_PUSH("ComboBox_obj::create");
{
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ComboBox.hx",16)
		if (((inParent == null()))){
			HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ComboBox.hx",17)
			hx::Throw (::wx::Error_obj::INVALID_PARENT);
		}
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ComboBox.hx",18)
		Dynamic handle = ::wx::ComboBox_obj::wx_combo_box_create(Dynamic( Array_obj<Dynamic>::__new().Add(inParent->wxHandle).Add(inID).Add(inValue).Add(inPosition).Add(inSize).Add(inStyle)),inChoices);
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ComboBox.hx",20)
		return ::wx::ComboBox_obj::__new(handle);
	}
}


STATIC_HX_DEFINE_DYNAMIC_FUNC7(ComboBox_obj,create,return )

Dynamic ComboBox_obj::wx_combo_box_create;

Dynamic ComboBox_obj::wx_combo_box_get_value;

Dynamic ComboBox_obj::wx_combo_box_set_value;


ComboBox_obj::ComboBox_obj()
{
}

void ComboBox_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(ComboBox);
	HX_MARK_MEMBER_NAME(onSelected,"onSelected");
	HX_MARK_MEMBER_NAME(onTextEnter,"onTextEnter");
	HX_MARK_MEMBER_NAME(onTextUpdated,"onTextUpdated");
	HX_MARK_MEMBER_NAME(value,"value");
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic ComboBox_obj::__Field(const ::String &inName)
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
	case 10:
		if (HX_FIELD_EQ(inName,"onSelected") ) { return onSelected; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"onTextEnter") ) { return onTextEnter; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"onTextUpdated") ) { return onTextUpdated; }
		if (HX_FIELD_EQ(inName,"setOnSelected") ) { return setOnSelected_dyn(); }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"setOnTextEnter") ) { return setOnTextEnter_dyn(); }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"setOnTextUpdated") ) { return setOnTextUpdated_dyn(); }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"wx_combo_box_create") ) { return wx_combo_box_create; }
		break;
	case 22:
		if (HX_FIELD_EQ(inName,"wx_combo_box_get_value") ) { return wx_combo_box_get_value; }
		if (HX_FIELD_EQ(inName,"wx_combo_box_set_value") ) { return wx_combo_box_set_value; }
	}
	return super::__Field(inName);
}

Dynamic ComboBox_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"value") ) { return setValue(inValue); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"onSelected") ) { return setOnSelected(inValue); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"onTextEnter") ) { return setOnTextEnter(inValue); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"onTextUpdated") ) { return setOnTextUpdated(inValue); }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"wx_combo_box_create") ) { wx_combo_box_create=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 22:
		if (HX_FIELD_EQ(inName,"wx_combo_box_get_value") ) { wx_combo_box_get_value=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_combo_box_set_value") ) { wx_combo_box_set_value=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue);
}

void ComboBox_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("value"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("create"),
	HX_CSTRING("wx_combo_box_create"),
	HX_CSTRING("wx_combo_box_get_value"),
	HX_CSTRING("wx_combo_box_set_value"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("onSelected"),
	HX_CSTRING("onTextEnter"),
	HX_CSTRING("onTextUpdated"),
	HX_CSTRING("setOnSelected"),
	HX_CSTRING("setOnTextUpdated"),
	HX_CSTRING("setOnTextEnter"),
	HX_CSTRING("value"),
	HX_CSTRING("setValue"),
	HX_CSTRING("getValue"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(ComboBox_obj::wx_combo_box_create,"wx_combo_box_create");
	HX_MARK_MEMBER_NAME(ComboBox_obj::wx_combo_box_get_value,"wx_combo_box_get_value");
	HX_MARK_MEMBER_NAME(ComboBox_obj::wx_combo_box_set_value,"wx_combo_box_set_value");
};

Class ComboBox_obj::__mClass;

void ComboBox_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.ComboBox"), hx::TCanCast< ComboBox_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void ComboBox_obj::__boot()
{
	hx::Static(wx_combo_box_create) = ::wx::Loader_obj::load(HX_CSTRING("wx_combo_box_create"),(int)2);
	hx::Static(wx_combo_box_get_value) = ::wx::Loader_obj::load(HX_CSTRING("wx_combo_box_get_value"),(int)1);
	hx::Static(wx_combo_box_set_value) = ::wx::Loader_obj::load(HX_CSTRING("wx_combo_box_set_value"),(int)2);
}

} // end namespace wx
