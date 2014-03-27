package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF 等價35mm焦距
	 * This tag indicates the equivalent focal length assuming a 35mm film camera, in mm. A value of 0 means the focal
		length is unknown. Note that this tag differs from the FocalLength tag.
	 * @author 
	 */
	public class FocalLengthIn35mmFilm extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0xA405;
		private const _count:uint = 1;
			
		/**
		 * Exif 等價35mm焦距 
		 * @param	value
		 */
		public function FocalLengthIn35mmFilm(value:uint) 
		{
			super(_tagID, TagDataDefine.N_SHORT,_count, [value]);
		}
		
	}

}