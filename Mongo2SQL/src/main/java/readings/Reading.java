package readings;

public abstract class Reading {
	
	private String id;
	private String datime;
	
	
	public Reading(String id, String datime) {
		this.id=id;
		this.datime=datime;
		
	}


	@Override
	public String toString() {
		return "Reading [id=" + id + ", datime=" + datime + "]";
	}

}
