#include <hxcpp.h>

#ifndef INCLUDED_IntHash
#include <IntHash.h>
#endif
#ifndef INCLUDED_wx_DC
#include <wx/DC.h>
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
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
#ifndef INCLUDED_wx_Sizer
#include <wx/Sizer.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif
namespace wx{

Void Window_obj::__construct(Dynamic inHandle)
{
{
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",80)
	super::__construct(inHandle);
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",81)
	this->wxEventHandlers = ::IntHash_obj::__new();
}
;
	return null();
}

Window_obj::~Window_obj() { }

Dynamic Window_obj::__CreateEmpty() { return  new Window_obj; }
hx::ObjectPtr< Window_obj > Window_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< Window_obj > result = new Window_obj();
	result->__construct(inHandle);
	return result;}

Dynamic Window_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Window_obj > result = new Window_obj();
	result->__construct(inArgs[0]);
	return result;}

Void Window_obj::HandleEvent( Dynamic event){
{
		HX_SOURCE_PUSH("Window_obj::HandleEvent")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",87)
		int type = event->__Field(HX_CSTRING("type"),true);
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",90)
		{
		}
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",96)
		if ((this->wxEventHandlers->exists(type))){
			HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",98)
			Dynamic func = this->wxEventHandlers->get(type);
			HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",99)
			if (((func != null()))){
				HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",101)
				event->__FieldRef(HX_CSTRING("skip")) = false;
				HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",102)
				func(event).Cast< Void >();
			}
		}
	}
return null();
}


