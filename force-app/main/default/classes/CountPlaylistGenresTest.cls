@isTest
public class CountPlaylistGenresTest {
	
    @isTest static void testValidation(){
        String genre = 'Jazz;Pop;Rock';
        List<String> picklist = new List<String>();
        picklist.add(genre);
        List<String> picklistWithSpace = CountPlaylistGenres.countGenres(picklist);
        system.assertEquals('3',picklistWithSpace[0]);
    }
    
    
}