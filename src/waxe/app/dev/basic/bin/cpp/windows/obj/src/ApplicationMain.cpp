#include <hxcpp.h>

#ifndef INCLUDED_ApplicationMain
#include <ApplicationMain.h>
#endif
#ifndef INCLUDED_Basic
#include <Basic.h>
#endif
#ifndef INCLUDED_wx_App
#include <wx/App.h>
#endif
#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_Frame
#include <wx/Frame.h>
#endif
#ifndef INCLUDED_wx_TopLevelWindow
#include <wx/TopLevelWindow.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif

Void ApplicationMain_obj::__construct()
{
	return null();
}

ApplicationMain_obj::~ApplicationMain_obj() { }

Dynamic ApplicationMain_obj::__CreateEmpty() { return  new ApplicationMain_obj; }
hx::ObjectPtr< ApplicationMain_obj > ApplicationMain_obj::__new()
{  hx::ObjectPtr< ApplicationMain_obj > result = new ApplicationMain_obj();
	result->__construct();
	return result;}

Dynamic ApplicationMain_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< ApplicationMain_obj > result = new ApplicationMain_obj();
	result->__construct();
	return result;}

::wx::Frame ApplicationMain_obj::frame;

bool ApplicationMain_obj::autoShowFrame;

Void ApplicationMain_obj::main( ){
{
		HX_SOURCE_PUSH("ApplicationMain_obj::main")

		HX_BEGIN_LOCAL_FUNC_S0(hx::LocalFunc,_Function_1_1)
		Void run(){
{
				struct _Function_2_1{
					inline static Dynamic Block( ){
						hx::Anon __result = hx::Anon_obj::Create();
						__result->Add(HX_CSTRING("width") , (int)800,false);
						__result->Add(HX_CSTRING("height") , (int)600,false);
						return __result;
					}
				};
				HX_SOURCE_POS("bin/cpp/windows/haxe/ApplicationMain.hx",23)
				::ApplicationMain_obj::frame = ::wx::Frame_obj::create(null(),null(),HX_CSTRING("Basic"),null(),_Function_2_1::Block(),null());
				HX_SOURCE_POS("bin/cpp/windows/haxe/ApplicationMain.hx",29)
				::Basic_obj::main();
				HX_SOURCE_POS("bin/cpp/windows/haxe/ApplicationMain.hx",31)
				if ((::ApplicationMain_obj::autoShowFrame)){
					HX_SOURCE_POS("bin/cpp/windows/haxe/ApplicationMain.hx",33)
					::wx::App_obj::setTopWindow(::ApplicationMain_obj::frame);
					HX_SOURCE_POS("bin/cpp/windows/haxe/ApplicationMain.hx",34)
					::ApplicationMain_obj::frame->show(true);
				}
			}
			return null();
		}
		HX_END_LOCAL_FUNC0((void))

		HX_SOURCE_POS("bin/cpp/windows/haxe/ApplicationMain.hx",13)
		::wx::App_obj::boot( Dynamic(new _Function_1_1()));
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(ApplicationMain_obj,main,(void))

Dynamic ApplicationMain_obj::getAsset( ::String inName){
	HX_SOURCE_PUSH("ApplicationMain_obj::getAsset")
}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(ApplicationMain_obj,getAsset,return )


ApplicationMain_obj::ApplicationMain_obj()
{
}

void ApplicationMain_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(ApplicationMain);
	HX_MARK_END_CLASS();
}

Dynamic ApplicationMain_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"main") ) { return main_dyn(); }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"frame") ) { return frame; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"getAsset") ) { return getAsset_dyn(); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"autoShowFrame") ) { return autoShowFrame; }
	}
	return super::__Field(inName);
}

Dynamic ApplicationMain_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"frame") ) { frame=inValue.Cast< ::wx::Frame >(); return inValue; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"autoShowFrame") ) { autoShowFrame=inValue.Cast< bool >(); return inValue; }
	}
	return super::__SetField(inName,inValue);
}

void ApplicationMain_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("frame"),
	HX_CSTRING("autoShowFrame"),
	HX_CSTRING("main"),
	HX_CSTRING("getAsset"),
	String(null()) };

static ::String sMemberFields[] = {
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(ApplicationMain_obj::frame,"frame");
	HX_MARK_MEMBER_NAME(ApplicationMain_obj::autoShowFrame,"autoShowFrame");
};

Class ApplicationMain_obj::__mClass;

void ApplicationMain_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("ApplicationMain"), hx::TCanCast< ApplicationMain_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void ApplicationMain_obj::__boot()
{
	hx::Static(frame);
	hx::Static(autoShowFrame) = true;
}

