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

public class MongoDBConnector {
	private MongoClient mongoClient;
	private DB mdb;

	public MongoDBConnector(String URI, String DBName) {
		mongoClient = new MongoClient( new MongoClientURI(URI)); 
		mdb = mongoClient.getDB(DBName);



	}

	public ArrayList<Reading> mongotoArrayList(String[] stringsarray,String mongoIdField, String mongoDateTimeField){

		ArrayList<Reading> readingsList = new ArrayList<Reading>();

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

			}


		}

		return readingsList;

	}



	public void mongoObjecttoReadingLists(DBObject dbo, String sensorfieldname, String sensortype) {


		switch(sensortype) { //Switch with strings requires Java 1.7+
		case "Temperature":
			ReadingLists.trList.add(new TemperatureReading(dbo.get(SettingsLoader.getMongoIdField()).toString(), dbo.get(SettingsLoader.getMongoDateTimeField()).toString(),Double.valueOf(dbo.get(sensorfieldname).toString())));			
			break;
		case "Humidity":
			ReadingLists.hrList.add(new HumidityReading(dbo.get(SettingsLoader.getMongoIdField()).toString(), dbo.get(SettingsLoader.getMongoDateTimeField()).toString(),Double.valueOf(dbo.get(sensorfieldname).toString())));
			break;
		case "Luminosity":
			ReadingLists.lrList.add(new LuminosityReading(dbo.get(SettingsLoader.getMongoIdField()).toString(), dbo.get(SettingsLoader.getMongoDateTimeField()).toString(),Integer.valueOf(dbo.get(sensorfieldname).toString())));			
			break;
		case "MovementReading":
			ReadingLists.mrList.add(new MovementReading(dbo.get(SettingsLoader.getMongoIdField()).toString(), dbo.get(SettingsLoader.getMongoDateTimeField()).toString(),Integer.valueOf(dbo.get(sensorfieldname).toString())));
			break;

		}






	}

}
