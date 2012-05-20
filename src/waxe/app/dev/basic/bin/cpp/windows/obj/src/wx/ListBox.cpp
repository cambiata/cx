#include <hxcpp.h>

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
#ifndef INCLUDED_wx_ListBox
#include <wx/ListBox.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif
namespace wx{

Void ListBox_obj::__construct(Dynamic inHandle)
{
{
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ListBox.hx",27)
	super::__construct(inHandle);
}
;
	return null();
}

ListBox_obj::~ListBox_obj() { }

Dynamic ListBox_obj::__CreateEmpty() { return  new ListBox_obj; }
hx::ObjectPtr< ListBox_obj > ListBox_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< ListBox_obj > result = new ListBox_obj();
	result->__construct(inHandle);
	return result;}

Dynamic ListBox_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< ListBox_obj > result = new ListBox_obj();
	result->__construct(inArgs[0]);
	return result;}

Dynamic ListBox_obj::setOnSelected( Dynamic f){
	HX_SOURCE_PUSH("ListBox_obj::setOnSelected")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ListBox.hx",32)
	this->setHandler(::wx::EventID_obj::COMMAND_LISTBOX_SELECTED_dyn(),f);
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ListBox.hx",32)
	return f;
}


HX_DEFINE_DYNAMIC_FUNC1(ListBox_obj,setOnSelected,return )

Dynamic ListBox_obj::setOnDClick( Dynamic f){
	HX_SOURCE_PUSH("ListBox_obj::setOnDClick")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ListBox.hx",34)
	this->setHandler(::wx::EventID_obj::COMMAND_LISTBOX_DOUBLECLICKED_dyn(),f);
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ListBox.hx",34)
	return f;
}


HX_DEFINE_DYNAMIC_FUNC1(ListBox_obj,setOnDClick,return )

int ListBox_obj::getSelection( ){
	HX_SOURCE_PUSH("ListBox_obj::getSelection")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ListBox.hx",35)
	return ::wx::ListBox_obj::wx_list_box_get_selection(this->wxHandle);
}


HX_DEFINE_DYNAMIC_FUNC0(ListBox_obj,getSelection,return )

int ListBox_obj::setSelection( int val){
	HX_SOURCE_PUSH("ListBox_obj::setSelection")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ListBox.hx",38)
	::wx::ListBox_obj::wx_list_box_set_selection(this->wxHandle,val);
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ListBox.hx",39)
	return val;
}


HX_DEFINE_DYNAMIC_FUNC1(ListBox_obj,setSelection,return )

::String ListBox_obj::getString( int inI){
	HX_SOURCE_PUSH("ListBox_obj::getString")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ListBox.hx",43)
	return ::wx::ListBox_obj::wx_list_box_get_string(this->wxHandle,inI);
}


HX_DEFINE_DYNAMIC_FUNC1(ListBox_obj,getString,return )

Void ListBox_obj::setString( int inI,::String inString){
{
		HX_SOURCE_PUSH("ListBox_obj::setString")
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ListBox.hx",47)
		::wx::ListBox_obj::wx_list_box_set_string(this->wxHandle,inString,inI);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC2(ListBox_obj,setString,(void))

int ListBox_obj::NO_SELECTION;

::wx::ListBox ListBox_obj::create( ::wx::Window inParent,Dynamic inID,Dynamic inPosition,Dynamic inSize,Array< ::String > inValues,Dynamic inStyle){
	HX_SOURCE_PUSH("ListBox_obj::create")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ListBox.hx",18)
	if (((inParent == null()))){
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ListBox.hx",19)
		hx::Throw (::wx::Error_obj::INVALID_PARENT);
	}
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ListBox.hx",20)
	Dynamic handle = ::wx::ListBox_obj::wx_list_box_create(Dynamic( Array_obj<Dynamic>::__new().Add(inParent->wxHandle).Add(inID).Add(HX_CSTRING("")).Add(inPosition).Add(inSize).Add(inStyle)),inValues);
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/ListBox.hx",22)
	return ::wx::ListBox_obj::__new(handle);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC6(ListBox_obj,create,return )

Dynamic ListBox_obj::wx_list_box_create;

Dynamic ListBox_obj::wx_list_box_get_selection;

Dynamic ListBox_obj::wx_list_box_set_selection;

Dynamic ListBox_obj::wx_list_box_get_string;

Dynamic ListBox_obj::wx_list_box_set_string;


ListBox_obj::ListBox_obj()
{
}

void ListBox_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(ListBox);
	HX_MARK_MEMBER_NAME(onSelected,"onSelected");
	HX_MARK_MEMBER_NAME(onDClick,"onDClick");
	HX_MARK_MEMBER_NAME(selection,"selection");
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic ListBox_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return create_dyn(); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"onDClick") ) { return onDClick; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"selection") ) { return getSelection(); }
		if (HX_FIELD_EQ(inName,"getString") ) { return getString_dyn(); }
		if (HX_FIELD_EQ(inName,"setString") ) { return setString_dyn(); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"onSelected") ) { return onSelected; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"setOnDClick") ) { return setOnDClick_dyn(); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"NO_SELECTION") ) { return NO_SELECTION; }
		if (HX_FIELD_EQ(inName,"getSelection") ) { return getSelection_dyn(); }
		if (HX_FIELD_EQ(inName,"setSelection") ) { return setSelection_dyn(); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"setOnSelected") ) { return setOnSelected_dyn(); }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"wx_list_box_create") ) { return wx_list_box_create; }
		break;
	case 22:
		if (HX_FIELD_EQ(inName,"wx_list_box_get_string") ) { return wx_list_box_get_string; }
		if (HX_FIELD_EQ(inName,"wx_list_box_set_string") ) { return wx_list_box_set_string; }
		break;
	case 25:
		if (HX_FIELD_EQ(inName,"wx_list_box_get_selection") ) { return wx_list_box_get_selection; }
		if (HX_FIELD_EQ(inName,"wx_list_box_set_selection") ) { return wx_list_box_set_selection; }
	}
	return super::__Field(inName);
}

