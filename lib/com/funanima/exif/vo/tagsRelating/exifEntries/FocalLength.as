package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF 焦距
	 * The actual focal length of the lens, in mm. Conversion is not made to the focal length of a 35 mm film camera.
	 * @author 
	 */
	public class FocalLength extends BaseIFDEntry
	{

		private const _tagID:uint = 0x920A;
		private const _count:uint = 1;
		
		/**
		 * 焦距
		 * @param	focal 單位:mm
		 */
		public function FocalLength(focal:Number=0) 
		{
			super(_tagID, TagDataDefine.N_RATIONAL,_count, [focal]);
		}
		
	}

}