package pt.iul.ista.sid;

import java.io.FileInputStream;
import java.util.Properties;

import javax.swing.JOptionPane;

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttMessage;

import com.mongodb.client.MongoClient;

public class MqttToMongo1 implements MqttCallback {

	public MqttToMongo1() {
		
	    MqttClient mqttclient;
	    MongoClient mongoClient;
	    
	}

	/**
	 * 
	 * connectionLost
	 * Invocado quando é perdida a ligação ao broker MQTT.
	 * 
	 */
	@Override
	public void connectionLost(Throwable cause) {
		System.out.println("Connection lost!");
		// TODO Auto-generated method stub

	}

	/**
	 * 
	 * messageArrived
	 * Invocado quando uma mensagem é recebida no topico subscrito.
	 * 
	 */
	@Override
	public void messageArrived(String topic, MqttMessage message) throws Exception {
		System.out.println("-------------------------------------------------");
		System.out.println("| Topico:" + topic);
		System.out.println("| Mensagem: " + new String(message.getPayload()));
		System.out.println("-------------------------------------------------");
	}

	/**
	 * 
	 * deliveryComplete
	 * Invocado quando uma mensagem é enviada com sucesso.
	 * 
	 */
	@Override
	public void deliveryComplete(IMqttDeliveryToken token) {
		System.out.println("-------------------------------------------------");
		System.out.println("| Mensagem: " + token.getMessage().toString());
		System.out.println("-------------------------------------------------");
		
	}

	public static void main(String[] args) {

        try {
            Properties p = new Properties();
            p.load(new FileInputStream("cloudToMongo.ini"));
            cloud_server = p.getProperty("cloud_server");
            cloud_topic = p.getProperty("cloud_topic");
            mongo_host = p.getProperty("mongo_host");
            mongo_database = p.getProperty("mongo_database");
            mongo_collection = p.getProperty("mongo_collection");
        } catch (Exception e) {

            System.out.println("Error reading CloudToMongo.ini file " + e);
            JOptionPane.showMessageDialog(null, "The CloudToMongo.inifile wasn't found.", "CloudToMongo", JOptionPane.ERROR_MESSAGE);
        }

		
	}

}
