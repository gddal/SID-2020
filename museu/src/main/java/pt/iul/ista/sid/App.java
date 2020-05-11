/**
 * 
 */
package pt.iul.ista.sid;

import java.io.FileInputStream;
import java.util.Properties;

import javax.swing.JOptionPane;

/**
 *
 * Trabalho final da UC de Sistemas de Informação Distribuídos 2020
 * 
 * Grupo 23
 * 
 * Classe de entrada da Aplicação do cliente.
 *
 * @author Miguel Diaz Gonçalves 82493
 * @author Gonçalo Dias do Amaral 83380
 * @author Dmytro Astashov 74278
 * @author André Freitas 82361
 * @author Pedro Jones 82946
 * @version 0.01
 *
 */
public class App {

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		Properties pFile = new Properties();
		
		try {
			pFile.load(new FileInputStream("cloudToMongo.ini"));
			cloud_server = pFile.getProperty("cloud_server");
			cloud_topic = pFile.getProperty("cloud_topic");
			mongo_host = pFile.getProperty("mongo_host");
			mongo_database = pFile.getProperty("mongo_database");
			mongo_collection = pFile.getProperty("mongo_collection");

		} catch (Exception e) {

			System.out.println("Error reading CloudToMongo.ini file " + e);
			JOptionPane.showMessageDialog(null, "The CloudToMongo.inifile wasn't found.", "CloudToMongo",
					JOptionPane.ERROR_MESSAGE);
		}

	}

}
