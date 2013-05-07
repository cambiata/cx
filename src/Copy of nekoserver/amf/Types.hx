package nekoserver.amf;

//AMF3
enum Amf3Value {
	ATInteger(i: Int);
	ATDouble(f: Float);
	ATTrue;
	ATFalse;
	ATString(s : String);
	ATArray(a: Array<Amf3Value>);
	ATObject(fields: Hash<Amf3Value>);
	//hashes are not implemented
	ATHash(h: Hash<Dynamic>);
	ATEnum(e: Hash<Amf3Value>);
	ATUndefined;
	ATNull;
}

//AMF0
enum AmfValue {
	ANumber(f: Float);
	ABool(b: Bool);
	AString(s: String);
	AObject(fields: Hash<AmfValue>);
	AUndefined;
	ANull;
	AArray(a: Array<AmfValue>);
	//hashes are not implemented
	AHash(h: Hash<AmfValue>);
	AEnum(e: Hash<AmfValue>);
}

enum AmfVersion {
	AMF0;
	AMF3;
}

enum SenderVersion {
	//flash player version 9
	VFP9;
	//flash player version 8 and below
	VFP;
	//flash media server or flashCom server
	VFMS;
}

enum ResultIndex {
	//runtime error occured
	onStatus;
	//everything is OK
	onResult;
	onDebugEvents;
}

typedef AmfBody = {
	var name: String;
	var data: Array<Dynamic>;
	var clientResponse: String;
}

enum ClassType {
	Dyn;//Dynamic
	Exteralizable;
}

typedef EnumPath = {
	//the index of the object or an array containing an enum as a field or an element
	var objectReference: Int;
	/**
	 * this field may be either Int or String, if its Int it's showing the index of enum in a corresponding array
	 * in case it's a String it shows the field of and object which is enum
	 */
	var key: Dynamic;
}

/**
 * TODO:
 * this structure is aimed to describe the general structure of any class.
 * Now it's used only in decoding of Objects(in AMF3). This structure needs to be extended
 * to describe classes.
 */
typedef ClassDef = {
	//this flag shows whether the structure describes the instance of a class or an object
	var typedObject: Bool;
	var type: ClassType;
}

typedef AmfHeader = {
	
}

typedef AmfResult = {
	var result: Dynamic;
	var clientResponse: String;
}

