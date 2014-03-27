package com.funanima.exif.vo.tagsRelating.ifd0Entries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * X分辨率
	 * @author 
	 */
	public class YResolution extends BaseIFDEntry
	{
		
		
		
		private const _tagID:uint = 0x011b;
		private const _count:uint = 1;
		
		/**
		 * Y分辨率
		 * @param	value 一般看到都是72
		 */
		public function YResolution(value:Number) 
		{
			super(_tagID, TagDataDefine.N_RATIONAL,_count, [value]);
		}
		
	}

}