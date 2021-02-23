//This class is called by a flow when creating playlist
public class CountPlaylistGenres {

    @InvocableMethod(label='Count the number of genres selected')
    public static List<String> countGenres(List<String> genres){
		List<String> temporaryList = new List<String>();     
        temporaryList.add(String.valueOf(genres[0].split(';').size()));
        return temporaryList;
    }
    
        
}