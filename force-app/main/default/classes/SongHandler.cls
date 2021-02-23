//This class is called by the trigger on the Song__c object
public class SongHandler {
	
    
    public static void afterInsert(List<Song__c> songs){
        
		SongHelper updateSubscribedPlaylists = new SongHelper(songs);
    }
    
    
   
}