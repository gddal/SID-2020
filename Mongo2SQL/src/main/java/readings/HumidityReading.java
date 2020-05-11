package readings;

public class HumidityReading extends Reading {
	

	private double humidity;

	
	public HumidityReading(String id, String datime, double humidity) {
		super(id,datime);
		this.humidity=humidity;

		
	}


	public double getHumidity() {
		return humidity;
	}

	
	
	
}
