package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF 曝光模式
	 * This tag indicates the exposure mode set when the image was shot. 
	 * In auto-bracketing mode, the camera shoots a	series of frames of the same scene at different exposure settings.
	 * @author 
	 */
	public class ExposureMode extends BaseIFDEntry
	{
		///自動
		public static const AUTO_EXPOSURE:uint 		= 0;
		///手動
		public static const MANUAL_EXPOSURE:uint 	= 1;
		///AUTO_BRACKET
		public static const AUTO_BRACKET:uint 		= 2;
		
		private const _tagID:uint = 0xA402;
		private var _count:uint = 1;
			
		/**
		 * Exif 曝光模式 
		 * @param	mode ex:ExposureMode.AUTO_EXPOSURE
		 */
		public function ExposureMode(mode:uint) 
		{
			super(_tagID, TagDataDefine.N_SHORT,_count, [mode]);
		}
		
	}

}