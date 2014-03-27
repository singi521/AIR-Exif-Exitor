package com.funanima.exif.vo.tagsRelating.gpsEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * 海拔參考
	 * @author 
	 */
	public class GPSAltitudeRef extends BaseIFDEntry
	{
		///海平面以上
		public static const ABOVE_SEA_LEVEL:uint = 0;
		
		///海平面以下
		public static const BELOW_SEA_LEVEL:uint = 1;
		
		private const _tagID:uint = 0x0005;
		private const _count:uint = 1;
		
		
		/**
		 * 海拔參考 ex:GPSAltitudeRef.BELOW_SEA_LEVEL
		 * @param	value 若高於海平面:0 低於海平面:1
		 */
		public function GPSAltitudeRef(value:uint=0) 
		{
			super(_tagID, TagDataDefine.N_BYTE,_count, [value]);
		}
		
	}

}