
public class Executer {
	
	
	
	
	public static void main(String[] args) {
		SettingsLoader sl = new SettingsLoader(); //Needed to load the ini files
		MongoDBConnector mdbc = new MongoDBConnector(SettingsLoader.getmongoURI(), SettingsLoader.getdbName());
		mdbc.mongotoArrayList(SettingsLoader.getdbStrings(), SettingsLoader.getMongoIdField(), SettingsLoader.getMongoDateTimeField());
		
	}
	
	
	
}
