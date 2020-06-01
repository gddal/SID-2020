package pt.iul.ista.sid;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Properties;
import java.util.TimeZone;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.eclipse.paho.client.mqttv3.MqttClient;
import com.mongodb.BasicDBObject;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

public class Mongo2MySQL {

	// Startup configuration file
	private static final String INI_FILE = "config.ini";

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
	private static final String INI_MYSQL_PWD = "mysql_pass";

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
	static Double EWMAWeight = 0.1;

	static MqttClient mqttClient;
	static MongoClient mongoClient;

	static MongoDatabase mongoDB;

	static MongoCollection<BasicDBObject> mongoTmp, mongoHum, mongoCel, mongoMov;

	// List of all interactable Medicoes objects
	private final static List<Medicao> medicoes = new ArrayList<Medicao>();

	public static void main(String[] args) throws Throwable {

		System.out.println("Mongo2MySQL");
		Logger mongoLogger = Logger.getLogger( "org.mongodb.driver" );
		mongoLogger.setLevel(Level.SEVERE); 
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

		mongoClient = new MongoClient(new MongoClientURI(mongoServer));
		mongoDB = mongoClient.getDatabase(mongoDatabase);
		mongoTmp = mongoDB.getCollection(mongoTemperature, BasicDBObject.class);
		mongoHum = mongoDB.getCollection(mongoHumidity, BasicDBObject.class);
		mongoCel = mongoDB.getCollection(mongoLuminosity, BasicDBObject.class);
		mongoMov = mongoDB.getCollection(mongoMotion, BasicDBObject.class);

		String lastMongoDate;
		String lastMySQLDate;

		System.out.println("-------------------------------------------------");
		// Temperatura
		lastMySQLDate = getLastMySQLRecord("tmp");
		lastMongoDate = getMedicoes("tmp", lastMySQLDate, mongoTmp);
		if (lastMongoDate != null) {
			calculateEWMA();
			saveMedicoes("tmp", lastMongoDate, average());
		}

		// Humidity
		lastMySQLDate = getLastMySQLRecord("hum");
		lastMongoDate = getMedicoes("hum", lastMySQLDate, mongoHum);
		if (lastMongoDate != null) {
			calculateEWMA();
			saveMedicoes("hum", lastMongoDate, average());
		}

		// Luminosity
		lastMySQLDate = getLastMySQLRecord("cel");
		lastMongoDate = getMedicoes("cel", lastMySQLDate, mongoCel);
		if (lastMongoDate != null) {
			calculateEWMA();
			saveMedicoes("cel", lastMongoDate, average());
		}

		// Motion
		lastMySQLDate = getLastMySQLRecord("mov");
		lastMongoDate = getMedicoes("mov", lastMySQLDate, mongoMov);
		if (lastMongoDate != null) {
			saveMedicoes("mov", lastMongoDate, detectMotion());
		}
		System.out.println("-------------------------------------------------");

	}

	private static String getMedicoes(String tipoSensor, String data, MongoCollection<BasicDBObject> col)
			throws Throwable {

		FindIterable<BasicDBObject> fi = col.find(Filters.gt("dat", data));
		MongoCursor<BasicDBObject> cursor = fi.iterator();
		System.out.print("| reading collection: " + col.getNamespace().getCollectionName());

		medicoes.clear();
		while (cursor.hasNext()) {
			medicoes.add(new Medicao(tipoSensor, cursor.next()));
		}		
		System.out.println(", found " + medicoes.size() + " new records");
		return (medicoes.isEmpty()) ? null : medicoes.get(medicoes.size()-1).datatoString();
	}

	private static void saveMedicoes(String tipoSensor, String data, double valor) {

		Connection conn = null;
		Statement stmt = null;

		try {
			conn = DriverManager.getConnection("jdbc:mysql://" + MySQLServer + "/" + MySQLDatabase + "?user="
					+ MySQLUser + "&password=" + MySQLPass + "&serverTimezone=UTC");

			stmt = conn.createStatement();
			System.out.println("| write to mysql: " + data + " " + tipoSensor + " " + valor);
			stmt.executeUpdate("INSERT INTO medicoessensores (TipoSensor,ValorMedicao,DataHoraMedicao) VALUES('"
					+ tipoSensor + "','" + valor + "','" + data + "')");

		} catch (Exception e) {
			System.out.println("Error connecting to Mysql " + e);
		} finally {
			try {
				if (conn != null) {
					stmt.close();
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("Error closing connecting to Mysql " + e);
			}
		}

	}

	private static String getLastMySQLRecord(String tipoSensor) {

		Calendar cal = Calendar.getInstance(); 
		cal.setTimeZone(TimeZone.getTimeZone("GMT")); 
		SimpleDateFormat output = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String lastdata = null;

		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;

		try {
			conn = DriverManager.getConnection("jdbc:mysql://" + MySQLServer + "/" + MySQLDatabase + "?user="
					+ MySQLUser + "&password=" + MySQLPass + "&serverTimezone=UTC");

			ps = conn.prepareStatement("SELECT MAX(DataHoraMedicao) AS lastdata FROM MedicoesSensores WHERE TipoSensor='" + tipoSensor + "'");
			rs = ps.executeQuery();
			rs.next();
			if (rs.getString("lastdata") != null) {
				lastdata = rs.getString("lastdata");
			} else {
				lastdata = output.format(new Timestamp(0));
			}

		} catch (Exception e) {
			System.out.println("Error connecting to Mysql " + e);
		} finally {
			try {
				if (conn != null) {
					rs.close();
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("Error closing connecting to Mysql " + e);
			}
		}
		
		System.out.println("| Las record for sensor: " + tipoSensor + " is " + lastdata);

		return lastdata;
	}

	private static double detectMotion() {

		double motion = 0;

		for (int i = 0; i < medicoes.size(); i++) {
			if (medicoes.get(i).getValor() == 1) {
				motion = 1;
			}
		}
		return motion;
	}

	private static void calculateEWMA() {

		for (int i = 0; i < medicoes.size() - 1; i++) {
			medicoes.get(i + 1).setValor(round(
					(1 - EWMAWeight) * medicoes.get(i).getValor() + EWMAWeight * medicoes.get(i + 1).getValor(), 2));
		}
	}

	private static double average() {

		double total = 0;

		for (int i = 0; i < medicoes.size(); i++) {
			total += medicoes.get(i).getValor();
		}
		return round(total / medicoes.size(), 2);
	}

	public static double round(double value, int places) {
		if (places < 0)
			throw new IllegalArgumentException();

		long factor = (long) Math.pow(10, places);
		value = value * factor;
		long tmp = Math.round(value);
		return (double) tmp / factor;
	}
}
