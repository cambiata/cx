#include <hxcpp.h>

#ifndef INCLUDED_wx_FlexGridSizer
#include <wx/FlexGridSizer.h>
#endif
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

Void FlexGridSizer_obj::__construct(Dynamic inHandle)
{
{
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/FlexGridSizer.hx",5)
	super::__construct(inHandle);
}
;
	return null();
}

FlexGridSizer_obj::~FlexGridSizer_obj() { }

Dynamic FlexGridSizer_obj::__CreateEmpty() { return  new FlexGridSizer_obj; }
hx::ObjectPtr< FlexGridSizer_obj > FlexGridSizer_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< FlexGridSizer_obj > result = new FlexGridSizer_obj();
	result->__construct(inHandle);
	return result;}

Dynamic FlexGridSizer_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< FlexGridSizer_obj > result = new FlexGridSizer_obj();
	result->__construct(inArgs[0]);
	return result;}

Void FlexGridSizer_obj::addGrowableRow( int row,Dynamic __o_proportion){
int proportion = __o_proportion.Default(0);
	HX_SOURCE_PUSH("FlexGridSizer_obj::addGrowableRow");
{
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/FlexGridSizer.hx",13)
		::wx::FlexGridSizer_obj::wx_sizer_add_growable_row(this->wxHandle,row,proportion);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC2(FlexGridSizer_obj,addGrowableRow,(void))

Void FlexGridSizer_obj::addGrowableCol( int col,Dynamic __o_proportion){
int proportion = __o_proportion.Default(0);
	HX_SOURCE_PUSH("FlexGridSizer_obj::addGrowableCol");
{
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/FlexGridSizer.hx",18)
		::wx::FlexGridSizer_obj::wx_sizer_add_growable_col(this->wxHandle,col,proportion);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC2(FlexGridSizer_obj,addGrowableCol,(void))

::wx::FlexGridSizer FlexGridSizer_obj::create( Dynamic rows,int cols,Dynamic __o_vgap,Dynamic __o_hgap){
int vgap = __o_vgap.Default(0);
int hgap = __o_hgap.Default(0);
	HX_SOURCE_PUSH("FlexGridSizer_obj::create");
{
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/FlexGridSizer.hx",8)
		return ::wx::FlexGridSizer_obj::__new(::wx::FlexGridSizer_obj::wx_sizer_create_flex_grid(rows,cols,vgap,hgap));
	}
}


STATIC_HX_DEFINE_DYNAMIC_FUNC4(FlexGridSizer_obj,create,return )

Dynamic FlexGridSizer_obj::wx_sizer_create_flex_grid;

Dynamic FlexGridSizer_obj::wx_sizer_add_growable_row;

Dynamic FlexGridSizer_obj::wx_sizer_add_growable_col;


FlexGridSizer_obj::FlexGridSizer_obj()
{
}

void FlexGridSizer_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(FlexGridSizer);
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic FlexGridSizer_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return create_dyn(); }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"addGrowableRow") ) { return addGrowableRow_dyn(); }
		if (HX_FIELD_EQ(inName,"addGrowableCol") ) { return addGrowableCol_dyn(); }
		break;
	case 25:
		if (HX_FIELD_EQ(inName,"wx_sizer_create_flex_grid") ) { return wx_sizer_create_flex_grid; }
		if (HX_FIELD_EQ(inName,"wx_sizer_add_growable_row") ) { return wx_sizer_add_growable_row; }
		if (HX_FIELD_EQ(inName,"wx_sizer_add_growable_col") ) { return wx_sizer_add_growable_col; }
	}
	return super::__Field(inName);
}

Dynamic FlexGridSizer_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	switch(inName.length) {
	case 25:
		if (HX_FIELD_EQ(inName,"wx_sizer_create_flex_grid") ) { wx_sizer_create_flex_grid=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_sizer_add_growable_row") ) { wx_sizer_add_growable_row=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_sizer_add_growable_col") ) { wx_sizer_add_growable_col=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue);
}

void FlexGridSizer_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("create"),
	HX_CSTRING("wx_sizer_create_flex_grid"),
	HX_CSTRING("wx_sizer_add_growable_row"),
	HX_CSTRING("wx_sizer_add_growable_col"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("addGrowableRow"),
	HX_CSTRING("addGrowableCol"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(FlexGridSizer_obj::wx_sizer_create_flex_grid,"wx_sizer_create_flex_grid");
	HX_MARK_MEMBER_NAME(FlexGridSizer_obj::wx_sizer_add_growable_row,"wx_sizer_add_growable_row");
	HX_MARK_MEMBER_NAME(FlexGridSizer_obj::wx_sizer_add_growable_col,"wx_sizer_add_growable_col");
};

Class FlexGridSizer_obj::__mClass;

void FlexGridSizer_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.FlexGridSizer"), hx::TCanCast< FlexGridSizer_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void FlexGridSizer_obj::__boot()
{
	hx::Static(wx_sizer_create_flex_grid) = ::wx::Loader_obj::load(HX_CSTRING("wx_sizer_create_flex_grid"),(int)4);
	hx::Static(wx_sizer_add_growable_row) = ::wx::Loader_obj::load(HX_CSTRING("wx_sizer_add_growable_row"),(int)3);
	hx::Static(wx_sizer_add_growable_col) = ::wx::Loader_obj::load(HX_CSTRING("wx_sizer_add_growable_col"),(int)3);
}

} // end namespace wx
