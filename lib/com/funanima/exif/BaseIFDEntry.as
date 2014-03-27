package com.funanima.exif 
{
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * ...
	 * @author 
	 */
	public class BaseIFDEntry 
	{
		private var _tagID:uint;
		private var _count:uint;
		private var _valueType:TagDataDefine;
		private var _value:Array;
	
		/**
		 * 基本的Entries
		 * @param	iTagID		tag ID
		 * @param	iValueType	ex:TagDataDefine.N_BYTE 值的型態
		 * @param	iValue		陣列資料 一個位置代表一個資料 資料空間依上方的型態而寫入
		 */
		public function BaseIFDEntry(iTagID:uint,iValueType:String,iCount:uint,iValues:Array) 
		{
			_tagID 		= iTagID;
			_valueType 	= TagDataDefine.getTagByTypeName(iValueType);
			_count		= iCount;
			_value 		= iValues;
		}
		
		
		public function get tagID():uint 
		{
			return _tagID;
		}
		
		public function get valueType():uint 
		{
			return _valueType.typeValue;
		}
		
		public function get value():Array 
		{
			return _value;
		}
		
		public function set value(value:Array):void 
		{
			_value = value;
		}
		
		public function get count():uint 
		{
			return _count;
		}
	
		
	}

}