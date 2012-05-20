#ifndef INCLUDED_wx_Sizer
#define INCLUDED_wx_Sizer

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,Sizer)
HX_DECLARE_CLASS1(wx,Window)
namespace wx{


class Sizer_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef Sizer_obj OBJ_;
		Sizer_obj();
		Void __construct(Dynamic inHandle);

	public:
		static hx::ObjectPtr< Sizer_obj > __new(Dynamic inHandle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~Sizer_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("Sizer"); }

		Dynamic wxHandle; /* REM */ 
		virtual Void _wx_deleted( );
		Dynamic _wx_deleted_dyn();

		virtual Void add( Dynamic sizerOrWindow,Dynamic proportion,Dynamic flag,Dynamic border);
		Dynamic add_dyn();

		virtual Void addSpacer( int inSize);
		Dynamic addSpacer_dyn();

		virtual Void addStretchSpacer( int inProportion);
		Dynamic addStretchSpacer_dyn();

		virtual Void setSizeHints( ::wx::Window inWindow);
		Dynamic setSizeHints_dyn();

		virtual Void fit( ::wx::Window inWindow);
		Dynamic fit_dyn();

		virtual Dynamic wxGetHandle( );
		Dynamic wxGetHandle_dyn();

		static int BORDER_LEFT; /* REM */ 
		static int BORDER_RIGHT; /* REM */ 
		static int BORDER_UP; /* REM */ 
		static int BORDER_DOWN; /* REM */ 
		static int BORDER_TOP; /* REM */ 
		static int BORDER_BOTTOM; /* REM */ 
		static int BORDER_ALL; /* REM */ 
		static int EXPAND; /* REM */ 
		static int ALIGN_NOT; /* REM */ 
		static int ALIGN_CENTER_HORIZONTAL; /* REM */ 
		static int ALIGN_CENTRE_HORIZONTAL; /* REM */ 
		static int ALIGN_LEFT; /* REM */ 
		static int ALIGN_TOP; /* REM */ 
		static int ALIGN_RIGHT; /* REM */ 
		static int ALIGN_BOTTOM; /* REM */ 
		static int ALIGN_CENTER_VERTICAL; /* REM */ 
		static int ALIGN_CENTRE_VERTICAL; /* REM */ 
		static int ALIGN_CENTER; /* REM */ 
		static int ALIGN_CENTRE; /* REM */ 
		static int ALIGN_MASK; /* REM */ 
		static Dynamic wx_set_data; /* REM */ 
	Dynamic &wx_set_data_dyn() { return wx_set_data;}
		static Dynamic wx_get_data; /* REM */ 
		static Dynamic wx_sizer_add; /* REM */ 
	Dynamic &wx_sizer_add_dyn() { return wx_sizer_add;}
		static Dynamic wx_sizer_add_spacer; /* REM */ 
	Dynamic &wx_sizer_add_spacer_dyn() { return wx_sizer_add_spacer;}
		static Dynamic wx_sizer_set_size_hints; /* REM */ 
	Dynamic &wx_sizer_set_size_hints_dyn() { return wx_sizer_set_size_hints;}
		static Dynamic wx_sizer_fit; /* REM */ 
	Dynamic &wx_sizer_fit_dyn() { return wx_sizer_fit;}
};

} // end namespace wx

#endif /* INCLUDED_wx_Sizer */ 
