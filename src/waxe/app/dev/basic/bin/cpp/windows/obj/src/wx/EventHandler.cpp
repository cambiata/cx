#include <hxcpp.h>

#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
namespace wx{

Void EventHandler_obj::__construct(Dynamic inHandle)
{
HX_STACK_PUSH("EventHandler::new","wx/EventHandler.hx",8);
{
	HX_STACK_LINE(9)
	this->wxHandle = inHandle;
	HX_STACK_LINE(10)
	if (((this->wxHandle != null()))){
		HX_STACK_LINE(11)
		::wx::EventHandler_obj::wx_set_window_handler(this->wxHandle,hx::ObjectPtr<OBJ_>(this));
	}
}
;
	return null();
}

EventHandler_obj::~EventHandler_obj() { }

Dynamic EventHandler_obj::__CreateEmpty() { return  new EventHandler_obj; }
hx::ObjectPtr< EventHandler_obj > EventHandler_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< EventHandler_obj > result = new EventHandler_obj();
	result->__construct(inHandle);
	return result;}

Dynamic EventHandler_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< EventHandler_obj > result = new EventHandler_obj();
	result->__construct(inArgs[0]);
	return result;}

Void EventHandler_obj::HandleEvent( Dynamic event){
{
		HX_STACK_PUSH("EventHandler::HandleEvent","wx/EventHandler.hx",39);
		HX_STACK_THIS(this);
		HX_STACK_ARG(event,"event");
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(EventHandler_obj,HandleEvent,(void))

Void EventHandler_obj::_handle_event( Dynamic event){
{
		HX_STACK_PUSH("EventHandler::_handle_event","wx/EventHandler.hx",16);
		HX_STACK_THIS(this);
		HX_STACK_ARG(event,"event");
		HX_STACK_LINE(16)
		this->HandleEvent(event);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(EventHandler_obj,_handle_event,(void))

Void EventHandler_obj::_wx_deleted( ){
{
		HX_STACK_PUSH("EventHandler::_wx_deleted","wx/EventHandler.hx",15);
		HX_STACK_THIS(this);
		HX_STACK_LINE(15)
		this->wxHandle = null();
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC0(EventHandler_obj,_wx_deleted,(void))

Dynamic EventHandler_obj::wx_set_window_handler;

Dynamic EventHandler_obj::wx_get_window_handler;


EventHandler_obj::EventHandler_obj()
{
}

void EventHandler_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(EventHandler);
	HX_MARK_MEMBER_NAME(wxHandle,"wxHandle");
	HX_MARK_END_CLASS();
}

void EventHandler_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(wxHandle,"wxHandle");
}

Dynamic EventHandler_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 8:
		if (HX_FIELD_EQ(inName,"wxHandle") ) { return wxHandle; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"HandleEvent") ) { return HandleEvent_dyn(); }
		if (HX_FIELD_EQ(inName,"_wx_deleted") ) { return _wx_deleted_dyn(); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"_handle_event") ) { return _handle_event_dyn(); }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"wx_set_window_handler") ) { return wx_set_window_handler; }
		if (HX_FIELD_EQ(inName,"wx_get_window_handler") ) { return wx_get_window_handler; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic EventHandler_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 8:
		if (HX_FIELD_EQ(inName,"wxHandle") ) { wxHandle=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"wx_set_window_handler") ) { wx_set_window_handler=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_get_window_handler") ) { wx_get_window_handler=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void EventHandler_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("wxHandle"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("wx_set_window_handler"),
	HX_CSTRING("wx_get_window_handler"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("HandleEvent"),
	HX_CSTRING("_handle_event"),
	HX_CSTRING("_wx_deleted"),
	HX_CSTRING("wxHandle"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(EventHandler_obj::__mClass,"__mClass");
	HX_MARK_MEMBER_NAME(EventHandler_obj::wx_set_window_handler,"wx_set_window_handler");
	HX_MARK_MEMBER_NAME(EventHandler_obj::wx_get_window_handler,"wx_get_window_handler");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(EventHandler_obj::__mClass,"__mClass");
	HX_VISIT_MEMBER_NAME(EventHandler_obj::wx_set_window_handler,"wx_set_window_handler");
	HX_VISIT_MEMBER_NAME(EventHandler_obj::wx_get_window_handler,"wx_get_window_handler");
};

Class EventHandler_obj::__mClass;

void EventHandler_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.EventHandler"), hx::TCanCast< EventHandler_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void EventHandler_obj::__boot()
{
	wx_set_window_handler= ::wx::Loader_obj::load(HX_CSTRING("wx_set_window_handler"),(int)2);
	wx_get_window_handler= ::wx::Loader_obj::load(HX_CSTRING("wx_get_window_handler"),(int)1);
}

} // end namespace wx
