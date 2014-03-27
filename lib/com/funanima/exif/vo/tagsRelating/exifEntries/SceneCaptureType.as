package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF 場景拍攝類型
	 * This tag indicates the type of scene that was shot. It can also be used to record the mode in which the image was
		shot. Note that this differs from the scene type (SceneType) tag.
	 * @author 
	 */
	public class SceneCaptureType extends BaseIFDEntry
	{
		///標準
		public static const STANDARD:uint 	= 0;
		///風景
		public static const LANDSCAPE:uint 	= 1;
		///肖像
		public static const PORTRAIT:uint 	= 2;
		///夜景
		public static const NIGHT_SCENE:uint = 3;
		
		private const _tagID:uint = 0xA406;
		private const _count:uint = 1;
			
		/**
		 * 場景拍攝類型
		 * @param	value ex:SceneCaptureType.STANDARD
		 */
		public function SceneCaptureType(value:uint=0) 
		{
			super(_tagID, TagDataDefine.N_SHORT,_count, [value]);
		}
		
	}

}