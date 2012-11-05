#include <hxcpp.h>

#ifndef INCLUDED_wx_Colour
#include <wx/Colour.h>
#endif
namespace wx{

Void Colour_obj::__construct(int red,int green,int blue)
{
HX_STACK_PUSH("Colour::new","wx/Colour.hx",13);
{
	HX_STACK_LINE(13)
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

int Colour_obj::setCombined( int inVal){
	HX_STACK_PUSH("Colour::setCombined","wx/Colour.hx",30);
	HX_STACK_THIS(this);
	HX_STACK_ARG(inVal,"inVal");
	HX_STACK_LINE(30)
	this->mRGB = (int(inVal) & int((int)16777215));
	HX_STACK_LINE(30)
	return this->mRGB;
}


HX_DEFINE_DYNAMIC_FUNC1(Colour_obj,setCombined,return )

int Colour_obj::getCombined( ){
	HX_STACK_PUSH("Colour::getCombined","wx/Colour.hx",29);
	HX_STACK_THIS(this);
	HX_STACK_LINE(29)
	return this->mRGB;
}


HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,getCombined,return )

int Colour_obj::setBlue( int inBlue){
	HX_STACK_PUSH("Colour::setBlue","wx/Colour.hx",27);
	HX_STACK_THIS(this);
	HX_STACK_ARG(inBlue,"inBlue");
	HX_STACK_LINE(27)
	this->mRGB = (int((int(this->mRGB) & int((int)16776960))) | int((int(inBlue) & int((int)255))));
	HX_STACK_LINE(27)
	return inBlue;
}


HX_DEFINE_DYNAMIC_FUNC1(Colour_obj,setBlue,return )

int Colour_obj::getBlue( ){
	HX_STACK_PUSH("Colour::getBlue","wx/Colour.hx",25);
	HX_STACK_THIS(this);
	HX_STACK_LINE(25)
	return (int((int(this->mRGB) >> int((int)16))) & int((int)255));
}


HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,getBlue,return )

int Colour_obj::setGreen( int inGreen){
	HX_STACK_PUSH("Colour::setGreen","wx/Colour.hx",23);
	HX_STACK_THIS(this);
	HX_STACK_ARG(inGreen,"inGreen");
	HX_STACK_LINE(23)
	this->mRGB = (int((int(this->mRGB) & int((int)16711935))) | int((int(inGreen) & int((int)255))));
	HX_STACK_LINE(23)
	return inGreen;
}


HX_DEFINE_DYNAMIC_FUNC1(Colour_obj,setGreen,return )

int Colour_obj::getGreen( ){
	HX_STACK_PUSH("Colour::getGreen","wx/Colour.hx",21);
	HX_STACK_THIS(this);
	HX_STACK_LINE(21)
	return (int((int(this->mRGB) >> int((int)8))) & int((int)255));
}


HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,getGreen,return )

int Colour_obj::setRed( int inRed){
	HX_STACK_PUSH("Colour::setRed","wx/Colour.hx",19);
	HX_STACK_THIS(this);
	HX_STACK_ARG(inRed,"inRed");
	HX_STACK_LINE(19)
	this->mRGB = (int((int(this->mRGB) & int((int)65535))) | int((int(inRed) & int((int)255))));
	HX_STACK_LINE(19)
	return inRed;
}


HX_DEFINE_DYNAMIC_FUNC1(Colour_obj,setRed,return )

int Colour_obj::getRed( ){
	HX_STACK_PUSH("Colour::getRed","wx/Colour.hx",17);
	HX_STACK_THIS(this);
	HX_STACK_LINE(17)
	return (int((int(this->mRGB) >> int((int)16))) & int((int)255));
}


HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,getRed,return )

::wx::Colour Colour_obj::LightPink( ){
	HX_STACK_PUSH("Colour::LightPink","wx/Colour.hx",33);
	HX_STACK_LINE(33)
	return ::wx::Colour_obj::__new((int)255,(int)182,(int)193);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightPink,return )

::wx::Colour Colour_obj::Pink( ){
	HX_STACK_PUSH("Colour::Pink","wx/Colour.hx",34);
	HX_STACK_LINE(34)
	return ::wx::Colour_obj::__new((int)255,(int)192,(int)203);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Pink,return )

::wx::Colour Colour_obj::Crimson( ){
	HX_STACK_PUSH("Colour::Crimson","wx/Colour.hx",35);
	HX_STACK_LINE(35)
	return ::wx::Colour_obj::__new((int)220,(int)20,(int)60);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Crimson,return )

::wx::Colour Colour_obj::LavenderBlush( ){
	HX_STACK_PUSH("Colour::LavenderBlush","wx/Colour.hx",36);
	HX_STACK_LINE(36)
	return ::wx::Colour_obj::__new((int)255,(int)240,(int)245);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LavenderBlush,return )

::wx::Colour Colour_obj::PaleVioletRed( ){
	HX_STACK_PUSH("Colour::PaleVioletRed","wx/Colour.hx",37);
	HX_STACK_LINE(37)
	return ::wx::Colour_obj::__new((int)219,(int)112,(int)147);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,PaleVioletRed,return )

::wx::Colour Colour_obj::HotPink( ){
	HX_STACK_PUSH("Colour::HotPink","wx/Colour.hx",38);
	HX_STACK_LINE(38)
	return ::wx::Colour_obj::__new((int)255,(int)105,(int)180);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,HotPink,return )

::wx::Colour Colour_obj::DeepPink( ){
	HX_STACK_PUSH("Colour::DeepPink","wx/Colour.hx",39);
	HX_STACK_LINE(39)
	return ::wx::Colour_obj::__new((int)255,(int)20,(int)147);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DeepPink,return )

::wx::Colour Colour_obj::MediumVioletRed( ){
	HX_STACK_PUSH("Colour::MediumVioletRed","wx/Colour.hx",40);
	HX_STACK_LINE(40)
	return ::wx::Colour_obj::__new((int)199,(int)21,(int)133);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MediumVioletRed,return )

