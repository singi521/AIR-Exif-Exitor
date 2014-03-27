package com.funanima.exif.vo.tagsRelating.gpsEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * GPS 移動速度
	 * Indicates the speed of GPS receiver movement.
	 * @author 
	 */
	public class GPSSpeed extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0x000D;
		private const _count:uint = 1;
		
		/**
		 * GPS 移動速度
		 * @param	speed	每小時/(公里、英里、海哩)會依據 GPSSpeedRef參考
		 */
		public function GPSSpeed(speed:Number) 
		{
			super(_tagID, TagDataDefine.N_RATIONAL,_count, [speed]);
		}
		
	}

}