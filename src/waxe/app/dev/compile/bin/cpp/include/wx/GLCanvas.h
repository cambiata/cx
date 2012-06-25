#ifndef INCLUDED_wx_GLCanvas
#define INCLUDED_wx_GLCanvas

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <wx/Window.h>
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,GLCanvas)
HX_DECLARE_CLASS1(wx,Window)
namespace wx{


class GLCanvas_obj : public ::wx::Window_obj{
	public:
		typedef ::wx::Window_obj super;
		typedef GLCanvas_obj OBJ_;
		GLCanvas_obj();
		Void __construct(Dynamic inHandle);

	public:
		static hx::ObjectPtr< GLCanvas_obj > __new(Dynamic inHandle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~GLCanvas_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("GLCanvas"); }

		virtual Void makeCurrent( );
		Dynamic makeCurrent_dyn();

		virtual Void flip( );
		Dynamic flip_dyn();

		static ::wx::GLCanvas create( ::wx::Window inParent,Dynamic inID,Dynamic inPosition,Dynamic inSize,Dynamic inStyle);
		static Dynamic create_dyn();

		static Dynamic wx_glcanvas_create; /* REM */ 
		static Dynamic &wx_glcanvas_create_dyn() { return wx_glcanvas_create;}
		static Dynamic wx_glcanvas_make_current; /* REM */ 
		static Dynamic &wx_glcanvas_make_current_dyn() { return wx_glcanvas_make_current;}
		static Dynamic wx_glcanvas_flip; /* REM */ 
		static Dynamic &wx_glcanvas_flip_dyn() { return wx_glcanvas_flip;}
};

} // end namespace wx

#endif /* INCLUDED_wx_GLCanvas */ 
