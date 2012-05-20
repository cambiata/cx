#include <hxcpp.h>

#ifndef INCLUDED_wx_GridSizer
#include <wx/GridSizer.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
#ifndef INCLUDED_wx_Sizer
#include <wx/Sizer.h>
#endif
namespace wx{

Void GridSizer_obj::__construct(Dynamic inHandle)
{
{
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/GridSizer.hx",5)
	super::__construct(inHandle);
}
;
	return null();
}

GridSizer_obj::~GridSizer_obj() { }

Dynamic GridSizer_obj::__CreateEmpty() { return  new GridSizer_obj; }
hx::ObjectPtr< GridSizer_obj > GridSizer_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< GridSizer_obj > result = new GridSizer_obj();
	result->__construct(inHandle);
	return result;}

Dynamic GridSizer_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< GridSizer_obj > result = new GridSizer_obj();
	result->__construct(inArgs[0]);
	return result;}

::wx::GridSizer GridSizer_obj::create( Dynamic rows,int cols,Dynamic __o_vgap,Dynamic __o_hgap){
int vgap = __o_vgap.Default(0);
int hgap = __o_hgap.Default(0);
	HX_SOURCE_PUSH("GridSizer_obj::create");
{
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/GridSizer.hx",8)
		return ::wx::GridSizer_obj::__new(::wx::GridSizer_obj::wx_sizer_create_grid(rows,cols,vgap,hgap));
	}
}


STATIC_HX_DEFINE_DYNAMIC_FUNC4(GridSizer_obj,create,return )

Dynamic GridSizer_obj::wx_sizer_create_grid;


GridSizer_obj::GridSizer_obj()
{
}

void GridSizer_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(GridSizer);
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic GridSizer_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return create_dyn(); }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"wx_sizer_create_grid") ) { return wx_sizer_create_grid; }
	}
	return super::__Field(inName);
}

Dynamic GridSizer_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	switch(inName.length) {
	case 20:
		if (HX_FIELD_EQ(inName,"wx_sizer_create_grid") ) { wx_sizer_create_grid=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue);
}

void GridSizer_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("create"),
	HX_CSTRING("wx_sizer_create_grid"),
	String(null()) };

static ::String sMemberFields[] = {
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(GridSizer_obj::wx_sizer_create_grid,"wx_sizer_create_grid");
};

Class GridSizer_obj::__mClass;

void GridSizer_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.GridSizer"), hx::TCanCast< GridSizer_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void GridSizer_obj::__boot()
{
	hx::Static(wx_sizer_create_grid) = ::wx::Loader_obj::load(HX_CSTRING("wx_sizer_create_grid"),(int)4);
}

} // end namespace wx
