package readings;

public class TemperatureReading extends Reading {
	

	private double temperature;

	
	public TemperatureReading(String id, String datime, double temperature) {
		super(id,datime);
		this.temperature=temperature;

		
	}


	@Override
	public String toString() {
		return "TemperatureReading [temperature=" + temperature + " " + super.toString() + "]";
	}

	
	
	
}
