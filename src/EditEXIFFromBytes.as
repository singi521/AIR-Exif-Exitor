package  
{
	import com.funanima.exif.BaseEditEXIF;
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.tagsRelating.ifd0Entries.*;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import flash.utils.ByteArray;
	
	/**
	 * 修改既有照片的EXIF資訊
	 * @author 
	 */
	public class EditEXIFFromBytes extends BaseEditEXIF
	{
		private var _gpsInfo:GPSIFDPointer;
		private var _exifInfo:ExifIFDPointer;
		
		public function EditEXIFFromBytes() 
		{
			
			
		}
		
		/**
		 * 修改照片EXIF資訊
		 * @param	srcBytes	原始照片的EXIF資訊
		 * @param	destFile	若有目的地則會直接存
		 */
		public function startEditProcess(srcBytes:ByteArray,destFile:File=null):void {
			
			super.init(srcBytes);
			
			if(destFile){
				saveEditByteFile(super.newStream,destFile);
			}
		}
		
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
		/**
		 * 儲存已經修改好的資訊
		 * @param	iNewStream	完整且修改過的位元組
		 * @param	destFile	目標位置
		 */
		private function saveEditByteFile(iNewStream:ByteArray, destFile:File):void 
		{
			if (iNewStream.length == 0) return;
			
			var newDestFile:File = new File(destFile.nativePath);
			var fs2:FileStream = new FileStream();
			fs2.open(newDestFile, FileMode.WRITE);
			fs2.writeBytes(iNewStream, 0, iNewStream.length);
			fs2.close();
		}
		
		override protected function getNewIFDContent():Vector.<BaseIFDEntry> 
		{
			var entries:Vector.<BaseIFDEntry> = new Vector.<BaseIFDEntry>();
			
			///一定要先寫 因為....有BUG
			if(_exifInfo != null && _exifInfo.IFDEntries.length>0){
				//增加EXIF資訊
				entries.push(_exifInfo);
			}
			
			var resolutionUnitEntries:ResolutionUnit = new ResolutionUnit(ResolutionUnit.INCHES);
			var XResolutionEntries:XResolution = new XResolution(72);
			var YResolutionEntries:YResolution = new YResolution(72);
			//var ddd:*  = orgExifInfo.ifds.primary.getEntryByTagName("Orientation").data;//測試把既有的資訊重新寫入
			var orientationEntries:Orientation = new Orientation(Orientation.TOP_LEFT);
			var softwareEntries:Software = new Software("Yourr Software name");
			
			
			entries.push(resolutionUnitEntries);
			entries.push(XResolutionEntries);
			entries.push(YResolutionEntries);
			entries.push(softwareEntries);
			entries.push(orientationEntries);
			
			
			if(gpsInfo != null && gpsInfo.IFDEntries.length>0){
				//增加GPS資訊
				entries.push(gpsInfo);
			}
			
			return entries;
		}
		
		
		public function get gpsInfo():GPSIFDPointer 
		{
			if (_gpsInfo == null) {
				_gpsInfo = new GPSIFDPointer();
			}
			return _gpsInfo;
		}
		
		public function set gpsInfo(value:GPSIFDPointer):void 
		{
			_gpsInfo = value;
		}
		
		public function get exifInfo():ExifIFDPointer 
		{
			if (_exifInfo == null) {
				_exifInfo = new ExifIFDPointer();
			}
			return _exifInfo;
		}
		
		public function set exifInfo(value:ExifIFDPointer):void 
		{
			_exifInfo = value;
		}
		
	}

}