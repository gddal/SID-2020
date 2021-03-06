/**
 * 
 */
package pt.iul.ista.sid;

import java.io.FileInputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import com.mongodb.*;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.util.JSON;

/**
 *
 * Trabalho final da UC de Sistemas de Informacao Distribuidos 2020
 * 
 * Grupo 23
 * 
 * Classe de entrada da Aplicacao do cliente.
 *
 * @author Miguel Diaz GonÃ§alves 82493
 * @author GonÃ§alo Dias do Amaral 83380
 * @author Dmytro Astashov 74278
 * @author AndrÃ© Freitas 82361
 * @author Pedro Jones 82946
 * @author Vitor CanhÃ£o 73788
 * @version 0.11
 *
 */
@SuppressWarnings("deprecation")
public class Mqtt2Mongo implements MqttCallback {

	// Startup configuration file
	private static final String INI_FILE = "config.ini";
	private static final String DATE_FORMAT = "dd/M/yyyy";
	private static final String TIME_FORMAT = "H:m:s";

	private static final String INI_BROKER = "mqtt_broker";
	private static final String INI_TOPIC = "mqtt_topic";
	private static final String INI_SRV = "mongo_server";
	private static final String INI_DB = "mongo_database";
	private static final String INI_TMP = "mongo_temperature";
	private static final String INI_HUM = "mongo_humidity";
	private static final String INI_CEL = "mongo_luminosity";
	private static final String INI_MOT = "mongo_motion";
	private static final String INI_ERR = "mongo_errors";

	private static final String INI_TIME = "mongo_addtime";
	private static final String INI_CLEAN = "mongo_clean";

	static String mqttBroker;
	static String mqttTopic;
	static String mongoServer;
	static String mongoDatabase;
	static String mongoTemperature;
	static String mongoHumidity;
	static String mongoLuminosity;
	static String mongoMotion;
	static String mongoErrors;

	static String mongoTime;
	static String mongoClean;

	static MqttClient mqttClient;
	static MongoClient mongoClient;

	static MongoDatabase mongoDB;

	static MongoCollection<BasicDBObject> mongoTmp, mongoHum, mongoCel, mongoMov, mongoErr;

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		System.out.println("Mqtt2Mongo");
		Logger mongoLogger = Logger.getLogger( "org.mongodb.driver" );
		mongoLogger.setLevel(Level.WARNING); 
		Properties pFile = new Properties();

		try {
			pFile.load(new FileInputStream(INI_FILE));
			mqttBroker = pFile.getProperty(INI_BROKER);
			mqttTopic = pFile.getProperty(INI_TOPIC);
			mongoServer = pFile.getProperty(INI_SRV);
			mongoDatabase = pFile.getProperty(INI_DB);
			mongoTemperature = pFile.getProperty(INI_TMP);
			mongoHumidity = pFile.getProperty(INI_HUM);
			mongoLuminosity = pFile.getProperty(INI_CEL);
			mongoMotion = pFile.getProperty(INI_MOT);
			mongoErrors = pFile.getProperty(INI_ERR);
			
			mongoTime = pFile.getProperty(INI_TIME);
			mongoClean = pFile.getProperty(INI_CLEAN);
			
			System.out.println("-------------------------------------------------");
			System.out.println("| mqttBroker: " + mqttBroker);
			System.out.println("| mqttTopic: " + mqttTopic);
			System.out.println("| mongoServer: " + mongoServer);
			System.out.println("| mongoDatabase: " + mongoDatabase);
			System.out.println("| mongoTemperature: " + mongoTemperature);
			System.out.println("| mongoHumidity: " + mongoHumidity);
			System.out.println("| mongoLuminosity: " + mongoLuminosity);
			System.out.println("| mongoMotion: " + mongoMotion);
			System.out.println("| mongoErrors: " + mongoErrors);
			System.out.println("-------------------------------------------------");

		} catch (Exception e) {
			System.out.println("Error reading " + INI_FILE + " file " + e);
		}

