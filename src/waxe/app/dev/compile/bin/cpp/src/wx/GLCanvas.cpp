#include <hxcpp.h>

#ifndef INCLUDED_wx_Error
#include <wx/Error.h>
#endif
#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_GLCanvas
#include <wx/GLCanvas.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif
namespace wx{

Void GLCanvas_obj::__construct(Dynamic inHandle)
{
{
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/GLCanvas.hx",7)
	super::__construct(inHandle);
}
;
	return null();
}

GLCanvas_obj::~GLCanvas_obj() { }

Dynamic GLCanvas_obj::__CreateEmpty() { return  new GLCanvas_obj; }
hx::ObjectPtr< GLCanvas_obj > GLCanvas_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< GLCanvas_obj > result = new GLCanvas_obj();
	result->__construct(inHandle);
	return result;}

Dynamic GLCanvas_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< GLCanvas_obj > result = new GLCanvas_obj();
	result->__construct(inArgs[0]);
	return result;}

Void GLCanvas_obj::makeCurrent( ){
{
		HX_SOURCE_PUSH("GLCanvas_obj::makeCurrent")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/GLCanvas.hx",20)
		::wx::GLCanvas_obj::wx_glcanvas_make_current(this->wxHandle);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC0(GLCanvas_obj,makeCurrent,(void))

Void GLCanvas_obj::flip( ){
{
		HX_SOURCE_PUSH("GLCanvas_obj::flip")
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/GLCanvas.hx",25)
		::wx::GLCanvas_obj::wx_glcanvas_flip(this->wxHandle);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC0(GLCanvas_obj,flip,(void))

::wx::GLCanvas GLCanvas_obj::create( ::wx::Window inParent,Dynamic inID,Dynamic inPosition,Dynamic inSize,Dynamic inStyle){
	HX_SOURCE_PUSH("GLCanvas_obj::create")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/GLCanvas.hx",12)
	if (((inParent == null()))){
		HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/GLCanvas.hx",13)
		hx::Throw (::wx::Error_obj::INVALID_PARENT);
	}
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/GLCanvas.hx",14)
	Dynamic handle = ::wx::GLCanvas_obj::wx_glcanvas_create(Dynamic( Array_obj<Dynamic>::__new().Add(inParent->wxHandle).Add(inID).Add(HX_CSTRING("")).Add(inPosition).Add(inSize).Add(inStyle)));
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/GLCanvas.hx",16)
	return ::wx::GLCanvas_obj::__new(handle);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC5(GLCanvas_obj,create,return )

Dynamic GLCanvas_obj::wx_glcanvas_create;

Dynamic GLCanvas_obj::wx_glcanvas_make_current;

Dynamic GLCanvas_obj::wx_glcanvas_flip;


GLCanvas_obj::GLCanvas_obj()
{
}

void GLCanvas_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(GLCanvas);
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic GLCanvas_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"flip") ) { return flip_dyn(); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return create_dyn(); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"makeCurrent") ) { return makeCurrent_dyn(); }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"wx_glcanvas_flip") ) { return wx_glcanvas_flip; }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"wx_glcanvas_create") ) { return wx_glcanvas_create; }
		break;
	case 24:
		if (HX_FIELD_EQ(inName,"wx_glcanvas_make_current") ) { return wx_glcanvas_make_current; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic GLCanvas_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 16:
		if (HX_FIELD_EQ(inName,"wx_glcanvas_flip") ) { wx_glcanvas_flip=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"wx_glcanvas_create") ) { wx_glcanvas_create=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 24:
		if (HX_FIELD_EQ(inName,"wx_glcanvas_make_current") ) { wx_glcanvas_make_current=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void GLCanvas_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("create"),
	HX_CSTRING("wx_glcanvas_create"),
	HX_CSTRING("wx_glcanvas_make_current"),
	HX_CSTRING("wx_glcanvas_flip"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("makeCurrent"),
	HX_CSTRING("flip"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(GLCanvas_obj::wx_glcanvas_create,"wx_glcanvas_create");
	HX_MARK_MEMBER_NAME(GLCanvas_obj::wx_glcanvas_make_current,"wx_glcanvas_make_current");
	HX_MARK_MEMBER_NAME(GLCanvas_obj::wx_glcanvas_flip,"wx_glcanvas_flip");
};

Class GLCanvas_obj::__mClass;

void GLCanvas_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.GLCanvas"), hx::TCanCast< GLCanvas_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void GLCanvas_obj::__boot()
{
	hx::Static(wx_glcanvas_create) = ::wx::Loader_obj::load(HX_CSTRING("wx_glcanvas_create"),(int)1);
	hx::Static(wx_glcanvas_make_current) = ::wx::Loader_obj::load(HX_CSTRING("wx_glcanvas_make_current"),(int)1);
	hx::Static(wx_glcanvas_flip) = ::wx::Loader_obj::load(HX_CSTRING("wx_glcanvas_flip"),(int)1);
}

} // end namespace wx
