package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF ISO感光度
	 * Indicates the ISO Speed and ISO Latitude of the camera or input device as specified in ISO 12232.
	 * @author 
	 */
	public class ISOSpeedRatings extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0x8827;
		private var _count:uint = 0;//any
		
		/**
		 * ISO感光度
		 * @param	values 依據 ISO 12232 定義 陣列長度可以 1-65535個
		 */
		public function ISOSpeedRatings(values:Array) 
		{
			_count = values.length;
			super(_tagID, TagDataDefine.N_SHORT,_count, values);
		}
		
	}

}