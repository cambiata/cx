#ifndef INCLUDED_wx_NMEStage
#define INCLUDED_wx_NMEStage

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <wx/GLCanvas.h>
HX_DECLARE_CLASS2(neash,display,DisplayObject)
HX_DECLARE_CLASS2(neash,display,DisplayObjectContainer)
HX_DECLARE_CLASS2(neash,display,IBitmapDrawable)
HX_DECLARE_CLASS2(neash,display,InteractiveObject)
HX_DECLARE_CLASS2(neash,display,ManagedStage)
HX_DECLARE_CLASS2(neash,display,Stage)
HX_DECLARE_CLASS2(neash,events,EventDispatcher)
HX_DECLARE_CLASS2(neash,events,IEventDispatcher)
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,GLCanvas)
HX_DECLARE_CLASS1(wx,NMEStage)
HX_DECLARE_CLASS1(wx,Timer)
HX_DECLARE_CLASS1(wx,Window)
namespace wx{


class NMEStage_obj : public ::wx::GLCanvas_obj{
	public:
		typedef ::wx::GLCanvas_obj super;
		typedef NMEStage_obj OBJ_;
		NMEStage_obj();
		Void __construct(Dynamic inHandle,int inWidth,int inHeight);

	public:
		static hx::ObjectPtr< NMEStage_obj > __new(Dynamic inHandle,int inWidth,int inHeight);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~NMEStage_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("NMEStage"); }

		::neash::display::ManagedStage stage; /* REM */ 
		int mLastValue; /* REM */ 
		::wx::Timer mTimer; /* REM */ 
		virtual Void _wx_deleted( );

		virtual Void myOnSize( Dynamic event);
		Dynamic myOnSize_dyn();

		virtual Void pumpMouseEvent( int inID,Dynamic inEvent);
		Dynamic pumpMouseEvent_dyn();

		virtual Void pumpKeyEvent( int inID,Dynamic inEvent);
		Dynamic pumpKeyEvent_dyn();

		virtual bool IsModifier( int inCode);
		Dynamic IsModifier_dyn();

		virtual Void HandleEvent( Dynamic event);

		virtual Void setNextWake( double inDelay);
		Dynamic setNextWake_dyn();

		virtual Void render( Dynamic _);
		Dynamic render_dyn();

		static ::wx::NMEStage create( ::wx::Window inParent,Dynamic inID,Dynamic inPosition,Dynamic inSize,Dynamic inStyle);
		static Dynamic create_dyn();

};

} // end namespace wx

#endif /* INCLUDED_wx_NMEStage */ 
