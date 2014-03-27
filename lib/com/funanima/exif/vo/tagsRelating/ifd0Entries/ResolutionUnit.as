package com.funanima.exif.vo.tagsRelating.ifd0Entries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * 分辨率的單位
	 * 	The unit for measuring XResolution and YResolution. The same unit is used for both XResolution and YResolution.
		If the image resolution in unknown, 2 (inches) is designated.
	 * @author 
	 */
	public class ResolutionUnit extends BaseIFDEntry
	{
		///英吋
		public static const INCHES:uint = 2;
		///釐米
		public static const CENTIMETERS:uint = 3;
		
		private const _tagID:uint = 0x0128;
		private const _count:uint = 1;
		
		/**
		 * 水平或垂直拍攝
		 * @param	value Orientation.TOP_LEFT
		 */
		public function ResolutionUnit(value:uint=2) 
		{
			
			super(_tagID, TagDataDefine.N_SHORT,_count, [value]);
		}
		
	}

}