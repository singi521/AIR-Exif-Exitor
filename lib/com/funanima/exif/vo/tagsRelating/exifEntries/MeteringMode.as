package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF 測光模式
	 * The metering mode.
	 * @author 
	 */
	public class BrightnessValue extends BaseIFDEntry
	{
		///未知
		public static const UNKNOWN:uint 					= 0;
		///平均
		public static const AVERAGE:uint 					= 1;
		///中央重電平均測光
		public static const CENTER_WEIGHTE_DAVERAGE:uint 	= 2;
		///點側
		public static const SPOT:uint 						= 3;
		///分區
		public static const MULTISPOT:uint 					= 4;
		///評估
		public static const PATTERN:uint 					= 5;
		///局部
		public static const PARTIAL:uint 					= 6;
		///其他
		public static const OTHER:uint 						= 255;

		private const _tagID:uint = 0x9207;
		private const _count:uint = 1;
		
		/**
		 * 測光模式
		 * @param	value 測光模式 ex: BrightnessValue.AVERAGE
		 */
		public function BrightnessValue(mode:uint=0) 
		{
			super(_tagID, TagDataDefine.N_SHORT,_count, [mode]);
		}
		
	}

}