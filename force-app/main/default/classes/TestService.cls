@isTest
public class TestService {
    
    //Create Bulk Contacts
    public static List<Contact> createContacts(Integer numContacts, Boolean subscriber){
        
        List<Contact> conts = new List<Contact>();
        for(Integer i = 0; i< numContacts; i++){           
                Contact cont = new Contact(LastName = 'Test' + i, Subscribe_to_new_songs__c = subscriber);   
            	conts.add(cont);
        }
        insert conts;
        return conts;        
    }
    
    //Create bulk Songs
    public static List<Song__c> createSongs(Integer numSongs, String genre){
        List<Song__c> songs = new List<Song__c>();
        for(Integer i = 0; i<numSongs; i ++){
            Song__c song = new Song__c(Name =  'Song' + i, Genre__c = genre, Singer__c = 'Singer ' + i, Title__c =  'Song' + i, Release_Date__c = Date.today() );
            songs.add(song);
        }
        insert songs;
        return songs;
    }
    
    //Create bulk playlists
    public static List<Playlist__c> createPlaylists(Integer numPlaylists, List<Contact> contacts, String genre){
        List<Playlist__c> playlist = new List<Playlist__c>();
        for(Integer i = 0; i<numPlaylists; i ++){
            Playlist__c plist = new Playlist__c(Name = 'Playlist' + i, Contact__c = contacts[i].Id, Genre_s__c = genre, Genres__c = genre);
            playlist.add(plist);
        }
        insert playlist;
        return playlist;
    }
    
    
    //create bulk playlist-song junction object
    public static List<Playlist_Song_Junction__c> addSongToPlaylist(Integer numRecs, List<Playlist__c> playlists, List<Song__c> songs){
        List<Playlist_Song_Junction__c> psjList = new List<Playlist_Song_Junction__c>();
        for(Integer i = 0; i<numRecs; i++){
            Playlist_Song_Junction__c psj = new Playlist_Song_Junction__c(Song__c = songs[i].Id, Playlist__c = playlists[i].Id);
            psjList.add(psj);
        }         
        insert psjList;
        return psjList;
    }

}