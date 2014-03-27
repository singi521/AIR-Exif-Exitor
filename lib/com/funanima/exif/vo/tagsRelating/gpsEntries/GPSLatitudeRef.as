package com.funanima.exif.vo.tagsRelating.gpsEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * 南北緯度
	 * @author 
	 */
	public class GPSLatitudeRef extends BaseIFDEntry
	{
		///北緯
		public static const NORTH:String = "N";
		
		///南緯
		public static const SOUTH:String = "S";
		
		
		private const _tagID:uint = 0x0001;
		private const _count:uint = 2;
		
		/**
		 * 南北緯度 ex : GPSLatitudeRef.NORTH
		 */
		public function GPSLatitudeRef(value:String) 
		{
			super(_tagID, TagDataDefine.N_ASCII,_count, [value]);
		}
		
	}

}