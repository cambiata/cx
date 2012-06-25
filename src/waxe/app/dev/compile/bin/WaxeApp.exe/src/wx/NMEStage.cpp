#include <hxcpp.h>

#ifndef INCLUDED_Std
#include <Std.h>
#endif
#ifndef INCLUDED_Type
#include <Type.h>
#endif
#ifndef INCLUDED_neash_Lib
#include <neash/Lib.h>
#endif
#ifndef INCLUDED_neash_display_DisplayObject
#include <neash/display/DisplayObject.h>
#endif
#ifndef INCLUDED_neash_display_DisplayObjectContainer
#include <neash/display/DisplayObjectContainer.h>
#endif
#ifndef INCLUDED_neash_display_IBitmapDrawable
#include <neash/display/IBitmapDrawable.h>
#endif
#ifndef INCLUDED_neash_display_InteractiveObject
#include <neash/display/InteractiveObject.h>
#endif
#ifndef INCLUDED_neash_display_ManagedStage
#include <neash/display/ManagedStage.h>
#endif
#ifndef INCLUDED_neash_display_Stage
#include <neash/display/Stage.h>
#endif
#ifndef INCLUDED_neash_events_EventDispatcher
#include <neash/events/EventDispatcher.h>
#endif
#ifndef INCLUDED_neash_events_IEventDispatcher
#include <neash/events/IEventDispatcher.h>
#endif
#ifndef INCLUDED_wx_App
#include <wx/App.h>
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
#ifndef INCLUDED_wx_GLCanvas
#include <wx/GLCanvas.h>
#endif
#ifndef INCLUDED_wx_NMEStage
#include <wx/NMEStage.h>
#endif
#ifndef INCLUDED_wx_Timer
#include <wx/Timer.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif
namespace wx{

Void NMEStage_obj::__construct(Dynamic inHandle,int inWidth,int inHeight)
{
{
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",16)
	super::__construct(inHandle);
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",17)
	::wx::NMEStage me = hx::ObjectPtr<OBJ_>(this);
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",18)
	this->mLastValue = (int)0;
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",19)
	this->stage = ::neash::Lib_obj::createManagedStage(inWidth,inHeight);
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",20)
	this->stage->onQuit = ::wx::App_obj::quit_dyn();
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",21)
	this->stage->beginRender = me->makeCurrent_dyn();
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",22)
	this->stage->endRender = me->flip_dyn();
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",23)
	this->stage->setNextWake = me->setNextWake_dyn();
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",24)
	this->stage->renderRequest = me->refresh_dyn();
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",25)
	this->setOnSize(this->myOnSize_dyn());
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",27)
	this->setHandler(::wx::EventID_obj::PAINT_dyn(),me->render_dyn());
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",28)
	this->mTimer = ::wx::Timer_obj::__new(hx::ObjectPtr<OBJ_>(this),null());
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",29)
	this->setNextWake((int)1);
}
;
	return null();
}

NMEStage_obj::~NMEStage_obj() { }

Dynamic NMEStage_obj::__CreateEmpty() { return  new NMEStage_obj; }
hx::ObjectPtr< NMEStage_obj > NMEStage_obj::__new(Dynamic inHandle,int inWidth,int inHeight)
{  hx::ObjectPtr< NMEStage_obj > result = new NMEStage_obj();
	result->__construct(inHandle,inWidth,inHeight);
	return result;}

Dynamic NMEStage_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< NMEStage_obj > result = new NMEStage_obj();
	result->__construct(inArgs[0],inArgs[1],inArgs[2]);
	return result;}

Void NMEStage_obj::_wx_deleted( ){
{
		HX_SOURCE_PUSH("NMEStage_obj::_wx_deleted")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",34)
		this->mTimer->stop();
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",35)
		this->super::_wx_deleted();
	}
return null();
}


