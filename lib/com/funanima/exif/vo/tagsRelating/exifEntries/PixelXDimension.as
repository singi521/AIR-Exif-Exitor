package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF Exif 圖片寬
	 * Information specific to compressed data. When a compressed file is recorded, the valid width of the meaningful
		image shall be recorded in this tag, whether or not there is padding data or a restart marker. This tag should not
		exist in an uncompressed file. For details see section 2.8.1 and Annex F.
	 * @author 
	 */
	public class PixelXDimension extends BaseIFDEntry
	{

		private const _tagID:uint = 0xA002;
		private const _count:uint = 1;
		
		/**
		 * Exif 圖片寬 
		 * @param	value
		 */
		public function PixelXDimension(value:uint) 
		{
			//也可以是 LONG
			super(_tagID, TagDataDefine.N_SHORT,_count, [value]);
		}
		
	}

}