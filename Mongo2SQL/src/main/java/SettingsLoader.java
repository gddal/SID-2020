import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

import utils.G23Utils;

public class SettingsLoader {


	private final static String INIFILEPATH = "Mongo2SQL.ini";
	
	private final static String DEFAULTMONGOURI = "mongodb://root:password@127.0.0.1:27017/?authSource=admin";
	private final static String DEFAULTMONGODB = "sid";
	private final static String DEFAULTMONGOIDFIELD = "_id";
	private final static String DEFAULTMONGODATETIMEFIELD = "datime";
	//Same order as DEFAULTSTRINGSLIST
	private final static String DEFAULTNUMBEROFREADS = "5|5|5|5";
	//mongodb collection name # mongodb field name # sensor type | .......
	private final static String DEFAULTSTRINGSLIST = "temperatures#tmp#Temperature|humidity#hum#Humidity|movement#mov#Movement|luminosity#lum#Luminosity";
	private final static String DEFAULTEWMAWEIGHT = "0.2|0.2|0.2|0.2";
	private final static String DEFAULTEWMAINITVALUE = "20.0|20.0|20.0|20.0";


	private static String mongoURI = DEFAULTMONGOURI;
	private static String dbName = DEFAULTMONGODB;
	private static String mongoIdField = DEFAULTMONGOIDFIELD;
	private static String mongoDateTimeField = DEFAULTMONGODATETIMEFIELD;
	private static int[] numberReads = G23Utils.parseIntarray(DEFAULTNUMBEROFREADS.split("\\|"));

	private static String[] dbStrings = DEFAULTSTRINGSLIST.split("\\|");
	
	
	private static double[] ewmaWeight = G23Utils.parseDoublearray((DEFAULTEWMAWEIGHT.split("\\|")));
	private static double[] ewmaInitialValue = G23Utils.parseDoublearray(DEFAULTEWMAINITVALUE.split("\\|"));
	
	private static Properties p;

	public SettingsLoader(){
		p = new Properties();

		readFile();


	}


	private void readFile() {

		try {
			FileInputStream in = new FileInputStream(INIFILEPATH);
			p.load(in);
			
			mongoURI = p.getProperty("URI", DEFAULTMONGOURI);
			System.out.println(mongoURI); //TODO Remove this
			dbName = p.getProperty("MongoDBName", DEFAULTMONGODB);
			mongoIdField = p.getProperty("MongoIDField", DEFAULTMONGOIDFIELD);
			mongoDateTimeField = p.getProperty("MongoDateTimeField", DEFAULTMONGODATETIMEFIELD);
			numberReads = G23Utils.parseIntarray(p.getProperty("NumberofReads",DEFAULTNUMBEROFREADS).split("\\|"));
			dbStrings = p.getProperty("StringList", DEFAULTSTRINGSLIST).split("\\|");
			
			ewmaWeight = G23Utils.parseDoublearray(p.getProperty("EWMAWeight",DEFAULTEWMAWEIGHT).split("\\|"));
			ewmaInitialValue = G23Utils.parseDoublearray(p.getProperty("EWMAInitialValue",DEFAULTEWMAINITVALUE).split("\\|"));

			in.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		


	}


	public static void setewmaInitialValue() {
		try {
			FileOutputStream out = new FileOutputStream(INIFILEPATH);
			String str = ReadingLists.returnLastTemperatureValue() + "|" + ReadingLists.returnLastHumidityValue() + "|" + ReadingLists.returnLastMovementValue() + "|" + ReadingLists.returnLastLuminosityValue();
	
			p.setProperty("EWMAInitialValue", str);
			p.store(out, null);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		
		
	}


	public static String getmongoURI() {
		return mongoURI;
	}

	public static String getdbName() {
		return dbName;
	}

	public static String[] getdbStrings() {
		return dbStrings;
	}
	
	public static String getMongoIdField() {
		return mongoIdField;
	}

	public static String getMongoDateTimeField() {
		return mongoDateTimeField;
	}
	
	public static int[] getNumberReads() {
		return numberReads;
	}
	
	
	public static double[] getEwmaWeight() {
		return ewmaWeight;
	}
	
	public static double[] getEwmaInitialValue() {
		return ewmaInitialValue;
	}



}


