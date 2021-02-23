//This class is called by the trigger on Playlist_Song_Junction__c
public class PlaylistSongHandler {
	
    private static Boolean hasDuplicates = false;
    private static Boolean hasSameGenre = false;
    
    public static void beforeInsert(List<Playlist_Song_Junction__c> playlistSongs){
        try{
				PlaylistSongHelper helper = new PlaylistSongHelper(playlistSongs);
        		hasSameGenre = helper.checkForMatchingGenre();
        		hasDuplicates = helper.checkForDuplicates();
        }
        catch(Exception e){
            system.debug(e);
        }        
        if(!hasSameGenre ){
            throw new applicationException('That Genre cannot be added to playlist');
        }
        
        if(hasDuplicates){
            throw new applicationException('This is a duplicate song');
        }
         
        
    }
     
        
    public class applicationException extends Exception {}

}