#include <hxcpp.h>

#ifndef INCLUDED_Main
#include <Main.h>
#endif
#ifndef INCLUDED_neash_display_DisplayObject
#include <neash/display/DisplayObject.h>
#endif
#ifndef INCLUDED_neash_display_DisplayObjectContainer
#include <neash/display/DisplayObjectContainer.h>
#endif
#ifndef INCLUDED_neash_display_Graphics
#include <neash/display/Graphics.h>
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
#ifndef INCLUDED_neash_display_StageAlign
#include <neash/display/StageAlign.h>
#endif
#ifndef INCLUDED_neash_display_StageScaleMode
#include <neash/display/StageScaleMode.h>
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
#ifndef INCLUDED_wx_BoxSizer
#include <wx/BoxSizer.h>
#endif
#ifndef INCLUDED_wx_Button
#include <wx/Button.h>
#endif
#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_Frame
#include <wx/Frame.h>
#endif
#ifndef INCLUDED_wx_GLCanvas
#include <wx/GLCanvas.h>
#endif
#ifndef INCLUDED_wx_NMEStage
#include <wx/NMEStage.h>
#endif
#ifndef INCLUDED_wx_Panel
#include <wx/Panel.h>
#endif
#ifndef INCLUDED_wx_Sizer
#include <wx/Sizer.h>
#endif
#ifndef INCLUDED_wx_TopLevelWindow
#include <wx/TopLevelWindow.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif

Void Main_obj::__construct()
{
{
	struct _Function_1_1{
		inline static Dynamic Block( ){
			{
				hx::Anon __result = hx::Anon_obj::Create();
				__result->Add(HX_CSTRING("width") , (int)400,false);
				__result->Add(HX_CSTRING("height") , (int)400,false);
				return __result;
			}
			return null();
		}
	};
	HX_SOURCE_POS("Main.hx",21)
	this->frame = ::wx::Frame_obj::create(null(),null(),HX_CSTRING("WaxeApp"),null(),_Function_1_1::Block(),null());
	HX_SOURCE_POS("Main.hx",24)
	::wx::Panel waxePanel = ::wx::Panel_obj::create(this->frame,null(),null(),null(),null());
	HX_SOURCE_POS("Main.hx",25)
	::wx::Button button = ::wx::Button_obj::create(waxePanel,null(),HX_CSTRING("A Button"),null(),null(),null());
	HX_SOURCE_POS("Main.hx",28)
	::wx::NMEStage nmeStage = ::wx::NMEStage_obj::create(waxePanel,null(),null(),null(),null());
	HX_SOURCE_POS("Main.hx",29)
	nmeStage->stage->nmeSetAlign(::neash::display::StageAlign_obj::TOP_LEFT_dyn());
	HX_SOURCE_POS("Main.hx",30)
	nmeStage->stage->nmeSetScaleMode(::neash::display::StageScaleMode_obj::NO_SCALE_dyn());
	HX_SOURCE_POS("Main.hx",32)
	nmeStage->stage->nmeGetGraphics()->beginFill((int)0,null());
	HX_SOURCE_POS("Main.hx",33)
	nmeStage->stage->nmeGetGraphics()->drawCircle((int)50,(int)50,(int)50);
	HX_SOURCE_POS("Main.hx",34)
	nmeStage->stage->nmeGetGraphics()->endFill();
	HX_SOURCE_POS("Main.hx",37)
	::wx::Sizer sizer = ::wx::BoxSizer_obj::create(true);
	HX_SOURCE_POS("Main.hx",38)
	waxePanel->setSizer(sizer);
	HX_SOURCE_POS("Main.hx",39)
	sizer->add(button,(int)1,(int(::wx::Sizer_obj::EXPAND) | int(::wx::Sizer_obj::BORDER_ALL)),(int)5);
	HX_SOURCE_POS("Main.hx",40)
	sizer->add(nmeStage,(int)3,(int(::wx::Sizer_obj::EXPAND) | int(::wx::Sizer_obj::BORDER_ALL)),(int)5);
	HX_SOURCE_POS("Main.hx",44)
	::wx::App_obj::setTopWindow(this->frame);
	HX_SOURCE_POS("Main.hx",45)
	this->frame->show(true);
}
;
	return null();
}

Main_obj::~Main_obj() { }

Dynamic Main_obj::__CreateEmpty() { return  new Main_obj; }
hx::ObjectPtr< Main_obj > Main_obj::__new()
{  hx::ObjectPtr< Main_obj > result = new Main_obj();
	result->__construct();
	return result;}

Dynamic Main_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Main_obj > result = new Main_obj();
	result->__construct();
	return result;}

Void Main_obj::main( ){
{
		HX_SOURCE_PUSH("Main_obj::main")

		HX_BEGIN_LOCAL_FUNC_S0(hx::LocalFunc,_Function_1_1)
		Void run(){
{
				HX_SOURCE_POS("Main.hx",53)
				::Main_obj::__new();
			}
			return null();
		}
		HX_END_LOCAL_FUNC0((void))

		HX_SOURCE_POS("Main.hx",52)
		::wx::App_obj::boot( Dynamic(new _Function_1_1()));
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Main_obj,main,(void))


Main_obj::Main_obj()
{
}

void Main_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Main);
	HX_MARK_MEMBER_NAME(frame,"frame");
	HX_MARK_END_CLASS();
}

Dynamic Main_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"main") ) { return main_dyn(); }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"frame") ) { return frame; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic Main_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"frame") ) { frame=inValue.Cast< ::wx::Frame >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void Main_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("frame"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("main"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("frame"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
};

Class Main_obj::__mClass;

void Main_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("Main"), hx::TCanCast< Main_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void Main_obj::__boot()
{
}

