#include <hxcpp.h>

#ifndef INCLUDED_ApplicationMain
#include <ApplicationMain.h>
#endif
#ifndef INCLUDED_HelloWaxe
#include <HelloWaxe.h>
#endif
#ifndef INCLUDED_wx_App
#include <wx/App.h>
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
#ifndef INCLUDED_wx_Panel
#include <wx/Panel.h>
#endif
#ifndef INCLUDED_wx_StaticText
#include <wx/StaticText.h>
#endif
#ifndef INCLUDED_wx_TextCtrl
#include <wx/TextCtrl.h>
#endif
#ifndef INCLUDED_wx_TopLevelWindow
#include <wx/TopLevelWindow.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif

Void HelloWaxe_obj::__construct()
{
HX_STACK_PUSH("HelloWaxe::new","HelloWaxe.hx",11);
{
	HX_STACK_LINE(12)
	::wx::Frame frame = ::ApplicationMain_obj::frame;		HX_STACK_VAR(frame,"frame");
	HX_STACK_LINE(13)
	::wx::Panel panel = ::wx::Panel_obj::create(frame,null(),null(),null(),null());		HX_STACK_VAR(panel,"panel");
	struct _Function_1_1{
		inline static Dynamic Block( ){
			HX_STACK_PUSH("*::closure","HelloWaxe.hx",14);
			{
				hx::Anon __result = hx::Anon_obj::Create();
				__result->Add(HX_CSTRING("x") , (int)20,false);
				__result->Add(HX_CSTRING("y") , (int)10,false);
				return __result;
			}
			return null();
		}
	};
	HX_STACK_LINE(14)
	Array< ::wx::StaticText > staticText = Array_obj< ::wx::StaticText >::__new().Add(::wx::StaticText_obj::create(panel,null(),HX_CSTRING("Hello Waxe!"),_Function_1_1::Block(),null(),null()));		HX_STACK_VAR(staticText,"staticText");
	struct _Function_1_2{
		inline static Dynamic Block( ){
			HX_STACK_PUSH("*::closure","HelloWaxe.hx",15);
			{
				hx::Anon __result = hx::Anon_obj::Create();
				__result->Add(HX_CSTRING("x") , (int)500,false);
				__result->Add(HX_CSTRING("y") , (int)320,false);
				return __result;
			}
			return null();
		}
	};
	HX_STACK_LINE(15)
	::wx::Button btnQuit = ::wx::Button_obj::create(panel,null(),HX_CSTRING("Quit"),_Function_1_2::Block(),null(),null());		HX_STACK_VAR(btnQuit,"btnQuit");

	HX_BEGIN_LOCAL_FUNC_S0(hx::LocalFunc,_Function_1_3)
	Void run(Dynamic _){
		HX_STACK_PUSH("*::_Function_1_3","HelloWaxe.hx",16);
		HX_STACK_ARG(_,"_");
		{
			HX_STACK_LINE(16)
			::wx::App_obj::quit();
		}
		return null();
	}
	HX_END_LOCAL_FUNC1((void))

	HX_STACK_LINE(16)
	btnQuit->setOnClick( Dynamic(new _Function_1_3()));
	struct _Function_1_4{
		inline static Dynamic Block( ){
			HX_STACK_PUSH("*::closure","HelloWaxe.hx",20);
			{
				hx::Anon __result = hx::Anon_obj::Create();
				__result->Add(HX_CSTRING("x") , (int)20,false);
				__result->Add(HX_CSTRING("y") , (int)80,false);
				return __result;
			}
			return null();
		}
	};
	struct _Function_1_5{
		inline static Dynamic Block( ){
			HX_STACK_PUSH("*::closure","HelloWaxe.hx",20);
			{
				hx::Anon __result = hx::Anon_obj::Create();
				__result->Add(HX_CSTRING("width") , (int)200,false);
				__result->Add(HX_CSTRING("height") , (int)22,false);
				return __result;
			}
			return null();
		}
	};
	HX_STACK_LINE(20)
	Array< ::wx::TextCtrl > textCtrl = Array_obj< ::wx::TextCtrl >::__new().Add(::wx::TextCtrl_obj::create(panel,null(),HX_CSTRING("Hello World"),_Function_1_4::Block(),_Function_1_5::Block(),null()));		HX_STACK_VAR(textCtrl,"textCtrl");

	HX_BEGIN_LOCAL_FUNC_S2(hx::LocalFunc,_Function_1_6,Array< ::wx::StaticText >,staticText,Array< ::wx::TextCtrl >,textCtrl)
	Void run(Dynamic _){
		HX_STACK_PUSH("*::_Function_1_6","HelloWaxe.hx",21);
		HX_STACK_ARG(_,"_");
		{
			HX_STACK_LINE(21)
			staticText->__get((int)0)->setLabel(textCtrl->__get((int)0)->getValue());
		}
		return null();
	}
	HX_END_LOCAL_FUNC1((void))

	HX_STACK_LINE(21)
	textCtrl->__get((int)0)->setOnTextUpdated( Dynamic(new _Function_1_6(staticText,textCtrl)));
}
;
	return null();
}

HelloWaxe_obj::~HelloWaxe_obj() { }

Dynamic HelloWaxe_obj::__CreateEmpty() { return  new HelloWaxe_obj; }
hx::ObjectPtr< HelloWaxe_obj > HelloWaxe_obj::__new()
{  hx::ObjectPtr< HelloWaxe_obj > result = new HelloWaxe_obj();
	result->__construct();
	return result;}

Dynamic HelloWaxe_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< HelloWaxe_obj > result = new HelloWaxe_obj();
	result->__construct();
	return result;}

Void HelloWaxe_obj::main( ){
{
		HX_STACK_PUSH("HelloWaxe::main","HelloWaxe.hx",27);
		HX_STACK_LINE(27)
		::HelloWaxe_obj::__new();
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(HelloWaxe_obj,main,(void))


HelloWaxe_obj::HelloWaxe_obj()
{
}

void HelloWaxe_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(HelloWaxe);
	HX_MARK_END_CLASS();
}

void HelloWaxe_obj::__Visit(HX_VISIT_PARAMS)
{
}

Dynamic HelloWaxe_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"main") ) { return main_dyn(); }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic HelloWaxe_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	return super::__SetField(inName,inValue,inCallProp);
}

void HelloWaxe_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("main"),
	String(null()) };

static ::String sMemberFields[] = {
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(HelloWaxe_obj::__mClass,"__mClass");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(HelloWaxe_obj::__mClass,"__mClass");
};

Class HelloWaxe_obj::__mClass;

void HelloWaxe_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("HelloWaxe"), hx::TCanCast< HelloWaxe_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void HelloWaxe_obj::__boot()
{
}

