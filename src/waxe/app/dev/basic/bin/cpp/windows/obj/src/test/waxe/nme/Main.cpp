#include <hxcpp.h>

#ifndef INCLUDED_ApplicationMain
#include <ApplicationMain.h>
#endif
#ifndef INCLUDED_haxe_Log
#include <haxe/Log.h>
#endif
#ifndef INCLUDED_test_waxe_nme_Main
#include <test/waxe/nme/Main.h>
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
#ifndef INCLUDED_wx_Menu
#include <wx/Menu.h>
#endif
#ifndef INCLUDED_wx_MenuBar
#include <wx/MenuBar.h>
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
namespace test{
namespace waxe{
namespace nme{

Void Main_obj::__construct()
{
HX_STACK_PUSH("Main::new","test/waxe/nme/Main.hx",14);
{
	HX_STACK_LINE(15)
	::wx::Frame frame = ::ApplicationMain_obj::frame;		HX_STACK_VAR(frame,"frame");
	HX_STACK_LINE(16)
	::wx::Panel panel = ::wx::Panel_obj::create(frame,null(),null(),null(),null());		HX_STACK_VAR(panel,"panel");
	struct _Function_1_1{
		inline static Dynamic Block( ){
			HX_STACK_PUSH("*::closure","test/waxe/nme/Main.hx",18);
			{
				hx::Anon __result = hx::Anon_obj::Create();
				__result->Add(HX_CSTRING("orientation") , (int)1073741824,false);
				__result->Add(HX_CSTRING("position") , (int)100,false);
				__result->Add(HX_CSTRING("thumbSize") , (int)100,false);
				__result->Add(HX_CSTRING("range") , (int)1000,false);
				return __result;
			}
			return null();
		}
	};
	HX_STACK_LINE(18)
	Dynamic scrollbar = _Function_1_1::Block();		HX_STACK_VAR(scrollbar,"scrollbar");
	HX_STACK_LINE(19)
	panel->setScrollbar(scrollbar);
	struct _Function_1_2{
		inline static Dynamic Block( ){
			HX_STACK_PUSH("*::closure","test/waxe/nme/Main.hx",21);
			{
				hx::Anon __result = hx::Anon_obj::Create();
				__result->Add(HX_CSTRING("x") , (int)20,false);
				__result->Add(HX_CSTRING("y") , (int)10,false);
				return __result;
			}
			return null();
		}
	};
	HX_STACK_LINE(21)
	Array< ::wx::StaticText > staticText = Array_obj< ::wx::StaticText >::__new().Add(::wx::StaticText_obj::create(panel,null(),HX_CSTRING("Hello Waxe!"),_Function_1_2::Block(),null(),null()));		HX_STACK_VAR(staticText,"staticText");
	struct _Function_1_3{
		inline static Dynamic Block( ){
			HX_STACK_PUSH("*::closure","test/waxe/nme/Main.hx",23);
			{
				hx::Anon __result = hx::Anon_obj::Create();
				__result->Add(HX_CSTRING("x") , (int)500,false);
				__result->Add(HX_CSTRING("y") , (int)320,false);
				return __result;
			}
			return null();
		}
	};
	HX_STACK_LINE(23)
	::wx::Button btnQuit = ::wx::Button_obj::create(panel,null(),HX_CSTRING("Quit"),_Function_1_3::Block(),null(),null());		HX_STACK_VAR(btnQuit,"btnQuit");

	HX_BEGIN_LOCAL_FUNC_S0(hx::LocalFunc,_Function_1_4)
	Void run(Dynamic _){
		HX_STACK_PUSH("*::_Function_1_4","test/waxe/nme/Main.hx",24);
		HX_STACK_ARG(_,"_");
		{
			HX_STACK_LINE(25)
			::haxe::Log_obj::trace(HX_CSTRING("Someone clicked me!"),hx::SourceInfo(HX_CSTRING("Main.hx"),25,HX_CSTRING("test.waxe.nme.Main"),HX_CSTRING("new")));
			HX_STACK_LINE(26)
			::wx::App_obj::quit();
		}
		return null();
	}
	HX_END_LOCAL_FUNC1((void))

	HX_STACK_LINE(24)
	btnQuit->setOnClick( Dynamic(new _Function_1_4()));
	struct _Function_1_5{
		inline static Dynamic Block( ){
			HX_STACK_PUSH("*::closure","test/waxe/nme/Main.hx",29);
			{
				hx::Anon __result = hx::Anon_obj::Create();
				__result->Add(HX_CSTRING("x") , (int)20,false);
				__result->Add(HX_CSTRING("y") , (int)80,false);
				return __result;
			}
			return null();
		}
	};
	struct _Function_1_6{
		inline static Dynamic Block( ){
			HX_STACK_PUSH("*::closure","test/waxe/nme/Main.hx",29);
			{
				hx::Anon __result = hx::Anon_obj::Create();
				__result->Add(HX_CSTRING("width") , (int)200,false);
				__result->Add(HX_CSTRING("height") , (int)22,false);
				return __result;
			}
			return null();
		}
	};
	HX_STACK_LINE(29)
	Array< ::wx::TextCtrl > textCtrl = Array_obj< ::wx::TextCtrl >::__new().Add(::wx::TextCtrl_obj::create(panel,null(),HX_CSTRING("Hello World"),_Function_1_5::Block(),_Function_1_6::Block(),null()));		HX_STACK_VAR(textCtrl,"textCtrl");

	HX_BEGIN_LOCAL_FUNC_S2(hx::LocalFunc,_Function_1_7,Array< ::wx::StaticText >,staticText,Array< ::wx::TextCtrl >,textCtrl)
	Void run(Dynamic _){
		HX_STACK_PUSH("*::_Function_1_7","test/waxe/nme/Main.hx",30);
		HX_STACK_ARG(_,"_");
		{
			HX_STACK_LINE(30)
			staticText->__get((int)0)->setLabel(textCtrl->__get((int)0)->getValue());
		}
		return null();
	}
	HX_END_LOCAL_FUNC1((void))

	HX_STACK_LINE(30)
	textCtrl->__get((int)0)->setOnTextUpdated( Dynamic(new _Function_1_7(staticText,textCtrl)));
	HX_STACK_LINE(34)
	::wx::MenuBar menuBar = ::wx::MenuBar_obj::__new();		HX_STACK_VAR(menuBar,"menuBar");
	HX_STACK_LINE(35)
	frame->wxSetMenuBar(menuBar);
	HX_STACK_LINE(37)
	::wx::Menu menuFile = ::wx::Menu_obj::__new(null(),null());		HX_STACK_VAR(menuFile,"menuFile");
	HX_STACK_LINE(38)
	menuBar->append(menuFile,HX_CSTRING("File"));
	HX_STACK_LINE(40)
	menuFile->append((int)0,HX_CSTRING("Test"),null(),null());
	HX_STACK_LINE(41)
	menuFile->appendSeparator();
	HX_STACK_LINE(42)
	menuFile->append((int)999,HX_CSTRING("Quit"),null(),null());

	HX_BEGIN_LOCAL_FUNC_S0(hx::LocalFunc,_Function_1_8)
	Void run(Dynamic _){
		HX_STACK_PUSH("*::_Function_1_8","test/waxe/nme/Main.hx",44);
		HX_STACK_ARG(_,"_");
		{
			HX_STACK_LINE(44)
			::haxe::Log_obj::trace(HX_CSTRING("Menu test clicked"),hx::SourceInfo(HX_CSTRING("Main.hx"),44,HX_CSTRING("test.waxe.nme.Main"),HX_CSTRING("new")));
		}
		return null();
	}
	HX_END_LOCAL_FUNC1((void))

	HX_STACK_LINE(44)
	frame->handle((int)0, Dynamic(new _Function_1_8()));

	HX_BEGIN_LOCAL_FUNC_S0(hx::LocalFunc,_Function_1_9)
	Void run(Dynamic _){
		HX_STACK_PUSH("*::_Function_1_9","test/waxe/nme/Main.hx",45);
		HX_STACK_ARG(_,"_");
		{
			HX_STACK_LINE(45)
			::wx::App_obj::quit();
		}
		return null();
	}
	HX_END_LOCAL_FUNC1((void))

	HX_STACK_LINE(45)
	frame->handle((int)999, Dynamic(new _Function_1_9()));
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
		HX_STACK_PUSH("Main::main","test/waxe/nme/Main.hx",49);
		HX_STACK_LINE(49)
		::test::waxe::nme::Main_obj::__new();
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
	HX_MARK_END_CLASS();
}

void Main_obj::__Visit(HX_VISIT_PARAMS)
{
}

Dynamic Main_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"main") ) { return main_dyn(); }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic Main_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	return super::__SetField(inName,inValue,inCallProp);
}

void Main_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("main"),
	String(null()) };

static ::String sMemberFields[] = {
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Main_obj::__mClass,"__mClass");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Main_obj::__mClass,"__mClass");
};

Class Main_obj::__mClass;

void Main_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("test.waxe.nme.Main"), hx::TCanCast< Main_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void Main_obj::__boot()
{
}

} // end namespace test
} // end namespace waxe
} // end namespace nme
