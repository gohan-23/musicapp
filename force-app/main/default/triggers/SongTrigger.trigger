trigger SongTrigger on Song__c (before insert, after insert, before update, after update) {
		
    if(Trigger.isInsert && Trigger.isAfter){
        SongHandler.afterInsert(Trigger.new);
        
    }
}