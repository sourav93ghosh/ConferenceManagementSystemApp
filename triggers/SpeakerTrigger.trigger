trigger SpeakerTrigger on Speaker__c (before insert) {

    if(Trigger.isBefore && Trigger.isInsert){
        Speaker_Helper.validateDOB(Trigger.new);
    }

}