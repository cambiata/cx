#ifndef INCLUDED_test_waxe_nme_Main
#define INCLUDED_test_waxe_nme_Main

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS3(test,waxe,nme,Main)
namespace test{
namespace waxe{
namespace nme{


class Main_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef Main_obj OBJ_;
		Main_obj();
		Void __construct();

	public:
		static hx::ObjectPtr< Main_obj > __new();
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~Main_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		::String __ToString() const { return HX_CSTRING("Main"); }

		static Void main( );
		static Dynamic main_dyn();

};

} // end namespace test
} // end namespace waxe
} // end namespace nme

#endif /* INCLUDED_test_waxe_nme_Main */ 
