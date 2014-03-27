package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF 對焦範圍
	 * This tag indicates the location and area of the main subject in the overall scene.
	 * The subject location and area are defined by Count values as follows.
		Count = 2 Indicates the location of the main subject as coordinates. The first value is the X coordinate and the
		second is the Y coordinate.
		Count = 3 The area of the main subject is given as a circle. The circular area is expressed as center coordinates
		and diameter. The first value is the center X coordinate, the second is the center Y coordinate, and the
		third is the diameter. (See Figure 12.)
		Count = 4 The area of the main subject is given as a rectangle. The rectangular area is expressed as center
		coordinates and area dimensions. The first value is the center X coordinate, the second is the center Y
		coordinate, the third is the width of the area, and the fourth is the height of the area. (See Figure 13.)
	 * @author 
	 */
	public class SubjectArea extends BaseIFDEntry
	{

		private const _tagID:uint = 0x9214;
		private var _count:uint = 2;//2 3 or 4
		
		/**
		 * 對焦範圍 
		 * @param	value1
		 * @param	value2
		 * @param	value3
		 * @param	value4
		 */
		public function SubjectArea(value1:uint,value2:uint,value3:uint=null,value4:uint=null) 
		{
			
			var values:Array;
			if (value3 != null) {
				values = [value1,value2,value3];
			}else if (value4 != null) {
				values = [value1,value2,value3,value4];
			}else {
				values = [value1,value2];
			}
			
			_count = values.length;
			super(_tagID, TagDataDefine.N_SHORT,_count, values);
		}
		
	}

}