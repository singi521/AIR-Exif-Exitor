package com.funanima.utils 
{
	/**
	 * ...
	 * @author 
	 */
	public class MathUtil 
	{
		
		public function MathUtil() 
		{
			
		}
		
		/**
		 * 浮點數換分數(近似值)
		 * @param	value
		 * @return	[numerator,denominator]
		 */
		public static function approximateFraction(value:Number):Array {
			var EPSILON:Number = .0000001;

			var n:int = 1;  // numerator
			var d:int = 1;  // denominator
			var fraction:Number = n / d;

			while (Math.abs(fraction - value) > EPSILON)
			{
				if (fraction < value)
				{
					n++;
				}
				else
				{
					d++;
					n = int(Math.round(value * d));
				}

				fraction = n / Number(d);
			}
			
			return [n, d];
		}
	}

}