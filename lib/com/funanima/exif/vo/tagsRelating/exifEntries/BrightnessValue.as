package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF BV亮度值
	 * The value of brightness. The unit is the APEX value. Ordinarily it is given in the range of -99.99 to 99.99. Note that
	 * if the numerator of the recorded value is FFFFFFFF.H, Unknown shall be indicated.
	 * @author 
	 */
	public class BrightnessValue extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0x9203;
		private const _count:uint = 1;
		
		/**
		 * BV亮度值
		 * @param	value BV亮度值
		 */
		public function BrightnessValue(value:Number) 
		{
			super(_tagID, TagDataDefine.N_SRATIONAL,_count, [value]);
		}
		
	}

}