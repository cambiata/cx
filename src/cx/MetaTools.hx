package cx;
import haxe.rtti.Meta;

/**
 * ...
 * @author Jonas Nyström
 */
class MetaTools
{
	static public function getTypeMeta(t:Dynamic) : Dynamic
	{
		return Meta.getType(t);
	}

	static public function typeHasMetaField(t:Dynamic, metaFieldName:String) : Bool
	{
		return Lambda.has(Reflect.fields(getTypeMeta(t)), metaFieldName); 
	}
	
	static public function getTypeMetaValues(t:Dynamic, metaFieldName:String) : Array<Dynamic>
	{
		return Reflect.field(getTypeMeta(t), metaFieldName);
	}

	static public function getTypeMetaFirstValue(t:Dynamic, metaFieldName:String) : Dynamic
	{
		var values = getTypeMetaValues(t, metaFieldName);
		return (values != null) ? values[0] : null;
	}
	
	//---------------------------------------------------------------------------------------------
	
	static public function getFieldsWithMetas(t:Dynamic) : Array<String>
	{
		return Reflect.fields(Meta.getFields(t));
	}
	
	static public function fieldHasMeta(t:Dynamic, fieldName:String) : Bool
	{
		return Lambda.has(getFieldsWithMetas(t), fieldName);
	}
	
	static public function getFieldMeta(t:Dynamic, fieldName:String) : Dynamic
	{
		return Reflect.field(Meta.getFields(t), fieldName);
	}
	
	static public function getFieldMetaValues(t:Dynamic, fieldName:String, metaFieldName:String) : Array<Dynamic>
	{
		return Reflect.field(getFieldMeta(t, fieldName), metaFieldName);
	}
	
	static public function fieldHasMetaField(t:Dynamic, fieldName:String, metaFieldName:String) : Bool 
	{
		return Lambda.has(Reflect.fields(getFieldMeta(t, fieldName)), metaFieldName);
	}
	
	static public function getFieldMetaFirstValue(t:Dynamic, fieldName:String, metaFieldName:String) : Dynamic
	{
		var values = getFieldMetaValues(t, fieldName, metaFieldName);
		return (values != null) ? values[0] : null;
	}

	//---------------------------------------------------------------------------------------------
	

	
}

@author("Jonas") 
@debug(true) 
@test
class Test 
{
	@values( -1, 100) 
	@v2('abc')
	var x : Int;
	
	@yValues
	@test
	var y:Float;
	
	@try('this')
	public function testMethod()
	{
		return null;
	}
	
	var z:String;

	static public function test()
	{
		trace(MetaTools.getTypeMeta(Test));
		trace(MetaTools.typeHasMetaField(Test, 'test'));
		trace(MetaTools.typeHasMetaField(Test, 'xtest'));
		trace(MetaTools.getTypeMetaValues(Test, 'debug'));
		trace(MetaTools.getTypeMetaFirstValue(Test, 'debug'));
		
		trace(MetaTools.getFieldsWithMetas(Test));
		trace(MetaTools.fieldHasMeta(Test, 'z'));
		trace(MetaTools.getFieldMeta(Test, 'x'));
		trace(MetaTools.getFieldMeta(Test, 'y'));
		trace(MetaTools.getFieldMetaValues(Test, 'y', 'test'));
		trace(MetaTools.fieldHasMetaField(Test, 'y', 'test'));
		trace(MetaTools.fieldHasMetaField(Test, 'y', 'xtest'));
		trace(MetaTools.getFieldMetaValues(Test, 'x', 'values'));
		trace(MetaTools.getFieldMetaFirstValue(Test, 'x', 'values'));
		trace(MetaTools.getFieldMetaFirstValue(Test, 'x', 'valuesx'));
	}	
}