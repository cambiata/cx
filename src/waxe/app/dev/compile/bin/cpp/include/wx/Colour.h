#ifndef INCLUDED_wx_Colour
#define INCLUDED_wx_Colour

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS1(wx,Colour)
namespace wx{


class Colour_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef Colour_obj OBJ_;
		Colour_obj();
		Void __construct(int red,int green,int blue);

	public:
		static hx::ObjectPtr< Colour_obj > __new(int red,int green,int blue);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~Colour_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("Colour"); }

		int red; /* REM */ 
		int green; /* REM */ 
		int blue; /* REM */ 
		int combined; /* REM */ 
		int mRGB; /* REM */ 
		virtual int getRed( );
		Dynamic getRed_dyn();

		virtual int setRed( int inRed);
		Dynamic setRed_dyn();

		virtual int getGreen( );
		Dynamic getGreen_dyn();

		virtual int setGreen( int inGreen);
		Dynamic setGreen_dyn();

		virtual int getBlue( );
		Dynamic getBlue_dyn();

		virtual int setBlue( int inBlue);
		Dynamic setBlue_dyn();

		virtual int getCombined( );
		Dynamic getCombined_dyn();

		virtual int setCombined( int inVal);
		Dynamic setCombined_dyn();

		static ::wx::Colour LightPink( );
		static Dynamic LightPink_dyn();

		static ::wx::Colour Pink( );
		static Dynamic Pink_dyn();

		static ::wx::Colour Crimson( );
		static Dynamic Crimson_dyn();

		static ::wx::Colour LavenderBlush( );
		static Dynamic LavenderBlush_dyn();

		static ::wx::Colour PaleVioletRed( );
		static Dynamic PaleVioletRed_dyn();

		static ::wx::Colour HotPink( );
		static Dynamic HotPink_dyn();

		static ::wx::Colour DeepPink( );
		static Dynamic DeepPink_dyn();

		static ::wx::Colour MediumVioletRed( );
		static Dynamic MediumVioletRed_dyn();

		static ::wx::Colour Orchid( );
		static Dynamic Orchid_dyn();

		static ::wx::Colour Thistle( );
		static Dynamic Thistle_dyn();

		static ::wx::Colour Plum( );
		static Dynamic Plum_dyn();

		static ::wx::Colour Violet( );
		static Dynamic Violet_dyn();

		static ::wx::Colour Fuchsia( );
		static Dynamic Fuchsia_dyn();

		static ::wx::Colour DarkMagenta( );
		static Dynamic DarkMagenta_dyn();

		static ::wx::Colour Purple( );
		static Dynamic Purple_dyn();

		static ::wx::Colour MediumOrchid( );
		static Dynamic MediumOrchid_dyn();

		static ::wx::Colour DarkViolet( );
		static Dynamic DarkViolet_dyn();

		static ::wx::Colour DarkOrchid( );
		static Dynamic DarkOrchid_dyn();

		static ::wx::Colour Indigo( );
		static Dynamic Indigo_dyn();

		static ::wx::Colour BlueViolet( );
		static Dynamic BlueViolet_dyn();

		static ::wx::Colour MediumPurple( );
		static Dynamic MediumPurple_dyn();

		static ::wx::Colour MediumSlateBlue( );
		static Dynamic MediumSlateBlue_dyn();

		static ::wx::Colour SlateBlue( );
		static Dynamic SlateBlue_dyn();

		static ::wx::Colour DarkSlateBlue( );
		static Dynamic DarkSlateBlue_dyn();

		static ::wx::Colour GhostWhite( );
		static Dynamic GhostWhite_dyn();

		static ::wx::Colour Lavender( );
		static Dynamic Lavender_dyn();

		static ::wx::Colour Blue( );
		static Dynamic Blue_dyn();

		static ::wx::Colour MediumBlue( );
		static Dynamic MediumBlue_dyn();

		static ::wx::Colour DarkBlue( );
		static Dynamic DarkBlue_dyn();

		static ::wx::Colour Navy( );
		static Dynamic Navy_dyn();

		static ::wx::Colour MidnightBlue( );
		static Dynamic MidnightBlue_dyn();

		static ::wx::Colour RoyalBlue( );
		static Dynamic RoyalBlue_dyn();

		static ::wx::Colour CornflowerBlue( );
		static Dynamic CornflowerBlue_dyn();

		static ::wx::Colour LightSteelBlue( );
		static Dynamic LightSteelBlue_dyn();

		static ::wx::Colour LightSlateGray( );
		static Dynamic LightSlateGray_dyn();

		static ::wx::Colour SlateGray( );
		static Dynamic SlateGray_dyn();

		static ::wx::Colour DodgerBlue( );
		static Dynamic DodgerBlue_dyn();

		static ::wx::Colour AliceBlue( );
		static Dynamic AliceBlue_dyn();

		static ::wx::Colour SteelBlue( );
		static Dynamic SteelBlue_dyn();

		static ::wx::Colour LightSkyBlue( );
		static Dynamic LightSkyBlue_dyn();

		static ::wx::Colour SkyBlue( );
		static Dynamic SkyBlue_dyn();

		static ::wx::Colour DeepSkyBlue( );
		static Dynamic DeepSkyBlue_dyn();

		static ::wx::Colour LightBlue( );
		static Dynamic LightBlue_dyn();

		static ::wx::Colour PowderBlue( );
		static Dynamic PowderBlue_dyn();

		static ::wx::Colour CadetBlue( );
		static Dynamic CadetBlue_dyn();

		static ::wx::Colour DarkTurquoise( );
		static Dynamic DarkTurquoise_dyn();

		static ::wx::Colour Azure( );
		static Dynamic Azure_dyn();

		static ::wx::Colour LightCyan( );
		static Dynamic LightCyan_dyn();

		static ::wx::Colour PaleTurquoise( );
		static Dynamic PaleTurquoise_dyn();

		static ::wx::Colour Aqua( );
		static Dynamic Aqua_dyn();

		static ::wx::Colour DarkCyan( );
		static Dynamic DarkCyan_dyn();

		static ::wx::Colour teal( );
		static Dynamic teal_dyn();

		static ::wx::Colour DarkSlateGrey( );
		static Dynamic DarkSlateGrey_dyn();

		static ::wx::Colour Mediumturquoise( );
		static Dynamic Mediumturquoise_dyn();

		static ::wx::Colour Lightseagreen( );
		static Dynamic Lightseagreen_dyn();

		static ::wx::Colour Turquoise( );
		static Dynamic Turquoise_dyn();

		static ::wx::Colour Aquamarine( );
		static Dynamic Aquamarine_dyn();

		static ::wx::Colour MediumAquamarine( );
		static Dynamic MediumAquamarine_dyn();

		static ::wx::Colour MediumSpringGreen( );
		static Dynamic MediumSpringGreen_dyn();

		static ::wx::Colour MintCream( );
		static Dynamic MintCream_dyn();

		static ::wx::Colour SpringGreen( );
		static Dynamic SpringGreen_dyn();

		static ::wx::Colour MediumseaGreen( );
		static Dynamic MediumseaGreen_dyn();

		static ::wx::Colour Seagreen( );
		static Dynamic Seagreen_dyn();

		static ::wx::Colour HoneyDew( );
		static Dynamic HoneyDew_dyn();

		static ::wx::Colour DarkseaGreen( );
		static Dynamic DarkseaGreen_dyn();

		static ::wx::Colour PaleGreen( );
		static Dynamic PaleGreen_dyn();

		static ::wx::Colour LightGreen( );
		static Dynamic LightGreen_dyn();

		static ::wx::Colour LimeGreen( );
		static Dynamic LimeGreen_dyn();

		static ::wx::Colour Lime( );
		static Dynamic Lime_dyn();

		static ::wx::Colour ForestGreen( );
		static Dynamic ForestGreen_dyn();

		static ::wx::Colour Green( );
		static Dynamic Green_dyn();

		static ::wx::Colour DarkGreen( );
		static Dynamic DarkGreen_dyn();

		static ::wx::Colour LawnGreen( );
		static Dynamic LawnGreen_dyn();

		static ::wx::Colour Chartreuse( );
		static Dynamic Chartreuse_dyn();

		static ::wx::Colour Greenyellow( );
		static Dynamic Greenyellow_dyn();

		static ::wx::Colour DarkOliveGreen( );
		static Dynamic DarkOliveGreen_dyn();

		static ::wx::Colour YellowGreen( );
		static Dynamic YellowGreen_dyn();

		static ::wx::Colour OliveDrab( );
		static Dynamic OliveDrab_dyn();

		static ::wx::Colour Ivory( );
		static Dynamic Ivory_dyn();

		static ::wx::Colour Beige( );
		static Dynamic Beige_dyn();

		static ::wx::Colour LightYellow( );
		static Dynamic LightYellow_dyn();

		static ::wx::Colour LightGoldenRodYellow( );
		static Dynamic LightGoldenRodYellow_dyn();

		static ::wx::Colour Yellow( );
		static Dynamic Yellow_dyn();

		static ::wx::Colour Olive( );
		static Dynamic Olive_dyn();

		static ::wx::Colour DarkKhaki( );
		static Dynamic DarkKhaki_dyn();

		static ::wx::Colour PalegOldenRod( );
		static Dynamic PalegOldenRod_dyn();

		static ::wx::Colour LemonChiffon( );
		static Dynamic LemonChiffon_dyn();

		static ::wx::Colour Khaki( );
		static Dynamic Khaki_dyn();

		static ::wx::Colour Gold( );
		static Dynamic Gold_dyn();

		static ::wx::Colour CornSilk( );
		static Dynamic CornSilk_dyn();

		static ::wx::Colour GoldenRod( );
		static Dynamic GoldenRod_dyn();

		static ::wx::Colour DarkGoldenRod( );
		static Dynamic DarkGoldenRod_dyn();

		static ::wx::Colour FloralWhite( );
		static Dynamic FloralWhite_dyn();

		static ::wx::Colour OldLace( );
		static Dynamic OldLace_dyn();

		static ::wx::Colour Wheat( );
		static Dynamic Wheat_dyn();

		static ::wx::Colour Orange( );
		static Dynamic Orange_dyn();

		static ::wx::Colour Moccasin( );
		static Dynamic Moccasin_dyn();

		static ::wx::Colour PapayaWhip( );
		static Dynamic PapayaWhip_dyn();

		static ::wx::Colour BlanchedAlmond( );
		static Dynamic BlanchedAlmond_dyn();

		static ::wx::Colour NavajoWhite( );
		static Dynamic NavajoWhite_dyn();

		static ::wx::Colour AntiqueWhite( );
		static Dynamic AntiqueWhite_dyn();

		static ::wx::Colour Tan( );
		static Dynamic Tan_dyn();

		static ::wx::Colour BurlyWood( );
		static Dynamic BurlyWood_dyn();

		static ::wx::Colour DarkOrange( );
		static Dynamic DarkOrange_dyn();

		static ::wx::Colour Bisque( );
		static Dynamic Bisque_dyn();

		static ::wx::Colour Linen( );
		static Dynamic Linen_dyn();

		static ::wx::Colour Peru( );
		static Dynamic Peru_dyn();

		static ::wx::Colour PeachPuff( );
		static Dynamic PeachPuff_dyn();

		static ::wx::Colour SandyBrown( );
		static Dynamic SandyBrown_dyn();

		static ::wx::Colour Chocolate( );
		static Dynamic Chocolate_dyn();

		static ::wx::Colour SaddleBrown( );
		static Dynamic SaddleBrown_dyn();

		static ::wx::Colour SeaShell( );
		static Dynamic SeaShell_dyn();

		static ::wx::Colour Sienna( );
		static Dynamic Sienna_dyn();

		static ::wx::Colour LightSalmon( );
		static Dynamic LightSalmon_dyn();

		static ::wx::Colour Coral( );
		static Dynamic Coral_dyn();

		static ::wx::Colour OrangeRed( );
		static Dynamic OrangeRed_dyn();

		static ::wx::Colour DarkSalmon( );
		static Dynamic DarkSalmon_dyn();

		static ::wx::Colour Tomato( );
		static Dynamic Tomato_dyn();

		static ::wx::Colour Salmon( );
		static Dynamic Salmon_dyn();

		static ::wx::Colour MistyRose( );
		static Dynamic MistyRose_dyn();

		static ::wx::Colour LightCoral( );
		static Dynamic LightCoral_dyn();

		static ::wx::Colour Snow( );
		static Dynamic Snow_dyn();

		static ::wx::Colour RosyBrown( );
		static Dynamic RosyBrown_dyn();

		static ::wx::Colour IndianRed( );
		static Dynamic IndianRed_dyn();

		static ::wx::Colour Red( );
		static Dynamic Red_dyn();

		static ::wx::Colour Brown( );
		static Dynamic Brown_dyn();

		static ::wx::Colour FireBrick( );
		static Dynamic FireBrick_dyn();

		static ::wx::Colour DarkRed( );
		static Dynamic DarkRed_dyn();

		static ::wx::Colour Maroon( );
		static Dynamic Maroon_dyn();

		static ::wx::Colour White( );
		static Dynamic White_dyn();

		static ::wx::Colour WhiteSmoke( );
		static Dynamic WhiteSmoke_dyn();

		static ::wx::Colour Gainsboro( );
		static Dynamic Gainsboro_dyn();

		static ::wx::Colour LightGrey( );
		static Dynamic LightGrey_dyn();

		static ::wx::Colour Silver( );
		static Dynamic Silver_dyn();

		static ::wx::Colour DarkGrey( );
		static Dynamic DarkGrey_dyn();

		static ::wx::Colour Grey( );
		static Dynamic Grey_dyn();

		static ::wx::Colour DimGrey( );
		static Dynamic DimGrey_dyn();

		static ::wx::Colour Black( );
		static Dynamic Black_dyn();

};

} // end namespace wx

#endif /* INCLUDED_wx_Colour */ 
