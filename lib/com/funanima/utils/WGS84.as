package com.funanima.utils 
{
	/**
	 * ...
	 * @author 
	 */
	public class WGS84
	{
		
		public function WGS84() 
		{
			
		}
		
		
		/**
		 * 轉為度分秒表示
		 * @param	data
		 * @return
		 */
		public static function converDMS(data:Number):Array {
			//data = 117.59709; //117°35′49.52″
			//0.59709° == 0.59709 * 60 = 35.8254′，0.8254′ = 0.8254 * 60 = 49.52″
			//度
			
			var spp:Array = String(data).split(".");
			//把"度分" 分離
			var degrees:uint = spp[0];//=117 ,spp[1]=0.59709
			
			//把 59709 變成 0.59709
			var desp:Number = Math.ceil((data - spp[0]) / 0.00001 )* .00001;
			
			//算出分
			var data2:Number = desp * 60;
			//把"分秒"分離 data2 = 35.8254
			var spp2:Array = String(data2).split(".");
			
			//取得分 35
			var minutes:uint 	= spp2[0];
			
			//把 spp2[1] = "8254" 變成 0.8254
			var desp2:Number = minutes - spp2[0];
			
			var ddesre:Number =  Math.floor((data2 - spp2[0]) / 0.00001 ) * .00001;
			
			//算出秒
			var seconds:Number 	= ddesre * 60;
			
			
			var DMSArray:Array = new Array(3);
				DMSArray[0] = degrees;
				DMSArray[1] = minutes;
				DMSArray[2] = seconds;
			
			var haha:Number = converToNumber(DMSArray);
			return DMSArray;
		}
		
		/**
		 * WGS84座標轉換為數字表示
		 * @param	data
		 * @return
		 */
		public static function converToNumber(data:Array):Number {
			var result:Number = (data[0] + data[1] / 60 + data[2] / 3600);
			return (Math.round(result/0.000001)*0.000001);
		}
		
		/**
		 * WGS84座標轉換為 度分表示 這個有問題
		 * @param	data
		 * @return
		 */
		public static function converToFormat(data:Number):Vector.<Number> {
			var lat3:Number = 0;
			var lat2:Number = data % 1;
			var lat1:Number = data - lat2;
			
			lat2 *= 60;
			lat2 = lat2 + lat3 * 3600;
			
			var latArray:Vector.<Number> = new Vector.<Number>(3);
				latArray[0] = (lat1);
				latArray[1] = (Math.round(lat2/0.000001)*0.000001);
				latArray[2] = (lat3);
			
			return latArray;
		}
		
		
		
	}

}