#include <hxcpp.h>

#ifndef INCLUDED_ApplicationMain
#include <ApplicationMain.h>
#endif
#ifndef INCLUDED_Basic
#include <Basic.h>
#endif
#ifndef INCLUDED_haxe_Log
#include <haxe/Log.h>
#endif
#ifndef INCLUDED_wx_Button
#include <wx/Button.h>
#endif
#ifndef INCLUDED_wx_ComboBox
#include <wx/ComboBox.h>
#endif
#ifndef INCLUDED_wx_ControlWithItems
#include <wx/ControlWithItems.h>
#endif
#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_Frame
#include <wx/Frame.h>
#endif
#ifndef INCLUDED_wx_ListBox
#include <wx/ListBox.h>
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

Void Basic_obj::__construct()
{
{
	HX_SOURCE_POS("./Basic.hx",17)
	Array< ::Basic > me = Array_obj< ::Basic >::__new().Add(hx::ObjectPtr<OBJ_>(this));
	HX_SOURCE_POS("./Basic.hx",19)
	this->frame = ::ApplicationMain_obj::frame;
	HX_SOURCE_POS("./Basic.hx",20)
	this->winPanel = ::wx::Panel_obj::create(this->frame,null(),null(),null(),null());
	HX_SOURCE_POS("./Basic.hx",21)
	::wx::Button btnClose = ::wx::Button_obj::create(this->winPanel,null(),HX_CSTRING("Close"),null(),null(),null());

	HX_BEGIN_LOCAL_FUNC_S1(hx::LocalFunc,_Function_1_1,Array< ::Basic >,me)
	Void run(Dynamic _){
{
			HX_SOURCE_POS("./Basic.hx",24)
			me->__get((int)0)->listBox->destroy();
			struct _Function_2_1{
				inline static Dynamic Block( ){
					hx::Anon __result = hx::Anon_obj::Create();
					__result->Add(HX_CSTRING("x") , (int)200,false);
					__result->Add(HX_CSTRING("y") , (int)20,false);
					return __result;
				}
			};
			struct _Function_2_2{
				inline static Dynamic Block( ){
					hx::Anon __result = hx::Anon_obj::Create();
					__result->Add(HX_CSTRING("width") , (int)200,false);
					__result->Add(HX_CSTRING("height") , (int)100,false);
					return __result;
				}
			};
			HX_SOURCE_POS("./Basic.hx",25)
			me->__get((int)0)->listBox = ::wx::ListBox_obj::create(me->__get((int)0)->winPanel,null(),_Function_2_1::Block(),_Function_2_2::Block(),Array_obj< ::String >::__new().Add(HX_CSTRING("d")).Add(HX_CSTRING("e")),null());
		}
		return null();
	}
	HX_END_LOCAL_FUNC1((void))

	HX_SOURCE_POS("./Basic.hx",22)
	btnClose->setOnClick( Dynamic(new _Function_1_1(me)));
	HX_SOURCE_POS("./Basic.hx",28)
	::wx::StaticText staticText = ::wx::StaticText_obj::create(this->winPanel,null(),HX_CSTRING("TextCtrl"),null(),null(),null());
	struct _Function_1_2{
		inline static Dynamic Block( ){
			hx::Anon __result = hx::Anon_obj::Create();
			__result->Add(HX_CSTRING("x") , (int)100,false);
			__result->Add(HX_CSTRING("y") , (int)50,false);
			return __result;
		}
	};
	HX_SOURCE_POS("./Basic.hx",29)
	staticText->setPosition(_Function_1_2::Block());
	HX_SOURCE_POS("./Basic.hx",30)
	staticText->setLabel(HX_CSTRING("Hejsan hoppsan"));
	struct _Function_1_3{
		inline static Dynamic Block( ){
			hx::Anon __result = hx::Anon_obj::Create();
			__result->Add(HX_CSTRING("x") , (int)100,false);
			__result->Add(HX_CSTRING("y") , (int)100,false);
			return __result;
		}
	};
	HX_SOURCE_POS("./Basic.hx",32)
	Array< ::wx::TextCtrl > textCtrl = Array_obj< ::wx::TextCtrl >::__new().Add(::wx::TextCtrl_obj::create(this->winPanel,null(),HX_CSTRING("Hejsan hoppsan textkontroll"),_Function_1_3::Block(),null(),null()));

	HX_BEGIN_LOCAL_FUNC_S1(hx::LocalFunc,_Function_1_4,Array< ::wx::TextCtrl >,textCtrl)
	Void run(Dynamic event){
{
			HX_SOURCE_POS("./Basic.hx",33)
			::haxe::Log_obj::trace(textCtrl->__get((int)0)->getValue(),hx::SourceInfo(HX_CSTRING("Basic.hx"),33,HX_CSTRING("Basic"),HX_CSTRING("new")));
		}
		return null();
	}
	HX_END_LOCAL_FUNC1((void))

	HX_SOURCE_POS("./Basic.hx",33)
	textCtrl->__get((int)0)->setOnTextUpdated( Dynamic(new _Function_1_4(textCtrl)));
	struct _Function_1_5{
		inline static Dynamic Block( ){
			hx::Anon __result = hx::Anon_obj::Create();
			__result->Add(HX_CSTRING("x") , (int)100,false);
			__result->Add(HX_CSTRING("y") , (int)150,false);
			return __result;
		}
	};
	HX_SOURCE_POS("./Basic.hx",35)
	Array< ::wx::ComboBox > comboBox = Array_obj< ::wx::ComboBox >::__new().Add(::wx::ComboBox_obj::create(this->winPanel,null(),HX_CSTRING("Test combo"),_Function_1_5::Block(),null(),null(),(int)200));

	HX_BEGIN_LOCAL_FUNC_S1(hx::LocalFunc,_Function_1_6,Array< ::wx::ComboBox >,comboBox)
	Void run(Dynamic event){
{
			HX_SOURCE_POS("./Basic.hx",38)
			::haxe::Log_obj::trace(event,hx::SourceInfo(HX_CSTRING("Basic.hx"),38,HX_CSTRING("Basic"),HX_CSTRING("new")));
			HX_SOURCE_POS("./Basic.hx",39)
			::haxe::Log_obj::trace(comboBox->__get((int)0)->getValue(),hx::SourceInfo(HX_CSTRING("Basic.hx"),39,HX_CSTRING("Basic"),HX_CSTRING("new")));
		}
		return null();
	}
	HX_END_LOCAL_FUNC1((void))

	HX_SOURCE_POS("./Basic.hx",36)
	comboBox->__get((int)0)->setOnTextUpdated( Dynamic(new _Function_1_6(comboBox)));
	struct _Function_1_7{
		inline static Dynamic Block( ){
			hx::Anon __result = hx::Anon_obj::Create();
			__result->Add(HX_CSTRING("x") , (int)200,false);
			__result->Add(HX_CSTRING("y") , (int)20,false);
			return __result;
		}
	};
	struct _Function_1_8{
		inline static Dynamic Block( ){
			hx::Anon __result = hx::Anon_obj::Create();
			__result->Add(HX_CSTRING("width") , (int)200,false);
			__result->Add(HX_CSTRING("height") , (int)100,false);
			return __result;
		}
	};
	HX_SOURCE_POS("./Basic.hx",43)
	this->listBox = ::wx::ListBox_obj::create(this->winPanel,null(),_Function_1_7::Block(),_Function_1_8::Block(),Array_obj< ::String >::__new().Add(HX_CSTRING("a")).Add(HX_CSTRING("b")).Add(HX_CSTRING("c")),null());
	HX_SOURCE_POS("./Basic.hx",44)
	::haxe::Log_obj::trace(this->listBox->getString((int)0),hx::SourceInfo(HX_CSTRING("Basic.hx"),44,HX_CSTRING("Basic"),HX_CSTRING("new")));
	HX_SOURCE_POS("./Basic.hx",45)
	this->listBox->setString((int)0,HX_CSTRING("ABC"));
}
;
	return null();
}

