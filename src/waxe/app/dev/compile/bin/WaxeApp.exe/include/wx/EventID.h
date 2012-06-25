#ifndef INCLUDED_wx_EventID
#define INCLUDED_wx_EventID

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS1(wx,EventID)
namespace wx{


class EventID_obj : public hx::EnumBase_obj
{
	typedef hx::EnumBase_obj super;
		typedef EventID_obj OBJ_;

	public:
		EventID_obj() {};
		HX_DO_ENUM_RTTI;
		static void __boot();
		static void __register();
		::String GetEnumName( ) const { return HX_CSTRING("wx.EventID"); }
		::String __ToString() const { return HX_CSTRING("EventID.") + tag; }

		static ::wx::EventID ACTIVATE;
		static inline ::wx::EventID ACTIVATE_dyn() { return ACTIVATE; }
		static ::wx::EventID ACTIVATE_APP;
		static inline ::wx::EventID ACTIVATE_APP_dyn() { return ACTIVATE_APP; }
		static ::wx::EventID CHAR;
		static inline ::wx::EventID CHAR_dyn() { return CHAR; }
		static ::wx::EventID CHAR_HOOK;
		static inline ::wx::EventID CHAR_HOOK_dyn() { return CHAR_HOOK; }
		static ::wx::EventID CHILD_FOCUS;
		static inline ::wx::EventID CHILD_FOCUS_dyn() { return CHILD_FOCUS; }
		static ::wx::EventID CLOSE_WINDOW;
		static inline ::wx::EventID CLOSE_WINDOW_dyn() { return CLOSE_WINDOW; }
		static ::wx::EventID COMMAND_BUTTON_CLICKED;
		static inline ::wx::EventID COMMAND_BUTTON_CLICKED_dyn() { return COMMAND_BUTTON_CLICKED; }
		static ::wx::EventID COMMAND_CHECKBOX_CLICKED;
		static inline ::wx::EventID COMMAND_CHECKBOX_CLICKED_dyn() { return COMMAND_CHECKBOX_CLICKED; }
		static ::wx::EventID COMMAND_CHECKLISTBOX_TOGGLED;
		static inline ::wx::EventID COMMAND_CHECKLISTBOX_TOGGLED_dyn() { return COMMAND_CHECKLISTBOX_TOGGLED; }
		static ::wx::EventID COMMAND_CHOICE_SELECTED;
		static inline ::wx::EventID COMMAND_CHOICE_SELECTED_dyn() { return COMMAND_CHOICE_SELECTED; }
		static ::wx::EventID COMMAND_COMBOBOX_SELECTED;
		static inline ::wx::EventID COMMAND_COMBOBOX_SELECTED_dyn() { return COMMAND_COMBOBOX_SELECTED; }
		static ::wx::EventID COMMAND_ENTER;
		static inline ::wx::EventID COMMAND_ENTER_dyn() { return COMMAND_ENTER; }
		static ::wx::EventID COMMAND_KILL_FOCUS;
		static inline ::wx::EventID COMMAND_KILL_FOCUS_dyn() { return COMMAND_KILL_FOCUS; }
		static ::wx::EventID COMMAND_LEFT_CLICK;
		static inline ::wx::EventID COMMAND_LEFT_CLICK_dyn() { return COMMAND_LEFT_CLICK; }
		static ::wx::EventID COMMAND_LEFT_DCLICK;
		static inline ::wx::EventID COMMAND_LEFT_DCLICK_dyn() { return COMMAND_LEFT_DCLICK; }
		static ::wx::EventID COMMAND_LISTBOX_DOUBLECLICKED;
		static inline ::wx::EventID COMMAND_LISTBOX_DOUBLECLICKED_dyn() { return COMMAND_LISTBOX_DOUBLECLICKED; }
		static ::wx::EventID COMMAND_LISTBOX_SELECTED;
		static inline ::wx::EventID COMMAND_LISTBOX_SELECTED_dyn() { return COMMAND_LISTBOX_SELECTED; }
		static ::wx::EventID COMMAND_MENU_SELECTED;
		static inline ::wx::EventID COMMAND_MENU_SELECTED_dyn() { return COMMAND_MENU_SELECTED; }
		static ::wx::EventID COMMAND_RADIOBOX_SELECTED;
		static inline ::wx::EventID COMMAND_RADIOBOX_SELECTED_dyn() { return COMMAND_RADIOBOX_SELECTED; }
		static ::wx::EventID COMMAND_RADIOBUTTON_SELECTED;
		static inline ::wx::EventID COMMAND_RADIOBUTTON_SELECTED_dyn() { return COMMAND_RADIOBUTTON_SELECTED; }
		static ::wx::EventID COMMAND_RIGHT_CLICK;
		static inline ::wx::EventID COMMAND_RIGHT_CLICK_dyn() { return COMMAND_RIGHT_CLICK; }
		static ::wx::EventID COMMAND_RIGHT_DCLICK;
		static inline ::wx::EventID COMMAND_RIGHT_DCLICK_dyn() { return COMMAND_RIGHT_DCLICK; }
		static ::wx::EventID COMMAND_SCROLLBAR_UPDATED;
		static inline ::wx::EventID COMMAND_SCROLLBAR_UPDATED_dyn() { return COMMAND_SCROLLBAR_UPDATED; }
		static ::wx::EventID COMMAND_SET_FOCUS;
		static inline ::wx::EventID COMMAND_SET_FOCUS_dyn() { return COMMAND_SET_FOCUS; }
		static ::wx::EventID COMMAND_SLIDER_UPDATED;
		static inline ::wx::EventID COMMAND_SLIDER_UPDATED_dyn() { return COMMAND_SLIDER_UPDATED; }
		static ::wx::EventID COMMAND_SPINCTRL_UPDATED;
		static inline ::wx::EventID COMMAND_SPINCTRL_UPDATED_dyn() { return COMMAND_SPINCTRL_UPDATED; }
		static ::wx::EventID COMMAND_TEXT_COPY;
		static inline ::wx::EventID COMMAND_TEXT_COPY_dyn() { return COMMAND_TEXT_COPY; }
		static ::wx::EventID COMMAND_TEXT_CUT;
		static inline ::wx::EventID COMMAND_TEXT_CUT_dyn() { return COMMAND_TEXT_CUT; }
		static ::wx::EventID COMMAND_TEXT_ENTER;
		static inline ::wx::EventID COMMAND_TEXT_ENTER_dyn() { return COMMAND_TEXT_ENTER; }
		static ::wx::EventID COMMAND_TEXT_PASTE;
		static inline ::wx::EventID COMMAND_TEXT_PASTE_dyn() { return COMMAND_TEXT_PASTE; }
		static ::wx::EventID COMMAND_TEXT_UPDATED;
		static inline ::wx::EventID COMMAND_TEXT_UPDATED_dyn() { return COMMAND_TEXT_UPDATED; }
		static ::wx::EventID COMMAND_TOOL_ENTER;
		static inline ::wx::EventID COMMAND_TOOL_ENTER_dyn() { return COMMAND_TOOL_ENTER; }
		static ::wx::EventID COMMAND_TOOL_RCLICKED;
		static inline ::wx::EventID COMMAND_TOOL_RCLICKED_dyn() { return COMMAND_TOOL_RCLICKED; }
		static ::wx::EventID COMMAND_VLBOX_SELECTED;
		static inline ::wx::EventID COMMAND_VLBOX_SELECTED_dyn() { return COMMAND_VLBOX_SELECTED; }
		static ::wx::EventID COMPARE_ITEM;
		static inline ::wx::EventID COMPARE_ITEM_dyn() { return COMPARE_ITEM; }
		static ::wx::EventID CONTEXT_MENU;
		static inline ::wx::EventID CONTEXT_MENU_dyn() { return CONTEXT_MENU; }
		static ::wx::EventID CREATE;
		static inline ::wx::EventID CREATE_dyn() { return CREATE; }
		static ::wx::EventID DESTROY;
		static inline ::wx::EventID DESTROY_dyn() { return DESTROY; }
		static ::wx::EventID DETAILED_HELP;
		static inline ::wx::EventID DETAILED_HELP_dyn() { return DETAILED_HELP; }
		static ::wx::EventID DISPLAY_CHANGED;
		static inline ::wx::EventID DISPLAY_CHANGED_dyn() { return DISPLAY_CHANGED; }
		static ::wx::EventID DRAW_ITEM;
		static inline ::wx::EventID DRAW_ITEM_dyn() { return DRAW_ITEM; }
		static ::wx::EventID DROP_FILES;
		static inline ::wx::EventID DROP_FILES_dyn() { return DROP_FILES; }
		static ::wx::EventID END_SESSION;
		static inline ::wx::EventID END_SESSION_dyn() { return END_SESSION; }
		static ::wx::EventID ENTER_WINDOW;
		static inline ::wx::EventID ENTER_WINDOW_dyn() { return ENTER_WINDOW; }
		static ::wx::EventID ERASE_BACKGROUND;
		static inline ::wx::EventID ERASE_BACKGROUND_dyn() { return ERASE_BACKGROUND; }
		static ::wx::EventID HELP;
		static inline ::wx::EventID HELP_dyn() { return HELP; }
		static ::wx::EventID HIBERNATE;
		static inline ::wx::EventID HIBERNATE_dyn() { return HIBERNATE; }
		static ::wx::EventID HOTKEY;
		static inline ::wx::EventID HOTKEY_dyn() { return HOTKEY; }
		static ::wx::EventID ICONIZE;
		static inline ::wx::EventID ICONIZE_dyn() { return ICONIZE; }
		static ::wx::EventID IDLE;
		static inline ::wx::EventID IDLE_dyn() { return IDLE; }
		static ::wx::EventID INIT_DIALOG;
		static inline ::wx::EventID INIT_DIALOG_dyn() { return INIT_DIALOG; }
		static ::wx::EventID JOY_BUTTON_DOWN;
		static inline ::wx::EventID JOY_BUTTON_DOWN_dyn() { return JOY_BUTTON_DOWN; }
		static ::wx::EventID JOY_BUTTON_UP;
		static inline ::wx::EventID JOY_BUTTON_UP_dyn() { return JOY_BUTTON_UP; }
		static ::wx::EventID JOY_MOVE;
		static inline ::wx::EventID JOY_MOVE_dyn() { return JOY_MOVE; }
		static ::wx::EventID JOY_ZMOVE;
		static inline ::wx::EventID JOY_ZMOVE_dyn() { return JOY_ZMOVE; }
		static ::wx::EventID KEY_DOWN;
		static inline ::wx::EventID KEY_DOWN_dyn() { return KEY_DOWN; }
		static ::wx::EventID KEY_UP;
		static inline ::wx::EventID KEY_UP_dyn() { return KEY_UP; }
		static ::wx::EventID KILL_FOCUS;
		static inline ::wx::EventID KILL_FOCUS_dyn() { return KILL_FOCUS; }
		static ::wx::EventID LEAVE_WINDOW;
		static inline ::wx::EventID LEAVE_WINDOW_dyn() { return LEAVE_WINDOW; }
		static ::wx::EventID LEFT_DCLICK;
		static inline ::wx::EventID LEFT_DCLICK_dyn() { return LEFT_DCLICK; }
		static ::wx::EventID LEFT_DOWN;
		static inline ::wx::EventID LEFT_DOWN_dyn() { return LEFT_DOWN; }
		static ::wx::EventID LEFT_UP;
		static inline ::wx::EventID LEFT_UP_dyn() { return LEFT_UP; }
		static ::wx::EventID MAXIMIZE;
		static inline ::wx::EventID MAXIMIZE_dyn() { return MAXIMIZE; }
		static ::wx::EventID MEASURE_ITEM;
		static inline ::wx::EventID MEASURE_ITEM_dyn() { return MEASURE_ITEM; }
		static ::wx::EventID MENU_CLOSE;
		static inline ::wx::EventID MENU_CLOSE_dyn() { return MENU_CLOSE; }
		static ::wx::EventID MENU_HIGHLIGHT;
		static inline ::wx::EventID MENU_HIGHLIGHT_dyn() { return MENU_HIGHLIGHT; }
		static ::wx::EventID MENU_OPEN;
		static inline ::wx::EventID MENU_OPEN_dyn() { return MENU_OPEN; }
		static ::wx::EventID MIDDLE_DCLICK;
		static inline ::wx::EventID MIDDLE_DCLICK_dyn() { return MIDDLE_DCLICK; }
		static ::wx::EventID MIDDLE_DOWN;
		static inline ::wx::EventID MIDDLE_DOWN_dyn() { return MIDDLE_DOWN; }
		static ::wx::EventID MIDDLE_UP;
		static inline ::wx::EventID MIDDLE_UP_dyn() { return MIDDLE_UP; }
		static ::wx::EventID MOTION;
		static inline ::wx::EventID MOTION_dyn() { return MOTION; }
		static ::wx::EventID MOUSEWHEEL;
		static inline ::wx::EventID MOUSEWHEEL_dyn() { return MOUSEWHEEL; }
		static ::wx::EventID MOUSE_CAPTURE_CHANGED;
		static inline ::wx::EventID MOUSE_CAPTURE_CHANGED_dyn() { return MOUSE_CAPTURE_CHANGED; }
		static ::wx::EventID MOUSE_CAPTURE_LOST;
		static inline ::wx::EventID MOUSE_CAPTURE_LOST_dyn() { return MOUSE_CAPTURE_LOST; }
		static ::wx::EventID MOVE;
		static inline ::wx::EventID MOVE_dyn() { return MOVE; }
		static ::wx::EventID MOVING;
		static inline ::wx::EventID MOVING_dyn() { return MOVING; }
		static ::wx::EventID NAVIGATION_KEY;
		static inline ::wx::EventID NAVIGATION_KEY_dyn() { return NAVIGATION_KEY; }
		static ::wx::EventID NC_ENTER_WINDOW;
		static inline ::wx::EventID NC_ENTER_WINDOW_dyn() { return NC_ENTER_WINDOW; }
		static ::wx::EventID NC_LEAVE_WINDOW;
		static inline ::wx::EventID NC_LEAVE_WINDOW_dyn() { return NC_LEAVE_WINDOW; }
		static ::wx::EventID NC_LEFT_DCLICK;
		static inline ::wx::EventID NC_LEFT_DCLICK_dyn() { return NC_LEFT_DCLICK; }
		static ::wx::EventID NC_LEFT_DOWN;
		static inline ::wx::EventID NC_LEFT_DOWN_dyn() { return NC_LEFT_DOWN; }
		static ::wx::EventID NC_LEFT_UP;
		static inline ::wx::EventID NC_LEFT_UP_dyn() { return NC_LEFT_UP; }
		static ::wx::EventID NC_MIDDLE_DCLICK;
		static inline ::wx::EventID NC_MIDDLE_DCLICK_dyn() { return NC_MIDDLE_DCLICK; }
		static ::wx::EventID NC_MIDDLE_DOWN;
		static inline ::wx::EventID NC_MIDDLE_DOWN_dyn() { return NC_MIDDLE_DOWN; }
		static ::wx::EventID NC_MIDDLE_UP;
		static inline ::wx::EventID NC_MIDDLE_UP_dyn() { return NC_MIDDLE_UP; }
		static ::wx::EventID NC_MOTION;
		static inline ::wx::EventID NC_MOTION_dyn() { return NC_MOTION; }
		static ::wx::EventID NC_PAINT;
		static inline ::wx::EventID NC_PAINT_dyn() { return NC_PAINT; }
		static ::wx::EventID NC_RIGHT_DCLICK;
		static inline ::wx::EventID NC_RIGHT_DCLICK_dyn() { return NC_RIGHT_DCLICK; }
		static ::wx::EventID NC_RIGHT_DOWN;
		static inline ::wx::EventID NC_RIGHT_DOWN_dyn() { return NC_RIGHT_DOWN; }
		static ::wx::EventID NC_RIGHT_UP;
		static inline ::wx::EventID NC_RIGHT_UP_dyn() { return NC_RIGHT_UP; }
		static ::wx::EventID PAINT;
		static inline ::wx::EventID PAINT_dyn() { return PAINT; }
		static ::wx::EventID PAINT_ICON;
		static inline ::wx::EventID PAINT_ICON_dyn() { return PAINT_ICON; }
		static ::wx::EventID PALETTE_CHANGED;
		static inline ::wx::EventID PALETTE_CHANGED_dyn() { return PALETTE_CHANGED; }
		static ::wx::EventID QUERY_END_SESSION;
		static inline ::wx::EventID QUERY_END_SESSION_dyn() { return QUERY_END_SESSION; }
		static ::wx::EventID QUERY_NEW_PALETTE;
		static inline ::wx::EventID QUERY_NEW_PALETTE_dyn() { return QUERY_NEW_PALETTE; }
		static ::wx::EventID RIGHT_DCLICK;
		static inline ::wx::EventID RIGHT_DCLICK_dyn() { return RIGHT_DCLICK; }
		static ::wx::EventID RIGHT_DOWN;
		static inline ::wx::EventID RIGHT_DOWN_dyn() { return RIGHT_DOWN; }
		static ::wx::EventID RIGHT_UP;
		static inline ::wx::EventID RIGHT_UP_dyn() { return RIGHT_UP; }
		static ::wx::EventID SCROLLWIN_BOTTOM;
		static inline ::wx::EventID SCROLLWIN_BOTTOM_dyn() { return SCROLLWIN_BOTTOM; }
		static ::wx::EventID SCROLLWIN_LINEDOWN;
		static inline ::wx::EventID SCROLLWIN_LINEDOWN_dyn() { return SCROLLWIN_LINEDOWN; }
		static ::wx::EventID SCROLLWIN_LINEUP;
		static inline ::wx::EventID SCROLLWIN_LINEUP_dyn() { return SCROLLWIN_LINEUP; }
		static ::wx::EventID SCROLLWIN_PAGEDOWN;
		static inline ::wx::EventID SCROLLWIN_PAGEDOWN_dyn() { return SCROLLWIN_PAGEDOWN; }
		static ::wx::EventID SCROLLWIN_PAGEUP;
		static inline ::wx::EventID SCROLLWIN_PAGEUP_dyn() { return SCROLLWIN_PAGEUP; }
		static ::wx::EventID SCROLLWIN_THUMBRELEASE;
		static inline ::wx::EventID SCROLLWIN_THUMBRELEASE_dyn() { return SCROLLWIN_THUMBRELEASE; }
		static ::wx::EventID SCROLLWIN_THUMBTRACK;
		static inline ::wx::EventID SCROLLWIN_THUMBTRACK_dyn() { return SCROLLWIN_THUMBTRACK; }
		static ::wx::EventID SCROLLWIN_TOP;
		static inline ::wx::EventID SCROLLWIN_TOP_dyn() { return SCROLLWIN_TOP; }
		static ::wx::EventID SCROLL_BOTTOM;
		static inline ::wx::EventID SCROLL_BOTTOM_dyn() { return SCROLL_BOTTOM; }
		static ::wx::EventID SCROLL_CHANGED;
		static inline ::wx::EventID SCROLL_CHANGED_dyn() { return SCROLL_CHANGED; }
		static ::wx::EventID SCROLL_LINEDOWN;
		static inline ::wx::EventID SCROLL_LINEDOWN_dyn() { return SCROLL_LINEDOWN; }
		static ::wx::EventID SCROLL_LINEUP;
		static inline ::wx::EventID SCROLL_LINEUP_dyn() { return SCROLL_LINEUP; }
		static ::wx::EventID SCROLL_PAGEDOWN;
		static inline ::wx::EventID SCROLL_PAGEDOWN_dyn() { return SCROLL_PAGEDOWN; }
		static ::wx::EventID SCROLL_PAGEUP;
		static inline ::wx::EventID SCROLL_PAGEUP_dyn() { return SCROLL_PAGEUP; }
		static ::wx::EventID SCROLL_THUMBRELEASE;
		static inline ::wx::EventID SCROLL_THUMBRELEASE_dyn() { return SCROLL_THUMBRELEASE; }
		static ::wx::EventID SCROLL_THUMBTRACK;
		static inline ::wx::EventID SCROLL_THUMBTRACK_dyn() { return SCROLL_THUMBTRACK; }
		static ::wx::EventID SCROLL_TOP;
		static inline ::wx::EventID SCROLL_TOP_dyn() { return SCROLL_TOP; }
		static ::wx::EventID SETTING_CHANGED;
		static inline ::wx::EventID SETTING_CHANGED_dyn() { return SETTING_CHANGED; }
		static ::wx::EventID SET_CURSOR;
		static inline ::wx::EventID SET_CURSOR_dyn() { return SET_CURSOR; }
		static ::wx::EventID SET_FOCUS;
		static inline ::wx::EventID SET_FOCUS_dyn() { return SET_FOCUS; }
		static ::wx::EventID SHOW;
		static inline ::wx::EventID SHOW_dyn() { return SHOW; }
		static ::wx::EventID SIZE;
		static inline ::wx::EventID SIZE_dyn() { return SIZE; }
		static ::wx::EventID SIZING;
		static inline ::wx::EventID SIZING_dyn() { return SIZING; }
		static ::wx::EventID SOCKET;
		static inline ::wx::EventID SOCKET_dyn() { return SOCKET; }
		static ::wx::EventID SYS_COLOUR_CHANGED;
		static inline ::wx::EventID SYS_COLOUR_CHANGED_dyn() { return SYS_COLOUR_CHANGED; }
		static ::wx::EventID TIMER;
		static inline ::wx::EventID TIMER_dyn() { return TIMER; }
		static ::wx::EventID UPDATE_UI;
		static inline ::wx::EventID UPDATE_UI_dyn() { return UPDATE_UI; }
};

} // end namespace wx

#endif /* INCLUDED_wx_EventID */ 
