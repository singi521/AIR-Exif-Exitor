package com.funanima.exif.vo.tagsRelating.gpsEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * GPS版本
	 * @author 
	 */
	public class GPSVersionID extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0x0000;
		private const _count:uint = 4;
		
		/**
		 * GPS版本號碼 ex 2.2.0.0
		 * @param	digit1
		 * @param	digit2
		 * @param	digit3
		 * @param	digit4
		 */
		public function GPSVersionID(digit1:uint=2,digit2:uint=2,digit3:uint=0,digit4:uint=0) 
		{
			super(_tagID, TagDataDefine.N_BYTE,_count, [digit1,digit2,digit3,digit4]);
		}
		
	}

}