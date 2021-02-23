@isTest
public class PlaylistValidationTest {
	
    @isTest static void testValidation(){
        String genre = 'Jazz;Pop;Rock';
        List<String> picklist = new List<String>();
        picklist.add(genre);
        List<String> picklistWithSpace = PlaylistValidation.validateGenres(picklist);
        system.assertEquals('Jazz Pop Rock ',picklistWithSpace[0]);
    }
    
    
}