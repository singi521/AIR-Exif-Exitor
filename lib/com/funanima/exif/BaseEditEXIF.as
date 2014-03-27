package com.funanima.exif
{
	import com.funanima.exif.read.shichiseki.ExifInfo;
	import com.funanima.exif.read.shichiseki.IFD;
	
	import com.funanima.exif.vo.TagDataDefine;
	import com.funanima.exif.vo.tagsRelating.ifd0Entries.GPSIFDPointer;
	import com.funanima.exif.vo.tagsRelating.ifd0Entries.Orientation;
	import com.funanima.exif.vo.tagsRelating.ifd0Entries.ResolutionUnit;
	import com.funanima.exif.vo.tagsRelating.ifd0Entries.Software;
	import com.funanima.exif.vo.tagsRelating.ifd0Entries.XResolution;
	import com.funanima.exif.vo.tagsRelating.ifd0Entries.YResolution;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	/**
	 * ...
	 * @author 
	 */
	public class BaseEditEXIF 
	{
		private var _orgStream:ByteArray;
		
		private var _newStream:ByteArray;
		
		///若原檔案內沒有此tag 則需要增加IFDEntry的數量
		private var _orgExifInfo:ExifInfo;
		private var _newEntries:Vector.<BaseIFDEntry>;
		
		
		public function BaseEditEXIF() 
		{
			
		}
		
		/**
		 * 修改原始照片的EXIF 初始並修改
		 * @param	orgiStream	原始照片的位元組
		 * @param	entries		要新增的內容	若為null 則必須有支CLASS繼承這支並附寫 getNewIFDContent函式。
		 */
		protected function init(orgiStream:ByteArray):void {
			
			
			orgiStream.position = 0;
			_orgStream = orgiStream;
			
			_orgExifInfo = new ExifInfo(_orgStream);
			
			///含照片與修改後EXIF的的全新位元組
			_newStream = new ByteArray();
			
			var isCleanComplete:Boolean = cleanExif(); //清除EXIF所有資料
			
			addIFD(getNewIFDContent());//新增IFD0的TAG
		}
		
		
		protected function getNewIFDContent():Vector.<BaseIFDEntry> {
			
			throw new Error("需要複寫此函式!範例在下面");
			/*
			var resolutionUnitEntries:ResolutionUnit = new ResolutionUnit(ResolutionUnit.INCHES);
			var XResolutionEntries:XResolution = new XResolution(72);
			var YResolutionEntries:YResolution = new YResolution(72);
			//var ddd:*  = orgExifInfo.ifds.primary.getEntryByTagName("Orientation").data;//測試把既有的資訊重新寫入
			var orientationEntries:Orientation = new Orientation(Orientation.TOP_LEFT);
			var softwareEntries:Software = new Software("your software name");
			var gpsInfo:GPSInfo = new GPSInfo();
			
			
			var entries:Vector.<BaseIFDEntry> = new Vector.<BaseIFDEntry>();
			
			entries.push(resolutionUnitEntries);
			entries.push(XResolutionEntries);
			entries.push(YResolutionEntries);
			entries.push(softwareEntries);
			entries.push(orientationEntries);
			
			//增加GPS資訊
			entries.push(gpsInfo);
			
			return entries;*/
		}
		
		/**
		 * 新增IFD內容在這裡
		 */
		private function addIFD(newEntries:Vector.<BaseIFDEntry>):void 
		{
			
			var newPrimaryIFD:IFDGroup = new IFDGroup();
			newPrimaryIFD.writeIFD(newEntries, _newStream.endian, newEntries.length, true);
			
			_newStream = insertBytes(_newStream, newPrimaryIFD.stram, _newStream.position);
			
			var exifFlagBytes:uint = 6;//e x i f 0 0
			_newStream.position = _orgExifInfo.app1DataSizePos;
			var newApp1DataSize:uint = exifFlagBytes + 8 + newPrimaryIFD.offsetValueAccumulate + _orgExifInfo.APP1_MAKER.length;
			_newStream.writeShort(newApp1DataSize); //修改app1的SIZE
		}
		
		/**
		 * 清除照片原本有的EXIF資訊
		 * @return
		 */
		private function cleanExif():Boolean 
		{
			//_newStream = new ByteArray();
			var imageStartPos:uint;
			
			//for (var i:uint = 0; i < _orgStream.length; i++) {
			
			//抓取app1size 之後的圖片起始 ff db
			var app1Size:uint = _orgExifInfo.app1DataSize;
			for (var i:uint = app1Size; i < app1Size+500; i++) {
				if (_orgStream[i].toString(16) == "ff") {
					if (_orgStream[i + 1].toString(16) == "db") {
						//trace("抓到位置 readByte [" + i + "]"); //通通清掉通通清掉通通清掉通通清掉通通清掉通通清掉
						imageStartPos = i;
						break;
					}
				}
			}
			
			if (imageStartPos == 0) {
				trace("抓不到圖片位置 無法清除EXIF資訊");
				return false;//抓不到圖片位置
			}
			
			var exifFlagBytes:uint = 6;//e x i f 0 0
			var headEndPos:uint = _orgExifInfo.tiffHeader.position + 8;
			
			_newStream.writeBytes(_orgStream, 0, headEndPos);
			_newStream.writeBytes(_orgStream, imageStartPos, _orgStream.length - imageStartPos);//Next IFD
			
			_newStream.position = _orgExifInfo.app1DataSizePos;
			
			//8: tiffsize 2: count 4: next ifd flag
			_newStream.writeShort(exifFlagBytes + 8 + 2 + 4 + _orgExifInfo.APP1_MAKER.length);
			
			_newStream.position = headEndPos;
			
			return true;
		}
		
		
		/**
		 * 插入位元組
		 * @param	srcBa
		 * @param	insertBa
		 * @param	srcPos
		 * @return
		 */
		private function insertBytes(srcBa:ByteArray,insertBa:ByteArray,srcPos:uint):ByteArray {
			var margeBa:ByteArray = new ByteArray();
			margeBa.endian = srcBa.endian;
			if(srcPos!=0){
				if (srcPos > srcBa.length) {
					trace("警告 : 要插入的位置超過原始資料的長度!!預設幫你插入到最後面!!");
					srcPos = srcBa.length;
				}
				margeBa.writeBytes(srcBa, 0, srcPos);
			}
			
			margeBa.writeBytes(insertBa, 0, insertBa.length);
			var insertEndPos:uint = margeBa.position;
			margeBa.writeBytes(srcBa, srcPos, srcBa.length - srcPos);
			margeBa.position = insertEndPos;
			return margeBa;
		}
		
		///原始照片位元組
		public function get orgStream():ByteArray 
		{
			return _orgStream;
		}
		
		/**
		 * 取得修改後完整全新的位元組
		 */
		public function get newStream():ByteArray 
		{
			return _newStream;
		}
		
		public function destroy():void {
			_orgExifInfo = null;
			
			_orgStream.clear();
			_orgStream = null;
			
			_newStream.clear();
			_newStream = null;
			
		}
		
	}

}