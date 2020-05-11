import java.util.ArrayList;

import readings.HumidityReading;
import readings.LuminosityReading;
import readings.MovementReading;
import readings.TemperatureReading;

public class ReadingLists {

	public static ArrayList<TemperatureReading> trList = new ArrayList<TemperatureReading>();
	public static ArrayList<HumidityReading> hrList = new ArrayList<HumidityReading>();
	public static ArrayList<LuminosityReading> lrList = new ArrayList<LuminosityReading>();
	public static ArrayList<MovementReading> mrList = new ArrayList<MovementReading>();

	
	public static void clearLists() {
		
		trList.clear();
		hrList.clear();
		lrList.clear();
		mrList.clear();

		
	}
	
}
