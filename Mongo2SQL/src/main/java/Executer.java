
public class Executer {
	
	
	
	
	public static void main(String[] args) {
		SettingsLoader sl = new SettingsLoader();
		MongoDBConnector mdbc = new MongoDBConnector(SettingsLoader.getmongoURI(), SettingsLoader.getdbName());
		mdbc.mongotoArrayList();
		System.out.println(ReadingLists.filteredtrList);
		System.out.println(ReadingLists.trList);

	}
	
	
	
}
