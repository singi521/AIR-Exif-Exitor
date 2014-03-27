package com.funanima.exif.vo.tagsRelating.ifd0Entries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * 水平或垂直拍攝
	 * @author 
	 */
	public class Orientation extends BaseIFDEntry
	{
		///1 = The 0th row is at the visual top of the image, and the 0th column is the visual left-hand side.
		public static const TOP_LEFT:uint = 1;
		
		///2 = The 0th row is at the visual top of the image, and the 0th column is the visual right-hand side.
		public static const TOP_RIGHT:uint = 2;
		
		///3 = The 0th row is at the visual bottom of the image, and the 0th column is the visual right-hand side.
		public static const BOTTOM_RIGHT:uint = 3;
		
		///4 = The 0th row is at the visual bottom of the image, and the 0th column is the visual left-hand side.
		public static const BOTTOM_LEFT:uint = 4;
		
		///5 = The 0th row is the visual left-hand side of the image, and the 0th column is the visual top.
		public static const LEFT_TOP:uint = 5;
		
		///6 = The 0th row is the visual right-hand side of the image, and the 0th column is the visual top.
		public static const RIGHT_TOP:uint = 6;
		
		///7 = The 0th row is the visual right-hand side of the image, and the 0th column is the visual bottom.
		public static const RIGHT_BOTTOM:uint = 7;
		
		///8 = The 0th row is the visual left-hand side of the image, and the 0th column is the visual bottom.
		public static const LEFT_BOTTOM:uint = 8;
		
		
		private const _tagID:uint = 0x0112;
		private const _count:uint = 1;
		
		
		/**
		 * 水平或垂直拍攝
		 * @param	value Orientation.TOP_LEFT
		 */
		public function Orientation(value:uint) 
		{
			super(_tagID, TagDataDefine.N_SHORT , _count , [value]);
		}
		
	}

}