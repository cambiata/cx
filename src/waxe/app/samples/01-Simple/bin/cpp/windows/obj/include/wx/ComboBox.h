#ifndef INCLUDED_wx_ComboBox
#define INCLUDED_wx_ComboBox

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <wx/ControlWithItems.h>
HX_DECLARE_CLASS1(wx,ComboBox)
HX_DECLARE_CLASS1(wx,ControlWithItems)
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,Window)
namespace wx{


class ComboBox_obj : public ::wx::ControlWithItems_obj{
	public:
		typedef ::wx::ControlWithItems_obj super;
		typedef ComboBox_obj OBJ_;
		ComboBox_obj();
		Void __construct(Dynamic inHandle);

	public:
		static hx::ObjectPtr< ComboBox_obj > __new(Dynamic inHandle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~ComboBox_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("ComboBox"); }

		Dynamic onSelected; /* REM */ 
	Dynamic &onSelected_dyn() { return onSelected;}
		Dynamic onTextEnter; /* REM */ 
	Dynamic &onTextEnter_dyn() { return onTextEnter;}
		Dynamic onTextUpdated; /* REM */ 
	Dynamic &onTextUpdated_dyn() { return onTextUpdated;}
		virtual Dynamic setOnSelected( Dynamic f);
		Dynamic setOnSelected_dyn();

		virtual Dynamic setOnTextUpdated( Dynamic f);
		Dynamic setOnTextUpdated_dyn();

		virtual Dynamic setOnTextEnter( Dynamic f);
		Dynamic setOnTextEnter_dyn();

		::String value; /* REM */ 
		virtual ::String setValue( ::String inString);
		Dynamic setValue_dyn();

		virtual ::String getValue( );
		Dynamic getValue_dyn();

		static ::wx::ComboBox create( ::wx::Window inParent,Dynamic inID,Dynamic inValue,Dynamic inPosition,Dynamic inSize,Array< ::String > inChoices,Dynamic inStyle);
		static Dynamic create_dyn();

		static Dynamic wx_combo_box_create; /* REM */ 
	Dynamic &wx_combo_box_create_dyn() { return wx_combo_box_create;}
		static Dynamic wx_combo_box_get_value; /* REM */ 
	Dynamic &wx_combo_box_get_value_dyn() { return wx_combo_box_get_value;}
		static Dynamic wx_combo_box_set_value; /* REM */ 
	Dynamic &wx_combo_box_set_value_dyn() { return wx_combo_box_set_value;}
};

} // end namespace wx

#endif /* INCLUDED_wx_ComboBox */ 
