/**
 * 
 */
package pt.iul.ista.sid;

import java.io.FileInputStream;
import java.util.Properties;
import java.util.Random;

import javax.swing.JOptionPane;

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;

import com.mongodb.*;
import com.mongodb.util.JSON;

/**
*
* Trabalho final da UC de Sistemas de Informacao Distribuidos 2020
* 
* Grupo 23
* 
* Classe de entrada da Aplicacao do cliente.
*
* @author Miguel Diaz Gonçalves 82493
* @author Gonçalo Dias do Amaral 83380
* @author Dmytro Astashov 74278
* @author André Freitas 82361
* @author Pedro Jones 82946
* @author Vitor Canhão 73788
* @version 0.11
*
*/
public class MqttToMongo implements MqttCallback {

	// Startup configuration file
	private static final String INI_FILE = "mqttToMongo.ini";

	private static final String INI_BROKER = "mqtt_broker";
	private static final String INI_TOPIC = "mqtt_topic";
	private static final String INI_SRV = "mongo_server";
	private static final String INI_DB = "mongo_database";
	private static final String INI_TMP = "mongo_temperature";
	private static final String INI_HUM = "mongo_humidity";
	private static final String INI_CEL = "mongo_luminosity";
	private static final String INI_MOT = "mongo_motion";
	private static final String INI_ERR = "mongo_errors";

	static String mqttBroker;
	static String mqttTopic;
	static String mongoServer;
	static String mongoDatabase;
	static String mongoTemperature;
	static String mongoHumidity;
	static String mongoLuminosity;
	static String mongoMotion;
	static String mongoErrors;

	static MqttClient mqttClient;
	static MongoClient mongoClient;

    static DB mongoDB;
    
    static DBCollection mongoTmp,mongoHum,mongoCel,mongoMov,mongoErr;
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {

		System.out.println("MQTT to Mongo");

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
			JOptionPane.showMessageDialog(null, "The " + INI_FILE + " file wasn't found.", "MqttToMongo",
					JOptionPane.ERROR_MESSAGE);
		}

		new MqttToMongo().connecMQTT();
		new MqttToMongo().connectMongo();

	}

	public void connecMQTT() {
		int i;
		try {
			i = new Random().nextInt(100000);
			mqttClient = new MqttClient(mqttBroker, "CloudToMongo_" + String.valueOf(i) + "_" + mqttTopic);
			mqttClient.connect();
			mqttClient.setCallback(this);
			mqttClient.subscribe(mqttTopic);
		} catch (MqttException e) {
			e.printStackTrace();
		}
	}

	public void connectMongo() {
		mongoClient = new MongoClient(new MongoClientURI(mongoServer));
		mongoDB = mongoClient.getDB(mongoDatabase);
		mongoTmp = mongoDB.getCollection(mongoTemperature);
		mongoHum = mongoDB.getCollection(mongoHumidity);
		mongoCel = mongoDB.getCollection(mongoLuminosity);
		mongoMov = mongoDB.getCollection(mongoMotion);
		mongoErr = mongoDB.getCollection(mongoErrors);
	}

	/**
	 * 
	 * connectionLost Invocado quando � perdida a liga��o ao broker MQTT.
	 * 
	 */
	@Override
	public void connectionLost(Throwable cause) {
		System.out.println("Connection lost!");
		// TODO Auto-generated method stub

	}

	/**
	 * 
	 * messageArrived Invocado quando uma mensagem � recebida no topico subscrito.
	 * 
	 */
	@Override
	public void messageArrived(String topic, MqttMessage message) throws Exception {
		System.out.println("-------------------------------------------------");
		System.out.println("| Message arrived");
		System.out.println("| Topico: " + topic);
		System.out.println("| Mensagem: " + message.toString());
		System.out.println("-------------------------------------------------");
		
        DBObject document = (DBObject) JSON.parse(clean(message.toString()));
        sendToMongo(document);

	}

	/**
	 * 
	 * deliveryComplete Invocado quando uma mensagem � enviada com sucesso.
	 * 
	 */
	@Override
	public void deliveryComplete(IMqttDeliveryToken token) {
		try {
			System.out.println("-------------------------------------------------");
			System.out.println("| Mensagem: " + token.getMessage().toString());
			System.out.println("-------------------------------------------------");
		} catch (MqttException e) {
			e.printStackTrace();
		}

	}
	
    public void sendToMongo(DBObject document) {
		System.out.println("-------------------------------------------------");
		System.out.println("| Message to MongoDB: "+ mongoServer);
		System.out.println("| Database: " + mongoDatabase);
		System.out.println("| Mensagem: " + document.toString());
		System.out.println("-------------------------------------------------");
    	
    }

    public String clean(String message) {
		return (message.replaceAll("\"\"", "\","));
        
    }	

}
