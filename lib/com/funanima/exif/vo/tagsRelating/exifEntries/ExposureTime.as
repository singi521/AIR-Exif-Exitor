package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF 曝光時間
	 * Exposure time, given in seconds (sec).
	 * @author 
	 */
	public class ExposureTime extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0x829A;
		private const _count:uint = 1;
		
		/**
		 * 曝光時間
		 * @param	seconds	秒
		 */
		public function ExposureTime(seconds:Number) 
		{
			super(_tagID, TagDataDefine.N_RATIONAL,_count, [seconds]);
		}
		
	}

}