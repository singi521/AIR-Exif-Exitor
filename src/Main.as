package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.GeolocationEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	/**
	 * 目前只能使用已經有EXIF資料來進行修改
	 * @author 
	 */
	public class Main extends Sprite 
	{
		//need import has exif data image
		[Embed(source = "../Assets/TEST_IMAGE.JPG",mimeType="application/octet-stream")]
		private var _testImage:Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//test image
			var testImageBytes:ByteArray = new _testImage();
			
			
			
			var newPicExif:EditEXIFFromBytes = new EditEXIFFromBytes();
			
			//edit gps info in Exif Tag
				//make gps fake infomation(taipei 101)
				var fakeGeo:GeolocationEvent = new GeolocationEvent(GeolocationEvent.UPDATE, false, false, 25.033496, 121.563863);
				newPicExif.gpsInfo.setGPSAttribute(fakeGeo);
				
			//edit width height in Exif Tag
				newPicExif.exifInfo.setExifIFDAttribute(800, 600);
			
			//start process
				newPicExif.startEditProcess(testImageBytes);
				
				
			//new image bytes
			var newImageBytes:ByteArray = newPicExif.newStream;
			
			//save new image in folder.
			var file:File = new File(File.applicationDirectory.nativePath +"/newTest.jpg");
			var fs2:FileStream = new FileStream();
			fs2.open(file, FileMode.WRITE);
			fs2.writeBytes(newImageBytes, 0, newImageBytes.length);
			fs2.close();
			
		}
		
	}
	
}