Basic_obj::~Basic_obj() { }

Dynamic Basic_obj::__CreateEmpty() { return  new Basic_obj; }
hx::ObjectPtr< Basic_obj > Basic_obj::__new()
{  hx::ObjectPtr< Basic_obj > result = new Basic_obj();
	result->__construct();
	return result;}

Dynamic Basic_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Basic_obj > result = new Basic_obj();
	result->__construct();
	return result;}

Void Basic_obj::main( ){
{
		HX_SOURCE_PUSH("Basic_obj::main")
		HX_SOURCE_POS("./Basic.hx",51)
		::Basic_obj::__new();
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Basic_obj,main,(void))


Basic_obj::Basic_obj()
{
}

void Basic_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Basic);
	HX_MARK_MEMBER_NAME(frame,"frame");
	HX_MARK_MEMBER_NAME(winPanel,"winPanel");
	HX_MARK_MEMBER_NAME(listBox,"listBox");
	HX_MARK_END_CLASS();
}

Dynamic Basic_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"main") ) { return main_dyn(); }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"frame") ) { return frame; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"listBox") ) { return listBox; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"winPanel") ) { return winPanel; }
	}
	return super::__Field(inName);
}

Dynamic Basic_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"frame") ) { frame=inValue.Cast< ::wx::Frame >(); return inValue; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"listBox") ) { listBox=inValue.Cast< ::wx::ListBox >(); return inValue; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"winPanel") ) { winPanel=inValue.Cast< ::wx::Window >(); return inValue; }
	}
	return super::__SetField(inName,inValue);
}

void Basic_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("frame"));
	outFields->push(HX_CSTRING("winPanel"));
	outFields->push(HX_CSTRING("listBox"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("main"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("frame"),
	HX_CSTRING("winPanel"),
	HX_CSTRING("listBox"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
};

Class Basic_obj::__mClass;

void Basic_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("Basic"), hx::TCanCast< Basic_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void Basic_obj::__boot()
{
}

