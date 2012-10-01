#ifndef INCLUDED_HelloWaxe
#define INCLUDED_HelloWaxe

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS0(HelloWaxe)


class HelloWaxe_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef HelloWaxe_obj OBJ_;
		HelloWaxe_obj();
		Void __construct();

	public:
		static hx::ObjectPtr< HelloWaxe_obj > __new();
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~HelloWaxe_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		::String __ToString() const { return HX_CSTRING("HelloWaxe"); }

		static Void main( );
		static Dynamic main_dyn();

};


#endif /* INCLUDED_HelloWaxe */ 
