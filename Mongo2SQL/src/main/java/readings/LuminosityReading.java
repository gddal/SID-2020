package readings;

public class LuminosityReading extends Reading {
	

	private int Luminosity;

	
	public LuminosityReading(String id, String datime, int Luminosity) {
		super(id,datime);
		this.Luminosity=Luminosity;

		
	}


	public int getLuminosity() {
		return Luminosity;
	}

	
	
	
}
