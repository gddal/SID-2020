import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import com.mongodb.*;

import readings.TemperatureReading;

import java.util.*;

import org.bson.Document;

public class Teste {
	private static DBObject object;
	static Connection conn;
	static Statement s;
	static ResultSet rs;

	public static void main(String[] args) 
	{	
		//MongoDB
		MongoClient mongoClient1 = new MongoClient( new MongoClientURI("mongodb://root:password@127.0.0.1:27017/?authSource=admin"));

		DB db = mongoClient1.getDB("sid");
		DBCollection table = db.getCollection("temperatures");
		DBCursor cursor = table.find();
		while(cursor.hasNext()) 
		{
			//Filter data and separate into different lists
			//One Java Object per each type of sensor

			DBObject dbo = cursor.next();
			System.out.println(dbo);
			System.out.println(dbo.get("_id"));
			TemperatureReading tr = new TemperatureReading(dbo.get("_id").toString(), dbo.get("datime").toString(),Double.valueOf(dbo.get("tmp").toString())); //TODO make date tostring easier for SQL import
			System.out.println(tr);
			
		}

		
		/*
		
		//mySQL
		String SqlCommando = new String();
		int result;
		String database_password= new String();
		String database_user= new String();
		String database_connection= new String();
		int maxIdCliente = 0;
		database_password = "senha123";
		database_user = "root";
		database_connection = "jdbc:mysql://localhost/hotel";
		
		
		//SQL connection
		try
		{ 	
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn =  DriverManager.getConnection(database_connection+"?user="+database_user+"&password="+database_password);
			System.out.println("connected");
		}			
		catch (Exception e)
		{System.out.println("Server down, unable to make the connection. ");}						
		SqlCommando ="Select max(Numero_Cliente) as  Maximo from cliente;";
		
		//SQL Query
		
		try
		{ 
			
			//Iterate each list and add to corresponding MYSQL table
			s = conn.createStatement();
			rs = s.executeQuery(SqlCommando);
			while (rs.next())
			{
				maxIdCliente = rs.getInt("Maximo")+1;
			}
		 		
			SqlCommando = "Insert into Cliente (Numero_Cliente, Nome_Cliente, Tipo_Cliente) values (" + maxIdCliente + ",'novo nome', 'I');";
			result = new Integer(s.executeUpdate(SqlCommando));	
	           		
			SqlCommando ="Select Numero_Cliente, Nome_Cliente From Cliente;";
			rs = s.executeQuery(SqlCommando);
			while (rs.next())
			{
				System.out.println(rs.getString("Nome_Cliente"));
				System.out.println(rs.getInt("Numero_Cliente"));
			}		                   
			s.close();
		}	
		catch (Exception e)
		{System.out.println("Error quering  the database . " + e);}	
		
	*/
	}
	
}