Void Window_obj::setHandler( ::wx::EventID inID,Dynamic inFunc){
{
		HX_SOURCE_PUSH("Window_obj::setHandler")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",108)
		this->wxEventHandlers->set(inID->__Index(),inFunc);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC2(Window_obj,setHandler,(void))

Void Window_obj::fit( ){
{
		HX_SOURCE_PUSH("Window_obj::fit")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",112)
		::wx::Window_obj::wx_window_fit(this->wxHandle);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC0(Window_obj,fit,(void))

Void Window_obj::refresh( ){
{
		HX_SOURCE_PUSH("Window_obj::refresh")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",113)
		::wx::Window_obj::wx_window_refresh(this->wxHandle);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC0(Window_obj,refresh,(void))

Void Window_obj::destroy( ){
{
		HX_SOURCE_PUSH("Window_obj::destroy")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",114)
		::wx::Window_obj::wx_window_destroy(this->wxHandle);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC0(Window_obj,destroy,(void))

Dynamic Window_obj::getSize( ){
	HX_SOURCE_PUSH("Window_obj::getSize")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",116)
	return ::wx::Window_obj::wx_window_get_size(this->wxHandle);
}


HX_DEFINE_DYNAMIC_FUNC0(Window_obj,getSize,return )

Dynamic Window_obj::setSize( Dynamic inSize){
	HX_SOURCE_PUSH("Window_obj::setSize")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",119)
	::wx::Window_obj::wx_window_set_size(this->wxHandle,inSize);
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",120)
	return inSize;
}


HX_DEFINE_DYNAMIC_FUNC1(Window_obj,setSize,return )

::wx::Sizer Window_obj::getSizer( ){
	HX_SOURCE_PUSH("Window_obj::getSizer")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",123)
	return ::wx::Window_obj::wx_window_get_sizer(this->wxHandle);
}


HX_DEFINE_DYNAMIC_FUNC0(Window_obj,getSizer,return )

::wx::Sizer Window_obj::setSizer( ::wx::Sizer inSizer){
	HX_SOURCE_PUSH("Window_obj::setSizer")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",126)
	::wx::Window_obj::wx_window_set_sizer(this->wxHandle,inSizer->wxGetHandle());
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",127)
	return inSizer;
}


HX_DEFINE_DYNAMIC_FUNC1(Window_obj,setSizer,return )

Dynamic Window_obj::getClientSize( ){
	HX_SOURCE_PUSH("Window_obj::getClientSize")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",130)
	return ::wx::Window_obj::wx_window_get_client_size(this->wxHandle);
}


HX_DEFINE_DYNAMIC_FUNC0(Window_obj,getClientSize,return )

Dynamic Window_obj::setClientSize( Dynamic inSize){
	HX_SOURCE_PUSH("Window_obj::setClientSize")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",133)
	::wx::Window_obj::wx_window_set_client_size(this->wxHandle,inSize->__Field(HX_CSTRING("width"),true),inSize->__Field(HX_CSTRING("height"),true));
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",134)
	return inSize;
}


HX_DEFINE_DYNAMIC_FUNC1(Window_obj,setClientSize,return )

Dynamic Window_obj::getPosition( ){
	HX_SOURCE_PUSH("Window_obj::getPosition")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",137)
	return ::wx::Window_obj::wx_window_get_position(this->wxHandle);
}


HX_DEFINE_DYNAMIC_FUNC0(Window_obj,getPosition,return )

Dynamic Window_obj::setPosition( Dynamic inPos){
	HX_SOURCE_PUSH("Window_obj::setPosition")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",140)
	::wx::Window_obj::wx_window_set_position(this->wxHandle,inPos);
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",141)
	return inPos;
}


HX_DEFINE_DYNAMIC_FUNC1(Window_obj,setPosition,return )

bool Window_obj::isShown( ){
	HX_SOURCE_PUSH("Window_obj::isShown")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",144)
	return ::wx::Window_obj::wx_window_get_shown(this->wxHandle);
}


HX_DEFINE_DYNAMIC_FUNC0(Window_obj,isShown,return )

bool Window_obj::show( hx::Null< bool >  __o_inShow){
bool inShow = __o_inShow.Default(true);
	HX_SOURCE_PUSH("Window_obj::show");
{
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",147)
		::wx::Window_obj::wx_window_set_shown(this->wxHandle,inShow);
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",148)
		return inShow;
	}
}


HX_DEFINE_DYNAMIC_FUNC1(Window_obj,show,return )

int Window_obj::getBackgroundColour( ){
	HX_SOURCE_PUSH("Window_obj::getBackgroundColour")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",151)
	return ::wx::Window_obj::wx_window_get_bg_colour(this->wxHandle);
}


HX_DEFINE_DYNAMIC_FUNC0(Window_obj,getBackgroundColour,return )

int Window_obj::setBackgroundColour( int inColour){
	HX_SOURCE_PUSH("Window_obj::setBackgroundColour")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",154)
	::wx::Window_obj::wx_window_set_bg_colour(this->wxHandle,inColour);
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",155)
	return inColour;
}


HX_DEFINE_DYNAMIC_FUNC1(Window_obj,setBackgroundColour,return )

::String Window_obj::getName( ){
	HX_SOURCE_PUSH("Window_obj::getName")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",158)
	return ::wx::Window_obj::wx_window_get_name(this->wxHandle);
}


HX_DEFINE_DYNAMIC_FUNC0(Window_obj,getName,return )

::String Window_obj::setName( ::String inName){
	HX_SOURCE_PUSH("Window_obj::setName")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",161)
	::wx::Window_obj::wx_window_set_name(this->wxHandle,inName);
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",162)
	return inName;
}


HX_DEFINE_DYNAMIC_FUNC1(Window_obj,setName,return )

Dynamic Window_obj::setOnClose( Dynamic f){
	HX_SOURCE_PUSH("Window_obj::setOnClose")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",171)
	this->setHandler(::wx::EventID_obj::CLOSE_WINDOW_dyn(),f);
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",171)
	return f;
}


HX_DEFINE_DYNAMIC_FUNC1(Window_obj,setOnClose,return )

Dynamic Window_obj::setOnSize( Dynamic f){
	HX_SOURCE_PUSH("Window_obj::setOnSize")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",173)
	this->setHandler(::wx::EventID_obj::SIZE_dyn(),f);
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",173)
	return f;
}


HX_DEFINE_DYNAMIC_FUNC1(Window_obj,setOnSize,return )

Dynamic Window_obj::setOnPaint( Dynamic f){
	HX_SOURCE_PUSH("Window_obj::setOnPaint")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",175)
	Dynamic f1 = Dynamic( Array_obj<Dynamic>::__new().Add(f));
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",177)
	Array< ::wx::Window > me = Array_obj< ::wx::Window >::__new().Add(hx::ObjectPtr<OBJ_>(this));

	HX_BEGIN_LOCAL_FUNC_S2(hx::LocalFunc,_Function_1_1,Array< ::wx::Window >,me,Dynamic,f1)
	Void run(Dynamic _){
{
			HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",179)
			::wx::DC dc = ::wx::DC_obj::createPaintDC(me->__get((int)0));
			HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",179)
			f1->__GetItem((int)0)(dc).Cast< Void >();
			HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",179)
			dc->destroy();
		}
		return null();
	}
	HX_END_LOCAL_FUNC1((void))

	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",178)
	this->setHandler(::wx::EventID_obj::PAINT_dyn(), Dynamic(new _Function_1_1(me,f1)));
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",180)
	return f1->__GetItem((int)0);
}


HX_DEFINE_DYNAMIC_FUNC1(Window_obj,setOnPaint,return )

int Window_obj::CENTRE;

int Window_obj::FRAME_NO_TASKBAR;

int Window_obj::FRAME_TOOL_WINDOW;

int Window_obj::FRAME_FLOAT_ON_PARENT;

int Window_obj::FRAME_SHAPED;

int Window_obj::RESIZE_BORDER;

int Window_obj::TINY_CAPTION_VERT;

int Window_obj::DIALOG_NO_PARENT;

int Window_obj::MAXIMIZE_BOX;

int Window_obj::MINIMIZE_BOX;

int Window_obj::SYSTEM_MENU;

int Window_obj::CLOSE_BOX;

int Window_obj::MAXIMIZE;

int Window_obj::MINIMIZE;

int Window_obj::STAY_ON_TOP;

int Window_obj::FULL_REPAINT_ON_RESIZE;

int Window_obj::POPUP_WINDOW;

int Window_obj::WANTS_CHARS;

int Window_obj::TAB_TRAVERSAL;

int Window_obj::TRANSPARENT_WINDOW;

int Window_obj::BORDER_NONE;

int Window_obj::CLIP_CHILDREN;

int Window_obj::ALWAYS_SHOW_SB;

int Window_obj::BORDER_STATIC;

int Window_obj::BORDER_SIMPLE;

int Window_obj::BORDER_RAISED;

int Window_obj::BORDER_SUNKEN;

int Window_obj::BORDER_DOUBLE;

int Window_obj::CAPTION;

int Window_obj::CLIP_SIBLINGS;

int Window_obj::HSCROLL;

int Window_obj::VSCROLL;

::String Window_obj::INVALID_PARENT;

::wx::Window Window_obj::create( ::wx::Window inParent,Dynamic inID,Dynamic inPosition,Dynamic inSize,Dynamic inStyle){
	HX_SOURCE_PUSH("Window_obj::create")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",72)
	if (((inParent == null()))){
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",73)
		hx::Throw (::wx::Error_obj::INVALID_PARENT);
	}
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",74)
	Dynamic handle = ::wx::Window_obj::wx_window_create(Dynamic( Array_obj<Dynamic>::__new().Add(inParent->wxHandle).Add(inID).Add(HX_CSTRING("")).Add(inPosition).Add(inSize).Add(inStyle)));
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Window.hx",75)
	return ::wx::Window_obj::__new(handle);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC5(Window_obj,create,return )

Dynamic Window_obj::wx_window_get_position;

Dynamic Window_obj::wx_window_set_position;

Dynamic Window_obj::wx_window_get_size;

Dynamic Window_obj::wx_window_set_size;

Dynamic Window_obj::wx_window_get_client_size;

Dynamic Window_obj::wx_window_set_client_size;

Dynamic Window_obj::wx_window_create;

Dynamic Window_obj::wx_window_set_sizer;

Dynamic Window_obj::wx_window_get_sizer;

Dynamic Window_obj::wx_window_fit;

Dynamic Window_obj::wx_window_get_shown;

Dynamic Window_obj::wx_window_set_shown;

Dynamic Window_obj::wx_window_get_bg_colour;

Dynamic Window_obj::wx_window_set_bg_colour;

Dynamic Window_obj::wx_window_get_name;

Dynamic Window_obj::wx_window_set_name;

Dynamic Window_obj::wx_window_refresh;

Dynamic Window_obj::wx_window_destroy;


Window_obj::Window_obj()
{
}

void Window_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Window);
	HX_MARK_MEMBER_NAME(wxEventHandlers,"wxEventHandlers");
	HX_MARK_MEMBER_NAME(size,"size");
	HX_MARK_MEMBER_NAME(sizer,"sizer");
	HX_MARK_MEMBER_NAME(clientSize,"clientSize");
	HX_MARK_MEMBER_NAME(position,"position");
	HX_MARK_MEMBER_NAME(shown,"shown");
	HX_MARK_MEMBER_NAME(name,"name");
	HX_MARK_MEMBER_NAME(backgroundColour,"backgroundColour");
	HX_MARK_MEMBER_NAME(onClose,"onClose");
	HX_MARK_MEMBER_NAME(onSize,"onSize");
	HX_MARK_MEMBER_NAME(onPaint,"onPaint");
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic Window_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 3:
		if (HX_FIELD_EQ(inName,"fit") ) { return fit_dyn(); }
		break;
	case 4:
		if (HX_FIELD_EQ(inName,"size") ) { return inCallProp ? getSize() : size; }
		if (HX_FIELD_EQ(inName,"name") ) { return inCallProp ? getName() : name; }
		if (HX_FIELD_EQ(inName,"show") ) { return show_dyn(); }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"sizer") ) { return inCallProp ? getSizer() : sizer; }
		if (HX_FIELD_EQ(inName,"shown") ) { return inCallProp ? isShown() : shown; }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"CENTRE") ) { return CENTRE; }
		if (HX_FIELD_EQ(inName,"create") ) { return create_dyn(); }
		if (HX_FIELD_EQ(inName,"onSize") ) { return onSize; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"CAPTION") ) { return CAPTION; }
		if (HX_FIELD_EQ(inName,"HSCROLL") ) { return HSCROLL; }
		if (HX_FIELD_EQ(inName,"VSCROLL") ) { return VSCROLL; }
		if (HX_FIELD_EQ(inName,"refresh") ) { return refresh_dyn(); }
		if (HX_FIELD_EQ(inName,"destroy") ) { return destroy_dyn(); }
		if (HX_FIELD_EQ(inName,"getSize") ) { return getSize_dyn(); }
		if (HX_FIELD_EQ(inName,"setSize") ) { return setSize_dyn(); }
		if (HX_FIELD_EQ(inName,"isShown") ) { return isShown_dyn(); }
		if (HX_FIELD_EQ(inName,"getName") ) { return getName_dyn(); }
		if (HX_FIELD_EQ(inName,"setName") ) { return setName_dyn(); }
		if (HX_FIELD_EQ(inName,"onClose") ) { return onClose; }
		if (HX_FIELD_EQ(inName,"onPaint") ) { return onPaint; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"MAXIMIZE") ) { return MAXIMIZE; }
		if (HX_FIELD_EQ(inName,"MINIMIZE") ) { return MINIMIZE; }
		if (HX_FIELD_EQ(inName,"position") ) { return inCallProp ? getPosition() : position; }
		if (HX_FIELD_EQ(inName,"getSizer") ) { return getSizer_dyn(); }
		if (HX_FIELD_EQ(inName,"setSizer") ) { return setSizer_dyn(); }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"CLOSE_BOX") ) { return CLOSE_BOX; }
		if (HX_FIELD_EQ(inName,"setOnSize") ) { return setOnSize_dyn(); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"clientSize") ) { return inCallProp ? getClientSize() : clientSize; }
		if (HX_FIELD_EQ(inName,"setHandler") ) { return setHandler_dyn(); }
		if (HX_FIELD_EQ(inName,"setOnClose") ) { return setOnClose_dyn(); }
		if (HX_FIELD_EQ(inName,"setOnPaint") ) { return setOnPaint_dyn(); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"SYSTEM_MENU") ) { return SYSTEM_MENU; }
		if (HX_FIELD_EQ(inName,"STAY_ON_TOP") ) { return STAY_ON_TOP; }
		if (HX_FIELD_EQ(inName,"WANTS_CHARS") ) { return WANTS_CHARS; }
		if (HX_FIELD_EQ(inName,"BORDER_NONE") ) { return BORDER_NONE; }
		if (HX_FIELD_EQ(inName,"HandleEvent") ) { return HandleEvent_dyn(); }
		if (HX_FIELD_EQ(inName,"getPosition") ) { return getPosition_dyn(); }
		if (HX_FIELD_EQ(inName,"setPosition") ) { return setPosition_dyn(); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"FRAME_SHAPED") ) { return FRAME_SHAPED; }
		if (HX_FIELD_EQ(inName,"MAXIMIZE_BOX") ) { return MAXIMIZE_BOX; }
		if (HX_FIELD_EQ(inName,"MINIMIZE_BOX") ) { return MINIMIZE_BOX; }
		if (HX_FIELD_EQ(inName,"POPUP_WINDOW") ) { return POPUP_WINDOW; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"RESIZE_BORDER") ) { return RESIZE_BORDER; }
		if (HX_FIELD_EQ(inName,"TAB_TRAVERSAL") ) { return TAB_TRAVERSAL; }
		if (HX_FIELD_EQ(inName,"CLIP_CHILDREN") ) { return CLIP_CHILDREN; }
		if (HX_FIELD_EQ(inName,"BORDER_STATIC") ) { return BORDER_STATIC; }
		if (HX_FIELD_EQ(inName,"BORDER_SIMPLE") ) { return BORDER_SIMPLE; }
		if (HX_FIELD_EQ(inName,"BORDER_RAISED") ) { return BORDER_RAISED; }
		if (HX_FIELD_EQ(inName,"BORDER_SUNKEN") ) { return BORDER_SUNKEN; }
		if (HX_FIELD_EQ(inName,"BORDER_DOUBLE") ) { return BORDER_DOUBLE; }
		if (HX_FIELD_EQ(inName,"CLIP_SIBLINGS") ) { return CLIP_SIBLINGS; }
		if (HX_FIELD_EQ(inName,"wx_window_fit") ) { return wx_window_fit; }
		if (HX_FIELD_EQ(inName,"getClientSize") ) { return getClientSize_dyn(); }
		if (HX_FIELD_EQ(inName,"setClientSize") ) { return setClientSize_dyn(); }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"ALWAYS_SHOW_SB") ) { return ALWAYS_SHOW_SB; }
		if (HX_FIELD_EQ(inName,"INVALID_PARENT") ) { return INVALID_PARENT; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"wxEventHandlers") ) { return wxEventHandlers; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"FRAME_NO_TASKBAR") ) { return FRAME_NO_TASKBAR; }
		if (HX_FIELD_EQ(inName,"DIALOG_NO_PARENT") ) { return DIALOG_NO_PARENT; }
		if (HX_FIELD_EQ(inName,"wx_window_create") ) { return wx_window_create; }
		if (HX_FIELD_EQ(inName,"backgroundColour") ) { return inCallProp ? getBackgroundColour() : backgroundColour; }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"FRAME_TOOL_WINDOW") ) { return FRAME_TOOL_WINDOW; }
		if (HX_FIELD_EQ(inName,"TINY_CAPTION_VERT") ) { return TINY_CAPTION_VERT; }
		if (HX_FIELD_EQ(inName,"wx_window_refresh") ) { return wx_window_refresh; }
		if (HX_FIELD_EQ(inName,"wx_window_destroy") ) { return wx_window_destroy; }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"TRANSPARENT_WINDOW") ) { return TRANSPARENT_WINDOW; }
		if (HX_FIELD_EQ(inName,"wx_window_get_size") ) { return wx_window_get_size; }
		if (HX_FIELD_EQ(inName,"wx_window_set_size") ) { return wx_window_set_size; }
		if (HX_FIELD_EQ(inName,"wx_window_get_name") ) { return wx_window_get_name; }
		if (HX_FIELD_EQ(inName,"wx_window_set_name") ) { return wx_window_set_name; }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"wx_window_set_sizer") ) { return wx_window_set_sizer; }
		if (HX_FIELD_EQ(inName,"wx_window_get_sizer") ) { return wx_window_get_sizer; }
		if (HX_FIELD_EQ(inName,"wx_window_get_shown") ) { return wx_window_get_shown; }
		if (HX_FIELD_EQ(inName,"wx_window_set_shown") ) { return wx_window_set_shown; }
		if (HX_FIELD_EQ(inName,"getBackgroundColour") ) { return getBackgroundColour_dyn(); }
		if (HX_FIELD_EQ(inName,"setBackgroundColour") ) { return setBackgroundColour_dyn(); }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"FRAME_FLOAT_ON_PARENT") ) { return FRAME_FLOAT_ON_PARENT; }
		break;
	case 22:
		if (HX_FIELD_EQ(inName,"FULL_REPAINT_ON_RESIZE") ) { return FULL_REPAINT_ON_RESIZE; }
		if (HX_FIELD_EQ(inName,"wx_window_get_position") ) { return wx_window_get_position; }
		if (HX_FIELD_EQ(inName,"wx_window_set_position") ) { return wx_window_set_position; }
		break;
	case 23:
		if (HX_FIELD_EQ(inName,"wx_window_get_bg_colour") ) { return wx_window_get_bg_colour; }
		if (HX_FIELD_EQ(inName,"wx_window_set_bg_colour") ) { return wx_window_set_bg_colour; }
		break;
	case 25:
		if (HX_FIELD_EQ(inName,"wx_window_get_client_size") ) { return wx_window_get_client_size; }
		if (HX_FIELD_EQ(inName,"wx_window_set_client_size") ) { return wx_window_set_client_size; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic Window_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"size") ) { if (inCallProp) return setSize(inValue);size=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"name") ) { if (inCallProp) return setName(inValue);name=inValue.Cast< ::String >(); return inValue; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"sizer") ) { if (inCallProp) return setSizer(inValue);sizer=inValue.Cast< ::wx::Sizer >(); return inValue; }
		if (HX_FIELD_EQ(inName,"shown") ) { if (inCallProp) return show(inValue);shown=inValue.Cast< bool >(); return inValue; }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"CENTRE") ) { CENTRE=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"onSize") ) { if (inCallProp) return setOnSize(inValue);onSize=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"CAPTION") ) { CAPTION=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"HSCROLL") ) { HSCROLL=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"VSCROLL") ) { VSCROLL=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"onClose") ) { if (inCallProp) return setOnClose(inValue);onClose=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"onPaint") ) { if (inCallProp) return setOnPaint(inValue);onPaint=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"MAXIMIZE") ) { MAXIMIZE=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"MINIMIZE") ) { MINIMIZE=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"position") ) { if (inCallProp) return setPosition(inValue);position=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"CLOSE_BOX") ) { CLOSE_BOX=inValue.Cast< int >(); return inValue; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"clientSize") ) { if (inCallProp) return setClientSize(inValue);clientSize=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"SYSTEM_MENU") ) { SYSTEM_MENU=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"STAY_ON_TOP") ) { STAY_ON_TOP=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"WANTS_CHARS") ) { WANTS_CHARS=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"BORDER_NONE") ) { BORDER_NONE=inValue.Cast< int >(); return inValue; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"FRAME_SHAPED") ) { FRAME_SHAPED=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"MAXIMIZE_BOX") ) { MAXIMIZE_BOX=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"MINIMIZE_BOX") ) { MINIMIZE_BOX=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"POPUP_WINDOW") ) { POPUP_WINDOW=inValue.Cast< int >(); return inValue; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"RESIZE_BORDER") ) { RESIZE_BORDER=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"TAB_TRAVERSAL") ) { TAB_TRAVERSAL=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"CLIP_CHILDREN") ) { CLIP_CHILDREN=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"BORDER_STATIC") ) { BORDER_STATIC=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"BORDER_SIMPLE") ) { BORDER_SIMPLE=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"BORDER_RAISED") ) { BORDER_RAISED=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"BORDER_SUNKEN") ) { BORDER_SUNKEN=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"BORDER_DOUBLE") ) { BORDER_DOUBLE=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"CLIP_SIBLINGS") ) { CLIP_SIBLINGS=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_window_fit") ) { wx_window_fit=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"ALWAYS_SHOW_SB") ) { ALWAYS_SHOW_SB=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"INVALID_PARENT") ) { INVALID_PARENT=inValue.Cast< ::String >(); return inValue; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"wxEventHandlers") ) { wxEventHandlers=inValue.Cast< ::IntHash >(); return inValue; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"FRAME_NO_TASKBAR") ) { FRAME_NO_TASKBAR=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"DIALOG_NO_PARENT") ) { DIALOG_NO_PARENT=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_window_create") ) { wx_window_create=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"backgroundColour") ) { if (inCallProp) return setBackgroundColour(inValue);backgroundColour=inValue.Cast< int >(); return inValue; }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"FRAME_TOOL_WINDOW") ) { FRAME_TOOL_WINDOW=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"TINY_CAPTION_VERT") ) { TINY_CAPTION_VERT=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_window_refresh") ) { wx_window_refresh=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_window_destroy") ) { wx_window_destroy=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"TRANSPARENT_WINDOW") ) { TRANSPARENT_WINDOW=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_window_get_size") ) { wx_window_get_size=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_window_set_size") ) { wx_window_set_size=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_window_get_name") ) { wx_window_get_name=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_window_set_name") ) { wx_window_set_name=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"wx_window_set_sizer") ) { wx_window_set_sizer=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_window_get_sizer") ) { wx_window_get_sizer=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_window_get_shown") ) { wx_window_get_shown=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_window_set_shown") ) { wx_window_set_shown=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"FRAME_FLOAT_ON_PARENT") ) { FRAME_FLOAT_ON_PARENT=inValue.Cast< int >(); return inValue; }
		break;
	case 22:
		if (HX_FIELD_EQ(inName,"FULL_REPAINT_ON_RESIZE") ) { FULL_REPAINT_ON_RESIZE=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_window_get_position") ) { wx_window_get_position=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_window_set_position") ) { wx_window_set_position=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 23:
		if (HX_FIELD_EQ(inName,"wx_window_get_bg_colour") ) { wx_window_get_bg_colour=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_window_set_bg_colour") ) { wx_window_set_bg_colour=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 25:
		if (HX_FIELD_EQ(inName,"wx_window_get_client_size") ) { wx_window_get_client_size=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_window_set_client_size") ) { wx_window_set_client_size=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void Window_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("wxEventHandlers"));
	outFields->push(HX_CSTRING("size"));
	outFields->push(HX_CSTRING("sizer"));
	outFields->push(HX_CSTRING("clientSize"));
	outFields->push(HX_CSTRING("position"));
	outFields->push(HX_CSTRING("shown"));
	outFields->push(HX_CSTRING("name"));
	outFields->push(HX_CSTRING("backgroundColour"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("CENTRE"),
	HX_CSTRING("FRAME_NO_TASKBAR"),
	HX_CSTRING("FRAME_TOOL_WINDOW"),
	HX_CSTRING("FRAME_FLOAT_ON_PARENT"),
	HX_CSTRING("FRAME_SHAPED"),
	HX_CSTRING("RESIZE_BORDER"),
	HX_CSTRING("TINY_CAPTION_VERT"),
	HX_CSTRING("DIALOG_NO_PARENT"),
	HX_CSTRING("MAXIMIZE_BOX"),
	HX_CSTRING("MINIMIZE_BOX"),
	HX_CSTRING("SYSTEM_MENU"),
	HX_CSTRING("CLOSE_BOX"),
	HX_CSTRING("MAXIMIZE"),
	HX_CSTRING("MINIMIZE"),
	HX_CSTRING("STAY_ON_TOP"),
	HX_CSTRING("FULL_REPAINT_ON_RESIZE"),
	HX_CSTRING("POPUP_WINDOW"),
	HX_CSTRING("WANTS_CHARS"),
	HX_CSTRING("TAB_TRAVERSAL"),
	HX_CSTRING("TRANSPARENT_WINDOW"),
	HX_CSTRING("BORDER_NONE"),
	HX_CSTRING("CLIP_CHILDREN"),
	HX_CSTRING("ALWAYS_SHOW_SB"),
	HX_CSTRING("BORDER_STATIC"),
	HX_CSTRING("BORDER_SIMPLE"),
	HX_CSTRING("BORDER_RAISED"),
	HX_CSTRING("BORDER_SUNKEN"),
	HX_CSTRING("BORDER_DOUBLE"),
	HX_CSTRING("CAPTION"),
	HX_CSTRING("CLIP_SIBLINGS"),
	HX_CSTRING("HSCROLL"),
	HX_CSTRING("VSCROLL"),
	HX_CSTRING("INVALID_PARENT"),
	HX_CSTRING("create"),
	HX_CSTRING("wx_window_get_position"),
	HX_CSTRING("wx_window_set_position"),
	HX_CSTRING("wx_window_get_size"),
	HX_CSTRING("wx_window_set_size"),
	HX_CSTRING("wx_window_get_client_size"),
	HX_CSTRING("wx_window_set_client_size"),
	HX_CSTRING("wx_window_create"),
	HX_CSTRING("wx_window_set_sizer"),
	HX_CSTRING("wx_window_get_sizer"),
	HX_CSTRING("wx_window_fit"),
	HX_CSTRING("wx_window_get_shown"),
	HX_CSTRING("wx_window_set_shown"),
	HX_CSTRING("wx_window_get_bg_colour"),
	HX_CSTRING("wx_window_set_bg_colour"),
	HX_CSTRING("wx_window_get_name"),
	HX_CSTRING("wx_window_set_name"),
	HX_CSTRING("wx_window_refresh"),
	HX_CSTRING("wx_window_destroy"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("wxEventHandlers"),
	HX_CSTRING("size"),
	HX_CSTRING("sizer"),
	HX_CSTRING("clientSize"),
	HX_CSTRING("position"),
	HX_CSTRING("shown"),
	HX_CSTRING("name"),
	HX_CSTRING("backgroundColour"),
	HX_CSTRING("HandleEvent"),
	HX_CSTRING("setHandler"),
	HX_CSTRING("fit"),
	HX_CSTRING("refresh"),
	HX_CSTRING("destroy"),
	HX_CSTRING("getSize"),
	HX_CSTRING("setSize"),
	HX_CSTRING("getSizer"),
	HX_CSTRING("setSizer"),
	HX_CSTRING("getClientSize"),
	HX_CSTRING("setClientSize"),
	HX_CSTRING("getPosition"),
	HX_CSTRING("setPosition"),
	HX_CSTRING("isShown"),
	HX_CSTRING("show"),
	HX_CSTRING("getBackgroundColour"),
	HX_CSTRING("setBackgroundColour"),
	HX_CSTRING("getName"),
	HX_CSTRING("setName"),
	HX_CSTRING("onClose"),
	HX_CSTRING("setOnClose"),
	HX_CSTRING("onSize"),
	HX_CSTRING("setOnSize"),
	HX_CSTRING("onPaint"),
	HX_CSTRING("setOnPaint"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Window_obj::CENTRE,"CENTRE");
	HX_MARK_MEMBER_NAME(Window_obj::FRAME_NO_TASKBAR,"FRAME_NO_TASKBAR");
	HX_MARK_MEMBER_NAME(Window_obj::FRAME_TOOL_WINDOW,"FRAME_TOOL_WINDOW");
	HX_MARK_MEMBER_NAME(Window_obj::FRAME_FLOAT_ON_PARENT,"FRAME_FLOAT_ON_PARENT");
	HX_MARK_MEMBER_NAME(Window_obj::FRAME_SHAPED,"FRAME_SHAPED");
	HX_MARK_MEMBER_NAME(Window_obj::RESIZE_BORDER,"RESIZE_BORDER");
	HX_MARK_MEMBER_NAME(Window_obj::TINY_CAPTION_VERT,"TINY_CAPTION_VERT");
	HX_MARK_MEMBER_NAME(Window_obj::DIALOG_NO_PARENT,"DIALOG_NO_PARENT");
	HX_MARK_MEMBER_NAME(Window_obj::MAXIMIZE_BOX,"MAXIMIZE_BOX");
	HX_MARK_MEMBER_NAME(Window_obj::MINIMIZE_BOX,"MINIMIZE_BOX");
	HX_MARK_MEMBER_NAME(Window_obj::SYSTEM_MENU,"SYSTEM_MENU");
	HX_MARK_MEMBER_NAME(Window_obj::CLOSE_BOX,"CLOSE_BOX");
	HX_MARK_MEMBER_NAME(Window_obj::MAXIMIZE,"MAXIMIZE");
	HX_MARK_MEMBER_NAME(Window_obj::MINIMIZE,"MINIMIZE");
	HX_MARK_MEMBER_NAME(Window_obj::STAY_ON_TOP,"STAY_ON_TOP");
	HX_MARK_MEMBER_NAME(Window_obj::FULL_REPAINT_ON_RESIZE,"FULL_REPAINT_ON_RESIZE");
	HX_MARK_MEMBER_NAME(Window_obj::POPUP_WINDOW,"POPUP_WINDOW");
	HX_MARK_MEMBER_NAME(Window_obj::WANTS_CHARS,"WANTS_CHARS");
	HX_MARK_MEMBER_NAME(Window_obj::TAB_TRAVERSAL,"TAB_TRAVERSAL");
	HX_MARK_MEMBER_NAME(Window_obj::TRANSPARENT_WINDOW,"TRANSPARENT_WINDOW");
	HX_MARK_MEMBER_NAME(Window_obj::BORDER_NONE,"BORDER_NONE");
	HX_MARK_MEMBER_NAME(Window_obj::CLIP_CHILDREN,"CLIP_CHILDREN");
	HX_MARK_MEMBER_NAME(Window_obj::ALWAYS_SHOW_SB,"ALWAYS_SHOW_SB");
	HX_MARK_MEMBER_NAME(Window_obj::BORDER_STATIC,"BORDER_STATIC");
	HX_MARK_MEMBER_NAME(Window_obj::BORDER_SIMPLE,"BORDER_SIMPLE");
	HX_MARK_MEMBER_NAME(Window_obj::BORDER_RAISED,"BORDER_RAISED");
	HX_MARK_MEMBER_NAME(Window_obj::BORDER_SUNKEN,"BORDER_SUNKEN");
	HX_MARK_MEMBER_NAME(Window_obj::BORDER_DOUBLE,"BORDER_DOUBLE");
	HX_MARK_MEMBER_NAME(Window_obj::CAPTION,"CAPTION");
	HX_MARK_MEMBER_NAME(Window_obj::CLIP_SIBLINGS,"CLIP_SIBLINGS");
	HX_MARK_MEMBER_NAME(Window_obj::HSCROLL,"HSCROLL");
	HX_MARK_MEMBER_NAME(Window_obj::VSCROLL,"VSCROLL");
	HX_MARK_MEMBER_NAME(Window_obj::INVALID_PARENT,"INVALID_PARENT");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_get_position,"wx_window_get_position");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_set_position,"wx_window_set_position");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_get_size,"wx_window_get_size");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_set_size,"wx_window_set_size");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_get_client_size,"wx_window_get_client_size");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_set_client_size,"wx_window_set_client_size");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_create,"wx_window_create");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_set_sizer,"wx_window_set_sizer");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_get_sizer,"wx_window_get_sizer");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_fit,"wx_window_fit");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_get_shown,"wx_window_get_shown");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_set_shown,"wx_window_set_shown");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_get_bg_colour,"wx_window_get_bg_colour");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_set_bg_colour,"wx_window_set_bg_colour");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_get_name,"wx_window_get_name");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_set_name,"wx_window_set_name");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_refresh,"wx_window_refresh");
	HX_MARK_MEMBER_NAME(Window_obj::wx_window_destroy,"wx_window_destroy");
};

