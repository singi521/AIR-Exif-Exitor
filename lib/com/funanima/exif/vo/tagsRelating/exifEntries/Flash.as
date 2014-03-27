package com.funanima.exif.vo.tagsRelating.exifEntries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.TagDataDefine;
	/**
	 * EXIF 閃光
	 * This tag indicates the status of flash when the image was shot. Bit 0 indicates the flash firing status, bits 1 and 2
	 * indicate the flash return status, bits 3 and 4 indicate the flash mode, bit 5 indicates whether the flash function is
	 * present, and bit 6 indicates "red eye" mode (see Figure 11).
	 * @author 
	 */
	public class Flash extends BaseIFDEntry
	{
		///關閉 Flash did not fire.
		public static const CLOSE:uint 			= 0x0000;
		
		///打開 0001.H = Flash fired.
		public static const OPEN:uint 			= 0x0001;
		
		///頻閃光線未檢測到。 0005.H = Strobe return light not detected.
		public static const SRLND:uint 			= 0x0005;
		
		///頻閃光線已檢測到。0007.H = Strobe return light detected.
		public static const SRLYD:uint 			= 0x0007;
		
		///打開(強制)0009.H = Flash fired, compulsory flash mode
		public static const OPEN_C:uint 		= 0x0009;
		
		///打開(強制/不探測返回光線)000D.H = Flash fired, compulsory flash mode, return light not detected
		public static const OPEN_CLND:uint 		= 0x000D;
		
		///打開(強制/探測返回光線)000F.H = Flash fired, compulsory flash mode, return light detected
		public static const OPEN_CLYD:uint 		= 0x000F;
		
		///關閉(強制)0010.H = Flash did not fire, compulsory flash mode
		public static const CLOSE_C:uint 		= 0x0010;
		
		///關閉(自動)0018.H = Flash did not fire, auto mode
		public static const CLOSE_AUTO:uint 	= 0x0018;
		
		///打開(自動)0019.H = Flash fired, auto mode
		public static const OPEN_AUTO:uint 		= 0x0019;
		
		///打開(自動/不探測返回光線)001D.H = Flash fired, auto mode, return light not detected
		public static const OPEN_ALND:uint 		= 0x001D;
		
		///打開(自動/探測返回光線)001F.H = Flash fired, auto mode, return light detected
		public static const OPEN_ALYD:uint 		= 0x001F;
		
		///無閃光功能 0020.H = No flash function
		public static const NO_FLASH:uint 		= 0x0020;
		
		///打開(防紅眼)0041.H = Flash fired, red-eye reduction mode
		public static const OPEN_RED_EYE:uint 	= 0x0041;
		
		///打開(防紅眼/不探測返回光線)0045.H = Flash fired, red-eye reduction mode, return light not detected
		public static const OPEN_RED_EYE_LND:uint 	= 0x0045;
		
		///打開(防紅眼/探測返回光線)0047.H = Flash fired, red-eye reduction mode, return light detected
		public static const OPEN_RED_EYE_LYD:uint 	= 0x0047;
		
		///打開(強制/防紅眼)0049.H = Flash fired, compulsory flash mode, red-eye reduction mode
		public static const OPEN_CRED_EYE:uint 		= 0x0049;
		
		///打開(強制/防紅眼/不探測返回光線)004D.H = Flash fired, compulsory flash mode, red-eye reduction mode, return light not detected
		public static const OPEN_CRED_EYE_LND:uint 	= 0x004D;
		
		///打開(強制/防紅眼/探測返回光線)004F.H = Flash fired, compulsory flash mode, red-eye reduction mode, return light detected
		public static const OPEN_CRED_EYE_LYD:uint 	= 0x004F;
		
		///打開(自動/防紅眼)0059.H = Flash fired, auto mode, red-eye reduction mode
		public static const OPEN_AUTO_RED_EYE:uint 	= 0x0059;
		
		///打開(自動/防紅眼/不探測返回光線)005D.H = Flash fired, auto mode, return light not detected, red-eye reduction mode
		public static const OPEN_AUTO_RED_EYE_LND:uint 	= 0x005D;
		
		///打開(自動/防紅眼/探測返回光線)005F.H = Flash fired, auto mode, return light detected, red - eye reduction mode
		public static const OPEN_AUTO_RED_EYE_LYD:uint 	= 0x005F;
		

		private const _tagID:uint = 0x9209;
		private const _count:uint = 1;
		
		/**
		 * 測光模式
		 * @param	value 測光模式 ex: Flash.OPEN_AUTO_RED_EYE_LYD
		 */
		public function Flash(mode:uint=0) 
		{
			super(_tagID, TagDataDefine.N_SHORT,_count, [mode]);
		}
		
	}

}