		new Mqtt2Mongo().connecMQTT();
		new Mqtt2Mongo().connectMongo();

	}

	public void connecMQTT() {
		int i;
		try {
			i = new Random().nextInt(100000);
			mqttClient = new MqttClient(mqttBroker, "CloudToMongo_" + String.valueOf(i) + "_" + mqttTopic);
			mqttClient.connect();
			mqttClient.setCallback(this);
			mqttClient.subscribe(mqttTopic);
		} catch (MqttException cause) {
			System.out.println("-------------------------------------------------");
			System.out.println("| Connection to mqtt failed!");
			System.out.println("| Cause: " + cause.getMessage());
			cause.printStackTrace();
			System.out.println("-------------------------------------------------");
		}
	}

	public void connectMongo() {
		
		mongoClient = new MongoClient(new MongoClientURI(mongoServer));
		mongoDB = mongoClient.getDatabase(mongoDatabase);
		
		try {
			mongoDB.createCollection(mongoTemperature);
			mongoDB.createCollection(mongoHumidity);
			mongoDB.createCollection(mongoLuminosity);
			mongoDB.createCollection(mongoMotion);
			mongoDB.createCollection(mongoErrors);
	    } catch (MongoCommandException e) {
	    }
		
		mongoTmp = mongoDB.getCollection(mongoTemperature, BasicDBObject.class);
		mongoHum = mongoDB.getCollection(mongoHumidity, BasicDBObject.class);
		mongoCel = mongoDB.getCollection(mongoLuminosity, BasicDBObject.class);
		mongoMov = mongoDB.getCollection(mongoMotion, BasicDBObject.class);
		mongoErr = mongoDB.getCollection(mongoErrors, BasicDBObject.class);
	}

	/**
	 * 
	 * connectionLost Invocado quando e perdida a ligacao ao broker MQTT.
	 * 
	 */
	public void connectionLost(Throwable cause) {
		System.out.println("-------------------------------------------------");
		System.out.println("| Connection lost!");
		System.out.println("| Cause: " + cause.getMessage());
		System.out.println("-------------------------------------------------");
		System.out.println("Connection lost!");
	}

	/**
	 * 
	 * messageArrived Invocado quando uma mensagem e recebida no topico subscrito.
	 * 
	 */
	public void messageArrived(String topic, MqttMessage message) throws Exception {
		System.out.println("-------------------------------------------------");
		System.out.println("| Message arrived");
		System.out.println("| Topico: " + topic);
		System.out.println("| Mensagem: " + message.toString());
		System.out.println("-------------------------------------------------");

		sendToMongo(message);

	}

	/**
	 * 
	 * deliveryComplete Invocado quando uma mensagem e enviada com sucesso.
	 * 
	 */
	public void deliveryComplete(IMqttDeliveryToken token) {
		try {
			System.out.println("-------------------------------------------------");
			System.out.println("| Mensagem: " + token.getMessage().toString());
			System.out.println("-------------------------------------------------");
		} catch (MqttException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 
	 * send a documnet do MongoDB.
	 * @throws ParseException 
	 * 
	 */
	public void sendToMongo(MqttMessage message) throws ParseException {

		BasicDBObject document = (BasicDBObject) JSON.parse(clean(message.toString()));
		
		System.out.println("| sendToMongo: " + clean(message.toString()));

		System.out.println("-------------------------------------------------");
		System.out.println("| MongoDB server: " + mongoServer);
		System.out.println("| Database: " + mongoDatabase);

		if (document.containsField("dat")) {
			System.out.println("| Data: " + document.get("dat").toString());
		}
		if (document.containsField("tim")) {
			System.out.println("| Hora: " + document.get("tim").toString());
		}
		if (document.containsField("tmp")) {
			System.out.println("| Temperatura: " + document.get("tmp").toString());
		}
		if (document.containsField("hum")) {
			System.out.println("| Humidade: " + document.get("hum").toString());
		}
		if (document.containsField("cell")) {
			System.out.println("| Luminosidade: " + document.get("cell").toString());
		}
		if (document.containsField("mov")) {
			System.out.println("| Movimento: " + document.get("mov").toString());
		}
		System.out.println("-------------------------------------------------");

		if (isDateValid(document.get("dat").toString(), DATE_FORMAT) && isDateValid(document.get("tim").toString(), TIME_FORMAT)) {
			parseDocument(document);
		} else {
			mongoErr.insertOne(document);
		}

	}

	private Date addHoursToJavaUtilDate(Date date, int hours) {
	    Calendar calendar = Calendar.getInstance();
	    calendar.setTime(date);
	    calendar.add(Calendar.HOUR_OF_DAY, hours);
	    return calendar.getTime();
	}
	
	private void parseDocument(BasicDBObject document) throws ParseException {

		boolean err = false;
		
		System.out.println("| parseDocument: " + document.toString());

		SimpleDateFormat input = new SimpleDateFormat( DATE_FORMAT + " " + TIME_FORMAT );
		SimpleDateFormat output = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date data = input.parse(document.get("dat").toString() + " " + document.get("tim").toString());
		
		String newDateValue = output.format(addHoursToJavaUtilDate(data,(mongoTime.equals(null) ? 0 : Integer.parseInt(mongoTime))));// TODO Correcção da hora do sensor
		
		if (document.containsField("tmp")) {
			if (isNumeric(document.get("tmp").toString())) {
				mongoTmp.insertOne(new BasicDBObject().append("dat", newDateValue).append("tmp", document.get("tmp").toString()));
			} else if (!err) {
				err = true;
				mongoErr.insertOne(document);
			}
		}
		
		if (document.containsField("hum")) {
			if (isNumeric(document.get("hum").toString())) {
				mongoHum.insertOne(new BasicDBObject().append("dat", newDateValue).append("hum", document.get("hum").toString()));
			} else if (!err) {
				err = true;
				mongoErr.insertOne(document);
			}
		}

		
		if (document.containsField("cell")) {
			if (isNumeric(document.get("cell").toString())) {
				mongoCel.insertOne(new BasicDBObject().append("dat", newDateValue).append("cel", document.get("cell").toString()));
			} else if (!err) {
				err = true;
				mongoErr.insertOne(document);
			}
		}

		
		if (document.containsField("mov")) {
			if (isNumeric(document.get("mov").toString())) {
				mongoMov.insertOne(new BasicDBObject().append("dat", newDateValue).append("mov", document.get("mov").toString()));
			} else if (!err) {
				err = true;
				mongoErr.insertOne(document);
			}
		}
		
	}

	public String clean(String message) {
		
		if ( Boolean.parseBoolean(mongoClean)) {
			return (message.replaceAll("\"mov\":\"0\"", ",").replaceAll("\"sens\":\"eth\"", ""));
		}
		else {
			return (message);	
		}

	}

	private boolean isNumeric(String str) {
		try {
			Double.parseDouble(str);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}

	private boolean isDateValid(String date, String format) {
		try {
			DateFormat df = new SimpleDateFormat(format);
			df.setLenient(false);
			df.parse(date);
			return true;
		} catch (ParseException e) {
			return false;
		}
	}

}
