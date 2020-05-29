package pt.iul.ista.sid;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.mongodb.BasicDBObject;

public class Medicao {

	private String sensor;
	private Date data;
	private Double valor;

	public Medicao(String sensor, Date data, Double valor) {
		this.sensor = sensor;
		this.data = data;
		this.valor = valor;
	}

	public Medicao(String sensor, BasicDBObject obj) throws Throwable {
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.sensor = sensor;
		this.data = formatter.parse(obj.get("dat").toString());
		this.valor = Double.valueOf(obj.get(sensor).toString());
	}

	public String getSensor() {
		return sensor;
	}

	public void setSensor(String sensor) {
		this.sensor = sensor;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public Double getValor() {
		return valor;
	}

	public void setValor(Double valor) {
		this.valor = valor;
	}

	public String datatoString(){
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(this.data);
	}
	
	public String toJSON() {
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return new BasicDBObject().append("dat", formatter.format(this.data)).append(sensor, valor.toString()).toString();
	}
	
	public String toString() {
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return "Medicao [sensor=" + sensor + ", data=" + formatter.format(this.data) + ", valor=" + valor + "]";
	}

}
