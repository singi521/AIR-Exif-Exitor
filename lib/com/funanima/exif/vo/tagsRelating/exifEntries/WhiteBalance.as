package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF 白平衡
	 * This tag indicates the white balance mode set when the image was shot.
	 * @author 
	 */
	public class WhiteBalance extends BaseIFDEntry
	{
		///自動
		public static const AUTO_WHITE_BALANCE:uint 	= 0;
		///手動
		public static const MANUAL_WHITE_BALANCE:uint 	= 1;
		
		private const _tagID:uint = 0xA403;
		private const _count:uint = 1;
			
		/**
		 * Exif 白平衡 
		 * @param	value ex: WhiteBalance.AUTO_WHITE_BALANCE
		 */
		public function WhiteBalance(value:uint) 
		{
			super(_tagID, TagDataDefine.N_SHORT,_count, [value]);
		}
		
	}

}