package com.funanima.exif.vo.tagsRelating.gpsEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * GPS 接收移動速度的單位
	 * Indicates the unit used to express the GPS receiver speed of movement. 'K' 'M' and 'N' represents kilometers per
	 * hour, miles per hour, and knots.
	 * @author 
	 */
	public class GPSSpeedRef extends BaseIFDEntry
	{
		///每小時公里
		public static const KILOMETERS_PER_HOUR:String = "K";
		
		///每小時英里
		public static const MILES_PER_HOUR:String = "M";
		
		///海哩
		public static const KNOTS:String = "N";
		
		private const _tagID:uint = 0x000C;
		private const _count:uint = 2;
		
		/**
		 * GPS 速度單位
		 * @param	unitCode ex : GPSSpeedRef.KILOMETERS_PER_HOUR
		 */
		public function GPSSpeedRef(unit:String) 
		{
			super(_tagID, TagDataDefine.N_ASCII,_count, [unit]);
		}
		
	}

}