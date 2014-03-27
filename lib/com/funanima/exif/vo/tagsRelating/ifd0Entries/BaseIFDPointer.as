package com.funanima.exif.vo.tagsRelating.ifd0Entries 
{
	import com.funanima.exif.BaseIFDEntry;
	/**
	 * ...
	 * @author 
	 */
	public class BaseIFDPointer extends BaseIFDEntry
	{
		
		protected var _IFDEntries:Vector.<BaseIFDEntry>;
		
		public function BaseIFDPointer(iTagID:uint,iValueType:String,iCount:uint) 
		{
			_IFDEntries = new Vector.<BaseIFDEntry>();
			super(iTagID, iValueType,iCount, [null]);
		}
		
		
		public function get IFDEntries():Vector.<BaseIFDEntry> 
		{
			return _IFDEntries;
		}
	}

}