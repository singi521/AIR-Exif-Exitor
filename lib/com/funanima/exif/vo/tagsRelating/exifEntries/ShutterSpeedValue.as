package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF TV快門速度
	 * Shutter speed. The unit is the APEX (Additive System of Photographic Exposure) setting (see Annex C).
	 * @author 
	 */
	public class ShutterSpeedValue extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0x9201;
		private const _count:uint = 1;
		
		/**
		 * TV快門速度
		 * @param	speed TV快門速度
		 */
		public function ShutterSpeedValue(speed:Number) 
		{
			super(_tagID, TagDataDefine.N_SRATIONAL,_count, [speed]);
		}
		
	}

}