//This class is called by the SongHandler class
public class SongHelper {
	private static Map<String, List<String>> genrePlaylistMap = new Map<String, List<String>>();
    private static Set<String> songGenres = new Set<String>();
    private static List<Playlist_Song_Junction__c> songPlaylist = new List<Playlist_Song_Junction__c>();
	private List<Song__c> songs = new List<Song__c>();
    private Set<String> subscribedPlaylists = new Set<String>();
    
    public SongHelper(List<Song__c> songs){
        this.songs = songs;
        this.subscribedPlaylists = getSubscriberPlaylists();
        getSongGenres(this.songs);
        initializeGenrePlaylistMap();
        createGenrePlaylistMap(this.subscribedPlaylists);
        linkSongsToPlaylist(this.songs);
    }
    
     //Method to get the playlists of all contacts who have subscribed to new songs
     private static Set<String> getSubscriberPlaylists(){
        Set<String> playlists = new Set<String>();
        for(Playlist__c playlist: [SELECT Id
                				   FROM Playlist__c 
                				   WHERE Contact__r.Subscribe_to_new_songs__c = true])
        {
            playlists.add(playlist.Id);
        }
        system.debug('getSubscriberPlaylists ' + playlists);
        return playlists;
    }
	
	//Initialize a map of the genre and the playlists that can accept that genre    
    private static void initializeGenrePlaylistMap(){
        for(String genre: songGenres){ 
            
            genrePlaylistMap.put(genre, new List<String>() );
        }        
        system.debug('initializeGenrePlaylistMap ' + genrePlaylistMap);
    }

    //construct a map of the genre and the playlists that can accept that genre    
    private static void createGenrePlaylistMap(Set<String> playlists){
        system.debug('playlists= ' + playlists);
        List<String> temp;
        for(Playlist_Song_Junction__c psj: [SELECT Genre__c, Playlist__c  FROM Playlist_Song_Junction__c WHERE Playlist__c IN :playlists ]){
			system.debug('psj.Genre__c ' + psj.Genre__c);
            system.debug('psj.Genre__c ' + psj.Playlist__c);
            if(genrePlaylistMap.containsKey(psj.Genre__c))
            {
                temp = genrePlaylistMap.get(psj.Genre__c);
                system.debug('temp ' + temp);
            	temp.add(psj.Playlist__c);
                system.debug('psj.Playlist__c ' + psj.Playlist__c);
            	system.debug('temp 2' + temp);
            	genrePlaylistMap.put(psj.Genre__c, temp);
            }
            
        }
        
        system.debug('createGenrePlaylistMap ' + genrePlaylistMap);
    }
    
    //Method to get all the different genres of the new songs
    private static void getSongGenres(List<Song__c> songs){
        for(Song__c song: songs){
            songGenres.add(song.Genre__c);
        }
        
        system.debug('getSongGenres ' + songGenres);
    }
    
    //Method to create a complete Playlist_Song_Junction__c record and insert it
    private static void linkSongsToPlaylist(List<Song__c> songs){
        
        for(Song__c song: songs){
            List<String> playlists = new List<String>();
            playlists = genrePlaylistMap.get(song.Genre__c);
            for(String playlist: playlists){
                Playlist_Song_Junction__c record = new Playlist_Song_Junction__c();
                //record.Genre__c = song.Genre__c;
                record.Playlist__c = playlist;
                record.Song__c = song.Id;
                
                songPlaylist.add(record);
                
            }
        }
        system.debug('linkSongsToPlaylist ' + songPlaylist);
        if(songPlaylist.size() > 0){
           insert songPlaylist; 
        }
        
        
    }
}