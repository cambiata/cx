#include <hxcpp.h>

#ifndef INCLUDED_wx_Colour
#include <wx/Colour.h>
#endif
namespace wx{

Void Colour_obj::__construct(int red,int green,int blue)
{
{
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",13)
	this->mRGB = (int((int((int(red) << int((int)16))) | int((int(green) << int((int)8))))) | int(blue));
}
;
	return null();
}

Colour_obj::~Colour_obj() { }

Dynamic Colour_obj::__CreateEmpty() { return  new Colour_obj; }
hx::ObjectPtr< Colour_obj > Colour_obj::__new(int red,int green,int blue)
{  hx::ObjectPtr< Colour_obj > result = new Colour_obj();
	result->__construct(red,green,blue);
	return result;}

Dynamic Colour_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Colour_obj > result = new Colour_obj();
	result->__construct(inArgs[0],inArgs[1],inArgs[2]);
	return result;}

int Colour_obj::getRed( ){
	HX_SOURCE_PUSH("Colour_obj::getRed")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",17)
	return (int((int(this->mRGB) >> int((int)16))) & int((int)255));
}


HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,getRed,return )

int Colour_obj::setRed( int inRed){
	HX_SOURCE_PUSH("Colour_obj::setRed")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",19)
	this->mRGB = (int((int(this->mRGB) & int((int)65535))) | int((int(inRed) & int((int)255))));
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",19)
	return inRed;
}


HX_DEFINE_DYNAMIC_FUNC1(Colour_obj,setRed,return )

int Colour_obj::getGreen( ){
	HX_SOURCE_PUSH("Colour_obj::getGreen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",21)
	return (int((int(this->mRGB) >> int((int)8))) & int((int)255));
}


HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,getGreen,return )

int Colour_obj::setGreen( int inGreen){
	HX_SOURCE_PUSH("Colour_obj::setGreen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",23)
	this->mRGB = (int((int(this->mRGB) & int((int)16711935))) | int((int(inGreen) & int((int)255))));
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",23)
	return inGreen;
}


HX_DEFINE_DYNAMIC_FUNC1(Colour_obj,setGreen,return )

int Colour_obj::getBlue( ){
	HX_SOURCE_PUSH("Colour_obj::getBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",25)
	return (int((int(this->mRGB) >> int((int)16))) & int((int)255));
}


HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,getBlue,return )

int Colour_obj::setBlue( int inBlue){
	HX_SOURCE_PUSH("Colour_obj::setBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",27)
	this->mRGB = (int((int(this->mRGB) & int((int)16776960))) | int((int(inBlue) & int((int)255))));
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",27)
	return inBlue;
}


HX_DEFINE_DYNAMIC_FUNC1(Colour_obj,setBlue,return )

int Colour_obj::getCombined( ){
	HX_SOURCE_PUSH("Colour_obj::getCombined")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",29)
	return this->mRGB;
}


HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,getCombined,return )

int Colour_obj::setCombined( int inVal){
	HX_SOURCE_PUSH("Colour_obj::setCombined")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",30)
	this->mRGB = (int(inVal) & int((int)16777215));
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",30)
	return this->mRGB;
}


HX_DEFINE_DYNAMIC_FUNC1(Colour_obj,setCombined,return )

::wx::Colour Colour_obj::LightPink( ){
	HX_SOURCE_PUSH("Colour_obj::LightPink")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",33)
	return ::wx::Colour_obj::__new((int)255,(int)182,(int)193);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightPink,return )

::wx::Colour Colour_obj::Pink( ){
	HX_SOURCE_PUSH("Colour_obj::Pink")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",34)
	return ::wx::Colour_obj::__new((int)255,(int)192,(int)203);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Pink,return )

::wx::Colour Colour_obj::Crimson( ){
	HX_SOURCE_PUSH("Colour_obj::Crimson")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",35)
	return ::wx::Colour_obj::__new((int)220,(int)20,(int)60);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Crimson,return )

::wx::Colour Colour_obj::LavenderBlush( ){
	HX_SOURCE_PUSH("Colour_obj::LavenderBlush")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",36)
	return ::wx::Colour_obj::__new((int)255,(int)240,(int)245);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LavenderBlush,return )

::wx::Colour Colour_obj::PaleVioletRed( ){
	HX_SOURCE_PUSH("Colour_obj::PaleVioletRed")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",37)
	return ::wx::Colour_obj::__new((int)219,(int)112,(int)147);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,PaleVioletRed,return )

::wx::Colour Colour_obj::HotPink( ){
	HX_SOURCE_PUSH("Colour_obj::HotPink")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",38)
	return ::wx::Colour_obj::__new((int)255,(int)105,(int)180);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,HotPink,return )

::wx::Colour Colour_obj::DeepPink( ){
	HX_SOURCE_PUSH("Colour_obj::DeepPink")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",39)
	return ::wx::Colour_obj::__new((int)255,(int)20,(int)147);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DeepPink,return )

::wx::Colour Colour_obj::MediumVioletRed( ){
	HX_SOURCE_PUSH("Colour_obj::MediumVioletRed")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",40)
	return ::wx::Colour_obj::__new((int)199,(int)21,(int)133);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MediumVioletRed,return )

::wx::Colour Colour_obj::Orchid( ){
	HX_SOURCE_PUSH("Colour_obj::Orchid")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",41)
	return ::wx::Colour_obj::__new((int)218,(int)112,(int)214);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Orchid,return )

::wx::Colour Colour_obj::Thistle( ){
	HX_SOURCE_PUSH("Colour_obj::Thistle")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",42)
	return ::wx::Colour_obj::__new((int)216,(int)191,(int)216);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Thistle,return )

::wx::Colour Colour_obj::Plum( ){
	HX_SOURCE_PUSH("Colour_obj::Plum")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",43)
	return ::wx::Colour_obj::__new((int)221,(int)160,(int)221);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Plum,return )

::wx::Colour Colour_obj::Violet( ){
	HX_SOURCE_PUSH("Colour_obj::Violet")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",44)
	return ::wx::Colour_obj::__new((int)238,(int)130,(int)238);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Violet,return )

