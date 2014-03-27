package com.funanima.exif.vo.tagsRelating.gpsEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * 經度
	 * @author 
	 */
	public class GPSLongitude extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0x0004;
		private const _count:uint = 3;
		
		/**
		 * 經度　-180(W)~180(E)
		 * @param	degrees	度
		 * @param	minutes	分
		 * @param	seconds	秒
		 */
		public function GPSLongitude(degrees:uint,minutes:uint,seconds:Number) 
		{
			super(_tagID, TagDataDefine.N_RATIONAL,_count, [degrees,minutes,seconds]);
		}
		
	}

}