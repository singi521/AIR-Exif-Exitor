package com.funanima.exif.vo.tagsRelating.gpsEntries 
{
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * GPS 精確度數據 
	 * Indicates the GPS DOP (data degree of precision). An HDOP value is written during two-dimensional measurement,
	 * and PDOP during three-dimensional measurement.
	 * @author 
	 */
	public class GPSDOP extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0x000B;
		private const _count:uint = 1;
		
		/**
		 * 精確度數據
		 * @param	value
		 */
		public function GPSDOP(value:Number) 
		{
			super(_tagID, TagDataDefine.N_RATIONAL,_count, [value]);
		}
		
	}

}