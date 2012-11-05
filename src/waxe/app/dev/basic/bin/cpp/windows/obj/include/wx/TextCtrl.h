#ifndef INCLUDED_wx_TextCtrl
#define INCLUDED_wx_TextCtrl

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <wx/Window.h>
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,TextCtrl)
HX_DECLARE_CLASS1(wx,Window)
namespace wx{


class TextCtrl_obj : public ::wx::Window_obj{
	public:
		typedef ::wx::Window_obj super;
		typedef TextCtrl_obj OBJ_;
		TextCtrl_obj();
		Void __construct(Dynamic inHandle);

	public:
		static hx::ObjectPtr< TextCtrl_obj > __new(Dynamic inHandle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~TextCtrl_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		::String __ToString() const { return HX_CSTRING("TextCtrl"); }

		virtual Dynamic setOnTextUpdated( Dynamic f);
		Dynamic setOnTextUpdated_dyn();

		Dynamic onTextUpdated; /* REM */ 
		Dynamic &onTextUpdated_dyn() { return onTextUpdated;}
		virtual ::String getValue( );
		Dynamic getValue_dyn();

		virtual ::String setValue( ::String inString);
		Dynamic setValue_dyn();

		::String value; /* REM */ 
		static ::wx::TextCtrl create( ::wx::Window inParent,Dynamic inID,::String inText,Dynamic inPosition,Dynamic inSize,Dynamic inStyle);
		static Dynamic create_dyn();

		static Dynamic wx_text_ctrl_create; /* REM */ 
		static Dynamic &wx_text_ctrl_create_dyn() { return wx_text_ctrl_create;}
		static Dynamic wx_text_ctrl_get_value; /* REM */ 
		static Dynamic &wx_text_ctrl_get_value_dyn() { return wx_text_ctrl_get_value;}
		static Dynamic wx_text_ctrl_set_value; /* REM */ 
		static Dynamic &wx_text_ctrl_set_value_dyn() { return wx_text_ctrl_set_value;}
};

} // end namespace wx

#endif /* INCLUDED_wx_TextCtrl */ 
