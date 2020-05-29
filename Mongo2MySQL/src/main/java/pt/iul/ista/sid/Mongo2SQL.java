package pt.iul.ista.sid;

import java.io.FileInputStream;
import java.util.Properties;

import org.eclipse.paho.client.mqttv3.MqttClient;

import com.mongodb.BasicDBObject;
import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class Mongo2SQL {

	// Startup configuration file
	private static final String INI_FILE = "config.ini";
	private static final String DATE_FORMAT = "dd/M/yyyy";
	private static final String TIME_FORMAT = "H:m:s";

	private static final String INI_MONGO_SRV = "mongo_server";
	private static final String INI_MONGO_DB = "mongo_database";
	private static final String INI_MONGO_TMP = "mongo_temperature";
	private static final String INI_MONGO_HUM = "mongo_humidity";
	private static final String INI_MONGO_CEL = "mongo_luminosity";
	private static final String INI_MONGO_MOT = "mongo_motion";
	private static final String INI_MYSQL_SRV = "mysql_server";
	private static final String INI_MYSQL_PRT = "mysql_port";
	private static final String INI_MYSQL_DB = "mysql_database";
	private static final String INI_MYSQL_USR = "mysql_user";
	private static final String INI_MYSQL_PWD = "mysql_user";

	static String mongoServer;
	static String mongoDatabase;
	static String mongoTemperature;
	static String mongoHumidity;
	static String mongoLuminosity;
	static String mongoMotion;
	static String MySQLServer;
	static String MySQLPort;
	static String MySQLDatabase;
	static String MySQLUser;
	static String MySQLPass;

	static MqttClient mqttClient;
	static MongoClient mongoClient;

	static MongoDatabase mongoDB;

	static MongoCollection<BasicDBObject> mongoTmp, mongoHum, mongoCel, mongoMov;

	public static void main(String[] args) {

		System.out.println("Mongo2MySQL");

		Properties pFile = new Properties();

		try {
			pFile.load(new FileInputStream(INI_FILE));
			mongoServer = pFile.getProperty(INI_MONGO_SRV);
			mongoDatabase = pFile.getProperty(INI_MONGO_DB);
			mongoTemperature = pFile.getProperty(INI_MONGO_TMP);
			mongoHumidity = pFile.getProperty(INI_MONGO_HUM);
			mongoLuminosity = pFile.getProperty(INI_MONGO_CEL);
			mongoMotion = pFile.getProperty(INI_MONGO_MOT);
			MySQLServer = pFile.getProperty(INI_MYSQL_SRV);
			MySQLPort = pFile.getProperty(INI_MYSQL_PRT);
			MySQLDatabase = pFile.getProperty(INI_MYSQL_DB);
			MySQLUser = pFile.getProperty(INI_MYSQL_USR);
			MySQLPass = pFile.getProperty(INI_MYSQL_PWD);

			System.out.println("-------------------------------------------------");
			System.out.println("| mongoServer: " + mongoServer);
			System.out.println("| mongoDatabase: " + mongoDatabase);
			System.out.println("| mongoTemperature: " + mongoTemperature);
			System.out.println("| mongoHumidity: " + mongoHumidity);
			System.out.println("| mongoLuminosity: " + mongoLuminosity);
			System.out.println("| mongoMotion: " + mongoMotion);
			System.out.println("| mysqlServer: " + MySQLServer);
			System.out.println("| mysqlPort: " + MySQLPort);
			System.out.println("| mysqlDatabase: " + MySQLDatabase);
			System.out.println("| mysqlUser: " + MySQLUser);
			System.out.println("-------------------------------------------------");

		} catch (Exception e) {
			System.out.println("Error reading " + INI_FILE + " file " + e);
		}

//		new Mqtt2Mongo().connecMQTT();
//		new Mqtt2Mongo().connectMongo();

	}

}
