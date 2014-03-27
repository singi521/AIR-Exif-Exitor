package com.funanima.exif.vo.tagsRelating.gpsEntries 
{
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * 方位參考
	 * @author 
	 */
	public class GPSTrackRef extends BaseIFDEntry
	{
		///真實方向
		public static const TRUE_DIRECTION:String = "T";
		
		///磁場方向
		public static const MAGNETIC_DIRECTION:String = "M";
		
		
		private const _tagID:uint = 0x000E;
		private const _count:uint = 2;
		
		/**
		 * 方位參考 ex : GPSTrackRef.NORTH
		 */
		public function GPSTrackRef(value:String) 
		{
			super(_tagID, TagDataDefine.N_ASCII,_count, [value]);
		}
		
	}

}