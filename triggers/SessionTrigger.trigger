trigger SessionTrigger on Session__c (before insert, before update) {

    if(Trigger.isBefore && Trigger.isInsert){
        Session_Helper.validateSessionRecords(Trigger.new);
    }
    
    if(Trigger.isBefore && Trigger.isUpdate){
        Session_Helper.validateUpdateRecords(Trigger.new);
    }

}