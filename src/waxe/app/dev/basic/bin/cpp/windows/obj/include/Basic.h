#ifndef INCLUDED_Basic
#define INCLUDED_Basic

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS0(Basic)
HX_DECLARE_CLASS1(wx,ControlWithItems)
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,Frame)
HX_DECLARE_CLASS1(wx,ListBox)
HX_DECLARE_CLASS1(wx,TopLevelWindow)
HX_DECLARE_CLASS1(wx,Window)


class Basic_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef Basic_obj OBJ_;
		Basic_obj();
		Void __construct();

	public:
		static hx::ObjectPtr< Basic_obj > __new();
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~Basic_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("Basic"); }

		::wx::Frame frame; /* REM */ 
		::wx::Window winPanel; /* REM */ 
		::wx::ListBox listBox; /* REM */ 
		static Void main( );
		static Dynamic main_dyn();

};


#endif /* INCLUDED_Basic */ 
