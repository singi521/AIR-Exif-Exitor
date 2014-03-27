package com.funanima.exif.vo.tagsRelating.ifd0Entries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * X分辨率
	 * @author 
	 */
	public class XResolution extends BaseIFDEntry
	{
		
		
		
		private const _tagID:uint = 0x011a;
		private const _count:uint = 1;
		
		/**
		 * X分辨率
		 * @param	value 一般看到都是72
		 */
		public function XResolution(value:Number) 
		{
			super(_tagID, TagDataDefine.N_RATIONAL,_count, [value]);
		}
		
	}

}