#include <hxcpp.h>

#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
#ifndef INCLUDED_wx_Timer
#include <wx/Timer.h>
#endif
namespace wx{

Void Timer_obj::__construct(::wx::EventHandler inHandler,hx::Null< int >  __o_inID)
{
int inID = __o_inID.Default(-1);
{
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Timer.hx",8)
	this->wxHandle = ::wx::Timer_obj::wx_timer_create(inHandler->wxHandle,inID);
}
;
	return null();
}

Timer_obj::~Timer_obj() { }

Dynamic Timer_obj::__CreateEmpty() { return  new Timer_obj; }
hx::ObjectPtr< Timer_obj > Timer_obj::__new(::wx::EventHandler inHandler,hx::Null< int >  __o_inID)
{  hx::ObjectPtr< Timer_obj > result = new Timer_obj();
	result->__construct(inHandler,__o_inID);
	return result;}

Dynamic Timer_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Timer_obj > result = new Timer_obj();
	result->__construct(inArgs[0],inArgs[1]);
	return result;}

Void Timer_obj::start( hx::Null< int >  __o_inMilliSeconds,hx::Null< bool >  __o_inOneShot){
int inMilliSeconds = __o_inMilliSeconds.Default(-1);
bool inOneShot = __o_inOneShot.Default(false);
	HX_SOURCE_PUSH("Timer_obj::start");
{
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Timer.hx",12)
		::wx::Timer_obj::wx_timer_start(this->wxHandle,inMilliSeconds,inOneShot);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC2(Timer_obj,start,(void))

Void Timer_obj::stop( ){
{
		HX_SOURCE_PUSH("Timer_obj::stop")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Timer.hx",16)
		::wx::Timer_obj::wx_timer_stop(this->wxHandle);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC0(Timer_obj,stop,(void))

Dynamic Timer_obj::wx_timer_create;

Dynamic Timer_obj::wx_timer_start;

Dynamic Timer_obj::wx_timer_stop;


Timer_obj::Timer_obj()
{
}

void Timer_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Timer);
	HX_MARK_MEMBER_NAME(wxHandle,"wxHandle");
	HX_MARK_END_CLASS();
}

Dynamic Timer_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"stop") ) { return stop_dyn(); }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"start") ) { return start_dyn(); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"wxHandle") ) { return wxHandle; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"wx_timer_stop") ) { return wx_timer_stop; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"wx_timer_start") ) { return wx_timer_start; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"wx_timer_create") ) { return wx_timer_create; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic Timer_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 8:
		if (HX_FIELD_EQ(inName,"wxHandle") ) { wxHandle=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"wx_timer_stop") ) { wx_timer_stop=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"wx_timer_start") ) { wx_timer_start=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"wx_timer_create") ) { wx_timer_create=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void Timer_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("wxHandle"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("wx_timer_create"),
	HX_CSTRING("wx_timer_start"),
	HX_CSTRING("wx_timer_stop"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("wxHandle"),
	HX_CSTRING("start"),
	HX_CSTRING("stop"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Timer_obj::wx_timer_create,"wx_timer_create");
	HX_MARK_MEMBER_NAME(Timer_obj::wx_timer_start,"wx_timer_start");
	HX_MARK_MEMBER_NAME(Timer_obj::wx_timer_stop,"wx_timer_stop");
};

Class Timer_obj::__mClass;

void Timer_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.Timer"), hx::TCanCast< Timer_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void Timer_obj::__boot()
{
	hx::Static(wx_timer_create) = ::wx::Loader_obj::load(HX_CSTRING("wx_timer_create"),(int)2);
	hx::Static(wx_timer_start) = ::wx::Loader_obj::load(HX_CSTRING("wx_timer_start"),(int)3);
	hx::Static(wx_timer_stop) = ::wx::Loader_obj::load(HX_CSTRING("wx_timer_stop"),(int)1);
}

} // end namespace wx
