trigger SpeakerSessionTrigger on Speaker_Session__c (after insert, before insert, before update) {

    if((Trigger.isBefore && Trigger.isInsert) || (Trigger.isBefore && Trigger.isUpdate)){
        SST_Helper.validateDuplicateBooking(Trigger.new);
    }
    
    if(Trigger.isAfter && Trigger.isInsert){
        SST_Helper.setEmailContent_AND_Send(Trigger.new);        
    }

}