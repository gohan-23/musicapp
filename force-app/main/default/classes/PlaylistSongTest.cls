@isTest
public class PlaylistSongTest {
	
    @testsetup
    public static void createTestData(){
        List<Contact> contacts = TestService.createContacts(5,true);
        List<Playlist__c> playlists = TestService.createPlaylists(5, contacts, 'Pop');
        List<Song__c> popSongs = TestService.createSongs(5, 'Pop');
        List<Song__c> rockSongs = TestService.createSongs(5, 'Rock');
    }
    
    @istest
    public static void addSongToPlaylistTest(){
        Test.startTest();
        List<Playlist__c> playlists = [SELECT Name, Id, Contact__c, Genres__c FROM Playlist__c];
        List<Song__c> popSongs = [SELECT Name, Id, Genre__c, Singer__c, Release_Date__c FROM Song__c WHERE Genre__c = 'Pop'];
        List<Song__c> rockSongs = [SELECT Name, Id, Genre__c, Singer__c, Release_Date__c FROM Song__c WHERE Genre__c = 'Rock'];
//        List<Playlist_Song_Junction__c> = TestService.addSongToPlaylist(5, playlists, songs);
		List<Playlist_Song_Junction__c> psjList = new List<Playlist_Song_Junction__c>();
        for(Integer i = 0; i<5; i++){
            Playlist_Song_Junction__c psj = new Playlist_Song_Junction__c(Song__c = popSongs[i].Id, Playlist__c = playlists[i].Id);
            psjList.add(psj);
        }         
        insert psjList;
        system.assertEquals(5, psjList.size());
        
        //Adding duplicates
		List<Playlist_Song_Junction__c> psjList2 = new List<Playlist_Song_Junction__c>();
        for(Integer i = 0; i<5; i++){
            Playlist_Song_Junction__c psj = new Playlist_Song_Junction__c(Song__c = popSongs[i].Id, Playlist__c = playlists[i].Id);
            psjList.add(psj);
        }         
        insert psjList2;
        
        //Adding wrong genre
		List<Playlist_Song_Junction__c> psjList3 = new List<Playlist_Song_Junction__c>();
        for(Integer i = 0; i<5; i++){
            Playlist_Song_Junction__c psj = new Playlist_Song_Junction__c(Song__c = rockSongs[i].Id, Playlist__c = playlists[i].Id);
            psjList.add(psj);
        }         
        insert psjList3;
        Test.stopTest();
    }
}