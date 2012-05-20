#ifndef INCLUDED_Simple
#define INCLUDED_Simple

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS0(Simple)
HX_DECLARE_CLASS1(wx,DC)
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,Frame)
HX_DECLARE_CLASS1(wx,TopLevelWindow)
HX_DECLARE_CLASS1(wx,Window)


class Simple_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef Simple_obj OBJ_;
		Simple_obj();
		Void __construct();

	public:
		static hx::ObjectPtr< Simple_obj > __new();
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~Simple_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("Simple"); }

		::wx::Frame mFrame; /* REM */ 
		::wx::Window mWindow; /* REM */ 
		::wx::Window mDrawArea; /* REM */ 
		virtual Void paintWindow( ::wx::DC dc);
		Dynamic paintWindow_dyn();

		virtual Void layout( );
		Dynamic layout_dyn();

		static Void main( );
		static Dynamic main_dyn();

};


#endif /* INCLUDED_Simple */ 
