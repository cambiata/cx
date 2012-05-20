#ifndef INCLUDED_wx_GridSizer
#define INCLUDED_wx_GridSizer

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <wx/Sizer.h>
HX_DECLARE_CLASS1(wx,GridSizer)
HX_DECLARE_CLASS1(wx,Sizer)
namespace wx{


class GridSizer_obj : public ::wx::Sizer_obj{
	public:
		typedef ::wx::Sizer_obj super;
		typedef GridSizer_obj OBJ_;
		GridSizer_obj();
		Void __construct(Dynamic inHandle);

	public:
		static hx::ObjectPtr< GridSizer_obj > __new(Dynamic inHandle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~GridSizer_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("GridSizer"); }

		static ::wx::GridSizer create( Dynamic rows,int cols,Dynamic vgap,Dynamic hgap);
		static Dynamic create_dyn();

		static Dynamic wx_sizer_create_grid; /* REM */ 
	Dynamic &wx_sizer_create_grid_dyn() { return wx_sizer_create_grid;}
};

} // end namespace wx

#endif /* INCLUDED_wx_GridSizer */ 
