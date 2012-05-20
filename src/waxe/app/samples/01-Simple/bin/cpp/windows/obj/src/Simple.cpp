#include <hxcpp.h>

#ifndef INCLUDED_ApplicationMain
#include <ApplicationMain.h>
#endif
#ifndef INCLUDED_Simple
#include <Simple.h>
#endif
#ifndef INCLUDED_wx_App
#include <wx/App.h>
#endif
#ifndef INCLUDED_wx_BoxSizer
#include <wx/BoxSizer.h>
#endif
#ifndef INCLUDED_wx_Brush
#include <wx/Brush.h>
#endif
#ifndef INCLUDED_wx_Button
#include <wx/Button.h>
#endif
#ifndef INCLUDED_wx_Colour
#include <wx/Colour.h>
#endif
#ifndef INCLUDED_wx_ComboBox
#include <wx/ComboBox.h>
#endif
#ifndef INCLUDED_wx_ControlWithItems
#include <wx/ControlWithItems.h>
#endif
#ifndef INCLUDED_wx_DC
#include <wx/DC.h>
#endif
#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_FlexGridSizer
#include <wx/FlexGridSizer.h>
#endif
#ifndef INCLUDED_wx_Font
#include <wx/Font.h>
#endif
#ifndef INCLUDED_wx_Frame
#include <wx/Frame.h>
#endif
#ifndef INCLUDED_wx_GridSizer
#include <wx/GridSizer.h>
#endif
#ifndef INCLUDED_wx_Panel
#include <wx/Panel.h>
#endif
#ifndef INCLUDED_wx_Pen
#include <wx/Pen.h>
#endif
#ifndef INCLUDED_wx_Sizer
#include <wx/Sizer.h>
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

