package com.funanima.exif.vo.tagsRelating.gpsEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * 緯度
	 * @author 
	 */
	public class GPSLatitude extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0x0002;
		private const _count:uint = 3;
		
		/**
		 * 緯度 -90(S)~90(N)
		 * @param	degrees	度
		 * @param	minutes	分
		 * @param	seconds	秒
		 */
		public function GPSLatitude(degrees:uint,minutes:uint,seconds:Number) 
		{
			super(_tagID, TagDataDefine.N_RATIONAL,_count, [degrees,minutes,seconds]);
		}
		
	}

}