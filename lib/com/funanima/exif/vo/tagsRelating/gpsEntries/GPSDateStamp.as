package com.funanima.exif.vo.tagsRelating.gpsEntries 
{
	import flash.globalization.DateTimeFormatter;
	import flash.globalization.DateTimeStyle;
	import flash.globalization.LocaleID;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * GPS 日期標記 
	 * A character string recording date and time information relative to UTC (Coordinated Universal Time). The
	 * format is "YYYY:MM:DD." The length of the string is 11 bytes including NULL.
	 * @author 
	 */
	public class GPSDateStamp extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0x001D;
		private const _count:uint = 11;
		
		/**
		 * GPS 日期標記
		 * @param	date
		 */
		public function GPSDateStamp(date:Date) 
		{
			const pattern:String = "yyyy:MM:dd";
			var df:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT, DateTimeStyle.SHORT, DateTimeStyle.NONE);
				df.setDateTimePattern(pattern);
			var shortDate:String = df.formatUTC(date);
			
			super(_tagID, TagDataDefine.N_ASCII,_count, [shortDate]);
		}
		
	}

}