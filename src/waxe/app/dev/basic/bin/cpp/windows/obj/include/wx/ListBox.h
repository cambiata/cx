#ifndef INCLUDED_wx_ListBox
#define INCLUDED_wx_ListBox

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <wx/ControlWithItems.h>
HX_DECLARE_CLASS1(wx,ControlWithItems)
HX_DECLARE_CLASS1(wx,EventHandler)
HX_DECLARE_CLASS1(wx,ListBox)
HX_DECLARE_CLASS1(wx,Window)
namespace wx{


class ListBox_obj : public ::wx::ControlWithItems_obj{
	public:
		typedef ::wx::ControlWithItems_obj super;
		typedef ListBox_obj OBJ_;
		ListBox_obj();
		Void __construct(Dynamic inHandle);

	public:
		static hx::ObjectPtr< ListBox_obj > __new(Dynamic inHandle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~ListBox_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("ListBox"); }

		Dynamic onSelected; /* REM */ 
	Dynamic &onSelected_dyn() { return onSelected;}
		Dynamic onDClick; /* REM */ 
	Dynamic &onDClick_dyn() { return onDClick;}
		int selection; /* REM */ 
		virtual Dynamic setOnSelected( Dynamic f);
		Dynamic setOnSelected_dyn();

		virtual Dynamic setOnDClick( Dynamic f);
		Dynamic setOnDClick_dyn();

		virtual int getSelection( );
		Dynamic getSelection_dyn();

		virtual int setSelection( int val);
		Dynamic setSelection_dyn();

		virtual ::String getString( int inI);
		Dynamic getString_dyn();

		virtual Void setString( int inI,::String inString);
		Dynamic setString_dyn();

		static int NO_SELECTION; /* REM */ 
		static ::wx::ListBox create( ::wx::Window inParent,Dynamic inID,Dynamic inPosition,Dynamic inSize,Array< ::String > inValues,Dynamic inStyle);
		static Dynamic create_dyn();

		static Dynamic wx_list_box_create; /* REM */ 
	Dynamic &wx_list_box_create_dyn() { return wx_list_box_create;}
		static Dynamic wx_list_box_get_selection; /* REM */ 
	Dynamic &wx_list_box_get_selection_dyn() { return wx_list_box_get_selection;}
		static Dynamic wx_list_box_set_selection; /* REM */ 
	Dynamic &wx_list_box_set_selection_dyn() { return wx_list_box_set_selection;}
		static Dynamic wx_list_box_get_string; /* REM */ 
	Dynamic &wx_list_box_get_string_dyn() { return wx_list_box_get_string;}
		static Dynamic wx_list_box_set_string; /* REM */ 
	Dynamic &wx_list_box_set_string_dyn() { return wx_list_box_set_string;}
};

} // end namespace wx

#endif /* INCLUDED_wx_ListBox */ 
