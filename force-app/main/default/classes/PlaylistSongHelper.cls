//This class is called by PlaylistSongHandler class
public class PlaylistSongHelper {
    
    private static List<Song__c> songs = new List<Song__c>();
    private static List<Playlist__c> playlists = new List<Playlist__c>();
   	private static Set<String> uniqueIdentifiers = new Set<String>();
    private static Set<String> uniqueIdentifiersFromPlaylist = new Set<String>();
    private static Map<String, Song__c> songMap = new Map<String, Song__c>();
    private static Set<String> playlistSet = new Set<String>();
    private List<Playlist_Song_Junction__c> playlistSongs = new List<Playlist_Song_Junction__c>();
    
    public PlaylistSongHelper(List<Playlist_Song_Junction__c> playlistSongs){
        		this.playlistSongs = playlistSongs;
                initializeMaps(this.playlistSongs);
        		populateSongMap();
        		getUniqueIdentifiersFromPlaylist();
    }
	
    //Method to check if the genre of the songs matches with the playlist
    public Boolean checkForMatchingGenre(){
        
        for(Playlist_Song_Junction__c record: this.playlistSongs){
            
            String songGenre = songMap.get(record.Song__c).Genre__c;
            String songTitle = songMap.get(record.Song__c).Title__c;
            
            if(!record.Genre_From_Playlist__c.contains(songGenre))
            {
                system.debug('checkForMatchingGenre FALSE');
                return false;
            }
            else {
                	record.Genre__c = songGenre;
                	record.Unique_Identifier__c = songTitle + '' + songGenre;
                	uniqueIdentifiers.add(record.Unique_Identifier__c);
            }
        }
        
        system.debug('checkForMatchingGenre uniqueIdentifiers' + uniqueIdentifiers);
        
        return true;
        
    }
    
    private static void initializeMaps(List<Playlist_Song_Junction__c> playlistSongs){
        for(Playlist_Song_Junction__c psj: playlistSongs){         
            playlistSet.add(psj.Playlist__c);
            songMap.put(psj.Song__c, new Song__c());
        }
        
        system.debug('initializeMaps playlistSet' + playlistSet);
        system.debug('initializeMaps songMap' + songMap);
    }
    
    //Method to populate the song map with Id and record
    private static void populateSongMap(){
        
        for(Song__c record : [SELECT Genre__c, Title__c, Id 
                              FROM Song__c 
                              WHERE Id 
                              IN :songMap.keySet()]){
            
			songMap.put(record.Id,record) ;           
        }
        
        system.debug('populateSongMap ' + songMap);
    }
    
    //This method gets the unique identifier (Title + Genre) from the existing playlists
    private static void getUniqueIdentifiersFromPlaylist(){
        for(Playlist_Song_Junction__c record : [SELECT Unique_Identifier__c 
                                                FROM Playlist_Song_Junction__c 
                                                WHERE Playlist__c 
                                                IN :playlistSet]){
            uniqueIdentifiersFromPlaylist.add(record.Unique_Identifier__c);
        }
        
        system.debug('getUniqueIdentifiersFromPlaylist ' + uniqueIdentifiersFromPlaylist);
    }
      
    //This methods check is the unique identifies that already exist in the playlist, conflict with the unique id that are going to be inserted
    public  Boolean checkForDuplicates(){
        for(String identifier: uniqueIdentifiers){
            if(uniqueIdentifiersFromPlaylist.contains(identifier)){
               
                system.debug('checkForDuplicates TRUE');
            	return true;
                
        	}           
        }
        system.debug('checkForDuplicates FALSE');
        return false;        
    }
}