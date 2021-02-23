trigger PlaylistSongTrigger on Playlist_Song_Junction__c (before insert, after insert, before update, after update) {
    
    if(Trigger.isInsert && Trigger.isBefore){
        PlaylistSongHandler.beforeInsert(Trigger.new);
       
    }
}