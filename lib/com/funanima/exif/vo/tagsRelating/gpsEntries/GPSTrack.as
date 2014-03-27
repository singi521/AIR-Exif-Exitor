package com.funanima.exif.vo.tagsRelating.gpsEntries 
{
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * GPS 方位
	 * @author 
	 */
	public class GPSTrack extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0x000F;
		private const _count:uint = 1;
		
		/**
		 * GPS 方位 搭配 GPSTrackRef 使用
		 * @param	degrees	度 0.00 to 359.99.
		 */
		public function GPSTrack(degrees:Number) 
		{
			super(_tagID, TagDataDefine.N_RATIONAL,_count, [degrees]);
		}
		
	}

}