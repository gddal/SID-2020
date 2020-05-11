import java.util.ArrayList;

import readings.HumidityReading;
import readings.LuminosityReading;
import readings.MovementReading;
import readings.Reading;
import readings.TemperatureReading;

public class ReadingLists {

	public static ArrayList<TemperatureReading> trList = new ArrayList<TemperatureReading>();
	public static ArrayList<HumidityReading> hrList = new ArrayList<HumidityReading>();
	public static ArrayList<LuminosityReading> lrList = new ArrayList<LuminosityReading>();
	public static ArrayList<MovementReading> mrList = new ArrayList<MovementReading>();
	
	public static ArrayList<TemperatureReading> filteredtrList = new ArrayList<TemperatureReading>();
	public static ArrayList<HumidityReading> filteredhrList = new ArrayList<HumidityReading>();
	public static ArrayList<LuminosityReading> filteredlrList = new ArrayList<LuminosityReading>();
	public static ArrayList<MovementReading> filteredmrList = new ArrayList<MovementReading>();

	
	public static void clearLists() {
		
		trList.clear();
		hrList.clear();
		lrList.clear();
		mrList.clear();
		
		filteredtrList.clear();
		filteredhrList.clear();
		filteredlrList.clear();
		filteredmrList.clear();

		
	}
	
	public static double returnLastTemperatureValue(){
		ArrayList<TemperatureReading> filteredtrlist = ReadingLists.filteredtrList;
		if (filteredtrlist != null && !filteredtrlist.isEmpty()) {
			TemperatureReading tr = filteredtrlist.get(filteredtrlist.size()-1);
			
			return tr.getTemperature();
			
			
		}
		return SettingsLoader.getEwmaInitialValue()[0];
	}
	
	
	public static double returnLastHumidityValue(){
		ArrayList<HumidityReading> filteredhrlist = ReadingLists.filteredhrList;
		if (filteredhrlist != null && !hrList.isEmpty()) {
			HumidityReading hr = filteredhrlist.get(filteredhrlist.size()-1);
			return hr.getHumidity();
			
			
		}
		return SettingsLoader.getEwmaInitialValue()[1];
	}
	
	public static double returnLastMovementValue(){
		ArrayList<MovementReading> filteredmrlist = ReadingLists.filteredmrList;
		if (filteredmrlist != null && !mrList.isEmpty()) {
			MovementReading mr = filteredmrlist.get(filteredmrlist.size()-1);
			return mr.getMovement();
			
			
		}

		return SettingsLoader.getEwmaInitialValue()[2];
	}
	public static double returnLastLuminosityValue(){
		ArrayList<LuminosityReading> filteredlrlist = ReadingLists.filteredlrList;
		if (filteredlrlist != null && !lrList.isEmpty()) {
			LuminosityReading lr = filteredlrlist.get(filteredlrlist.size()-1);
			return lr.getLuminosity();
			
			
		}
		return SettingsLoader.getEwmaInitialValue()[3];
	}
	

	
}
