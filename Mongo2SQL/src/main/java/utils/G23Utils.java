package utils;

public class G23Utils {


	public static int[] parseIntarray(String[] strarray) { //TODO ERROR Messages
		//Has bad performance :/
		int[] intarray = new int[strarray.length];
		for(int i = 0; i < strarray.length; i++) {
			intarray[i] = Integer.parseInt(strarray[i]);	
		}		
		return intarray;
	}

	public static double[] parseDoublearray(String[] strarray) { //TODO ERROR Messages
		//Has bad performance :/
		double[] doublearray = new double[strarray.length];
		for(int i = 0; i < strarray.length; i++) {
			doublearray[i] = Double.parseDouble(strarray[i]);	
		}		
		return doublearray;
	}

	public static double exponentiallyWeightedMovingAverage(double weight, double lastvalue, double value) {
		double result;
		result = (1-weight)*lastvalue + weight*value;
		return result;
		
		
	}

}
