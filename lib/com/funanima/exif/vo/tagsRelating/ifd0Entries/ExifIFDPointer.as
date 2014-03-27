package com.funanima.exif.vo.tagsRelating.ifd0Entries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.tagsRelating.exifEntries.*;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF 圖片資訊
	 * 例如白平衡、ISO 等鏡頭資訊
	 * @author 
	 */
	public class ExifIFDPointer extends BaseIFDPointer
	{
		
		private const _tagID:uint = 0x8769;
		private const _count:uint = 1;
		private const _tagValueType:String = TagDataDefine.N_LONG;
		
		
		/**
		 * Exif IFD內容
		 * @param	value 
		 */
		public function ExifIFDPointer() 
		{
			super(_tagID, _tagValueType, _count);
		}
		
		public function setExifIFDAttribute(imgWidth:Number,imgHeight:Number):void 
		{
			_IFDEntries = new Vector.<BaseIFDEntry>();
			
			var pixelXDimensionEntry:PixelXDimension = new PixelXDimension(imgWidth);
			_IFDEntries.push(pixelXDimensionEntry);
			
			var pixelYDimensionEntry:PixelYDimension = new PixelYDimension(imgHeight);
			_IFDEntries.push(pixelYDimensionEntry);
		}
		
	}

}