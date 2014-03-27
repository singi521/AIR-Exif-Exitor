package com.funanima.exif.vo
{
	/**
	 * ...
	 * @author 
	 */
	public class TagDataDefine 
	{
		public static const N_BYTE:String 		= "BYTE";
		public static const N_ASCII:String 		= "ASCII";
		public static const N_SHORT:String 		= "SHORT";
		public static const N_LONG:String 		= "LONG";
		public static const N_RATIONAL:String 	= "RATIONAL";
		public static const N_UNDEFINED:String 	= "UNDEFINED";
		public static const N_SLONG:String 		= "SLONG";
		public static const N_SRATIONAL:String 	= "SRATIONAL";
		
		private static const TAG_DATA:Object = {
			BYTE:		{"size":1,"type":1},
			ASCII:		{"size":1,"type":2},
			SHORT:		{"size":2,"type":3},
			LONG:		{"size":4,"type":4},
			RATIONAL:	{"size":8,"type":5},
			UNDEFINED:	{"size":1,"type":7},
			SLONG:		{"size":4,"type":9},
			SRATIONAL:	{"size":8,"type":10}
		}
		
		private static const TAG_TYPES:Object = {
			1: {"name":N_BYTE		, size:1},
			2: {"name":N_ASCII		, size:1},
			3: {"name":N_SHORT		, size:2},
			4: {"name":N_LONG		, size:4},
			5: {"name":N_RATIONAL	, size:8},
			7: {"name":N_UNDEFINED	, size:1},
			9: {"name":N_SLONG		, size:4},
			10: {"name":N_SRATIONAL	, size:8}
		}		
		
		private var _name:String;
		private var _size:uint;
		private var _typeValue:uint;
		
		
		public function TagDataDefine(iName:String,iSize:uint,iTypeValue:uint) 
		{
			_name = iName;
			_size = iSize;
			_typeValue = iTypeValue;
		}
		
		public static function getTagByTypeValue(type:uint):TagDataDefine {
			var tagObj:Object = TAG_TYPES[type];
			return new TagDataDefine(tagObj.name,tagObj.size,type);
		}
		
		public static function getTagByTypeName(name:String):TagDataDefine {
			var tagObj:Object = TAG_DATA[name];
			return new TagDataDefine(name,tagObj.size,tagObj.type);
		}
		
		
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get size():uint 
		{
			return _size;
		}
		
		public function get typeValue():uint 
		{
			return _typeValue;
		}
		
	}

}