Class Window_obj::__mClass;

void Window_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.Window"), hx::TCanCast< Window_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void Window_obj::__boot()
{
	hx::Static(CENTRE) = (int)1;
	hx::Static(FRAME_NO_TASKBAR) = (int)2;
	hx::Static(FRAME_TOOL_WINDOW) = (int)4;
	hx::Static(FRAME_FLOAT_ON_PARENT) = (int)8;
	hx::Static(FRAME_SHAPED) = (int)16;
	hx::Static(RESIZE_BORDER) = (int)32;
	hx::Static(TINY_CAPTION_VERT) = (int)128;
	hx::Static(DIALOG_NO_PARENT) = (int)256;
	hx::Static(MAXIMIZE_BOX) = (int)512;
	hx::Static(MINIMIZE_BOX) = (int)1024;
	hx::Static(SYSTEM_MENU) = (int)2048;
	hx::Static(CLOSE_BOX) = (int)4096;
	hx::Static(MAXIMIZE) = (int)8192;
	hx::Static(MINIMIZE) = (int)16384;
	hx::Static(STAY_ON_TOP) = (int)32768;
	hx::Static(FULL_REPAINT_ON_RESIZE) = (int)65536;
	hx::Static(POPUP_WINDOW) = (int)131072;
	hx::Static(WANTS_CHARS) = (int)262144;
	hx::Static(TAB_TRAVERSAL) = (int)524288;
	hx::Static(TRANSPARENT_WINDOW) = (int)1048576;
	hx::Static(BORDER_NONE) = (int)2097152;
	hx::Static(CLIP_CHILDREN) = (int)4194304;
	hx::Static(ALWAYS_SHOW_SB) = (int)8388608;
	hx::Static(BORDER_STATIC) = (int)16777216;
	hx::Static(BORDER_SIMPLE) = (int)33554432;
	hx::Static(BORDER_RAISED) = (int)67108864;
	hx::Static(BORDER_SUNKEN) = (int)134217728;
	hx::Static(BORDER_DOUBLE) = (int)268435456;
	hx::Static(CAPTION) = (int)536870912;
	hx::Static(CLIP_SIBLINGS) = (int)536870912;
	hx::Static(HSCROLL) = (int)1073741824;
	hx::Static(VSCROLL) = (int)-2147483648;
	hx::Static(INVALID_PARENT) = HX_CSTRING("Invalid Parent");
	hx::Static(wx_window_get_position) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_get_position"),(int)1);
	hx::Static(wx_window_set_position) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_set_position"),(int)2);
	hx::Static(wx_window_get_size) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_get_size"),(int)1);
	hx::Static(wx_window_set_size) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_set_size"),(int)2);
	hx::Static(wx_window_get_client_size) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_get_client_size"),(int)1);
	hx::Static(wx_window_set_client_size) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_set_client_size"),(int)2);
	hx::Static(wx_window_create) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_create"),(int)1);
	hx::Static(wx_window_set_sizer) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_set_sizer"),(int)2);
	hx::Static(wx_window_get_sizer) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_get_sizer"),(int)1);
	hx::Static(wx_window_fit) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_fit"),(int)1);
	hx::Static(wx_window_get_shown) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_get_shown"),(int)1);
	hx::Static(wx_window_set_shown) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_set_shown"),(int)2);
	hx::Static(wx_window_get_bg_colour) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_get_bg_colour"),(int)1);
	hx::Static(wx_window_set_bg_colour) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_set_bg_colour"),(int)2);
	hx::Static(wx_window_get_name) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_get_name"),(int)1);
	hx::Static(wx_window_set_name) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_set_name"),(int)2);
	hx::Static(wx_window_refresh) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_refresh"),(int)1);
	hx::Static(wx_window_destroy) = ::wx::Loader_obj::load(HX_CSTRING("wx_window_destroy"),(int)1);
}

} // end namespace wx
