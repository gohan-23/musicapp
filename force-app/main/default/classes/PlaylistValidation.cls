//This class is called by a flow when creating playlist
global class PlaylistValidation {
    
    @InvocableMethod(label='Convert the picklist into string')
    public static List<String> validateGenres(List<String> genres){
		List<String> temporaryList = new List<String>();
        String genresString = '';  
        for(String genre: genres[0].split(';')){
            genresString = genresString + genre + ' ';
        }       
        temporaryList.add(genresString);
        return temporaryList;
    }
    
        
}