#ifndef INCLUDED_wx_Bitmap
#define INCLUDED_wx_Bitmap

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS2(haxe,io,Bytes)
HX_DECLARE_CLASS1(wx,Bitmap)
namespace wx{


class Bitmap_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef Bitmap_obj OBJ_;
		Bitmap_obj();
		Void __construct(Dynamic inHandle);

	public:
		static hx::ObjectPtr< Bitmap_obj > __new(Dynamic inHandle);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~Bitmap_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("Bitmap"); }

		Dynamic wxHandle; /* REM */ 
		static ::wx::Bitmap fromBytes( ::haxe::io::Bytes inBytes);
		static Dynamic fromBytes_dyn();

		static ::wx::Bitmap fromResource( ::String inResorceName);
		static Dynamic fromResource_dyn();

		static Dynamic wx_bitmap_from_bytes; /* REM */ 
		static Dynamic &wx_bitmap_from_bytes_dyn() { return wx_bitmap_from_bytes;}
};

} // end namespace wx

#endif /* INCLUDED_wx_Bitmap */ 
