package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF 曝光模式
	 * The class of the program used by the camera to set exposure when the picture is taken. The tag values are as follows.
	 * @author 
	 */
	public class ExposureProgram extends BaseIFDEntry
	{
		///未定義
		public static const NOT_DEFINED:uint 		= 0;
		///手動
		public static const MANUAL:uint 			= 1;
		///標準
		public static const NORMAL_PROGRAM:uint 	= 2;
		///光圈先決
		public static const APERTURE_PRIORITY:uint 	= 3;
		///快門先決
		public static const SHUTTER_PRIORITY:uint 	= 4;
		///景深先決 (biased toward depth of field)
		public static const CREATIVE_PROGRAM:uint 	= 5;
		///運動模式(biased toward depth of field)
		public static const ACTION_PROGRAM:uint 	= 6;
		///肖像模式(for closeup photos with the background out of focus)
		public static const PORTRAIT_MODE:uint 		= 7;
		///風景模式(for landscape photos with the background in focus)
		public static const LANDSCAPE_MODE:uint 	= 8;
		
		private const _tagID:uint = 0x8822;
		private const _count:uint = 1;
		
		/**
		 * 曝光模式
		 * @param	takenMode ex:ExposureProgram.LANDSCAPE_MODE
		 */
		public function ExposureProgram(takenMode:uint=0) 
		{
			super(_tagID, TagDataDefine.N_SHORT,_count, [fnumber]);
		}
		
	}

}