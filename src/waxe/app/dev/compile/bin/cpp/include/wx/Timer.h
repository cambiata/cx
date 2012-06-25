#ifndef INCLUDED_wx_Timer
#define INCLUDED_wx_Timer

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,Timer)
namespace wx{


class Timer_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef Timer_obj OBJ_;
		Timer_obj();
		Void __construct(::wx::EventHandler inHandler,hx::Null< int >  __o_inID);

	public:
		static hx::ObjectPtr< Timer_obj > __new(::wx::EventHandler inHandler,hx::Null< int >  __o_inID);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~Timer_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("Timer"); }

		Dynamic wxHandle; /* REM */ 
		virtual Void start( hx::Null< int >  inMilliSeconds,hx::Null< bool >  inOneShot);
		Dynamic start_dyn();

		virtual Void stop( );
		Dynamic stop_dyn();

		static Dynamic wx_timer_create; /* REM */ 
		static Dynamic &wx_timer_create_dyn() { return wx_timer_create;}
		static Dynamic wx_timer_start; /* REM */ 
		static Dynamic &wx_timer_start_dyn() { return wx_timer_start;}
		static Dynamic wx_timer_stop; /* REM */ 
		static Dynamic &wx_timer_stop_dyn() { return wx_timer_stop;}
};

} // end namespace wx

#endif /* INCLUDED_wx_Timer */ 
