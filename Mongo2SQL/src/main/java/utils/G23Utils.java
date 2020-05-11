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
	

}
