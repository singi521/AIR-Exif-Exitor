package  
{
	import com.funanima.exif.BaseEditEXIF;
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.exif.vo.tagsRelating.exifEntries.PixelXDimension;
	import com.funanima.exif.vo.tagsRelating.ifd0Entries.*;
	import flash.events.GeolocationEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import flash.utils.ByteArray;
	
	/**
	 * 修改既有照片的EXIF資訊
	 * @author 
	 */
	public class EditEXIFFromFile extends BaseEditEXIF
	{
		
		public function EditEXIFFromFile(srcFile:File,destFile:File) 
		{
			//讀取既有照片
			if (srcFile.exists == false) {
				throw new Error("來源檔案不存在!!");
			}
			
			var fileByte:ByteArray = new ByteArray();
			var fs:FileStream = new FileStream();
			fs.open(srcFile, FileMode.READ);
			fs.readBytes(fileByte, 0, fs.bytesAvailable);
			fs.close();
			
			
			init(fileByte);
			
			saveEditByteFile(super.newStream,destFile);
			
			destroy();
		}
		
		override protected function init(orgiStream:ByteArray):void 
		{
			super.init(orgiStream);
			
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
			
			//有BUG 所以一定要先寫 ExifIFDPointer
			var exifInfo:ExifIFDPointer = new ExifIFDPointer();
			exifInfo.setExifIFDAttribute(1024,768);
			entries.push(exifInfo);
			
			//寫入主IFD資訊
			var resolutionUnitEntries:ResolutionUnit = new ResolutionUnit(ResolutionUnit.INCHES);
			var XResolutionEntries:XResolution = new XResolution(72);
			var YResolutionEntries:YResolution = new YResolution(72);
			//var ddd:*  = orgExifInfo.ifds.primary.getEntryByTagName("Orientation").data;//測試把既有的資訊重新寫入
			var orientationEntries:Orientation = new Orientation(Orientation.TOP_LEFT);
			var softwareEntries:Software = new Software("your software name");
			entries.push(resolutionUnitEntries);
			entries.push(XResolutionEntries);
			entries.push(YResolutionEntries);
			entries.push(softwareEntries);
			entries.push(orientationEntries);
			
			
			//增加GPS資訊
			var gpsInfo:GPSIFDPointer = new GPSIFDPointer();
			var test:GeolocationEvent = new GeolocationEvent(GeolocationEvent.UPDATE);
			test.latitude = 25.8585;
			gpsInfo.setGPSAttribute(test);
			entries.push(gpsInfo);
			
			
			return entries;
		}
		
	}

}