Void Simple_obj::__construct()
{
{
	HX_SOURCE_POS("./Simple.hx",12)
	this->mFrame = ::ApplicationMain_obj::frame;
	HX_SOURCE_POS("./Simple.hx",27)
	Array< ::Simple > me = Array_obj< ::Simple >::__new().Add(hx::ObjectPtr<OBJ_>(this));

	HX_BEGIN_LOCAL_FUNC_S1(hx::LocalFunc,_Function_1_1,Array< ::Simple >,me)
	Void run(Dynamic evt){
{
			HX_SOURCE_POS("./Simple.hx",28)
			me->__get((int)0)->layout();
			HX_SOURCE_POS("./Simple.hx",28)
			evt->__FieldRef(HX_CSTRING("skip")) = true;
		}
		return null();
	}
	HX_END_LOCAL_FUNC1((void))

	HX_SOURCE_POS("./Simple.hx",28)
	this->mFrame->setOnSize( Dynamic(new _Function_1_1(me)));
	HX_SOURCE_POS("./Simple.hx",30)
	this->mWindow = ::wx::Panel_obj::create(this->mFrame,null(),null(),null(),null());
	HX_SOURCE_POS("./Simple.hx",31)
	this->mDrawArea = ::wx::Panel_obj::create(this->mWindow,null(),null(),null(),null());
	HX_SOURCE_POS("./Simple.hx",34)
	::wx::FlexGridSizer vertical_sizer = ::wx::FlexGridSizer_obj::create(null(),(int)1,null(),null());
	HX_SOURCE_POS("./Simple.hx",35)
	vertical_sizer->addGrowableCol((int)0,null());
	HX_SOURCE_POS("./Simple.hx",36)
	::wx::FlexGridSizer items_sizer = ::wx::FlexGridSizer_obj::create(null(),(int)2,null(),null());
	HX_SOURCE_POS("./Simple.hx",37)
	::wx::BoxSizer button_sizer = ::wx::BoxSizer_obj::create(false);
	HX_SOURCE_POS("./Simple.hx",38)
	vertical_sizer->add(items_sizer,(int)0,::wx::Sizer_obj::EXPAND,null());
	HX_SOURCE_POS("./Simple.hx",39)
	vertical_sizer->add(this->mDrawArea,(int)1,::wx::Sizer_obj::EXPAND,null());
	HX_SOURCE_POS("./Simple.hx",42)
	vertical_sizer->add(button_sizer,(int)0,(int((int(::wx::Sizer_obj::ALIGN_CENTRE) | int(::wx::Sizer_obj::BORDER_TOP))) | int(::wx::Sizer_obj::BORDER_BOTTOM)),(int)10);
	HX_SOURCE_POS("./Simple.hx",44)
	vertical_sizer->addGrowableRow((int)1,null());
	HX_SOURCE_POS("./Simple.hx",45)
	::wx::Button close = ::wx::Button_obj::create(this->mWindow,null(),HX_CSTRING("Close"),null(),null(),null());
	HX_SOURCE_POS("./Simple.hx",46)
	button_sizer->add(close,null(),null(),null());
	HX_SOURCE_POS("./Simple.hx",49)
	items_sizer->addGrowableCol((int)1,(int)1);
	HX_SOURCE_POS("./Simple.hx",50)
	items_sizer->add(::wx::StaticText_obj::create(this->mWindow,null(),HX_CSTRING("TextCtrl"),null(),null(),null()),(int)0,::wx::Sizer_obj::ALIGN_CENTRE_VERTICAL,null());
	HX_SOURCE_POS("./Simple.hx",51)
	::wx::TextCtrl text = ::wx::TextCtrl_obj::create(this->mWindow,null(),HX_CSTRING("Here is some text"),null(),null(),null());
	HX_SOURCE_POS("./Simple.hx",52)
	items_sizer->add(text,(int)1,(int(::wx::Sizer_obj::EXPAND) | int(::wx::Sizer_obj::BORDER_ALL)),(int)10);
	HX_SOURCE_POS("./Simple.hx",54)
	items_sizer->add(::wx::StaticText_obj::create(this->mWindow,null(),HX_CSTRING("ComboBox"),null(),null(),null()),(int)0,::wx::Sizer_obj::ALIGN_CENTRE_VERTICAL,null());
	HX_SOURCE_POS("./Simple.hx",55)
	::wx::ComboBox combo = ::wx::ComboBox_obj::create(this->mWindow,null(),HX_CSTRING("Some Text"),null(),null(),Array_obj< ::String >::__new().Add(HX_CSTRING("Choice 1")).Add(HX_CSTRING("Choice 2")),null());
	HX_SOURCE_POS("./Simple.hx",56)
	items_sizer->add(combo,(int)1,(int(::wx::Sizer_obj::EXPAND) | int(::wx::Sizer_obj::BORDER_ALL)),(int)10);
	HX_SOURCE_POS("./Simple.hx",58)
	items_sizer->add(::wx::StaticText_obj::create(this->mWindow,null(),HX_CSTRING("Text 3"),null(),null(),null()),(int)0,::wx::Sizer_obj::ALIGN_CENTRE_VERTICAL,null());
	HX_SOURCE_POS("./Simple.hx",59)
	::wx::TextCtrl text1 = ::wx::TextCtrl_obj::create(this->mWindow,null(),HX_CSTRING("Hello !"),null(),null(),null());
	HX_SOURCE_POS("./Simple.hx",60)
	items_sizer->add(text1,(int)1,(int(::wx::Sizer_obj::EXPAND) | int(::wx::Sizer_obj::BORDER_ALL)),(int)10);
	HX_SOURCE_POS("./Simple.hx",64)
	this->mWindow->setSizer(vertical_sizer);
	HX_SOURCE_POS("./Simple.hx",66)
	this->mDrawArea->setBackgroundColour((int)16777215);

	HX_BEGIN_LOCAL_FUNC_S0(hx::LocalFunc,_Function_1_2)
	Void run(Dynamic _){
{
			HX_SOURCE_POS("./Simple.hx",67)
			::wx::App_obj::quit();
		}
		return null();
	}
	HX_END_LOCAL_FUNC1((void))

	HX_SOURCE_POS("./Simple.hx",67)
	close->setOnClick( Dynamic(new _Function_1_2()));
	HX_SOURCE_POS("./Simple.hx",69)
	this->layout();
	HX_SOURCE_POS("./Simple.hx",71)
	this->mDrawArea->setOnPaint(this->paintWindow_dyn());
	HX_SOURCE_POS("./Simple.hx",72)
	::wx::App_obj::setTopWindow(this->mFrame);
	HX_SOURCE_POS("./Simple.hx",73)
	this->mFrame->show(true);
}
;
	return null();
}

Simple_obj::~Simple_obj() { }

