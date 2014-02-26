package
{
	/**
	 * gps纠偏算法，适用于google,高德体系的地图
	 * @author Administrator
	 */
	public class GpsCorrect {
		private static var  pi:Number = 3.14159265358979324;
		private static var  a:Number = 6378245.0;
		private static var  ee:Number = 0.00669342162296594323;
		
		public static function transform(wgLat:Number, wgLon:Number, latlng:Array):void {
			if (outOfChina(wgLat, wgLon)) {
				latlng[0] = wgLat;
				latlng[1] = wgLon;
				return;
			}
			var dLat:Number = transformLat(wgLon - 105.0, wgLat - 35.0);
			var dLon:Number = transformLon(wgLon - 105.0, wgLat - 35.0);
			var radLat:Number = wgLat / 180.0 * pi;
			var  magic:Number = Math.sin(radLat);
			magic = 1 - ee * magic * magic;
			var  sqrtMagic:Number = Math.sqrt(magic);
			dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
			dLon = (dLon * 180.0) / (a / sqrtMagic * Math.cos(radLat) * pi);
			latlng[0] = wgLat + dLat;
			latlng[1] = wgLon + dLon;
		}
		
		private static  function  outOfChina(lat:Number, lon:Number):Boolean {
			if (lon < 72.004 || lon > 137.8347)
				return true;
			if (lat < 0.8293 || lat > 55.8271)
				return true;
			return false;
		}
		
		private static function transformLat(x:Number, y:Number):Number {
			var ret:Number = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * Math.sqrt(Math.abs(x));
			ret += (20.0 * Math.sin(6.0 * x * pi) + 20.0 * Math.sin(2.0 * x * pi)) * 2.0 / 3.0;
			ret += (20.0 * Math.sin(y * pi) + 40.0 * Math.sin(y / 3.0 * pi)) * 2.0 / 3.0;
			ret += (160.0 * Math.sin(y / 12.0 * pi) + 320 * Math.sin(y * pi / 30.0)) * 2.0 / 3.0;
			return ret;
		}
		
		private static function transformLon(x:Number, y:Number):Number {
			var ret:Number = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * Math.sqrt(Math.abs(x));
			ret += (20.0 * Math.sin(6.0 * x * pi) + 20.0 * Math.sin(2.0 * x * pi)) * 2.0 / 3.0;
			ret += (20.0 * Math.sin(x * pi) + 40.0 * Math.sin(x / 3.0 * pi)) * 2.0 / 3.0;
			ret += (150.0 * Math.sin(x / 12.0 * pi) + 300.0 * Math.sin(x / 30.0 * pi)) * 2.0 / 3.0;
			return ret;
		}
	}

}


