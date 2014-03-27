package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF Exif 圖片高
	 * Information specific to compressed data. When a compressed file is recorded, the valid height of the meaningful
		image shall be recorded in this tag, whether or not there is padding data or a restart marker. This tag should not
		exist in an uncompressed file. For details see section 2.8.1 and Annex F. Since data padding is unnecessary in the
		vertical direction, the number of lines recorded in this valid image height tag will in fact be the same as that
		recorded in the SOF.
	 * @author 
	 */
	public class PixelYDimension extends BaseIFDEntry
	{

		private const _tagID:uint = 0xA003;
		private const _count:uint = 1;
		
		/**
		 * Exif 圖片高 
		 * @param	value
		 */
		public function PixelYDimension(value:uint) 
		{
			//也可以是 LONG
			super(_tagID, TagDataDefine.N_SHORT,_count, [value]);
		}
		
	}

}