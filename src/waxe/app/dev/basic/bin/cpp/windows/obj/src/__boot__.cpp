#include <hxcpp.h>

#include <wx/TextCtrl.h>
#include <wx/StaticText.h>
#include <wx/Sizer.h>
#include <wx/Pen.h>
#include <wx/Panel.h>
#include <wx/MenuBar.h>
#include <wx/Menu.h>
#include <wx/Frame.h>
#include <wx/TopLevelWindow.h>
#include <wx/Font.h>
#include <wx/EventID.h>
#include <wx/Error.h>
#include <wx/DC.h>
#include <wx/Colour.h>
#include <wx/Button.h>
#include <wx/Window.h>
#include <wx/EventHandler.h>
#include <wx/Brush.h>
#include <wx/Bitmap.h>
#include <wx/App.h>
#include <wx/Loader.h>
#include <test/waxe/nme/Main.h>
#include <haxe/io/Error.h>
#include <haxe/io/Bytes.h>
#include <haxe/Resource.h>
#include <haxe/Log.h>
#include <cpp/Lib.h>
#include <Type.h>
#include <ValueType.h>
#include <StringBuf.h>
#include <Std.h>
#include <Reflect.h>
#include <IntIter.h>
#include <IntHash.h>
#include <ApplicationMain.h>

void __boot_all()
{
hx::RegisterResources( hx::GetResources() );
::wx::TextCtrl_obj::__register();
::wx::StaticText_obj::__register();
::wx::Sizer_obj::__register();
::wx::Pen_obj::__register();
::wx::Panel_obj::__register();
::wx::MenuBar_obj::__register();
::wx::Menu_obj::__register();
::wx::Frame_obj::__register();
::wx::TopLevelWindow_obj::__register();
::wx::Font_obj::__register();
::wx::EventID_obj::__register();
::wx::Error_obj::__register();
::wx::DC_obj::__register();
::wx::Colour_obj::__register();
::wx::Button_obj::__register();
::wx::Window_obj::__register();
::wx::EventHandler_obj::__register();
::wx::Brush_obj::__register();
::wx::Bitmap_obj::__register();
::wx::App_obj::__register();
::wx::Loader_obj::__register();
::test::waxe::nme::Main_obj::__register();
::haxe::io::Error_obj::__register();
::haxe::io::Bytes_obj::__register();
::haxe::Resource_obj::__register();
::haxe::Log_obj::__register();
::cpp::Lib_obj::__register();
::Type_obj::__register();
::ValueType_obj::__register();
::StringBuf_obj::__register();
::Std_obj::__register();
::Reflect_obj::__register();
::IntIter_obj::__register();
::IntHash_obj::__register();
::ApplicationMain_obj::__register();
::cpp::Lib_obj::__boot();
::haxe::Log_obj::__boot();
::ApplicationMain_obj::__boot();
::IntHash_obj::__boot();
::IntIter_obj::__boot();
::Reflect_obj::__boot();
::Std_obj::__boot();
::StringBuf_obj::__boot();
::ValueType_obj::__boot();
::Type_obj::__boot();
::haxe::Resource_obj::__boot();
::haxe::io::Bytes_obj::__boot();
::haxe::io::Error_obj::__boot();
::test::waxe::nme::Main_obj::__boot();
::wx::Loader_obj::__boot();
::wx::App_obj::__boot();
::wx::Bitmap_obj::__boot();
::wx::Brush_obj::__boot();
::wx::EventHandler_obj::__boot();
::wx::Window_obj::__boot();
::wx::Button_obj::__boot();
::wx::Colour_obj::__boot();
::wx::DC_obj::__boot();
::wx::Error_obj::__boot();
::wx::EventID_obj::__boot();
::wx::Font_obj::__boot();
::wx::TopLevelWindow_obj::__boot();
::wx::Frame_obj::__boot();
::wx::Menu_obj::__boot();
::wx::MenuBar_obj::__boot();
::wx::Panel_obj::__boot();
::wx::Pen_obj::__boot();
::wx::Sizer_obj::__boot();
::wx::StaticText_obj::__boot();
::wx::TextCtrl_obj::__boot();
}

