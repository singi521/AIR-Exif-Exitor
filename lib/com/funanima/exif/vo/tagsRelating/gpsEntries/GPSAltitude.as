package com.funanima.exif.vo.tagsRelating.gpsEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * 海拔高度
	 * Indicates the altitude based on the reference in GPSAltitudeRef. Altitude is expressed as one RATIONAL value.
		The reference unit is meters.
	 * @author 
	 */
	public class GPSAltitude extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0x0006;
		private const _count:uint = 1;
		
		/**
		 * 海拔高度
		 * @param	meters	公尺 正負是參考 GPSAltitudeRef 可有小數點，所以這邊不可打負數
		 */
		public function GPSAltitude(meters:Number) 
		{
			super(_tagID, TagDataDefine.N_RATIONAL,_count, [Math.abs(meters)]);
		}
		
	}

}