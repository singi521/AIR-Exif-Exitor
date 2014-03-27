package com.funanima.exif.vo.tagsRelating.ifd0Entries 
{
	import com.funanima.exif.BaseIFDEntry;
	import com.funanima.utils.WGS84;
	import com.funanima.exif.vo.TagDataDefine;
	import com.funanima.exif.vo.tagsRelating.gpsEntries.*;
	import flash.events.GeolocationEvent;
	/**
	 * GPS 資訊都在這
	 * @author 
	 */
	public class GPSIFDPointer extends BaseIFDPointer
	{
		
		private const _tagID:uint = 0x8825;
		private const _count:uint = 1;
		private const _tagValueType:String = TagDataDefine.N_LONG;
		
		/**
		 * IFD內容
		 * @param	value 
		 */
		public function GPSIFDPointer() 
		{
			_IFDEntries = new Vector.<BaseIFDEntry>();
			
			super(_tagID, _tagValueType,_count);
		}
		
		
		
		/**
		 * 設定GPS座標等GPS資訊
		 * @param	geoEvent	flash 內建的Event，裡面會有座標資訊
		 *	latitude	南北緯度 -90~90
		 * 	longitude	東西經度 -180~180	
		 */
		public function setGPSAttribute(geoEvent:GeolocationEvent):void 
		{
			_IFDEntries = new Vector.<BaseIFDEntry>();
			
			var versionEntry:GPSVersionID = new GPSVersionID(2, 2, 0, 0);
			_IFDEntries.push(versionEntry);
			
			//TEST
			//成州國小 25.099593,121.450585 >> 121d27'02.11", 25d05'58.53"
			//121.450583_N_25.099592_E_
			//var converLatitude:Array = WGS84.converDMS(25.099593);
			//var converLongitude:Array = WGS84.converDMS(121.450585);
			
			///轉換座標
			var latitude:Number = geoEvent.latitude;
			var longitude:Number = geoEvent.longitude;
			var converLatitude:Array = WGS84.converDMS(latitude);
			var converLongitude:Array = WGS84.converDMS(longitude);
			
			//南北緯度
			if(latitude>0){
				var latitudeRefEntry:GPSLatitudeRef = new GPSLatitudeRef(latitude>0?GPSLatitudeRef.NORTH:GPSLatitudeRef.SOUTH);
				var latitudeEntry:GPSLatitude = new GPSLatitude(converLatitude[0],converLatitude[1],converLatitude[2]);
				_IFDEntries.push(latitudeRefEntry);
				_IFDEntries.push(latitudeEntry);
			}
			
			//東西經度
			if(longitude>0){
				var longitudeRefEntry:GPSLongitudeRef = new GPSLongitudeRef(longitude>0?GPSLongitudeRef.EAST:GPSLongitudeRef.WEST);
				var longitudeEntry:GPSLongitude = new GPSLongitude(converLongitude[0], converLongitude[1], converLongitude[2]);
				_IFDEntries.push(longitudeRefEntry);
				_IFDEntries.push(longitudeEntry);
			}
			
			
			//高度
			if(geoEvent.altitude>0){
				var altitudeRefEntry:GPSAltitudeRef = new GPSAltitudeRef(geoEvent.altitude>=0?GPSAltitudeRef.ABOVE_SEA_LEVEL:GPSAltitudeRef.BELOW_SEA_LEVEL);
				var altitudeEntry:GPSAltitude = new GPSAltitude(geoEvent.altitude);
				_IFDEntries.push(altitudeRefEntry);
				_IFDEntries.push(altitudeEntry);
			}
			
			
			//速度 (flash 速度單位為 公尺/秒 要換算成 公里/小時)
			if(geoEvent.speed>0){
				var gpsSpeedRefEntry:GPSSpeedRef = new GPSSpeedRef(GPSSpeedRef.KILOMETERS_PER_HOUR);
				var gpsSpeedEntry:GPSSpeed = new GPSSpeed((geoEvent.speed * 3600) / 1000);
				_IFDEntries.push(gpsSpeedRefEntry);
				_IFDEntries.push(gpsSpeedEntry);
				trace("GPS 移動速度:" + geoEvent.speed);
			}
			
			//時間戳
			if(geoEvent.timestamp>0){
				var gpsDate:Date = new Date(new Date().getTime()- geoEvent.timestamp);
				var gpsStampEntry:GPSTimeStamp = new GPSTimeStamp(gpsDate.hours,gpsDate.minutes,Number(gpsDate.seconds+"."+gpsDate.milliseconds));
				_IFDEntries.push(gpsStampEntry);
			}
			
		}
		
		
	}

}