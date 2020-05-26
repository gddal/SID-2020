import java.util.ArrayList;

import org.bson.Document;

import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;

import readings.HumidityReading;
import readings.LuminosityReading;
import readings.MovementReading;
import readings.Reading;
import readings.TemperatureReading;
import utils.G23Utils;

public class MongoDBConnector {
	private MongoClient mongoClient;
	private DB mdb;
	private SettingsLoader settings;

	public MongoDBConnector(String URI, String DBName) {
		mongoClient = new MongoClient( new MongoClientURI(URI)); 
		mdb = mongoClient.getDB(DBName);



	}

	public void mongotoArrayList(){
		String[] stringsarray = SettingsLoader.getdbStrings();	

		for(int i = 0; i < stringsarray.length; i++) {
			String[] stringinfo = stringsarray[i].split("#");

			String collection = stringinfo[0];
			String sensorfieldname = stringinfo[1];
			String sensortype = stringinfo[2];

			DBCollection table = mdb.getCollection(collection);
			DBCursor cursor = table.find();

			int	currentlyread = 0;

			System.out.println(SettingsLoader.getNumberReads()[0]);
			while(cursor.hasNext() && (currentlyread < SettingsLoader.getNumberReads()[i] || SettingsLoader.getNumberReads()[i] == -1)) { //Checks if there's something to be read and if it has already read all allowed entries. Note that if it's -1 it's set to infinite.

				DBObject dbo = cursor.next();
				mongoObjecttoReadingLists(dbo,sensorfieldname,sensortype);
				currentlyread++;
				SettingsLoader.setewmaInitialValue();
			}

		}


	}


	public void mongoObjecttoReadingLists(DBObject dbo, String sensorfieldname, String sensortype) { //TODO possibly change or remove sensortype and make it an ENUM

		String tstring = SettingsLoader.getdbStrings()[0].split("#")[2];
		String hstring = SettingsLoader.getdbStrings()[1].split("#")[2];
		String mstring = SettingsLoader.getdbStrings()[2].split("#")[2];
		String lstring = SettingsLoader.getdbStrings()[3].split("#")[2];

		//TODO simplify big expressions
		//Implementation had to be done with if's since case switch doesn't support variables
		if(tstring.equals(sensortype)) {
			TemperatureReading r = new TemperatureReading(dbo.get(SettingsLoader.getMongoIdField()).toString(), dbo.get(SettingsLoader.getMongoDateTimeField()).toString(),Double.valueOf(dbo.get(sensorfieldname).toString()));			
			ReadingLists.trList.add(r);		
			//Filters
			double newvalue = G23Utils.exponentiallyWeightedMovingAverage(SettingsLoader.getEwmaWeight()[0], SettingsLoader.getEwmaInitialValue()[0], r.getTemperature());
			TemperatureReading filteredreading = new TemperatureReading(r.getId(),r.getDatime(),newvalue);
			ReadingLists.filteredtrList.add(filteredreading);
		}//TODO implement filters on the other sensors
		if(hstring.equals(sensortype)) {
			ReadingLists.hrList.add(new HumidityReading(dbo.get(SettingsLoader.getMongoIdField()).toString(), dbo.get(SettingsLoader.getMongoDateTimeField()).toString(),Double.valueOf(dbo.get(sensorfieldname).toString())));
		}
		if(lstring.equals(sensortype)) {
			ReadingLists.lrList.add(new LuminosityReading(dbo.get(SettingsLoader.getMongoIdField()).toString(), dbo.get(SettingsLoader.getMongoDateTimeField()).toString(),Integer.valueOf(dbo.get(sensorfieldname).toString())));			
		}
		if(mstring.equals(sensortype)) {
			ReadingLists.mrList.add(new MovementReading(dbo.get(SettingsLoader.getMongoIdField()).toString(), dbo.get(SettingsLoader.getMongoDateTimeField()).toString(),Integer.valueOf(dbo.get(sensorfieldname).toString())));
		}








	}

}