Dynamic Simple_obj::__CreateEmpty() { return  new Simple_obj; }
hx::ObjectPtr< Simple_obj > Simple_obj::__new()
{  hx::ObjectPtr< Simple_obj > result = new Simple_obj();
	result->__construct();
	return result;}

Dynamic Simple_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Simple_obj > result = new Simple_obj();
	result->__construct();
	return result;}

Void Simple_obj::paintWindow( ::wx::DC dc){
{
		HX_SOURCE_PUSH("Simple_obj::paintWindow")
		HX_SOURCE_POS("./Simple.hx",78)
		dc->clear();
		HX_SOURCE_POS("./Simple.hx",79)
		dc->setPen(::wx::Pen_obj::__new(::wx::Colour_obj::Pink(),(int)3,null()));
		HX_SOURCE_POS("./Simple.hx",80)
		dc->drawLine((int)0,(int)0,(int)300,(int)250);
		HX_SOURCE_POS("./Simple.hx",81)
		dc->setBrush(::wx::Brush_obj::__new(::wx::Colour_obj::Yellow(),::wx::Brush_obj::SOLID));
		HX_SOURCE_POS("./Simple.hx",82)
		dc->drawRectangle((int)100,(int)100,(int)100,(int)200);
		HX_SOURCE_POS("./Simple.hx",83)
		dc->setBrush(::wx::Brush_obj::__new(::wx::Colour_obj::DarkGreen(),::wx::Brush_obj::SOLID));
		HX_SOURCE_POS("./Simple.hx",84)
		dc->setPen(::wx::Pen_obj::__new(::wx::Colour_obj::Black(),(int)3,::wx::Pen_obj::SHORT_DASH));
		HX_SOURCE_POS("./Simple.hx",85)
		dc->drawCircle((int)100,(int)10,(int)50);
		HX_SOURCE_POS("./Simple.hx",86)
		dc->drawEllipse((int)100,(int)200,(int)200,(int)40);
		HX_SOURCE_POS("./Simple.hx",87)
		dc->setFont(::wx::Font_obj::__new((int)20,null(),null(),null(),null(),null()));
		HX_SOURCE_POS("./Simple.hx",88)
		dc->drawText(HX_CSTRING("Hello!"),(int)20,(int)20);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(Simple_obj,paintWindow,(void))

Void Simple_obj::layout( ){
{
		HX_SOURCE_PUSH("Simple_obj::layout")
		HX_SOURCE_POS("./Simple.hx",92)
		this->mWindow->setSize(this->mFrame->getClientSize());
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC0(Simple_obj,layout,(void))

Void Simple_obj::main( ){
{
		HX_SOURCE_PUSH("Simple_obj::main")
		HX_SOURCE_POS("./Simple.hx",97)
		::Simple_obj::__new();
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Simple_obj,main,(void))


Simple_obj::Simple_obj()
{
}

void Simple_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Simple);
	HX_MARK_MEMBER_NAME(mFrame,"mFrame");
	HX_MARK_MEMBER_NAME(mWindow,"mWindow");
	HX_MARK_MEMBER_NAME(mDrawArea,"mDrawArea");
	HX_MARK_END_CLASS();
}

Dynamic Simple_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"main") ) { return main_dyn(); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"mFrame") ) { return mFrame; }
		if (HX_FIELD_EQ(inName,"layout") ) { return layout_dyn(); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"mWindow") ) { return mWindow; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"mDrawArea") ) { return mDrawArea; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"paintWindow") ) { return paintWindow_dyn(); }
	}
	return super::__Field(inName);
}

Dynamic Simple_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"mFrame") ) { mFrame=inValue.Cast< ::wx::Frame >(); return inValue; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"mWindow") ) { mWindow=inValue.Cast< ::wx::Window >(); return inValue; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"mDrawArea") ) { mDrawArea=inValue.Cast< ::wx::Window >(); return inValue; }
	}
	return super::__SetField(inName,inValue);
}

void Simple_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("mFrame"));
	outFields->push(HX_CSTRING("mWindow"));
	outFields->push(HX_CSTRING("mDrawArea"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("main"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("mFrame"),
	HX_CSTRING("mWindow"),
	HX_CSTRING("mDrawArea"),
	HX_CSTRING("paintWindow"),
	HX_CSTRING("layout"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
};

Class Simple_obj::__mClass;

void Simple_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("Simple"), hx::TCanCast< Simple_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void Simple_obj::__boot()
{
}