Void NMEStage_obj::myOnSize( Dynamic event){
{
		HX_SOURCE_PUSH("NMEStage_obj::myOnSize")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",40)
		Dynamic s = this->getClientSize();
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",41)
		this->stage->resize(s->__Field(HX_CSTRING("width"),true),s->__Field(HX_CSTRING("height"),true));
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(NMEStage_obj,myOnSize,(void))

Void NMEStage_obj::pumpMouseEvent( int inID,Dynamic inEvent){
{
		HX_SOURCE_PUSH("NMEStage_obj::pumpMouseEvent")
		struct _Function_1_1{
			inline static Dynamic Block( ){
				{
					hx::Anon __result = hx::Anon_obj::Create();
					return __result;
				}
				return null();
			}
		};
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",46)
		Dynamic e = _Function_1_1::Block();
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",47)
		e->__FieldRef(HX_CSTRING("type")) = inID;
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",48)
		e->__FieldRef(HX_CSTRING("x")) = inEvent->__Field(HX_CSTRING("x"),true);
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",49)
		e->__FieldRef(HX_CSTRING("y")) = inEvent->__Field(HX_CSTRING("y"),true);
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",50)
		e->__FieldRef(HX_CSTRING("flags")) = (int((int((int(((  ((inEvent->__Field(HX_CSTRING("leftIsDown"),true))) ? int((int)32769) : int((int)0) ))) | int(((  ((inEvent->__Field(HX_CSTRING("controlDown"),true))) ? int((int)4) : int((int)0) ))))) | int(((  ((inEvent->__Field(HX_CSTRING("metaDown"),true))) ? int((int)8) : int((int)0) ))))) | int(((  ((inEvent->__Field(HX_CSTRING("shiftDown"),true))) ? int((int)2) : int((int)0) ))));
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",54)
		this->stage->pumpEvent(e);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC2(NMEStage_obj,pumpMouseEvent,(void))

Void NMEStage_obj::pumpKeyEvent( int inID,Dynamic inEvent){
{
		HX_SOURCE_PUSH("NMEStage_obj::pumpKeyEvent")
		struct _Function_1_1{
			inline static Dynamic Block( ){
				{
					hx::Anon __result = hx::Anon_obj::Create();
					return __result;
				}
				return null();
			}
		};
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",59)
		Dynamic e = _Function_1_1::Block();
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",60)
		e->__FieldRef(HX_CSTRING("type")) = inID;
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",61)
		e->__FieldRef(HX_CSTRING("x")) = inEvent->__Field(HX_CSTRING("x"),true);
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",62)
		e->__FieldRef(HX_CSTRING("y")) = inEvent->__Field(HX_CSTRING("y"),true);
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",63)
		e->__FieldRef(HX_CSTRING("flags")) = (int((int((int(((  ((inEvent->__Field(HX_CSTRING("leftIsDown"),true))) ? int((int)32769) : int((int)0) ))) | int(((  ((inEvent->__Field(HX_CSTRING("controlDown"),true))) ? int((int)4) : int((int)0) ))))) | int(((  ((inEvent->__Field(HX_CSTRING("metaDown"),true))) ? int((int)8) : int((int)0) ))))) | int(((  ((inEvent->__Field(HX_CSTRING("shiftDown"),true))) ? int((int)2) : int((int)0) ))));
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",67)
		e->__FieldRef(HX_CSTRING("code")) = inEvent->__Field(HX_CSTRING("code"),true);
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",68)
		e->__FieldRef(HX_CSTRING("value")) = inEvent->__Field(HX_CSTRING("flashCode"),true);
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",69)
		this->stage->pumpEvent(e);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC2(NMEStage_obj,pumpKeyEvent,(void))

bool NMEStage_obj::IsModifier( int inCode){
	HX_SOURCE_PUSH("NMEStage_obj::IsModifier")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",73)
	return (bool((inCode >= (int)15)) && bool((inCode <= (int)20)));
}


HX_DEFINE_DYNAMIC_FUNC1(NMEStage_obj,IsModifier,return )

Void NMEStage_obj::HandleEvent( Dynamic event){
{
		HX_SOURCE_PUSH("NMEStage_obj::HandleEvent")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",79)
		this->super::HandleEvent(event);
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",80)
		{
::wx::EventID _switch_1 = (::Type_obj::createEnumIndex(hx::ClassOf< ::wx::EventID >(),::Std_obj::_int(event->__Field(HX_CSTRING("type"),true)),null()));
			switch((_switch_1)->GetIndex()){
				case 20: {
					HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",82)
					this->pumpMouseEvent((int)5,event);
				}
				;break;
				case 21: {
					HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",83)
					this->pumpMouseEvent((int)7,event);
				}
				;break;
				case 26: {
					HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",84)
					this->pumpMouseEvent((int)4,event);
				}
				;break;
				case 51: {
					HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",85)
					if ((this->IsModifier(event->__Field(HX_CSTRING("flashCode"),true)))){
						HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",89)
						this->pumpKeyEvent((int)1,event);
						HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",90)
						this->mLastValue = (int)0;
					}
				}
				;break;
				case 48: {
					HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",93)
					this->mLastValue = event->__Field(HX_CSTRING("code"),true);
					HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",94)
					this->pumpKeyEvent((int)1,event);
				}
				;break;
				case 52: {
					HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",96)
					event->__FieldRef(HX_CSTRING("code")) = this->mLastValue;
					HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",97)
					this->pumpKeyEvent((int)3,event);
				}
				;break;
				case 19: {
					struct _Function_2_1{
						inline static Dynamic Block( ){
							{
								hx::Anon __result = hx::Anon_obj::Create();
								__result->Add(HX_CSTRING("type") , (int)9,false);
								return __result;
							}
							return null();
						}
					};
					HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",98)
					this->stage->pumpEvent(_Function_2_1::Block());
				}
				;break;
				default: {
				}
			}
		}
	}
return null();
}


Void NMEStage_obj::setNextWake( double inDelay){
{
		HX_SOURCE_PUSH("NMEStage_obj::setNextWake")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",107)
		int start = ::Std_obj::_int((inDelay * (int)1000));
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",108)
		if (((start <= (int)1))){
			HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",108)
			start = (int)1;
		}
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",109)
		this->mTimer->start(start,true);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(NMEStage_obj,setNextWake,(void))

Void NMEStage_obj::render( Dynamic _){
{
		HX_SOURCE_PUSH("NMEStage_obj::render")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",113)
		this->stage->nmeRender(true);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(NMEStage_obj,render,(void))

::wx::NMEStage NMEStage_obj::create( ::wx::Window inParent,Dynamic inID,Dynamic inPosition,Dynamic inSize,Dynamic inStyle){
	HX_SOURCE_PUSH("NMEStage_obj::create")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",120)
	if (((inParent == null()))){
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",121)
		hx::Throw (::wx::Error_obj::INVALID_PARENT);
	}
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",122)
	Dynamic handle = ::wx::GLCanvas_obj::wx_glcanvas_create(Dynamic( Array_obj<Dynamic>::__new().Add(inParent->wxHandle).Add(inID).Add(HX_CSTRING("")).Add(inPosition).Add(inSize).Add(inStyle)));
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",123)
	int w = (  (((inSize == null()))) ? int((int)-1) : int(inSize->__Field(HX_CSTRING("width"),true)) );
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",124)
	int h = (  (((inSize == null()))) ? int((int)-1) : int(inSize->__Field(HX_CSTRING("height"),true)) );
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",125)
	::wx::NMEStage stage = ::wx::NMEStage_obj::__new(handle,w,h);
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",126)
	stage->myOnSize(null());
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/NMEStage.hx",127)
	return stage;
}


STATIC_HX_DEFINE_DYNAMIC_FUNC5(NMEStage_obj,create,return )


NMEStage_obj::NMEStage_obj()
{
}

void NMEStage_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(NMEStage);
	HX_MARK_MEMBER_NAME(stage,"stage");
	HX_MARK_MEMBER_NAME(mLastValue,"mLastValue");
	HX_MARK_MEMBER_NAME(mTimer,"mTimer");
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic NMEStage_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"stage") ) { return stage; }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return create_dyn(); }
		if (HX_FIELD_EQ(inName,"mTimer") ) { return mTimer; }
		if (HX_FIELD_EQ(inName,"render") ) { return render_dyn(); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"myOnSize") ) { return myOnSize_dyn(); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"mLastValue") ) { return mLastValue; }
		if (HX_FIELD_EQ(inName,"IsModifier") ) { return IsModifier_dyn(); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"_wx_deleted") ) { return _wx_deleted_dyn(); }
		if (HX_FIELD_EQ(inName,"HandleEvent") ) { return HandleEvent_dyn(); }
		if (HX_FIELD_EQ(inName,"setNextWake") ) { return setNextWake_dyn(); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"pumpKeyEvent") ) { return pumpKeyEvent_dyn(); }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"pumpMouseEvent") ) { return pumpMouseEvent_dyn(); }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic NMEStage_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"stage") ) { stage=inValue.Cast< ::neash::display::ManagedStage >(); return inValue; }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"mTimer") ) { mTimer=inValue.Cast< ::wx::Timer >(); return inValue; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"mLastValue") ) { mLastValue=inValue.Cast< int >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void NMEStage_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("stage"));
	outFields->push(HX_CSTRING("mLastValue"));
	outFields->push(HX_CSTRING("mTimer"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("create"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("stage"),
	HX_CSTRING("mLastValue"),
	HX_CSTRING("mTimer"),
	HX_CSTRING("_wx_deleted"),
	HX_CSTRING("myOnSize"),
	HX_CSTRING("pumpMouseEvent"),
	HX_CSTRING("pumpKeyEvent"),
	HX_CSTRING("IsModifier"),
	HX_CSTRING("HandleEvent"),
	HX_CSTRING("setNextWake"),
	HX_CSTRING("render"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
};

Class NMEStage_obj::__mClass;

void NMEStage_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.NMEStage"), hx::TCanCast< NMEStage_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void NMEStage_obj::__boot()
{
}

} // end namespace wx
