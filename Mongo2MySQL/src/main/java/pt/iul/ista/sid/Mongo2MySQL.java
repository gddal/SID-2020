package pt.iul.ista.sid;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

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

		sendToMySQL();

	}

	/**
	 * 
	 * send a documnets do MySQL.
	 * 
	 * @throws Throwable
	 * 
	 */
	public static void sendToMySQL() throws Throwable {

		mongoClient = new MongoClient(new MongoClientURI(mongoServer));
		mongoDB = mongoClient.getDatabase(mongoDatabase);
		mongoTmp = mongoDB.getCollection(mongoTemperature, BasicDBObject.class);
		mongoHum = mongoDB.getCollection(mongoHumidity, BasicDBObject.class);
		mongoCel = mongoDB.getCollection(mongoLuminosity, BasicDBObject.class);
		mongoMov = mongoDB.getCollection(mongoMotion, BasicDBObject.class);

		String lastMongoDate;
		String lastMySQLDate;

		// Temperatura
		lastMySQLDate = getLastMySQLRecord("tmp").datatoString();
		lastMongoDate = getMongoRecords("tmp", lastMySQLDate, mongoTmp);
		if (lastMongoDate != null) {
			ewma();
			updateMySQL("tmp", lastMongoDate, average());
		}

		// Humidity
		lastMySQLDate = getLastMySQLRecord("hum").datatoString();
		lastMongoDate = getMongoRecords("hum", lastMySQLDate, mongoHum);
		if (lastMongoDate != null) {
			ewma();
			updateMySQL("hum", lastMongoDate, average());
		}

		// Luminosity
		lastMySQLDate = getLastMySQLRecord("cel").datatoString();
		lastMongoDate = getMongoRecords("cel", lastMySQLDate, mongoCel);
		if (lastMongoDate != null) {
			ewma();
			updateMySQL("cel", lastMongoDate, average());
		}
		
		// Motion
		lastMySQLDate = getLastMySQLRecord("mov").datatoString();
		lastMongoDate = getMongoRecords("mov", lastMySQLDate, mongoMov);
		if (lastMongoDate != null) {
			ewma();
			updateMySQL("mov", lastMongoDate, average());
		}

	}

	private static String getMongoRecords(String tipoSensor, String data, MongoCollection<BasicDBObject> col)
			throws Throwable {

		FindIterable<BasicDBObject> fi = col.find(Filters.gt("dat", data));
		MongoCursor<BasicDBObject> cursor = fi.iterator();
		BasicDBObject m = null;
		medicoes.clear();
		while (cursor.hasNext()) {
			m = cursor.next();
			medicoes.add(new Medicao(tipoSensor, m));
		}
		return (medicoes.isEmpty()) ? null : m.getString("dat");
	}

	private static void updateMySQL(String tipoSensor, String data, double valor) {

		Connection conn = null;
		Statement stmt = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://" + MySQLServer + "/" + MySQLDatabase + "?user="
					+ MySQLUser + "&password=" + MySQLPass);

			stmt = conn.createStatement();
			stmt.executeUpdate("INSERT INTO medicoessensores (TipoSensor,ValorMedicao,DataHoraMedicao) VALUES('"
					+ tipoSensor + "','" + valor + "','" + data + "')");

		} catch (Exception e) {
			System.out.println("Error connecting to Mysql " + e);
		} finally {
			try {
				if (conn != null)
					stmt.close();
				conn.close();
			} catch (SQLException e) {
				System.out.println("Error closing connecting to Mysql " + e);
			}
		}

	}

	private static Medicao getLastMySQLRecord(String tipoSensor) {

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Medicao med = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://" + MySQLServer + "/" + MySQLDatabase + "?user="
					+ MySQLUser + "&password=" + MySQLPass);

			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT * FROM Main.MedicoesSensores WHERE TipoSensor='" + tipoSensor
					+ "' ORDER BY DataHoraMedicao DESC LIMIT 1");

			if (rs != null) {
				while (rs.next()) {
					med = new Medicao(tipoSensor, rs.getTimestamp("DataHoraMedicao"), rs.getDouble("ValorMedicao"));
				}
			}

		} catch (Exception e) {
			System.out.println("Error connecting to Mysql " + e);
		} finally {
			try {
				if (conn != null) {
					stmt.close();
					rs.close();
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("Error closing connecting to Mysql " + e);
			}
		}
		return med;
	}

	private static void ewma() {

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
