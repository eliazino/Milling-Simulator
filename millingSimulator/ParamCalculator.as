package 
{

	public class ParamCalculator
	{
		public var pii:Number = 3.142;
		public function ParamCalculator()
		{
			// constructor code
		}

		public function cuttingSpeed(diam:Number, sspeed:Number):Number
		{
			var cutting_speed:Number = pii * diam * sspeed;
			return cutting_speed;
		}
		public function radialDephtOfCut(thetaX:Number, diam:Number):Number
		{
			var tang:Number = (Math.cos(thetaX)*diam)/2;
			return tang;
		}
		public function feedPerTeeth(vf:Number, T:Number, N:Number):Number
		{
			var fpt:Number = vf / (T * N);
			return fpt;
		}
		public function maxUncutChipThickness(af:Number, ae:Number, D:Number):Number
		{
			var amax:Number = 2*af*(Math.sqrt(ae/D));
			return amax;
		}
		public function averageChipThickness(af:Number, ae:Number, D:Number):Number
		{
			var aavrg:Number = af*(Math.sqrt(ae/D));
			return aavrg;
		}
		public function lengthOfChipCut(ae:Number, D:Number):Number
		{
			var leN:Number = Math.sqrt(ae*D);
			return leN;
		}
		public function materialRemovalRate(ae:Number, ap:Number, vf:Number):Number
		{
			var ze:Number = ae * ap * vf;
			return ze;
		}
		public function millingTime(lw:Number, leN:Number, vf:Number):Number
		{
			var tm:Number = (lw + leN) / vf;
			return tm;
		}
		public function specificForce(materialIndex:int, remIndex:int):Number
		{
			var sF:Array = new Array();
			sF[0] = [2200,1950,1820,1700,1520];
			// Number 2
			sF[1] = [1980,1800,1720,1600,1570];
			//Number 3
			sF[2] = [2520,2200,2040,1850,1740];
			//Number 4
			sF[3] = [1980,1800,1730,1700,1600];
			//Number 5
			sF[4] = [2300,2000,1880,1750,1660];
			//Number 6
			sF[5] = [2540,2250,2140,2000,1800];
			//Number 7
			sF[6] = [2000,1800,1680,1600,1500];
			//Number 8
			sF[7] = [2800,2500,2320,2200,2040];
			//Number 9
			sF[8] = [3000,2700,2500,2400,2200];
			//Number 10
			sF[9] = [2180,2000,1750,1600,1470];
			//Number 11
			sF[10] = [1750,1400,1240,1050,970];
			//Number 12
			sF[11] = [1150,950,800,7000,630];
			//Number 13
			sF[12] = [580,480,400,350,320];
			var Sforce:Number;
			Sforce = sF[materialIndex][remIndex];
			return Sforce;
		}
		public function FeedSpeed(index:int):Number
		{
			var feedarr:Array = [0.1,0.2,0.3,0.4,0.6];
			return feedarr[index];
		}

	}

}