#ifndef INCLUDED_wx_Window
#define INCLUDED_wx_Window

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <wx/EventHandler.h>
HX_DECLARE_CLASS0(IntHash)
HX_DECLARE_CLASS1(wx,DC)
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,EventID)
HX_DECLARE_CLASS1(wx,Sizer)
HX_DECLARE_CLASS1(wx,Window)
namespace wx{


class Window_obj : public ::wx::EventHandler_obj{
	public:
		typedef ::wx::EventHandler_obj super;
		typedef Window_obj OBJ_;
		Window_obj();
		Void __construct(Dynamic inHandle);

	public:
		static hx::ObjectPtr< Window_obj > __new(Dynamic inHandle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~Window_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("Window"); }

		::IntHash wxEventHandlers; /* REM */ 
		Dynamic size; /* REM */ 
		::wx::Sizer sizer; /* REM */ 
		Dynamic clientSize; /* REM */ 
		Dynamic position; /* REM */ 
		bool shown; /* REM */ 
		::String name; /* REM */ 
		int backgroundColour; /* REM */ 
		virtual Void HandleEvent( Dynamic event);

		virtual Void setHandler( ::wx::EventID inID,Dynamic inFunc);
		Dynamic setHandler_dyn();

		virtual Void fit( );
		Dynamic fit_dyn();

		virtual Void refresh( );
		Dynamic refresh_dyn();

		virtual Void destroy( );
		Dynamic destroy_dyn();

		virtual Dynamic getSize( );
		Dynamic getSize_dyn();

		virtual Dynamic setSize( Dynamic inSize);
		Dynamic setSize_dyn();

		virtual ::wx::Sizer getSizer( );
		Dynamic getSizer_dyn();

		virtual ::wx::Sizer setSizer( ::wx::Sizer inSizer);
		Dynamic setSizer_dyn();

		virtual Dynamic getClientSize( );
		Dynamic getClientSize_dyn();

		virtual Dynamic setClientSize( Dynamic inSize);
		Dynamic setClientSize_dyn();

		virtual Dynamic getPosition( );
		Dynamic getPosition_dyn();

		virtual Dynamic setPosition( Dynamic inPos);
		Dynamic setPosition_dyn();

		virtual bool isShown( );
		Dynamic isShown_dyn();

		virtual bool show( hx::Null< bool >  inShow);
		Dynamic show_dyn();

		virtual int getBackgroundColour( );
		Dynamic getBackgroundColour_dyn();

		virtual int setBackgroundColour( int inColour);
		Dynamic setBackgroundColour_dyn();

		virtual ::String getName( );
		Dynamic getName_dyn();

		virtual ::String setName( ::String inName);
		Dynamic setName_dyn();

		Dynamic onClose; /* REM */ 
		Dynamic &onClose_dyn() { return onClose;}
		virtual Dynamic setOnClose( Dynamic f);
		Dynamic setOnClose_dyn();

		Dynamic onSize; /* REM */ 
		Dynamic &onSize_dyn() { return onSize;}
		virtual Dynamic setOnSize( Dynamic f);
		Dynamic setOnSize_dyn();

		Dynamic onPaint; /* REM */ 
		Dynamic &onPaint_dyn() { return onPaint;}
		virtual Dynamic setOnPaint( Dynamic f);
		Dynamic setOnPaint_dyn();

