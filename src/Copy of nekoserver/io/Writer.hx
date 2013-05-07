﻿package nekoserver.io;

interface Writer {
	public function write(val: Dynamic): Bool;
	public function writeInt(val: Int): Void;
	public function writeFloat(val: Float): Void;
	public function writeString(val: String): Void;
	public function writeArray(val: Array < Dynamic>, writeItem: Dynamic -> Writer -> Bool): Void;
	public function writeArrayHeader(array: Array<Dynamic>, ?withMark: Bool): Int;
	public function writeNull(): Void;
	public function writeObject(val: Dynamic, writeFields: Dynamic -> Writer -> Int -> Void): Void;
	public function writeObjectHeader(): Int;
	public function writeObjectFooter(): Void;
	public function writeObjectField(name: String, val: Dynamic, currentRef: Int, ?writeValue: Dynamic -> Bool): Void;
	public function writeObjectFieldHeader(fieldName: String): Void;
}