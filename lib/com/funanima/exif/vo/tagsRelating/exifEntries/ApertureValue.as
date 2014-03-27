package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF AV光圈值
	 * The lens aperture. The unit is the APEX value.
	 * @author 
	 */
	public class ApertureValue extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0x9202;
		private const _count:uint = 1;
		
		/**
		 * AV光圈值
		 * @param	value AV光圈值
		 */
		public function ApertureValue(value:Number) 
		{
			super(_tagID, TagDataDefine.N_RATIONAL,_count, [value]);
		}
		
	}

}