::wx::Colour Colour_obj::Orchid( ){
	HX_STACK_PUSH("Colour::Orchid","wx/Colour.hx",41);
	HX_STACK_LINE(41)
	return ::wx::Colour_obj::__new((int)218,(int)112,(int)214);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Orchid,return )

::wx::Colour Colour_obj::Thistle( ){
	HX_STACK_PUSH("Colour::Thistle","wx/Colour.hx",42);
	HX_STACK_LINE(42)
	return ::wx::Colour_obj::__new((int)216,(int)191,(int)216);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Thistle,return )

::wx::Colour Colour_obj::Plum( ){
	HX_STACK_PUSH("Colour::Plum","wx/Colour.hx",43);
	HX_STACK_LINE(43)
	return ::wx::Colour_obj::__new((int)221,(int)160,(int)221);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Plum,return )

::wx::Colour Colour_obj::Violet( ){
	HX_STACK_PUSH("Colour::Violet","wx/Colour.hx",44);
	HX_STACK_LINE(44)
	return ::wx::Colour_obj::__new((int)238,(int)130,(int)238);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Violet,return )

::wx::Colour Colour_obj::Fuchsia( ){
	HX_STACK_PUSH("Colour::Fuchsia","wx/Colour.hx",45);
	HX_STACK_LINE(45)
	return ::wx::Colour_obj::__new((int)255,(int)0,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Fuchsia,return )

::wx::Colour Colour_obj::DarkMagenta( ){
	HX_STACK_PUSH("Colour::DarkMagenta","wx/Colour.hx",46);
	HX_STACK_LINE(46)
	return ::wx::Colour_obj::__new((int)139,(int)0,(int)139);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkMagenta,return )

::wx::Colour Colour_obj::Purple( ){
	HX_STACK_PUSH("Colour::Purple","wx/Colour.hx",47);
	HX_STACK_LINE(47)
	return ::wx::Colour_obj::__new((int)128,(int)0,(int)128);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Purple,return )

::wx::Colour Colour_obj::MediumOrchid( ){
	HX_STACK_PUSH("Colour::MediumOrchid","wx/Colour.hx",48);
	HX_STACK_LINE(48)
	return ::wx::Colour_obj::__new((int)186,(int)85,(int)211);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MediumOrchid,return )

::wx::Colour Colour_obj::DarkViolet( ){
	HX_STACK_PUSH("Colour::DarkViolet","wx/Colour.hx",49);
	HX_STACK_LINE(49)
	return ::wx::Colour_obj::__new((int)148,(int)0,(int)211);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkViolet,return )

::wx::Colour Colour_obj::DarkOrchid( ){
	HX_STACK_PUSH("Colour::DarkOrchid","wx/Colour.hx",50);
	HX_STACK_LINE(50)
	return ::wx::Colour_obj::__new((int)153,(int)50,(int)204);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkOrchid,return )

::wx::Colour Colour_obj::Indigo( ){
	HX_STACK_PUSH("Colour::Indigo","wx/Colour.hx",51);
	HX_STACK_LINE(51)
	return ::wx::Colour_obj::__new((int)75,(int)0,(int)130);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Indigo,return )

::wx::Colour Colour_obj::BlueViolet( ){
	HX_STACK_PUSH("Colour::BlueViolet","wx/Colour.hx",52);
	HX_STACK_LINE(52)
	return ::wx::Colour_obj::__new((int)138,(int)43,(int)226);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,BlueViolet,return )

::wx::Colour Colour_obj::MediumPurple( ){
	HX_STACK_PUSH("Colour::MediumPurple","wx/Colour.hx",53);
	HX_STACK_LINE(53)
	return ::wx::Colour_obj::__new((int)147,(int)112,(int)219);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MediumPurple,return )

::wx::Colour Colour_obj::MediumSlateBlue( ){
	HX_STACK_PUSH("Colour::MediumSlateBlue","wx/Colour.hx",54);
	HX_STACK_LINE(54)
	return ::wx::Colour_obj::__new((int)123,(int)104,(int)238);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MediumSlateBlue,return )

::wx::Colour Colour_obj::SlateBlue( ){
	HX_STACK_PUSH("Colour::SlateBlue","wx/Colour.hx",55);
	HX_STACK_LINE(55)
	return ::wx::Colour_obj::__new((int)106,(int)90,(int)205);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,SlateBlue,return )

::wx::Colour Colour_obj::DarkSlateBlue( ){
	HX_STACK_PUSH("Colour::DarkSlateBlue","wx/Colour.hx",56);
	HX_STACK_LINE(56)
	return ::wx::Colour_obj::__new((int)72,(int)61,(int)139);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkSlateBlue,return )

::wx::Colour Colour_obj::GhostWhite( ){
	HX_STACK_PUSH("Colour::GhostWhite","wx/Colour.hx",57);
	HX_STACK_LINE(57)
	return ::wx::Colour_obj::__new((int)248,(int)248,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,GhostWhite,return )

::wx::Colour Colour_obj::Lavender( ){
	HX_STACK_PUSH("Colour::Lavender","wx/Colour.hx",58);
	HX_STACK_LINE(58)
	return ::wx::Colour_obj::__new((int)230,(int)230,(int)250);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Lavender,return )

::wx::Colour Colour_obj::Blue( ){
	HX_STACK_PUSH("Colour::Blue","wx/Colour.hx",59);
	HX_STACK_LINE(59)
	return ::wx::Colour_obj::__new((int)0,(int)0,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Blue,return )

::wx::Colour Colour_obj::MediumBlue( ){
	HX_STACK_PUSH("Colour::MediumBlue","wx/Colour.hx",60);
	HX_STACK_LINE(60)
	return ::wx::Colour_obj::__new((int)0,(int)0,(int)205);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MediumBlue,return )

::wx::Colour Colour_obj::DarkBlue( ){
	HX_STACK_PUSH("Colour::DarkBlue","wx/Colour.hx",61);
	HX_STACK_LINE(61)
	return ::wx::Colour_obj::__new((int)0,(int)0,(int)139);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkBlue,return )

::wx::Colour Colour_obj::Navy( ){
	HX_STACK_PUSH("Colour::Navy","wx/Colour.hx",62);
	HX_STACK_LINE(62)
	return ::wx::Colour_obj::__new((int)0,(int)0,(int)128);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Navy,return )

::wx::Colour Colour_obj::MidnightBlue( ){
	HX_STACK_PUSH("Colour::MidnightBlue","wx/Colour.hx",63);
	HX_STACK_LINE(63)
	return ::wx::Colour_obj::__new((int)25,(int)25,(int)112);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MidnightBlue,return )

::wx::Colour Colour_obj::RoyalBlue( ){
	HX_STACK_PUSH("Colour::RoyalBlue","wx/Colour.hx",64);
	HX_STACK_LINE(64)
	return ::wx::Colour_obj::__new((int)65,(int)105,(int)225);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,RoyalBlue,return )

::wx::Colour Colour_obj::CornflowerBlue( ){
	HX_STACK_PUSH("Colour::CornflowerBlue","wx/Colour.hx",65);
	HX_STACK_LINE(65)
	return ::wx::Colour_obj::__new((int)100,(int)149,(int)237);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,CornflowerBlue,return )

::wx::Colour Colour_obj::LightSteelBlue( ){
	HX_STACK_PUSH("Colour::LightSteelBlue","wx/Colour.hx",66);
	HX_STACK_LINE(66)
	return ::wx::Colour_obj::__new((int)176,(int)196,(int)222);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightSteelBlue,return )

::wx::Colour Colour_obj::LightSlateGray( ){
	HX_STACK_PUSH("Colour::LightSlateGray","wx/Colour.hx",67);
	HX_STACK_LINE(67)
	return ::wx::Colour_obj::__new((int)119,(int)136,(int)153);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightSlateGray,return )

::wx::Colour Colour_obj::SlateGray( ){
	HX_STACK_PUSH("Colour::SlateGray","wx/Colour.hx",68);
	HX_STACK_LINE(68)
	return ::wx::Colour_obj::__new((int)112,(int)128,(int)144);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,SlateGray,return )

::wx::Colour Colour_obj::DodgerBlue( ){
	HX_STACK_PUSH("Colour::DodgerBlue","wx/Colour.hx",69);
	HX_STACK_LINE(69)
	return ::wx::Colour_obj::__new((int)30,(int)144,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DodgerBlue,return )

::wx::Colour Colour_obj::AliceBlue( ){
	HX_STACK_PUSH("Colour::AliceBlue","wx/Colour.hx",70);
	HX_STACK_LINE(70)
	return ::wx::Colour_obj::__new((int)240,(int)248,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,AliceBlue,return )

::wx::Colour Colour_obj::SteelBlue( ){
	HX_STACK_PUSH("Colour::SteelBlue","wx/Colour.hx",71);
	HX_STACK_LINE(71)
	return ::wx::Colour_obj::__new((int)70,(int)130,(int)180);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,SteelBlue,return )

::wx::Colour Colour_obj::LightSkyBlue( ){
	HX_STACK_PUSH("Colour::LightSkyBlue","wx/Colour.hx",72);
	HX_STACK_LINE(72)
	return ::wx::Colour_obj::__new((int)135,(int)206,(int)250);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightSkyBlue,return )

::wx::Colour Colour_obj::SkyBlue( ){
	HX_STACK_PUSH("Colour::SkyBlue","wx/Colour.hx",73);
	HX_STACK_LINE(73)
	return ::wx::Colour_obj::__new((int)135,(int)206,(int)235);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,SkyBlue,return )

::wx::Colour Colour_obj::DeepSkyBlue( ){
	HX_STACK_PUSH("Colour::DeepSkyBlue","wx/Colour.hx",74);
	HX_STACK_LINE(74)
	return ::wx::Colour_obj::__new((int)0,(int)191,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DeepSkyBlue,return )

::wx::Colour Colour_obj::LightBlue( ){
	HX_STACK_PUSH("Colour::LightBlue","wx/Colour.hx",75);
	HX_STACK_LINE(75)
	return ::wx::Colour_obj::__new((int)173,(int)216,(int)230);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightBlue,return )

::wx::Colour Colour_obj::PowderBlue( ){
	HX_STACK_PUSH("Colour::PowderBlue","wx/Colour.hx",76);
	HX_STACK_LINE(76)
	return ::wx::Colour_obj::__new((int)176,(int)224,(int)230);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,PowderBlue,return )

::wx::Colour Colour_obj::CadetBlue( ){
	HX_STACK_PUSH("Colour::CadetBlue","wx/Colour.hx",77);
	HX_STACK_LINE(77)
	return ::wx::Colour_obj::__new((int)95,(int)158,(int)160);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,CadetBlue,return )

::wx::Colour Colour_obj::DarkTurquoise( ){
	HX_STACK_PUSH("Colour::DarkTurquoise","wx/Colour.hx",78);
	HX_STACK_LINE(78)
	return ::wx::Colour_obj::__new((int)0,(int)206,(int)209);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkTurquoise,return )

::wx::Colour Colour_obj::Azure( ){
	HX_STACK_PUSH("Colour::Azure","wx/Colour.hx",79);
	HX_STACK_LINE(79)
	return ::wx::Colour_obj::__new((int)240,(int)255,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Azure,return )

::wx::Colour Colour_obj::LightCyan( ){
	HX_STACK_PUSH("Colour::LightCyan","wx/Colour.hx",80);
	HX_STACK_LINE(80)
	return ::wx::Colour_obj::__new((int)224,(int)255,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightCyan,return )

::wx::Colour Colour_obj::PaleTurquoise( ){
	HX_STACK_PUSH("Colour::PaleTurquoise","wx/Colour.hx",81);
	HX_STACK_LINE(81)
	return ::wx::Colour_obj::__new((int)175,(int)238,(int)238);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,PaleTurquoise,return )

::wx::Colour Colour_obj::Aqua( ){
	HX_STACK_PUSH("Colour::Aqua","wx/Colour.hx",82);
	HX_STACK_LINE(82)
	return ::wx::Colour_obj::__new((int)0,(int)255,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Aqua,return )

::wx::Colour Colour_obj::DarkCyan( ){
	HX_STACK_PUSH("Colour::DarkCyan","wx/Colour.hx",83);
	HX_STACK_LINE(83)
	return ::wx::Colour_obj::__new((int)0,(int)139,(int)139);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkCyan,return )

::wx::Colour Colour_obj::teal( ){
	HX_STACK_PUSH("Colour::teal","wx/Colour.hx",84);
	HX_STACK_LINE(84)
	return ::wx::Colour_obj::__new((int)0,(int)128,(int)128);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,teal,return )

::wx::Colour Colour_obj::DarkSlateGrey( ){
	HX_STACK_PUSH("Colour::DarkSlateGrey","wx/Colour.hx",85);
	HX_STACK_LINE(85)
	return ::wx::Colour_obj::__new((int)47,(int)79,(int)79);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkSlateGrey,return )

::wx::Colour Colour_obj::Mediumturquoise( ){
	HX_STACK_PUSH("Colour::Mediumturquoise","wx/Colour.hx",86);
	HX_STACK_LINE(86)
	return ::wx::Colour_obj::__new((int)72,(int)209,(int)204);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Mediumturquoise,return )

::wx::Colour Colour_obj::Lightseagreen( ){
	HX_STACK_PUSH("Colour::Lightseagreen","wx/Colour.hx",87);
	HX_STACK_LINE(87)
	return ::wx::Colour_obj::__new((int)32,(int)178,(int)170);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Lightseagreen,return )

::wx::Colour Colour_obj::Turquoise( ){
	HX_STACK_PUSH("Colour::Turquoise","wx/Colour.hx",88);
	HX_STACK_LINE(88)
	return ::wx::Colour_obj::__new((int)64,(int)224,(int)208);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Turquoise,return )

::wx::Colour Colour_obj::Aquamarine( ){
	HX_STACK_PUSH("Colour::Aquamarine","wx/Colour.hx",89);
	HX_STACK_LINE(89)
	return ::wx::Colour_obj::__new((int)127,(int)255,(int)212);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Aquamarine,return )

::wx::Colour Colour_obj::MediumAquamarine( ){
	HX_STACK_PUSH("Colour::MediumAquamarine","wx/Colour.hx",90);
	HX_STACK_LINE(90)
	return ::wx::Colour_obj::__new((int)102,(int)205,(int)170);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MediumAquamarine,return )

::wx::Colour Colour_obj::MediumSpringGreen( ){
	HX_STACK_PUSH("Colour::MediumSpringGreen","wx/Colour.hx",91);
	HX_STACK_LINE(91)
	return ::wx::Colour_obj::__new((int)0,(int)250,(int)154);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MediumSpringGreen,return )

::wx::Colour Colour_obj::MintCream( ){
	HX_STACK_PUSH("Colour::MintCream","wx/Colour.hx",92);
	HX_STACK_LINE(92)
	return ::wx::Colour_obj::__new((int)245,(int)255,(int)250);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MintCream,return )

::wx::Colour Colour_obj::SpringGreen( ){
	HX_STACK_PUSH("Colour::SpringGreen","wx/Colour.hx",93);
	HX_STACK_LINE(93)
	return ::wx::Colour_obj::__new((int)0,(int)255,(int)127);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,SpringGreen,return )

::wx::Colour Colour_obj::MediumseaGreen( ){
	HX_STACK_PUSH("Colour::MediumseaGreen","wx/Colour.hx",94);
	HX_STACK_LINE(94)
	return ::wx::Colour_obj::__new((int)60,(int)179,(int)113);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MediumseaGreen,return )

::wx::Colour Colour_obj::Seagreen( ){
	HX_STACK_PUSH("Colour::Seagreen","wx/Colour.hx",95);
	HX_STACK_LINE(95)
	return ::wx::Colour_obj::__new((int)46,(int)139,(int)87);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Seagreen,return )

::wx::Colour Colour_obj::HoneyDew( ){
	HX_STACK_PUSH("Colour::HoneyDew","wx/Colour.hx",96);
	HX_STACK_LINE(96)
	return ::wx::Colour_obj::__new((int)240,(int)255,(int)240);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,HoneyDew,return )

::wx::Colour Colour_obj::DarkseaGreen( ){
	HX_STACK_PUSH("Colour::DarkseaGreen","wx/Colour.hx",97);
	HX_STACK_LINE(97)
	return ::wx::Colour_obj::__new((int)143,(int)188,(int)143);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkseaGreen,return )

::wx::Colour Colour_obj::PaleGreen( ){
	HX_STACK_PUSH("Colour::PaleGreen","wx/Colour.hx",98);
	HX_STACK_LINE(98)
	return ::wx::Colour_obj::__new((int)152,(int)251,(int)152);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,PaleGreen,return )

::wx::Colour Colour_obj::LightGreen( ){
	HX_STACK_PUSH("Colour::LightGreen","wx/Colour.hx",99);
	HX_STACK_LINE(99)
	return ::wx::Colour_obj::__new((int)144,(int)238,(int)144);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightGreen,return )

::wx::Colour Colour_obj::LimeGreen( ){
	HX_STACK_PUSH("Colour::LimeGreen","wx/Colour.hx",100);
	HX_STACK_LINE(100)
	return ::wx::Colour_obj::__new((int)50,(int)205,(int)50);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LimeGreen,return )

::wx::Colour Colour_obj::Lime( ){
	HX_STACK_PUSH("Colour::Lime","wx/Colour.hx",101);
	HX_STACK_LINE(101)
	return ::wx::Colour_obj::__new((int)0,(int)255,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Lime,return )

::wx::Colour Colour_obj::ForestGreen( ){
	HX_STACK_PUSH("Colour::ForestGreen","wx/Colour.hx",102);
	HX_STACK_LINE(102)
	return ::wx::Colour_obj::__new((int)34,(int)139,(int)34);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,ForestGreen,return )

::wx::Colour Colour_obj::Green( ){
	HX_STACK_PUSH("Colour::Green","wx/Colour.hx",103);
	HX_STACK_LINE(103)
	return ::wx::Colour_obj::__new((int)0,(int)128,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Green,return )

::wx::Colour Colour_obj::DarkGreen( ){
	HX_STACK_PUSH("Colour::DarkGreen","wx/Colour.hx",104);
	HX_STACK_LINE(104)
	return ::wx::Colour_obj::__new((int)0,(int)100,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkGreen,return )

::wx::Colour Colour_obj::LawnGreen( ){
	HX_STACK_PUSH("Colour::LawnGreen","wx/Colour.hx",105);
	HX_STACK_LINE(105)
	return ::wx::Colour_obj::__new((int)124,(int)252,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LawnGreen,return )

::wx::Colour Colour_obj::Chartreuse( ){
	HX_STACK_PUSH("Colour::Chartreuse","wx/Colour.hx",106);
	HX_STACK_LINE(106)
	return ::wx::Colour_obj::__new((int)127,(int)255,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Chartreuse,return )

::wx::Colour Colour_obj::Greenyellow( ){
	HX_STACK_PUSH("Colour::Greenyellow","wx/Colour.hx",107);
	HX_STACK_LINE(107)
	return ::wx::Colour_obj::__new((int)173,(int)255,(int)47);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Greenyellow,return )

::wx::Colour Colour_obj::DarkOliveGreen( ){
	HX_STACK_PUSH("Colour::DarkOliveGreen","wx/Colour.hx",108);
	HX_STACK_LINE(108)
	return ::wx::Colour_obj::__new((int)85,(int)107,(int)47);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkOliveGreen,return )

::wx::Colour Colour_obj::YellowGreen( ){
	HX_STACK_PUSH("Colour::YellowGreen","wx/Colour.hx",109);
	HX_STACK_LINE(109)
	return ::wx::Colour_obj::__new((int)154,(int)205,(int)50);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,YellowGreen,return )

::wx::Colour Colour_obj::OliveDrab( ){
	HX_STACK_PUSH("Colour::OliveDrab","wx/Colour.hx",110);
	HX_STACK_LINE(110)
	return ::wx::Colour_obj::__new((int)107,(int)142,(int)35);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,OliveDrab,return )

::wx::Colour Colour_obj::Ivory( ){
	HX_STACK_PUSH("Colour::Ivory","wx/Colour.hx",111);
	HX_STACK_LINE(111)
	return ::wx::Colour_obj::__new((int)255,(int)255,(int)240);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Ivory,return )

::wx::Colour Colour_obj::Beige( ){
	HX_STACK_PUSH("Colour::Beige","wx/Colour.hx",112);
	HX_STACK_LINE(112)
	return ::wx::Colour_obj::__new((int)245,(int)245,(int)220);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Beige,return )

::wx::Colour Colour_obj::LightYellow( ){
	HX_STACK_PUSH("Colour::LightYellow","wx/Colour.hx",113);
	HX_STACK_LINE(113)
	return ::wx::Colour_obj::__new((int)255,(int)255,(int)224);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightYellow,return )

::wx::Colour Colour_obj::LightGoldenRodYellow( ){
	HX_STACK_PUSH("Colour::LightGoldenRodYellow","wx/Colour.hx",114);
	HX_STACK_LINE(114)
	return ::wx::Colour_obj::__new((int)250,(int)250,(int)210);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightGoldenRodYellow,return )

::wx::Colour Colour_obj::Yellow( ){
	HX_STACK_PUSH("Colour::Yellow","wx/Colour.hx",115);
	HX_STACK_LINE(115)
	return ::wx::Colour_obj::__new((int)255,(int)255,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Yellow,return )

::wx::Colour Colour_obj::Olive( ){
	HX_STACK_PUSH("Colour::Olive","wx/Colour.hx",116);
	HX_STACK_LINE(116)
	return ::wx::Colour_obj::__new((int)128,(int)128,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Olive,return )

::wx::Colour Colour_obj::DarkKhaki( ){
	HX_STACK_PUSH("Colour::DarkKhaki","wx/Colour.hx",117);
	HX_STACK_LINE(117)
	return ::wx::Colour_obj::__new((int)189,(int)183,(int)107);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkKhaki,return )

::wx::Colour Colour_obj::PalegOldenRod( ){
	HX_STACK_PUSH("Colour::PalegOldenRod","wx/Colour.hx",118);
	HX_STACK_LINE(118)
	return ::wx::Colour_obj::__new((int)238,(int)232,(int)170);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,PalegOldenRod,return )

::wx::Colour Colour_obj::LemonChiffon( ){
	HX_STACK_PUSH("Colour::LemonChiffon","wx/Colour.hx",119);
	HX_STACK_LINE(119)
	return ::wx::Colour_obj::__new((int)255,(int)250,(int)205);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LemonChiffon,return )

::wx::Colour Colour_obj::Khaki( ){
	HX_STACK_PUSH("Colour::Khaki","wx/Colour.hx",120);
	HX_STACK_LINE(120)
	return ::wx::Colour_obj::__new((int)240,(int)230,(int)140);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Khaki,return )

::wx::Colour Colour_obj::Gold( ){
	HX_STACK_PUSH("Colour::Gold","wx/Colour.hx",121);
	HX_STACK_LINE(121)
	return ::wx::Colour_obj::__new((int)255,(int)215,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Gold,return )

::wx::Colour Colour_obj::CornSilk( ){
	HX_STACK_PUSH("Colour::CornSilk","wx/Colour.hx",122);
	HX_STACK_LINE(122)
	return ::wx::Colour_obj::__new((int)255,(int)248,(int)220);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,CornSilk,return )

::wx::Colour Colour_obj::GoldenRod( ){
	HX_STACK_PUSH("Colour::GoldenRod","wx/Colour.hx",123);
	HX_STACK_LINE(123)
	return ::wx::Colour_obj::__new((int)218,(int)165,(int)32);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,GoldenRod,return )

::wx::Colour Colour_obj::DarkGoldenRod( ){
	HX_STACK_PUSH("Colour::DarkGoldenRod","wx/Colour.hx",124);
	HX_STACK_LINE(124)
	return ::wx::Colour_obj::__new((int)184,(int)134,(int)11);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkGoldenRod,return )

::wx::Colour Colour_obj::FloralWhite( ){
	HX_STACK_PUSH("Colour::FloralWhite","wx/Colour.hx",125);
	HX_STACK_LINE(125)
	return ::wx::Colour_obj::__new((int)255,(int)250,(int)240);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,FloralWhite,return )

::wx::Colour Colour_obj::OldLace( ){
	HX_STACK_PUSH("Colour::OldLace","wx/Colour.hx",126);
	HX_STACK_LINE(126)
	return ::wx::Colour_obj::__new((int)253,(int)245,(int)230);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,OldLace,return )

::wx::Colour Colour_obj::Wheat( ){
	HX_STACK_PUSH("Colour::Wheat","wx/Colour.hx",127);
	HX_STACK_LINE(127)
	return ::wx::Colour_obj::__new((int)245,(int)222,(int)179);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Wheat,return )

::wx::Colour Colour_obj::Orange( ){
	HX_STACK_PUSH("Colour::Orange","wx/Colour.hx",128);
	HX_STACK_LINE(128)
	return ::wx::Colour_obj::__new((int)255,(int)165,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Orange,return )

::wx::Colour Colour_obj::Moccasin( ){
	HX_STACK_PUSH("Colour::Moccasin","wx/Colour.hx",129);
	HX_STACK_LINE(129)
	return ::wx::Colour_obj::__new((int)255,(int)228,(int)181);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Moccasin,return )

::wx::Colour Colour_obj::PapayaWhip( ){
	HX_STACK_PUSH("Colour::PapayaWhip","wx/Colour.hx",130);
	HX_STACK_LINE(130)
	return ::wx::Colour_obj::__new((int)255,(int)239,(int)213);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,PapayaWhip,return )

::wx::Colour Colour_obj::BlanchedAlmond( ){
	HX_STACK_PUSH("Colour::BlanchedAlmond","wx/Colour.hx",131);
	HX_STACK_LINE(131)
	return ::wx::Colour_obj::__new((int)255,(int)235,(int)205);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,BlanchedAlmond,return )

::wx::Colour Colour_obj::NavajoWhite( ){
	HX_STACK_PUSH("Colour::NavajoWhite","wx/Colour.hx",132);
	HX_STACK_LINE(132)
	return ::wx::Colour_obj::__new((int)255,(int)222,(int)173);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,NavajoWhite,return )

::wx::Colour Colour_obj::AntiqueWhite( ){
	HX_STACK_PUSH("Colour::AntiqueWhite","wx/Colour.hx",133);
	HX_STACK_LINE(133)
	return ::wx::Colour_obj::__new((int)250,(int)235,(int)215);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,AntiqueWhite,return )

::wx::Colour Colour_obj::Tan( ){
	HX_STACK_PUSH("Colour::Tan","wx/Colour.hx",134);
	HX_STACK_LINE(134)
	return ::wx::Colour_obj::__new((int)210,(int)180,(int)140);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Tan,return )

::wx::Colour Colour_obj::BurlyWood( ){
	HX_STACK_PUSH("Colour::BurlyWood","wx/Colour.hx",135);
	HX_STACK_LINE(135)
	return ::wx::Colour_obj::__new((int)222,(int)184,(int)135);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,BurlyWood,return )

::wx::Colour Colour_obj::DarkOrange( ){
	HX_STACK_PUSH("Colour::DarkOrange","wx/Colour.hx",136);
	HX_STACK_LINE(136)
	return ::wx::Colour_obj::__new((int)255,(int)140,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkOrange,return )

::wx::Colour Colour_obj::Bisque( ){
	HX_STACK_PUSH("Colour::Bisque","wx/Colour.hx",137);
	HX_STACK_LINE(137)
	return ::wx::Colour_obj::__new((int)255,(int)228,(int)196);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Bisque,return )

::wx::Colour Colour_obj::Linen( ){
	HX_STACK_PUSH("Colour::Linen","wx/Colour.hx",138);
	HX_STACK_LINE(138)
	return ::wx::Colour_obj::__new((int)250,(int)240,(int)230);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Linen,return )

::wx::Colour Colour_obj::Peru( ){
	HX_STACK_PUSH("Colour::Peru","wx/Colour.hx",139);
	HX_STACK_LINE(139)
	return ::wx::Colour_obj::__new((int)205,(int)133,(int)63);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Peru,return )

::wx::Colour Colour_obj::PeachPuff( ){
	HX_STACK_PUSH("Colour::PeachPuff","wx/Colour.hx",140);
	HX_STACK_LINE(140)
	return ::wx::Colour_obj::__new((int)255,(int)218,(int)185);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,PeachPuff,return )

::wx::Colour Colour_obj::SandyBrown( ){
	HX_STACK_PUSH("Colour::SandyBrown","wx/Colour.hx",141);
	HX_STACK_LINE(141)
	return ::wx::Colour_obj::__new((int)244,(int)164,(int)96);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,SandyBrown,return )

::wx::Colour Colour_obj::Chocolate( ){
	HX_STACK_PUSH("Colour::Chocolate","wx/Colour.hx",142);
	HX_STACK_LINE(142)
	return ::wx::Colour_obj::__new((int)210,(int)105,(int)30);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Chocolate,return )

::wx::Colour Colour_obj::SaddleBrown( ){
	HX_STACK_PUSH("Colour::SaddleBrown","wx/Colour.hx",143);
	HX_STACK_LINE(143)
	return ::wx::Colour_obj::__new((int)139,(int)69,(int)19);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,SaddleBrown,return )

::wx::Colour Colour_obj::SeaShell( ){
	HX_STACK_PUSH("Colour::SeaShell","wx/Colour.hx",144);
	HX_STACK_LINE(144)
	return ::wx::Colour_obj::__new((int)255,(int)245,(int)238);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,SeaShell,return )

::wx::Colour Colour_obj::Sienna( ){
	HX_STACK_PUSH("Colour::Sienna","wx/Colour.hx",145);
	HX_STACK_LINE(145)
	return ::wx::Colour_obj::__new((int)160,(int)82,(int)45);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Sienna,return )

::wx::Colour Colour_obj::LightSalmon( ){
	HX_STACK_PUSH("Colour::LightSalmon","wx/Colour.hx",146);
	HX_STACK_LINE(146)
	return ::wx::Colour_obj::__new((int)255,(int)160,(int)122);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightSalmon,return )

::wx::Colour Colour_obj::Coral( ){
	HX_STACK_PUSH("Colour::Coral","wx/Colour.hx",147);
	HX_STACK_LINE(147)
	return ::wx::Colour_obj::__new((int)255,(int)127,(int)80);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Coral,return )

::wx::Colour Colour_obj::OrangeRed( ){
	HX_STACK_PUSH("Colour::OrangeRed","wx/Colour.hx",148);
	HX_STACK_LINE(148)
	return ::wx::Colour_obj::__new((int)255,(int)69,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,OrangeRed,return )

::wx::Colour Colour_obj::DarkSalmon( ){
	HX_STACK_PUSH("Colour::DarkSalmon","wx/Colour.hx",149);
	HX_STACK_LINE(149)
	return ::wx::Colour_obj::__new((int)233,(int)150,(int)122);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkSalmon,return )

::wx::Colour Colour_obj::Tomato( ){
	HX_STACK_PUSH("Colour::Tomato","wx/Colour.hx",150);
	HX_STACK_LINE(150)
	return ::wx::Colour_obj::__new((int)255,(int)99,(int)71);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Tomato,return )

::wx::Colour Colour_obj::Salmon( ){
	HX_STACK_PUSH("Colour::Salmon","wx/Colour.hx",151);
	HX_STACK_LINE(151)
	return ::wx::Colour_obj::__new((int)250,(int)128,(int)114);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Salmon,return )

::wx::Colour Colour_obj::MistyRose( ){
	HX_STACK_PUSH("Colour::MistyRose","wx/Colour.hx",152);
	HX_STACK_LINE(152)
	return ::wx::Colour_obj::__new((int)255,(int)228,(int)225);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,MistyRose,return )

::wx::Colour Colour_obj::LightCoral( ){
	HX_STACK_PUSH("Colour::LightCoral","wx/Colour.hx",153);
	HX_STACK_LINE(153)
	return ::wx::Colour_obj::__new((int)240,(int)128,(int)128);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightCoral,return )

::wx::Colour Colour_obj::Snow( ){
	HX_STACK_PUSH("Colour::Snow","wx/Colour.hx",154);
	HX_STACK_LINE(154)
	return ::wx::Colour_obj::__new((int)255,(int)250,(int)250);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Snow,return )

::wx::Colour Colour_obj::RosyBrown( ){
	HX_STACK_PUSH("Colour::RosyBrown","wx/Colour.hx",155);
	HX_STACK_LINE(155)
	return ::wx::Colour_obj::__new((int)188,(int)143,(int)143);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,RosyBrown,return )

::wx::Colour Colour_obj::IndianRed( ){
	HX_STACK_PUSH("Colour::IndianRed","wx/Colour.hx",156);
	HX_STACK_LINE(156)
	return ::wx::Colour_obj::__new((int)205,(int)92,(int)92);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,IndianRed,return )

::wx::Colour Colour_obj::Red( ){
	HX_STACK_PUSH("Colour::Red","wx/Colour.hx",157);
	HX_STACK_LINE(157)
	return ::wx::Colour_obj::__new((int)255,(int)0,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Red,return )

::wx::Colour Colour_obj::Brown( ){
	HX_STACK_PUSH("Colour::Brown","wx/Colour.hx",158);
	HX_STACK_LINE(158)
	return ::wx::Colour_obj::__new((int)165,(int)42,(int)42);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Brown,return )

::wx::Colour Colour_obj::FireBrick( ){
	HX_STACK_PUSH("Colour::FireBrick","wx/Colour.hx",159);
	HX_STACK_LINE(159)
	return ::wx::Colour_obj::__new((int)178,(int)34,(int)34);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,FireBrick,return )

::wx::Colour Colour_obj::DarkRed( ){
	HX_STACK_PUSH("Colour::DarkRed","wx/Colour.hx",160);
	HX_STACK_LINE(160)
	return ::wx::Colour_obj::__new((int)139,(int)0,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkRed,return )

::wx::Colour Colour_obj::Maroon( ){
	HX_STACK_PUSH("Colour::Maroon","wx/Colour.hx",161);
	HX_STACK_LINE(161)
	return ::wx::Colour_obj::__new((int)128,(int)0,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Maroon,return )

::wx::Colour Colour_obj::White( ){
	HX_STACK_PUSH("Colour::White","wx/Colour.hx",162);
	HX_STACK_LINE(162)
	return ::wx::Colour_obj::__new((int)255,(int)255,(int)255);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,White,return )

::wx::Colour Colour_obj::WhiteSmoke( ){
	HX_STACK_PUSH("Colour::WhiteSmoke","wx/Colour.hx",163);
	HX_STACK_LINE(163)
	return ::wx::Colour_obj::__new((int)245,(int)245,(int)245);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,WhiteSmoke,return )

::wx::Colour Colour_obj::Gainsboro( ){
	HX_STACK_PUSH("Colour::Gainsboro","wx/Colour.hx",164);
	HX_STACK_LINE(164)
	return ::wx::Colour_obj::__new((int)220,(int)220,(int)220);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Gainsboro,return )

::wx::Colour Colour_obj::LightGrey( ){
	HX_STACK_PUSH("Colour::LightGrey","wx/Colour.hx",165);
	HX_STACK_LINE(165)
	return ::wx::Colour_obj::__new((int)211,(int)211,(int)211);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,LightGrey,return )

::wx::Colour Colour_obj::Silver( ){
	HX_STACK_PUSH("Colour::Silver","wx/Colour.hx",166);
	HX_STACK_LINE(166)
	return ::wx::Colour_obj::__new((int)192,(int)192,(int)192);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Silver,return )

::wx::Colour Colour_obj::DarkGrey( ){
	HX_STACK_PUSH("Colour::DarkGrey","wx/Colour.hx",167);
	HX_STACK_LINE(167)
	return ::wx::Colour_obj::__new((int)169,(int)169,(int)169);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DarkGrey,return )

::wx::Colour Colour_obj::Grey( ){
	HX_STACK_PUSH("Colour::Grey","wx/Colour.hx",168);
	HX_STACK_LINE(168)
	return ::wx::Colour_obj::__new((int)128,(int)128,(int)128);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Grey,return )

::wx::Colour Colour_obj::DimGrey( ){
	HX_STACK_PUSH("Colour::DimGrey","wx/Colour.hx",169);
	HX_STACK_LINE(169)
	return ::wx::Colour_obj::__new((int)105,(int)105,(int)105);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,DimGrey,return )

::wx::Colour Colour_obj::Black( ){
	HX_STACK_PUSH("Colour::Black","wx/Colour.hx",170);
	HX_STACK_LINE(170)
	return ::wx::Colour_obj::__new((int)0,(int)0,(int)0);
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(Colour_obj,Black,return )


Colour_obj::Colour_obj()
{
}

void Colour_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Colour);
	HX_MARK_MEMBER_NAME(mRGB,"mRGB");
	HX_MARK_MEMBER_NAME(combined,"combined");
	HX_MARK_MEMBER_NAME(blue,"blue");
	HX_MARK_MEMBER_NAME(green,"green");
	HX_MARK_MEMBER_NAME(red,"red");
	HX_MARK_END_CLASS();
}

void Colour_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(mRGB,"mRGB");
	HX_VISIT_MEMBER_NAME(combined,"combined");
	HX_VISIT_MEMBER_NAME(blue,"blue");
	HX_VISIT_MEMBER_NAME(green,"green");
	HX_VISIT_MEMBER_NAME(red,"red");
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
		if (HX_FIELD_EQ(inName,"mRGB") ) { return mRGB; }
		if (HX_FIELD_EQ(inName,"blue") ) { return inCallProp ? getBlue() : blue; }
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
		if (HX_FIELD_EQ(inName,"setRed") ) { return setRed_dyn(); }
		if (HX_FIELD_EQ(inName,"getRed") ) { return getRed_dyn(); }
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
		if (HX_FIELD_EQ(inName,"setBlue") ) { return setBlue_dyn(); }
		if (HX_FIELD_EQ(inName,"getBlue") ) { return getBlue_dyn(); }
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
		if (HX_FIELD_EQ(inName,"setGreen") ) { return setGreen_dyn(); }
		if (HX_FIELD_EQ(inName,"getGreen") ) { return getGreen_dyn(); }
		if (HX_FIELD_EQ(inName,"combined") ) { return inCallProp ? getCombined() : combined; }
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
		if (HX_FIELD_EQ(inName,"setCombined") ) { return setCombined_dyn(); }
		if (HX_FIELD_EQ(inName,"getCombined") ) { return getCombined_dyn(); }
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
		if (HX_FIELD_EQ(inName,"mRGB") ) { mRGB=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"blue") ) { if (inCallProp) return setBlue(inValue);blue=inValue.Cast< int >(); return inValue; }
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
	outFields->push(HX_CSTRING("mRGB"));
	outFields->push(HX_CSTRING("combined"));
	outFields->push(HX_CSTRING("blue"));
	outFields->push(HX_CSTRING("green"));
	outFields->push(HX_CSTRING("red"));
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
	HX_CSTRING("setCombined"),
	HX_CSTRING("getCombined"),
	HX_CSTRING("setBlue"),
	HX_CSTRING("getBlue"),
	HX_CSTRING("setGreen"),
	HX_CSTRING("getGreen"),
	HX_CSTRING("setRed"),
	HX_CSTRING("getRed"),
	HX_CSTRING("mRGB"),
	HX_CSTRING("combined"),
	HX_CSTRING("blue"),
	HX_CSTRING("green"),
	HX_CSTRING("red"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Colour_obj::__mClass,"__mClass");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Colour_obj::__mClass,"__mClass");
};

Class Colour_obj::__mClass;

void Colour_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.Colour"), hx::TCanCast< Colour_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void Colour_obj::__boot()
{
}

} // end namespace wx
