package com.funanima.exif.vo.tagsRelating.gpsEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * 東西經
	 * @author 
	 */
	public class GPSLongitudeRef extends BaseIFDEntry
	{
		///東經
		public static const EAST:String = "E";
		
		///西經
		public static const WEST:String = "W";
		
		private const _tagID:uint = 0x0003;
		private const _count:uint = 2;
		
		/**
		 * 南北緯度 ex : GPSLongitudeRef.NORTH
		 */
		public function GPSLongitudeRef(value:String) 
		{
			super(_tagID, TagDataDefine.N_ASCII,_count, [value]);
		}
		
	}

}