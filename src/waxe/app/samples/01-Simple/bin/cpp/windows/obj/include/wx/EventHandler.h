#ifndef INCLUDED_wx_EventHandler
#define INCLUDED_wx_EventHandler

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS1(wx,EventHandler)
namespace wx{


class EventHandler_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef EventHandler_obj OBJ_;
		EventHandler_obj();
		Void __construct(Dynamic inHandle);

	public:
		static hx::ObjectPtr< EventHandler_obj > __new(Dynamic inHandle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~EventHandler_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("EventHandler"); }

		Dynamic wxHandle; /* REM */ 
		virtual Void _wx_deleted( );
		Dynamic _wx_deleted_dyn();

		virtual Void _handle_event( Dynamic event);
		Dynamic _handle_event_dyn();

		virtual Void HandleEvent( Dynamic event);
		Dynamic HandleEvent_dyn();

		static Dynamic wx_set_window_handler; /* REM */ 
	Dynamic &wx_set_window_handler_dyn() { return wx_set_window_handler;}
		static Dynamic wx_get_window_handler; /* REM */ 
};

} // end namespace wx

#endif /* INCLUDED_wx_EventHandler */ 
