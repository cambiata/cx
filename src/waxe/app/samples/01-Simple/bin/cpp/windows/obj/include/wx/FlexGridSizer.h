#ifndef INCLUDED_wx_FlexGridSizer
#define INCLUDED_wx_FlexGridSizer

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <wx/GridSizer.h>
HX_DECLARE_CLASS1(wx,FlexGridSizer)
HX_DECLARE_CLASS1(wx,GridSizer)
HX_DECLARE_CLASS1(wx,Sizer)
namespace wx{


class FlexGridSizer_obj : public ::wx::GridSizer_obj{
	public:
		typedef ::wx::GridSizer_obj super;
		typedef FlexGridSizer_obj OBJ_;
		FlexGridSizer_obj();
		Void __construct(Dynamic inHandle);

	public:
		static hx::ObjectPtr< FlexGridSizer_obj > __new(Dynamic inHandle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~FlexGridSizer_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("FlexGridSizer"); }

		virtual Void addGrowableRow( int row,Dynamic proportion);
		Dynamic addGrowableRow_dyn();

		virtual Void addGrowableCol( int col,Dynamic proportion);
		Dynamic addGrowableCol_dyn();

		static ::wx::FlexGridSizer create( Dynamic rows,int cols,Dynamic vgap,Dynamic hgap);
		static Dynamic create_dyn();

		static Dynamic wx_sizer_create_flex_grid; /* REM */ 
	Dynamic &wx_sizer_create_flex_grid_dyn() { return wx_sizer_create_flex_grid;}
		static Dynamic wx_sizer_add_growable_row; /* REM */ 
	Dynamic &wx_sizer_add_growable_row_dyn() { return wx_sizer_add_growable_row;}
		static Dynamic wx_sizer_add_growable_col; /* REM */ 
	Dynamic &wx_sizer_add_growable_col_dyn() { return wx_sizer_add_growable_col;}
};

} // end namespace wx

#endif /* INCLUDED_wx_FlexGridSizer */ 