		static int CENTRE; /* REM */ 
		static int FRAME_NO_TASKBAR; /* REM */ 
		static int FRAME_TOOL_WINDOW; /* REM */ 
		static int FRAME_FLOAT_ON_PARENT; /* REM */ 
		static int FRAME_SHAPED; /* REM */ 
		static int RESIZE_BORDER; /* REM */ 
		static int TINY_CAPTION_VERT; /* REM */ 
		static int DIALOG_NO_PARENT; /* REM */ 
		static int MAXIMIZE_BOX; /* REM */ 
		static int MINIMIZE_BOX; /* REM */ 
		static int SYSTEM_MENU; /* REM */ 
		static int CLOSE_BOX; /* REM */ 
		static int MAXIMIZE; /* REM */ 
		static int MINIMIZE; /* REM */ 
		static int STAY_ON_TOP; /* REM */ 
		static int FULL_REPAINT_ON_RESIZE; /* REM */ 
		static int POPUP_WINDOW; /* REM */ 
		static int WANTS_CHARS; /* REM */ 
		static int TAB_TRAVERSAL; /* REM */ 
		static int TRANSPARENT_WINDOW; /* REM */ 
		static int BORDER_NONE; /* REM */ 
		static int CLIP_CHILDREN; /* REM */ 
		static int ALWAYS_SHOW_SB; /* REM */ 
		static int BORDER_STATIC; /* REM */ 
		static int BORDER_SIMPLE; /* REM */ 
		static int BORDER_RAISED; /* REM */ 
		static int BORDER_SUNKEN; /* REM */ 
		static int BORDER_DOUBLE; /* REM */ 
		static int CAPTION; /* REM */ 
		static int CLIP_SIBLINGS; /* REM */ 
		static int HSCROLL; /* REM */ 
		static int VSCROLL; /* REM */ 
		static ::String INVALID_PARENT; /* REM */ 
		static ::wx::Window create( ::wx::Window inParent,Dynamic inID,Dynamic inPosition,Dynamic inSize,Dynamic inStyle);
		static Dynamic create_dyn();

		static Dynamic wx_window_get_position; /* REM */ 
		static Dynamic &wx_window_get_position_dyn() { return wx_window_get_position;}
		static Dynamic wx_window_set_position; /* REM */ 
		static Dynamic &wx_window_set_position_dyn() { return wx_window_set_position;}
		static Dynamic wx_window_get_size; /* REM */ 
		static Dynamic &wx_window_get_size_dyn() { return wx_window_get_size;}
		static Dynamic wx_window_set_size; /* REM */ 
		static Dynamic &wx_window_set_size_dyn() { return wx_window_set_size;}
		static Dynamic wx_window_get_client_size; /* REM */ 
		static Dynamic &wx_window_get_client_size_dyn() { return wx_window_get_client_size;}
		static Dynamic wx_window_set_client_size; /* REM */ 
		static Dynamic &wx_window_set_client_size_dyn() { return wx_window_set_client_size;}
		static Dynamic wx_window_create; /* REM */ 
		static Dynamic &wx_window_create_dyn() { return wx_window_create;}
		static Dynamic wx_window_set_sizer; /* REM */ 
		static Dynamic &wx_window_set_sizer_dyn() { return wx_window_set_sizer;}
		static Dynamic wx_window_get_sizer; /* REM */ 
		static Dynamic &wx_window_get_sizer_dyn() { return wx_window_get_sizer;}
		static Dynamic wx_window_fit; /* REM */ 
		static Dynamic &wx_window_fit_dyn() { return wx_window_fit;}
		static Dynamic wx_window_get_shown; /* REM */ 
		static Dynamic &wx_window_get_shown_dyn() { return wx_window_get_shown;}
		static Dynamic wx_window_set_shown; /* REM */ 
		static Dynamic &wx_window_set_shown_dyn() { return wx_window_set_shown;}
		static Dynamic wx_window_get_bg_colour; /* REM */ 
		static Dynamic &wx_window_get_bg_colour_dyn() { return wx_window_get_bg_colour;}
		static Dynamic wx_window_set_bg_colour; /* REM */ 
		static Dynamic &wx_window_set_bg_colour_dyn() { return wx_window_set_bg_colour;}
		static Dynamic wx_window_get_name; /* REM */ 
		static Dynamic &wx_window_get_name_dyn() { return wx_window_get_name;}
		static Dynamic wx_window_set_name; /* REM */ 
		static Dynamic &wx_window_set_name_dyn() { return wx_window_set_name;}
		static Dynamic wx_window_refresh; /* REM */ 
		static Dynamic &wx_window_refresh_dyn() { return wx_window_refresh;}
		static Dynamic wx_window_destroy; /* REM */ 
		static Dynamic &wx_window_destroy_dyn() { return wx_window_destroy;}
};

} // end namespace wx

#endif /* INCLUDED_wx_Window */ 
