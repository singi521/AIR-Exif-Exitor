package com.funanima.exif.vo.tagsRelating.ifd0Entries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * 軟體名稱
	 * @author 
	 */
	public class Software extends BaseIFDEntry
	{
		
		private const _tagID:uint = 0x0131;
		
		/**
		 * 軟體名稱
		 * @param	value 
		 */
		public function Software(value:String) 
		{
			var valueAry:Array = value.split("");
			
			super(_tagID, TagDataDefine.N_ASCII,valueAry.length, valueAry);
		}
		
	}

}