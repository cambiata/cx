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
HX_STACK_PUSH("ComboBox::new","wx/ComboBox.hx",25);
{
	HX_STACK_LINE(25)
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

Dynamic ComboBox_obj::setOnTextEnter( Dynamic f){
	HX_STACK_PUSH("ComboBox::setOnTextEnter","wx/ComboBox.hx",34);
	HX_STACK_THIS(this);
	HX_STACK_ARG(f,"f");
	HX_STACK_LINE(34)
	this->setHandler(::wx::EventID_obj::COMMAND_TEXT_ENTER_dyn(),f);
	HX_STACK_LINE(34)
	return f;
}


HX_DEFINE_DYNAMIC_FUNC1(ComboBox_obj,setOnTextEnter,return )

Dynamic ComboBox_obj::setOnTextUpdated( Dynamic f){
	HX_STACK_PUSH("ComboBox::setOnTextUpdated","wx/ComboBox.hx",32);
	HX_STACK_THIS(this);
	HX_STACK_ARG(f,"f");
	HX_STACK_LINE(32)
	this->setHandler(::wx::EventID_obj::COMMAND_TEXT_UPDATED_dyn(),f);
	HX_STACK_LINE(32)
	return f;
}


HX_DEFINE_DYNAMIC_FUNC1(ComboBox_obj,setOnTextUpdated,return )

Dynamic ComboBox_obj::setOnSelected( Dynamic f){
	HX_STACK_PUSH("ComboBox::setOnSelected","wx/ComboBox.hx",30);
	HX_STACK_THIS(this);
	HX_STACK_ARG(f,"f");
	HX_STACK_LINE(30)
	this->setHandler(::wx::EventID_obj::COMMAND_COMBOBOX_SELECTED_dyn(),f);
	HX_STACK_LINE(30)
	return f;
}


HX_DEFINE_DYNAMIC_FUNC1(ComboBox_obj,setOnSelected,return )

::wx::ComboBox ComboBox_obj::create( ::wx::Window inParent,Dynamic inID,::String __o_inValue,Dynamic inPosition,Dynamic inSize,Array< ::String > inChoices,Dynamic inStyle){
::String inValue = __o_inValue.Default(HX_CSTRING(""));
	HX_STACK_PUSH("ComboBox::create","wx/ComboBox.hx",15);
	HX_STACK_ARG(inParent,"inParent");
	HX_STACK_ARG(inID,"inID");
	HX_STACK_ARG(inValue,"inValue");
	HX_STACK_ARG(inPosition,"inPosition");
	HX_STACK_ARG(inSize,"inSize");
	HX_STACK_ARG(inChoices,"inChoices");
	HX_STACK_ARG(inStyle,"inStyle");
{
		HX_STACK_LINE(16)
		if (((inParent == null()))){
			HX_STACK_LINE(17)
			hx::Throw (::wx::Error_obj::INVALID_PARENT);
		}
		HX_STACK_LINE(18)
		Dynamic handle = ::wx::ComboBox_obj::wx_combo_box_create(Dynamic( Array_obj<Dynamic>::__new().Add(inParent->wxHandle).Add(inID).Add(inValue).Add(inPosition).Add(inSize).Add(inStyle)),inChoices);		HX_STACK_VAR(handle,"handle");
		HX_STACK_LINE(20)
		return ::wx::ComboBox_obj::__new(handle);
	}
}


STATIC_HX_DEFINE_DYNAMIC_FUNC7(ComboBox_obj,create,return )

Dynamic ComboBox_obj::wx_combo_box_create;


ComboBox_obj::ComboBox_obj()
{
}

void ComboBox_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(ComboBox);
	HX_MARK_MEMBER_NAME(onTextUpdated,"onTextUpdated");
	HX_MARK_MEMBER_NAME(onTextEnter,"onTextEnter");
	HX_MARK_MEMBER_NAME(onSelected,"onSelected");
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void ComboBox_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(onTextUpdated,"onTextUpdated");
	HX_VISIT_MEMBER_NAME(onTextEnter,"onTextEnter");
	HX_VISIT_MEMBER_NAME(onSelected,"onSelected");
	super::__Visit(HX_VISIT_ARG);
}

Dynamic ComboBox_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return create_dyn(); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"onSelected") ) { return onSelected; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"onTextEnter") ) { return onTextEnter; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"setOnSelected") ) { return setOnSelected_dyn(); }
		if (HX_FIELD_EQ(inName,"onTextUpdated") ) { return onTextUpdated; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"setOnTextEnter") ) { return setOnTextEnter_dyn(); }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"setOnTextUpdated") ) { return setOnTextUpdated_dyn(); }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"wx_combo_box_create") ) { return wx_combo_box_create; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic ComboBox_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 10:
		if (HX_FIELD_EQ(inName,"onSelected") ) { if (inCallProp) return setOnSelected(inValue);onSelected=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"onTextEnter") ) { if (inCallProp) return setOnTextEnter(inValue);onTextEnter=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"onTextUpdated") ) { if (inCallProp) return setOnTextUpdated(inValue);onTextUpdated=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"wx_combo_box_create") ) { wx_combo_box_create=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void ComboBox_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("create"),
	HX_CSTRING("wx_combo_box_create"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("setOnTextEnter"),
	HX_CSTRING("setOnTextUpdated"),
	HX_CSTRING("setOnSelected"),
	HX_CSTRING("onTextUpdated"),
	HX_CSTRING("onTextEnter"),
	HX_CSTRING("onSelected"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(ComboBox_obj::__mClass,"__mClass");
	HX_MARK_MEMBER_NAME(ComboBox_obj::wx_combo_box_create,"wx_combo_box_create");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(ComboBox_obj::__mClass,"__mClass");
	HX_VISIT_MEMBER_NAME(ComboBox_obj::wx_combo_box_create,"wx_combo_box_create");
};

Class ComboBox_obj::__mClass;

void ComboBox_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.ComboBox"), hx::TCanCast< ComboBox_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void ComboBox_obj::__boot()
{
	wx_combo_box_create= ::wx::Loader_obj::load(HX_CSTRING("wx_combo_box_create"),(int)2);
}

} // end namespace wx
