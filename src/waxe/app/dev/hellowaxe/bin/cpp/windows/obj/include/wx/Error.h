#ifndef INCLUDED_wx_Error
#define INCLUDED_wx_Error

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS1(wx,Error)
namespace wx{


class Error_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef Error_obj OBJ_;
		Error_obj();
		Void __construct();

	public:
		static hx::ObjectPtr< Error_obj > __new();
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~Error_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		::String __ToString() const { return HX_CSTRING("Error"); }

		static ::String INVALID_PARENT; /* REM */ 
};

} // end namespace wx

#endif /* INCLUDED_wx_Error */ 
