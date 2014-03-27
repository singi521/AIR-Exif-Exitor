package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF 光圈
	 * The F number.
	 * @author 
	 */
	public class FNumber extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0x829D;
		private const _count:uint = 1;
		
		/**
		 * 光圈
		 * @param	fnumber
		 */
		public function FNumber(fnumber:Number) 
		{
			super(_tagID, TagDataDefine.N_RATIONAL,_count, [fnumber]);
		}
		
	}

}