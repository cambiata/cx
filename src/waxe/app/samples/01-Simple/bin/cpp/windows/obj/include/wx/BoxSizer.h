#ifndef INCLUDED_wx_BoxSizer
#define INCLUDED_wx_BoxSizer

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <wx/Sizer.h>
HX_DECLARE_CLASS1(wx,BoxSizer)
HX_DECLARE_CLASS1(wx,Sizer)
namespace wx{


class BoxSizer_obj : public ::wx::Sizer_obj{
	public:
		typedef ::wx::Sizer_obj super;
		typedef BoxSizer_obj OBJ_;
		BoxSizer_obj();
		Void __construct(Dynamic inHandle);

	public:
		static hx::ObjectPtr< BoxSizer_obj > __new(Dynamic inHandle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~BoxSizer_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("BoxSizer"); }

		static ::wx::BoxSizer create( bool inVertical);
		static Dynamic create_dyn();

		static Dynamic wx_sizer_create_box; /* REM */ 
	Dynamic &wx_sizer_create_box_dyn() { return wx_sizer_create_box;}
};

} // end namespace wx

#endif /* INCLUDED_wx_BoxSizer */ 