::wx::Colour Colour_obj::Fuchsia( ){
	HX_SOURCE_PUSH("Colour_obj::Fuchsia")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",45)
	return ::wx::Colour_obj::__new((int)255,(int)0,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Fuchsia,return )

::wx::Colour Colour_obj::DarkMagenta( ){
	HX_SOURCE_PUSH("Colour_obj::DarkMagenta")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",46)
	return ::wx::Colour_obj::__new((int)139,(int)0,(int)139);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkMagenta,return )

::wx::Colour Colour_obj::Purple( ){
	HX_SOURCE_PUSH("Colour_obj::Purple")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",47)
	return ::wx::Colour_obj::__new((int)128,(int)0,(int)128);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Purple,return )

::wx::Colour Colour_obj::MediumOrchid( ){
	HX_SOURCE_PUSH("Colour_obj::MediumOrchid")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",48)
	return ::wx::Colour_obj::__new((int)186,(int)85,(int)211);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MediumOrchid,return )

::wx::Colour Colour_obj::DarkViolet( ){
	HX_SOURCE_PUSH("Colour_obj::DarkViolet")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",49)
	return ::wx::Colour_obj::__new((int)148,(int)0,(int)211);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkViolet,return )

::wx::Colour Colour_obj::DarkOrchid( ){
	HX_SOURCE_PUSH("Colour_obj::DarkOrchid")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",50)
	return ::wx::Colour_obj::__new((int)153,(int)50,(int)204);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkOrchid,return )

::wx::Colour Colour_obj::Indigo( ){
	HX_SOURCE_PUSH("Colour_obj::Indigo")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",51)
	return ::wx::Colour_obj::__new((int)75,(int)0,(int)130);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Indigo,return )

::wx::Colour Colour_obj::BlueViolet( ){
	HX_SOURCE_PUSH("Colour_obj::BlueViolet")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",52)
	return ::wx::Colour_obj::__new((int)138,(int)43,(int)226);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,BlueViolet,return )

::wx::Colour Colour_obj::MediumPurple( ){
	HX_SOURCE_PUSH("Colour_obj::MediumPurple")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",53)
	return ::wx::Colour_obj::__new((int)147,(int)112,(int)219);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MediumPurple,return )

::wx::Colour Colour_obj::MediumSlateBlue( ){
	HX_SOURCE_PUSH("Colour_obj::MediumSlateBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",54)
	return ::wx::Colour_obj::__new((int)123,(int)104,(int)238);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MediumSlateBlue,return )

::wx::Colour Colour_obj::SlateBlue( ){
	HX_SOURCE_PUSH("Colour_obj::SlateBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",55)
	return ::wx::Colour_obj::__new((int)106,(int)90,(int)205);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,SlateBlue,return )

::wx::Colour Colour_obj::DarkSlateBlue( ){
	HX_SOURCE_PUSH("Colour_obj::DarkSlateBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",56)
	return ::wx::Colour_obj::__new((int)72,(int)61,(int)139);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkSlateBlue,return )

::wx::Colour Colour_obj::GhostWhite( ){
	HX_SOURCE_PUSH("Colour_obj::GhostWhite")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",57)
	return ::wx::Colour_obj::__new((int)248,(int)248,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,GhostWhite,return )

::wx::Colour Colour_obj::Lavender( ){
	HX_SOURCE_PUSH("Colour_obj::Lavender")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",58)
	return ::wx::Colour_obj::__new((int)230,(int)230,(int)250);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Lavender,return )

::wx::Colour Colour_obj::Blue( ){
	HX_SOURCE_PUSH("Colour_obj::Blue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",59)
	return ::wx::Colour_obj::__new((int)0,(int)0,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Blue,return )

::wx::Colour Colour_obj::MediumBlue( ){
	HX_SOURCE_PUSH("Colour_obj::MediumBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",60)
	return ::wx::Colour_obj::__new((int)0,(int)0,(int)205);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MediumBlue,return )

::wx::Colour Colour_obj::DarkBlue( ){
	HX_SOURCE_PUSH("Colour_obj::DarkBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",61)
	return ::wx::Colour_obj::__new((int)0,(int)0,(int)139);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkBlue,return )

::wx::Colour Colour_obj::Navy( ){
	HX_SOURCE_PUSH("Colour_obj::Navy")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",62)
	return ::wx::Colour_obj::__new((int)0,(int)0,(int)128);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Navy,return )

::wx::Colour Colour_obj::MidnightBlue( ){
	HX_SOURCE_PUSH("Colour_obj::MidnightBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",63)
	return ::wx::Colour_obj::__new((int)25,(int)25,(int)112);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MidnightBlue,return )

::wx::Colour Colour_obj::RoyalBlue( ){
	HX_SOURCE_PUSH("Colour_obj::RoyalBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",64)
	return ::wx::Colour_obj::__new((int)65,(int)105,(int)225);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,RoyalBlue,return )

::wx::Colour Colour_obj::CornflowerBlue( ){
	HX_SOURCE_PUSH("Colour_obj::CornflowerBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",65)
	return ::wx::Colour_obj::__new((int)100,(int)149,(int)237);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,CornflowerBlue,return )

::wx::Colour Colour_obj::LightSteelBlue( ){
	HX_SOURCE_PUSH("Colour_obj::LightSteelBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",66)
	return ::wx::Colour_obj::__new((int)176,(int)196,(int)222);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightSteelBlue,return )

::wx::Colour Colour_obj::LightSlateGray( ){
	HX_SOURCE_PUSH("Colour_obj::LightSlateGray")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",67)
	return ::wx::Colour_obj::__new((int)119,(int)136,(int)153);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightSlateGray,return )

::wx::Colour Colour_obj::SlateGray( ){
	HX_SOURCE_PUSH("Colour_obj::SlateGray")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",68)
	return ::wx::Colour_obj::__new((int)112,(int)128,(int)144);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,SlateGray,return )

::wx::Colour Colour_obj::DodgerBlue( ){
	HX_SOURCE_PUSH("Colour_obj::DodgerBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",69)
	return ::wx::Colour_obj::__new((int)30,(int)144,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DodgerBlue,return )

::wx::Colour Colour_obj::AliceBlue( ){
	HX_SOURCE_PUSH("Colour_obj::AliceBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",70)
	return ::wx::Colour_obj::__new((int)240,(int)248,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,AliceBlue,return )

::wx::Colour Colour_obj::SteelBlue( ){
	HX_SOURCE_PUSH("Colour_obj::SteelBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",71)
	return ::wx::Colour_obj::__new((int)70,(int)130,(int)180);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,SteelBlue,return )

::wx::Colour Colour_obj::LightSkyBlue( ){
	HX_SOURCE_PUSH("Colour_obj::LightSkyBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",72)
	return ::wx::Colour_obj::__new((int)135,(int)206,(int)250);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightSkyBlue,return )

::wx::Colour Colour_obj::SkyBlue( ){
	HX_SOURCE_PUSH("Colour_obj::SkyBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",73)
	return ::wx::Colour_obj::__new((int)135,(int)206,(int)235);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,SkyBlue,return )

::wx::Colour Colour_obj::DeepSkyBlue( ){
	HX_SOURCE_PUSH("Colour_obj::DeepSkyBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",74)
	return ::wx::Colour_obj::__new((int)0,(int)191,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DeepSkyBlue,return )

::wx::Colour Colour_obj::LightBlue( ){
	HX_SOURCE_PUSH("Colour_obj::LightBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",75)
	return ::wx::Colour_obj::__new((int)173,(int)216,(int)230);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightBlue,return )

::wx::Colour Colour_obj::PowderBlue( ){
	HX_SOURCE_PUSH("Colour_obj::PowderBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",76)
	return ::wx::Colour_obj::__new((int)176,(int)224,(int)230);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,PowderBlue,return )

::wx::Colour Colour_obj::CadetBlue( ){
	HX_SOURCE_PUSH("Colour_obj::CadetBlue")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",77)
	return ::wx::Colour_obj::__new((int)95,(int)158,(int)160);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,CadetBlue,return )

::wx::Colour Colour_obj::DarkTurquoise( ){
	HX_SOURCE_PUSH("Colour_obj::DarkTurquoise")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",78)
	return ::wx::Colour_obj::__new((int)0,(int)206,(int)209);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkTurquoise,return )

::wx::Colour Colour_obj::Azure( ){
	HX_SOURCE_PUSH("Colour_obj::Azure")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",79)
	return ::wx::Colour_obj::__new((int)240,(int)255,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Azure,return )

::wx::Colour Colour_obj::LightCyan( ){
	HX_SOURCE_PUSH("Colour_obj::LightCyan")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",80)
	return ::wx::Colour_obj::__new((int)224,(int)255,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightCyan,return )

::wx::Colour Colour_obj::PaleTurquoise( ){
	HX_SOURCE_PUSH("Colour_obj::PaleTurquoise")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",81)
	return ::wx::Colour_obj::__new((int)175,(int)238,(int)238);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,PaleTurquoise,return )

::wx::Colour Colour_obj::Aqua( ){
	HX_SOURCE_PUSH("Colour_obj::Aqua")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",82)
	return ::wx::Colour_obj::__new((int)0,(int)255,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Aqua,return )

::wx::Colour Colour_obj::DarkCyan( ){
	HX_SOURCE_PUSH("Colour_obj::DarkCyan")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",83)
	return ::wx::Colour_obj::__new((int)0,(int)139,(int)139);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkCyan,return )

::wx::Colour Colour_obj::teal( ){
	HX_SOURCE_PUSH("Colour_obj::teal")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",84)
	return ::wx::Colour_obj::__new((int)0,(int)128,(int)128);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,teal,return )

::wx::Colour Colour_obj::DarkSlateGrey( ){
	HX_SOURCE_PUSH("Colour_obj::DarkSlateGrey")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",85)
	return ::wx::Colour_obj::__new((int)47,(int)79,(int)79);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkSlateGrey,return )

::wx::Colour Colour_obj::Mediumturquoise( ){
	HX_SOURCE_PUSH("Colour_obj::Mediumturquoise")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",86)
	return ::wx::Colour_obj::__new((int)72,(int)209,(int)204);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Mediumturquoise,return )

::wx::Colour Colour_obj::Lightseagreen( ){
	HX_SOURCE_PUSH("Colour_obj::Lightseagreen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",87)
	return ::wx::Colour_obj::__new((int)32,(int)178,(int)170);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Lightseagreen,return )

::wx::Colour Colour_obj::Turquoise( ){
	HX_SOURCE_PUSH("Colour_obj::Turquoise")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",88)
	return ::wx::Colour_obj::__new((int)64,(int)224,(int)208);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Turquoise,return )

::wx::Colour Colour_obj::Aquamarine( ){
	HX_SOURCE_PUSH("Colour_obj::Aquamarine")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",89)
	return ::wx::Colour_obj::__new((int)127,(int)255,(int)212);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Aquamarine,return )

::wx::Colour Colour_obj::MediumAquamarine( ){
	HX_SOURCE_PUSH("Colour_obj::MediumAquamarine")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",90)
	return ::wx::Colour_obj::__new((int)102,(int)205,(int)170);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MediumAquamarine,return )

::wx::Colour Colour_obj::MediumSpringGreen( ){
	HX_SOURCE_PUSH("Colour_obj::MediumSpringGreen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",91)
	return ::wx::Colour_obj::__new((int)0,(int)250,(int)154);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MediumSpringGreen,return )

::wx::Colour Colour_obj::MintCream( ){
	HX_SOURCE_PUSH("Colour_obj::MintCream")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",92)
	return ::wx::Colour_obj::__new((int)245,(int)255,(int)250);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MintCream,return )

::wx::Colour Colour_obj::SpringGreen( ){
	HX_SOURCE_PUSH("Colour_obj::SpringGreen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",93)
	return ::wx::Colour_obj::__new((int)0,(int)255,(int)127);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,SpringGreen,return )

::wx::Colour Colour_obj::MediumseaGreen( ){
	HX_SOURCE_PUSH("Colour_obj::MediumseaGreen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",94)
	return ::wx::Colour_obj::__new((int)60,(int)179,(int)113);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MediumseaGreen,return )

::wx::Colour Colour_obj::Seagreen( ){
	HX_SOURCE_PUSH("Colour_obj::Seagreen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",95)
	return ::wx::Colour_obj::__new((int)46,(int)139,(int)87);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Seagreen,return )

::wx::Colour Colour_obj::HoneyDew( ){
	HX_SOURCE_PUSH("Colour_obj::HoneyDew")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",96)
	return ::wx::Colour_obj::__new((int)240,(int)255,(int)240);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,HoneyDew,return )

::wx::Colour Colour_obj::DarkseaGreen( ){
	HX_SOURCE_PUSH("Colour_obj::DarkseaGreen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",97)
	return ::wx::Colour_obj::__new((int)143,(int)188,(int)143);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkseaGreen,return )

::wx::Colour Colour_obj::PaleGreen( ){
	HX_SOURCE_PUSH("Colour_obj::PaleGreen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",98)
	return ::wx::Colour_obj::__new((int)152,(int)251,(int)152);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,PaleGreen,return )

::wx::Colour Colour_obj::LightGreen( ){
	HX_SOURCE_PUSH("Colour_obj::LightGreen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",99)
	return ::wx::Colour_obj::__new((int)144,(int)238,(int)144);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightGreen,return )

::wx::Colour Colour_obj::LimeGreen( ){
	HX_SOURCE_PUSH("Colour_obj::LimeGreen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",100)
	return ::wx::Colour_obj::__new((int)50,(int)205,(int)50);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LimeGreen,return )

::wx::Colour Colour_obj::Lime( ){
	HX_SOURCE_PUSH("Colour_obj::Lime")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",101)
	return ::wx::Colour_obj::__new((int)0,(int)255,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Lime,return )

::wx::Colour Colour_obj::ForestGreen( ){
	HX_SOURCE_PUSH("Colour_obj::ForestGreen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",102)
	return ::wx::Colour_obj::__new((int)34,(int)139,(int)34);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,ForestGreen,return )

::wx::Colour Colour_obj::Green( ){
	HX_SOURCE_PUSH("Colour_obj::Green")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",103)
	return ::wx::Colour_obj::__new((int)0,(int)128,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Green,return )

::wx::Colour Colour_obj::DarkGreen( ){
	HX_SOURCE_PUSH("Colour_obj::DarkGreen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",104)
	return ::wx::Colour_obj::__new((int)0,(int)100,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkGreen,return )

::wx::Colour Colour_obj::LawnGreen( ){
	HX_SOURCE_PUSH("Colour_obj::LawnGreen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",105)
	return ::wx::Colour_obj::__new((int)124,(int)252,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LawnGreen,return )

::wx::Colour Colour_obj::Chartreuse( ){
	HX_SOURCE_PUSH("Colour_obj::Chartreuse")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",106)
	return ::wx::Colour_obj::__new((int)127,(int)255,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Chartreuse,return )

::wx::Colour Colour_obj::Greenyellow( ){
	HX_SOURCE_PUSH("Colour_obj::Greenyellow")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",107)
	return ::wx::Colour_obj::__new((int)173,(int)255,(int)47);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Greenyellow,return )

::wx::Colour Colour_obj::DarkOliveGreen( ){
	HX_SOURCE_PUSH("Colour_obj::DarkOliveGreen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",108)
	return ::wx::Colour_obj::__new((int)85,(int)107,(int)47);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkOliveGreen,return )

::wx::Colour Colour_obj::YellowGreen( ){
	HX_SOURCE_PUSH("Colour_obj::YellowGreen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",109)
	return ::wx::Colour_obj::__new((int)154,(int)205,(int)50);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,YellowGreen,return )

::wx::Colour Colour_obj::OliveDrab( ){
	HX_SOURCE_PUSH("Colour_obj::OliveDrab")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",110)
	return ::wx::Colour_obj::__new((int)107,(int)142,(int)35);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,OliveDrab,return )

::wx::Colour Colour_obj::Ivory( ){
	HX_SOURCE_PUSH("Colour_obj::Ivory")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",111)
	return ::wx::Colour_obj::__new((int)255,(int)255,(int)240);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Ivory,return )

::wx::Colour Colour_obj::Beige( ){
	HX_SOURCE_PUSH("Colour_obj::Beige")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",112)
	return ::wx::Colour_obj::__new((int)245,(int)245,(int)220);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Beige,return )

::wx::Colour Colour_obj::LightYellow( ){
	HX_SOURCE_PUSH("Colour_obj::LightYellow")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",113)
	return ::wx::Colour_obj::__new((int)255,(int)255,(int)224);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightYellow,return )

::wx::Colour Colour_obj::LightGoldenRodYellow( ){
	HX_SOURCE_PUSH("Colour_obj::LightGoldenRodYellow")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",114)
	return ::wx::Colour_obj::__new((int)250,(int)250,(int)210);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightGoldenRodYellow,return )

::wx::Colour Colour_obj::Yellow( ){
	HX_SOURCE_PUSH("Colour_obj::Yellow")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",115)
	return ::wx::Colour_obj::__new((int)255,(int)255,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Yellow,return )

::wx::Colour Colour_obj::Olive( ){
	HX_SOURCE_PUSH("Colour_obj::Olive")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",116)
	return ::wx::Colour_obj::__new((int)128,(int)128,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Olive,return )

::wx::Colour Colour_obj::DarkKhaki( ){
	HX_SOURCE_PUSH("Colour_obj::DarkKhaki")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",117)
	return ::wx::Colour_obj::__new((int)189,(int)183,(int)107);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkKhaki,return )

::wx::Colour Colour_obj::PalegOldenRod( ){
	HX_SOURCE_PUSH("Colour_obj::PalegOldenRod")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",118)
	return ::wx::Colour_obj::__new((int)238,(int)232,(int)170);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,PalegOldenRod,return )

::wx::Colour Colour_obj::LemonChiffon( ){
	HX_SOURCE_PUSH("Colour_obj::LemonChiffon")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",119)
	return ::wx::Colour_obj::__new((int)255,(int)250,(int)205);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LemonChiffon,return )

::wx::Colour Colour_obj::Khaki( ){
	HX_SOURCE_PUSH("Colour_obj::Khaki")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",120)
	return ::wx::Colour_obj::__new((int)240,(int)230,(int)140);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Khaki,return )

::wx::Colour Colour_obj::Gold( ){
	HX_SOURCE_PUSH("Colour_obj::Gold")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",121)
	return ::wx::Colour_obj::__new((int)255,(int)215,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Gold,return )

::wx::Colour Colour_obj::CornSilk( ){
	HX_SOURCE_PUSH("Colour_obj::CornSilk")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",122)
	return ::wx::Colour_obj::__new((int)255,(int)248,(int)220);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,CornSilk,return )

::wx::Colour Colour_obj::GoldenRod( ){
	HX_SOURCE_PUSH("Colour_obj::GoldenRod")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",123)
	return ::wx::Colour_obj::__new((int)218,(int)165,(int)32);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,GoldenRod,return )

::wx::Colour Colour_obj::DarkGoldenRod( ){
	HX_SOURCE_PUSH("Colour_obj::DarkGoldenRod")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",124)
	return ::wx::Colour_obj::__new((int)184,(int)134,(int)11);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkGoldenRod,return )

::wx::Colour Colour_obj::FloralWhite( ){
	HX_SOURCE_PUSH("Colour_obj::FloralWhite")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",125)
	return ::wx::Colour_obj::__new((int)255,(int)250,(int)240);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,FloralWhite,return )

::wx::Colour Colour_obj::OldLace( ){
	HX_SOURCE_PUSH("Colour_obj::OldLace")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",126)
	return ::wx::Colour_obj::__new((int)253,(int)245,(int)230);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,OldLace,return )

::wx::Colour Colour_obj::Wheat( ){
	HX_SOURCE_PUSH("Colour_obj::Wheat")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",127)
	return ::wx::Colour_obj::__new((int)245,(int)222,(int)179);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Wheat,return )

::wx::Colour Colour_obj::Orange( ){
	HX_SOURCE_PUSH("Colour_obj::Orange")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",128)
	return ::wx::Colour_obj::__new((int)255,(int)165,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Orange,return )

::wx::Colour Colour_obj::Moccasin( ){
	HX_SOURCE_PUSH("Colour_obj::Moccasin")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",129)
	return ::wx::Colour_obj::__new((int)255,(int)228,(int)181);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Moccasin,return )

::wx::Colour Colour_obj::PapayaWhip( ){
	HX_SOURCE_PUSH("Colour_obj::PapayaWhip")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",130)
	return ::wx::Colour_obj::__new((int)255,(int)239,(int)213);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,PapayaWhip,return )

::wx::Colour Colour_obj::BlanchedAlmond( ){
	HX_SOURCE_PUSH("Colour_obj::BlanchedAlmond")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",131)
	return ::wx::Colour_obj::__new((int)255,(int)235,(int)205);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,BlanchedAlmond,return )

::wx::Colour Colour_obj::NavajoWhite( ){
	HX_SOURCE_PUSH("Colour_obj::NavajoWhite")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",132)
	return ::wx::Colour_obj::__new((int)255,(int)222,(int)173);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,NavajoWhite,return )

::wx::Colour Colour_obj::AntiqueWhite( ){
	HX_SOURCE_PUSH("Colour_obj::AntiqueWhite")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",133)
	return ::wx::Colour_obj::__new((int)250,(int)235,(int)215);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,AntiqueWhite,return )

::wx::Colour Colour_obj::Tan( ){
	HX_SOURCE_PUSH("Colour_obj::Tan")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",134)
	return ::wx::Colour_obj::__new((int)210,(int)180,(int)140);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Tan,return )

::wx::Colour Colour_obj::BurlyWood( ){
	HX_SOURCE_PUSH("Colour_obj::BurlyWood")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",135)
	return ::wx::Colour_obj::__new((int)222,(int)184,(int)135);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,BurlyWood,return )

::wx::Colour Colour_obj::DarkOrange( ){
	HX_SOURCE_PUSH("Colour_obj::DarkOrange")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",136)
	return ::wx::Colour_obj::__new((int)255,(int)140,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkOrange,return )

::wx::Colour Colour_obj::Bisque( ){
	HX_SOURCE_PUSH("Colour_obj::Bisque")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",137)
	return ::wx::Colour_obj::__new((int)255,(int)228,(int)196);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Bisque,return )

::wx::Colour Colour_obj::Linen( ){
	HX_SOURCE_PUSH("Colour_obj::Linen")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",138)
	return ::wx::Colour_obj::__new((int)250,(int)240,(int)230);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Linen,return )

::wx::Colour Colour_obj::Peru( ){
	HX_SOURCE_PUSH("Colour_obj::Peru")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",139)
	return ::wx::Colour_obj::__new((int)205,(int)133,(int)63);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Peru,return )

::wx::Colour Colour_obj::PeachPuff( ){
	HX_SOURCE_PUSH("Colour_obj::PeachPuff")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",140)
	return ::wx::Colour_obj::__new((int)255,(int)218,(int)185);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,PeachPuff,return )

::wx::Colour Colour_obj::SandyBrown( ){
	HX_SOURCE_PUSH("Colour_obj::SandyBrown")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",141)
	return ::wx::Colour_obj::__new((int)244,(int)164,(int)96);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,SandyBrown,return )

::wx::Colour Colour_obj::Chocolate( ){
	HX_SOURCE_PUSH("Colour_obj::Chocolate")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",142)
	return ::wx::Colour_obj::__new((int)210,(int)105,(int)30);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Chocolate,return )

::wx::Colour Colour_obj::SaddleBrown( ){
	HX_SOURCE_PUSH("Colour_obj::SaddleBrown")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",143)
	return ::wx::Colour_obj::__new((int)139,(int)69,(int)19);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,SaddleBrown,return )

::wx::Colour Colour_obj::SeaShell( ){
	HX_SOURCE_PUSH("Colour_obj::SeaShell")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",144)
	return ::wx::Colour_obj::__new((int)255,(int)245,(int)238);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,SeaShell,return )

::wx::Colour Colour_obj::Sienna( ){
	HX_SOURCE_PUSH("Colour_obj::Sienna")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",145)
	return ::wx::Colour_obj::__new((int)160,(int)82,(int)45);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Sienna,return )

::wx::Colour Colour_obj::LightSalmon( ){
	HX_SOURCE_PUSH("Colour_obj::LightSalmon")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",146)
	return ::wx::Colour_obj::__new((int)255,(int)160,(int)122);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightSalmon,return )

::wx::Colour Colour_obj::Coral( ){
	HX_SOURCE_PUSH("Colour_obj::Coral")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",147)
	return ::wx::Colour_obj::__new((int)255,(int)127,(int)80);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Coral,return )

::wx::Colour Colour_obj::OrangeRed( ){
	HX_SOURCE_PUSH("Colour_obj::OrangeRed")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",148)
	return ::wx::Colour_obj::__new((int)255,(int)69,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,OrangeRed,return )

::wx::Colour Colour_obj::DarkSalmon( ){
	HX_SOURCE_PUSH("Colour_obj::DarkSalmon")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",149)
	return ::wx::Colour_obj::__new((int)233,(int)150,(int)122);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkSalmon,return )

::wx::Colour Colour_obj::Tomato( ){
	HX_SOURCE_PUSH("Colour_obj::Tomato")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",150)
	return ::wx::Colour_obj::__new((int)255,(int)99,(int)71);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Tomato,return )

::wx::Colour Colour_obj::Salmon( ){
	HX_SOURCE_PUSH("Colour_obj::Salmon")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",151)
	return ::wx::Colour_obj::__new((int)250,(int)128,(int)114);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Salmon,return )

::wx::Colour Colour_obj::MistyRose( ){
	HX_SOURCE_PUSH("Colour_obj::MistyRose")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",152)
	return ::wx::Colour_obj::__new((int)255,(int)228,(int)225);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MistyRose,return )

::wx::Colour Colour_obj::LightCoral( ){
	HX_SOURCE_PUSH("Colour_obj::LightCoral")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",153)
	return ::wx::Colour_obj::__new((int)240,(int)128,(int)128);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightCoral,return )

::wx::Colour Colour_obj::Snow( ){
	HX_SOURCE_PUSH("Colour_obj::Snow")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",154)
	return ::wx::Colour_obj::__new((int)255,(int)250,(int)250);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Snow,return )

::wx::Colour Colour_obj::RosyBrown( ){
	HX_SOURCE_PUSH("Colour_obj::RosyBrown")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",155)
	return ::wx::Colour_obj::__new((int)188,(int)143,(int)143);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,RosyBrown,return )

::wx::Colour Colour_obj::IndianRed( ){
	HX_SOURCE_PUSH("Colour_obj::IndianRed")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",156)
	return ::wx::Colour_obj::__new((int)205,(int)92,(int)92);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,IndianRed,return )

::wx::Colour Colour_obj::Red( ){
	HX_SOURCE_PUSH("Colour_obj::Red")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",157)
	return ::wx::Colour_obj::__new((int)255,(int)0,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Red,return )

::wx::Colour Colour_obj::Brown( ){
	HX_SOURCE_PUSH("Colour_obj::Brown")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",158)
	return ::wx::Colour_obj::__new((int)165,(int)42,(int)42);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Brown,return )

::wx::Colour Colour_obj::FireBrick( ){
	HX_SOURCE_PUSH("Colour_obj::FireBrick")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",159)
	return ::wx::Colour_obj::__new((int)178,(int)34,(int)34);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,FireBrick,return )

::wx::Colour Colour_obj::DarkRed( ){
	HX_SOURCE_PUSH("Colour_obj::DarkRed")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",160)
	return ::wx::Colour_obj::__new((int)139,(int)0,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkRed,return )

::wx::Colour Colour_obj::Maroon( ){
	HX_SOURCE_PUSH("Colour_obj::Maroon")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",161)
	return ::wx::Colour_obj::__new((int)128,(int)0,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Maroon,return )

::wx::Colour Colour_obj::White( ){
	HX_SOURCE_PUSH("Colour_obj::White")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",162)
	return ::wx::Colour_obj::__new((int)255,(int)255,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,White,return )

::wx::Colour Colour_obj::WhiteSmoke( ){
	HX_SOURCE_PUSH("Colour_obj::WhiteSmoke")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",163)
	return ::wx::Colour_obj::__new((int)245,(int)245,(int)245);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,WhiteSmoke,return )

::wx::Colour Colour_obj::Gainsboro( ){
	HX_SOURCE_PUSH("Colour_obj::Gainsboro")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",164)
	return ::wx::Colour_obj::__new((int)220,(int)220,(int)220);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Gainsboro,return )

::wx::Colour Colour_obj::LightGrey( ){
	HX_SOURCE_PUSH("Colour_obj::LightGrey")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",165)
	return ::wx::Colour_obj::__new((int)211,(int)211,(int)211);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightGrey,return )

::wx::Colour Colour_obj::Silver( ){
	HX_SOURCE_PUSH("Colour_obj::Silver")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",166)
	return ::wx::Colour_obj::__new((int)192,(int)192,(int)192);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Silver,return )

::wx::Colour Colour_obj::DarkGrey( ){
	HX_SOURCE_PUSH("Colour_obj::DarkGrey")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",167)
	return ::wx::Colour_obj::__new((int)169,(int)169,(int)169);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkGrey,return )

::wx::Colour Colour_obj::Grey( ){
	HX_SOURCE_PUSH("Colour_obj::Grey")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",168)
	return ::wx::Colour_obj::__new((int)128,(int)128,(int)128);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Grey,return )

::wx::Colour Colour_obj::DimGrey( ){
	HX_SOURCE_PUSH("Colour_obj::DimGrey")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",169)
	return ::wx::Colour_obj::__new((int)105,(int)105,(int)105);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DimGrey,return )

::wx::Colour Colour_obj::Black( ){
	HX_SOURCE_PUSH("Colour_obj::Black")
	HX_SOURCE_POS("C:\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/Colour.hx",170)
	return ::wx::Colour_obj::__new((int)0,(int)0,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Black,return )


Colour_obj::Colour_obj()
{
}

void Colour_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Colour);
	HX_MARK_MEMBER_NAME(red,"red");
	HX_MARK_MEMBER_NAME(green,"green");
	HX_MARK_MEMBER_NAME(blue,"blue");
	HX_MARK_MEMBER_NAME(combined,"combined");
	HX_MARK_MEMBER_NAME(mRGB,"mRGB");
	HX_MARK_END_CLASS();
}

Dynamic Colour_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 3:
		if (HX_FIELD_EQ(inName,"Tan") ) { return Tan_dyn(); }
		if (HX_FIELD_EQ(inName,"Red") ) { return Red_dyn(); }
		if (HX_FIELD_EQ(inName,"red") ) { return inCallProp ? getRed() : red; }
		break;
	case 4:
		if (HX_FIELD_EQ(inName,"Pink") ) { return Pink_dyn(); }
		if (HX_FIELD_EQ(inName,"Plum") ) { return Plum_dyn(); }
		if (HX_FIELD_EQ(inName,"Blue") ) { return Blue_dyn(); }
		if (HX_FIELD_EQ(inName,"Navy") ) { return Navy_dyn(); }
		if (HX_FIELD_EQ(inName,"Aqua") ) { return Aqua_dyn(); }
		if (HX_FIELD_EQ(inName,"teal") ) { return teal_dyn(); }
		if (HX_FIELD_EQ(inName,"Lime") ) { return Lime_dyn(); }
		if (HX_FIELD_EQ(inName,"Gold") ) { return Gold_dyn(); }
		if (HX_FIELD_EQ(inName,"Peru") ) { return Peru_dyn(); }
		if (HX_FIELD_EQ(inName,"Snow") ) { return Snow_dyn(); }
		if (HX_FIELD_EQ(inName,"Grey") ) { return Grey_dyn(); }
		if (HX_FIELD_EQ(inName,"blue") ) { return inCallProp ? getBlue() : blue; }
		if (HX_FIELD_EQ(inName,"mRGB") ) { return mRGB; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"Azure") ) { return Azure_dyn(); }
		if (HX_FIELD_EQ(inName,"Green") ) { return Green_dyn(); }
		if (HX_FIELD_EQ(inName,"Ivory") ) { return Ivory_dyn(); }
		if (HX_FIELD_EQ(inName,"Beige") ) { return Beige_dyn(); }
		if (HX_FIELD_EQ(inName,"Olive") ) { return Olive_dyn(); }
		if (HX_FIELD_EQ(inName,"Khaki") ) { return Khaki_dyn(); }
		if (HX_FIELD_EQ(inName,"Wheat") ) { return Wheat_dyn(); }
		if (HX_FIELD_EQ(inName,"Linen") ) { return Linen_dyn(); }
		if (HX_FIELD_EQ(inName,"Coral") ) { return Coral_dyn(); }
		if (HX_FIELD_EQ(inName,"Brown") ) { return Brown_dyn(); }
		if (HX_FIELD_EQ(inName,"White") ) { return White_dyn(); }
		if (HX_FIELD_EQ(inName,"Black") ) { return Black_dyn(); }
		if (HX_FIELD_EQ(inName,"green") ) { return inCallProp ? getGreen() : green; }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"Orchid") ) { return Orchid_dyn(); }
		if (HX_FIELD_EQ(inName,"Violet") ) { return Violet_dyn(); }
		if (HX_FIELD_EQ(inName,"Purple") ) { return Purple_dyn(); }
		if (HX_FIELD_EQ(inName,"Indigo") ) { return Indigo_dyn(); }
		if (HX_FIELD_EQ(inName,"Yellow") ) { return Yellow_dyn(); }
		if (HX_FIELD_EQ(inName,"Orange") ) { return Orange_dyn(); }
		if (HX_FIELD_EQ(inName,"Bisque") ) { return Bisque_dyn(); }
		if (HX_FIELD_EQ(inName,"Sienna") ) { return Sienna_dyn(); }
		if (HX_FIELD_EQ(inName,"Tomato") ) { return Tomato_dyn(); }
		if (HX_FIELD_EQ(inName,"Salmon") ) { return Salmon_dyn(); }
		if (HX_FIELD_EQ(inName,"Maroon") ) { return Maroon_dyn(); }
		if (HX_FIELD_EQ(inName,"Silver") ) { return Silver_dyn(); }
		if (HX_FIELD_EQ(inName,"getRed") ) { return getRed_dyn(); }
		if (HX_FIELD_EQ(inName,"setRed") ) { return setRed_dyn(); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"Crimson") ) { return Crimson_dyn(); }
		if (HX_FIELD_EQ(inName,"HotPink") ) { return HotPink_dyn(); }
		if (HX_FIELD_EQ(inName,"Thistle") ) { return Thistle_dyn(); }
		if (HX_FIELD_EQ(inName,"Fuchsia") ) { return Fuchsia_dyn(); }
		if (HX_FIELD_EQ(inName,"SkyBlue") ) { return SkyBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"OldLace") ) { return OldLace_dyn(); }
		if (HX_FIELD_EQ(inName,"DarkRed") ) { return DarkRed_dyn(); }
		if (HX_FIELD_EQ(inName,"DimGrey") ) { return DimGrey_dyn(); }
		if (HX_FIELD_EQ(inName,"getBlue") ) { return getBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"setBlue") ) { return setBlue_dyn(); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"DeepPink") ) { return DeepPink_dyn(); }
		if (HX_FIELD_EQ(inName,"Lavender") ) { return Lavender_dyn(); }
		if (HX_FIELD_EQ(inName,"DarkBlue") ) { return DarkBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"DarkCyan") ) { return DarkCyan_dyn(); }
		if (HX_FIELD_EQ(inName,"Seagreen") ) { return Seagreen_dyn(); }
		if (HX_FIELD_EQ(inName,"HoneyDew") ) { return HoneyDew_dyn(); }
		if (HX_FIELD_EQ(inName,"CornSilk") ) { return CornSilk_dyn(); }
		if (HX_FIELD_EQ(inName,"Moccasin") ) { return Moccasin_dyn(); }
		if (HX_FIELD_EQ(inName,"SeaShell") ) { return SeaShell_dyn(); }
		if (HX_FIELD_EQ(inName,"DarkGrey") ) { return DarkGrey_dyn(); }
		if (HX_FIELD_EQ(inName,"combined") ) { return inCallProp ? getCombined() : combined; }
		if (HX_FIELD_EQ(inName,"getGreen") ) { return getGreen_dyn(); }
		if (HX_FIELD_EQ(inName,"setGreen") ) { return setGreen_dyn(); }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"LightPink") ) { return LightPink_dyn(); }
		if (HX_FIELD_EQ(inName,"SlateBlue") ) { return SlateBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"RoyalBlue") ) { return RoyalBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"SlateGray") ) { return SlateGray_dyn(); }
		if (HX_FIELD_EQ(inName,"AliceBlue") ) { return AliceBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"SteelBlue") ) { return SteelBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"LightBlue") ) { return LightBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"CadetBlue") ) { return CadetBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"LightCyan") ) { return LightCyan_dyn(); }
		if (HX_FIELD_EQ(inName,"Turquoise") ) { return Turquoise_dyn(); }
		if (HX_FIELD_EQ(inName,"MintCream") ) { return MintCream_dyn(); }
		if (HX_FIELD_EQ(inName,"PaleGreen") ) { return PaleGreen_dyn(); }
		if (HX_FIELD_EQ(inName,"LimeGreen") ) { return LimeGreen_dyn(); }
		if (HX_FIELD_EQ(inName,"DarkGreen") ) { return DarkGreen_dyn(); }
		if (HX_FIELD_EQ(inName,"LawnGreen") ) { return LawnGreen_dyn(); }
		if (HX_FIELD_EQ(inName,"OliveDrab") ) { return OliveDrab_dyn(); }
		if (HX_FIELD_EQ(inName,"DarkKhaki") ) { return DarkKhaki_dyn(); }
		if (HX_FIELD_EQ(inName,"GoldenRod") ) { return GoldenRod_dyn(); }
		if (HX_FIELD_EQ(inName,"BurlyWood") ) { return BurlyWood_dyn(); }
		if (HX_FIELD_EQ(inName,"PeachPuff") ) { return PeachPuff_dyn(); }
		if (HX_FIELD_EQ(inName,"Chocolate") ) { return Chocolate_dyn(); }
		if (HX_FIELD_EQ(inName,"OrangeRed") ) { return OrangeRed_dyn(); }
		if (HX_FIELD_EQ(inName,"MistyRose") ) { return MistyRose_dyn(); }
		if (HX_FIELD_EQ(inName,"RosyBrown") ) { return RosyBrown_dyn(); }
		if (HX_FIELD_EQ(inName,"IndianRed") ) { return IndianRed_dyn(); }
		if (HX_FIELD_EQ(inName,"FireBrick") ) { return FireBrick_dyn(); }
		if (HX_FIELD_EQ(inName,"Gainsboro") ) { return Gainsboro_dyn(); }
		if (HX_FIELD_EQ(inName,"LightGrey") ) { return LightGrey_dyn(); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"DarkViolet") ) { return DarkViolet_dyn(); }
		if (HX_FIELD_EQ(inName,"DarkOrchid") ) { return DarkOrchid_dyn(); }
		if (HX_FIELD_EQ(inName,"BlueViolet") ) { return BlueViolet_dyn(); }
		if (HX_FIELD_EQ(inName,"GhostWhite") ) { return GhostWhite_dyn(); }
		if (HX_FIELD_EQ(inName,"MediumBlue") ) { return MediumBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"DodgerBlue") ) { return DodgerBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"PowderBlue") ) { return PowderBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"Aquamarine") ) { return Aquamarine_dyn(); }
		if (HX_FIELD_EQ(inName,"LightGreen") ) { return LightGreen_dyn(); }
		if (HX_FIELD_EQ(inName,"Chartreuse") ) { return Chartreuse_dyn(); }
		if (HX_FIELD_EQ(inName,"PapayaWhip") ) { return PapayaWhip_dyn(); }
		if (HX_FIELD_EQ(inName,"DarkOrange") ) { return DarkOrange_dyn(); }
		if (HX_FIELD_EQ(inName,"SandyBrown") ) { return SandyBrown_dyn(); }
		if (HX_FIELD_EQ(inName,"DarkSalmon") ) { return DarkSalmon_dyn(); }
		if (HX_FIELD_EQ(inName,"LightCoral") ) { return LightCoral_dyn(); }
		if (HX_FIELD_EQ(inName,"WhiteSmoke") ) { return WhiteSmoke_dyn(); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"DarkMagenta") ) { return DarkMagenta_dyn(); }
		if (HX_FIELD_EQ(inName,"DeepSkyBlue") ) { return DeepSkyBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"SpringGreen") ) { return SpringGreen_dyn(); }
		if (HX_FIELD_EQ(inName,"ForestGreen") ) { return ForestGreen_dyn(); }
		if (HX_FIELD_EQ(inName,"Greenyellow") ) { return Greenyellow_dyn(); }
		if (HX_FIELD_EQ(inName,"YellowGreen") ) { return YellowGreen_dyn(); }
		if (HX_FIELD_EQ(inName,"LightYellow") ) { return LightYellow_dyn(); }
		if (HX_FIELD_EQ(inName,"FloralWhite") ) { return FloralWhite_dyn(); }
		if (HX_FIELD_EQ(inName,"NavajoWhite") ) { return NavajoWhite_dyn(); }
		if (HX_FIELD_EQ(inName,"SaddleBrown") ) { return SaddleBrown_dyn(); }
		if (HX_FIELD_EQ(inName,"LightSalmon") ) { return LightSalmon_dyn(); }
		if (HX_FIELD_EQ(inName,"getCombined") ) { return getCombined_dyn(); }
		if (HX_FIELD_EQ(inName,"setCombined") ) { return setCombined_dyn(); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"MediumOrchid") ) { return MediumOrchid_dyn(); }
		if (HX_FIELD_EQ(inName,"MediumPurple") ) { return MediumPurple_dyn(); }
		if (HX_FIELD_EQ(inName,"MidnightBlue") ) { return MidnightBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"LightSkyBlue") ) { return LightSkyBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"DarkseaGreen") ) { return DarkseaGreen_dyn(); }
		if (HX_FIELD_EQ(inName,"LemonChiffon") ) { return LemonChiffon_dyn(); }
		if (HX_FIELD_EQ(inName,"AntiqueWhite") ) { return AntiqueWhite_dyn(); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"LavenderBlush") ) { return LavenderBlush_dyn(); }
		if (HX_FIELD_EQ(inName,"PaleVioletRed") ) { return PaleVioletRed_dyn(); }
		if (HX_FIELD_EQ(inName,"DarkSlateBlue") ) { return DarkSlateBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"DarkTurquoise") ) { return DarkTurquoise_dyn(); }
		if (HX_FIELD_EQ(inName,"PaleTurquoise") ) { return PaleTurquoise_dyn(); }
		if (HX_FIELD_EQ(inName,"DarkSlateGrey") ) { return DarkSlateGrey_dyn(); }
		if (HX_FIELD_EQ(inName,"Lightseagreen") ) { return Lightseagreen_dyn(); }
		if (HX_FIELD_EQ(inName,"PalegOldenRod") ) { return PalegOldenRod_dyn(); }
		if (HX_FIELD_EQ(inName,"DarkGoldenRod") ) { return DarkGoldenRod_dyn(); }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"CornflowerBlue") ) { return CornflowerBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"LightSteelBlue") ) { return LightSteelBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"LightSlateGray") ) { return LightSlateGray_dyn(); }
		if (HX_FIELD_EQ(inName,"MediumseaGreen") ) { return MediumseaGreen_dyn(); }
		if (HX_FIELD_EQ(inName,"DarkOliveGreen") ) { return DarkOliveGreen_dyn(); }
		if (HX_FIELD_EQ(inName,"BlanchedAlmond") ) { return BlanchedAlmond_dyn(); }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"MediumVioletRed") ) { return MediumVioletRed_dyn(); }
		if (HX_FIELD_EQ(inName,"MediumSlateBlue") ) { return MediumSlateBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"Mediumturquoise") ) { return Mediumturquoise_dyn(); }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"MediumAquamarine") ) { return MediumAquamarine_dyn(); }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"MediumSpringGreen") ) { return MediumSpringGreen_dyn(); }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"LightGoldenRodYellow") ) { return LightGoldenRodYellow_dyn(); }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic Colour_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 3:
		if (HX_FIELD_EQ(inName,"red") ) { if (inCallProp) return setRed(inValue);red=inValue.Cast< int >(); return inValue; }
		break;
	case 4:
		if (HX_FIELD_EQ(inName,"blue") ) { if (inCallProp) return setBlue(inValue);blue=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"mRGB") ) { mRGB=inValue.Cast< int >(); return inValue; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"green") ) { if (inCallProp) return setGreen(inValue);green=inValue.Cast< int >(); return inValue; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"combined") ) { if (inCallProp) return setCombined(inValue);combined=inValue.Cast< int >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void Colour_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("red"));
	outFields->push(HX_CSTRING("green"));
	outFields->push(HX_CSTRING("blue"));
	outFields->push(HX_CSTRING("combined"));
	outFields->push(HX_CSTRING("mRGB"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("LightPink"),
	HX_CSTRING("Pink"),
	HX_CSTRING("Crimson"),
	HX_CSTRING("LavenderBlush"),
	HX_CSTRING("PaleVioletRed"),
	HX_CSTRING("HotPink"),
	HX_CSTRING("DeepPink"),
	HX_CSTRING("MediumVioletRed"),
	HX_CSTRING("Orchid"),
	HX_CSTRING("Thistle"),
	HX_CSTRING("Plum"),
	HX_CSTRING("Violet"),
	HX_CSTRING("Fuchsia"),
	HX_CSTRING("DarkMagenta"),
	HX_CSTRING("Purple"),
	HX_CSTRING("MediumOrchid"),
	HX_CSTRING("DarkViolet"),
	HX_CSTRING("DarkOrchid"),
	HX_CSTRING("Indigo"),
	HX_CSTRING("BlueViolet"),
	HX_CSTRING("MediumPurple"),
	HX_CSTRING("MediumSlateBlue"),
	HX_CSTRING("SlateBlue"),
	HX_CSTRING("DarkSlateBlue"),
	HX_CSTRING("GhostWhite"),
	HX_CSTRING("Lavender"),
	HX_CSTRING("Blue"),
	HX_CSTRING("MediumBlue"),
	HX_CSTRING("DarkBlue"),
	HX_CSTRING("Navy"),
	HX_CSTRING("MidnightBlue"),
	HX_CSTRING("RoyalBlue"),
	HX_CSTRING("CornflowerBlue"),
	HX_CSTRING("LightSteelBlue"),
	HX_CSTRING("LightSlateGray"),
	HX_CSTRING("SlateGray"),
	HX_CSTRING("DodgerBlue"),
	HX_CSTRING("AliceBlue"),
	HX_CSTRING("SteelBlue"),
	HX_CSTRING("LightSkyBlue"),
	HX_CSTRING("SkyBlue"),
	HX_CSTRING("DeepSkyBlue"),
	HX_CSTRING("LightBlue"),
	HX_CSTRING("PowderBlue"),
	HX_CSTRING("CadetBlue"),
	HX_CSTRING("DarkTurquoise"),
	HX_CSTRING("Azure"),
	HX_CSTRING("LightCyan"),
	HX_CSTRING("PaleTurquoise"),
	HX_CSTRING("Aqua"),
	HX_CSTRING("DarkCyan"),
	HX_CSTRING("teal"),
	HX_CSTRING("DarkSlateGrey"),
	HX_CSTRING("Mediumturquoise"),
	HX_CSTRING("Lightseagreen"),
	HX_CSTRING("Turquoise"),
	HX_CSTRING("Aquamarine"),
	HX_CSTRING("MediumAquamarine"),
	HX_CSTRING("MediumSpringGreen"),
	HX_CSTRING("MintCream"),
	HX_CSTRING("SpringGreen"),
	HX_CSTRING("MediumseaGreen"),
	HX_CSTRING("Seagreen"),
	HX_CSTRING("HoneyDew"),
	HX_CSTRING("DarkseaGreen"),
	HX_CSTRING("PaleGreen"),
	HX_CSTRING("LightGreen"),
	HX_CSTRING("LimeGreen"),
	HX_CSTRING("Lime"),
	HX_CSTRING("ForestGreen"),
	HX_CSTRING("Green"),
	HX_CSTRING("DarkGreen"),
	HX_CSTRING("LawnGreen"),
	HX_CSTRING("Chartreuse"),
	HX_CSTRING("Greenyellow"),
	HX_CSTRING("DarkOliveGreen"),
	HX_CSTRING("YellowGreen"),
	HX_CSTRING("OliveDrab"),
	HX_CSTRING("Ivory"),
	HX_CSTRING("Beige"),
	HX_CSTRING("LightYellow"),
	HX_CSTRING("LightGoldenRodYellow"),
	HX_CSTRING("Yellow"),
	HX_CSTRING("Olive"),
	HX_CSTRING("DarkKhaki"),
	HX_CSTRING("PalegOldenRod"),
	HX_CSTRING("LemonChiffon"),
	HX_CSTRING("Khaki"),
	HX_CSTRING("Gold"),
	HX_CSTRING("CornSilk"),
	HX_CSTRING("GoldenRod"),
	HX_CSTRING("DarkGoldenRod"),
	HX_CSTRING("FloralWhite"),
	HX_CSTRING("OldLace"),
	HX_CSTRING("Wheat"),
	HX_CSTRING("Orange"),
	HX_CSTRING("Moccasin"),
	HX_CSTRING("PapayaWhip"),
	HX_CSTRING("BlanchedAlmond"),
	HX_CSTRING("NavajoWhite"),
	HX_CSTRING("AntiqueWhite"),
	HX_CSTRING("Tan"),
	HX_CSTRING("BurlyWood"),
	HX_CSTRING("DarkOrange"),
	HX_CSTRING("Bisque"),
	HX_CSTRING("Linen"),
	HX_CSTRING("Peru"),
	HX_CSTRING("PeachPuff"),
	HX_CSTRING("SandyBrown"),
	HX_CSTRING("Chocolate"),
	HX_CSTRING("SaddleBrown"),
	HX_CSTRING("SeaShell"),
	HX_CSTRING("Sienna"),
	HX_CSTRING("LightSalmon"),
	HX_CSTRING("Coral"),
	HX_CSTRING("OrangeRed"),
	HX_CSTRING("DarkSalmon"),
	HX_CSTRING("Tomato"),
	HX_CSTRING("Salmon"),
	HX_CSTRING("MistyRose"),
	HX_CSTRING("LightCoral"),
	HX_CSTRING("Snow"),
	HX_CSTRING("RosyBrown"),
	HX_CSTRING("IndianRed"),
	HX_CSTRING("Red"),
	HX_CSTRING("Brown"),
	HX_CSTRING("FireBrick"),
	HX_CSTRING("DarkRed"),
	HX_CSTRING("Maroon"),
	HX_CSTRING("White"),
	HX_CSTRING("WhiteSmoke"),
	HX_CSTRING("Gainsboro"),
	HX_CSTRING("LightGrey"),
	HX_CSTRING("Silver"),
	HX_CSTRING("DarkGrey"),
	HX_CSTRING("Grey"),
	HX_CSTRING("DimGrey"),
	HX_CSTRING("Black"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("red"),
	HX_CSTRING("green"),
	HX_CSTRING("blue"),
	HX_CSTRING("combined"),
	HX_CSTRING("mRGB"),
	HX_CSTRING("getRed"),
	HX_CSTRING("setRed"),
	HX_CSTRING("getGreen"),
	HX_CSTRING("setGreen"),
	HX_CSTRING("getBlue"),
	HX_CSTRING("setBlue"),
	HX_CSTRING("getCombined"),
	HX_CSTRING("setCombined"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
};

Class Colour_obj::__mClass;

void Colour_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.Colour"), hx::TCanCast< Colour_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void Colour_obj::__boot()
{
}

} // end namespace wx