Dynamic ListBox_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	switch(inName.length) {
	case 8:
		if (HX_FIELD_EQ(inName,"onDClick") ) { return setOnDClick(inValue); }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"selection") ) { return setSelection(inValue); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"onSelected") ) { return setOnSelected(inValue); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"NO_SELECTION") ) { NO_SELECTION=inValue.Cast< int >(); return inValue; }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"wx_list_box_create") ) { wx_list_box_create=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 22:
		if (HX_FIELD_EQ(inName,"wx_list_box_get_string") ) { wx_list_box_get_string=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_list_box_set_string") ) { wx_list_box_set_string=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 25:
		if (HX_FIELD_EQ(inName,"wx_list_box_get_selection") ) { wx_list_box_get_selection=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_list_box_set_selection") ) { wx_list_box_set_selection=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue);
}

void ListBox_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("selection"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("NO_SELECTION"),
	HX_CSTRING("create"),
	HX_CSTRING("wx_list_box_create"),
	HX_CSTRING("wx_list_box_get_selection"),
	HX_CSTRING("wx_list_box_set_selection"),
	HX_CSTRING("wx_list_box_get_string"),
	HX_CSTRING("wx_list_box_set_string"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("onSelected"),
	HX_CSTRING("onDClick"),
	HX_CSTRING("selection"),
	HX_CSTRING("setOnSelected"),
	HX_CSTRING("setOnDClick"),
	HX_CSTRING("getSelection"),
	HX_CSTRING("setSelection"),
	HX_CSTRING("getString"),
	HX_CSTRING("setString"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(ListBox_obj::NO_SELECTION,"NO_SELECTION");
	HX_MARK_MEMBER_NAME(ListBox_obj::wx_list_box_create,"wx_list_box_create");
	HX_MARK_MEMBER_NAME(ListBox_obj::wx_list_box_get_selection,"wx_list_box_get_selection");
	HX_MARK_MEMBER_NAME(ListBox_obj::wx_list_box_set_selection,"wx_list_box_set_selection");
	HX_MARK_MEMBER_NAME(ListBox_obj::wx_list_box_get_string,"wx_list_box_get_string");
	HX_MARK_MEMBER_NAME(ListBox_obj::wx_list_box_set_string,"wx_list_box_set_string");
};

Class ListBox_obj::__mClass;

void ListBox_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.ListBox"), hx::TCanCast< ListBox_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void ListBox_obj::__boot()
{
	hx::Static(NO_SELECTION) = (int)-1;
	hx::Static(wx_list_box_create) = ::wx::Loader_obj::load(HX_CSTRING("wx_list_box_create"),(int)2);
	hx::Static(wx_list_box_get_selection) = ::wx::Loader_obj::load(HX_CSTRING("wx_list_box_get_selection"),(int)1);
	hx::Static(wx_list_box_set_selection) = ::wx::Loader_obj::load(HX_CSTRING("wx_list_box_set_selection"),(int)2);
	hx::Static(wx_list_box_get_string) = ::wx::Loader_obj::load(HX_CSTRING("wx_list_box_get_string"),(int)2);
	hx::Static(wx_list_box_set_string) = ::wx::Loader_obj::load(HX_CSTRING("wx_list_box_set_string"),(int)3);
}

} // end namespace wx
