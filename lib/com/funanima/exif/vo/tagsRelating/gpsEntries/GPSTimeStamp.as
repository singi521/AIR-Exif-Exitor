package com.funanima.exif.vo.tagsRelating.gpsEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * GPS 的時間 
	 * Indicates the time as UTC (Coordinated Universal Time). TimeStamp is expressed as three RATIONAL values
	 * giving the hour, minute, and second.
	 * @author 
	 */
	public class GPSTimeStamp extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0x0007;
		private const _count:uint = 3;
		
		/**
		 * 緯度 -90(S)~90(N)
		 * @param	hour	時 	0~24
		 * @param	minute	分	0~60
		 * @param	second	秒	0~59.99
		 */
		public function GPSTimeStamp(hour:uint,minute:uint,second:Number) 
		{
			super(_tagID, TagDataDefine.N_RATIONAL,_count, [hour,minute,second]);
		}
		
	}

}