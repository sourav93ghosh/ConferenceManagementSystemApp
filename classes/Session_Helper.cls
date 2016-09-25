/* Helper class for Session object */
public class Session_Helper{

    /* Method to validate session records */
    public static void validateSessionRecords(List<Session__c> requestedSessions){
    
        Integer flag;
        List<String> sessionName = new List<String>();
        for(Session__c item: requestedSessions)
            sessionName.add(item.Name);  
             
        List<Session__c> ssn = [select Name, Date_and_Time__c, Status__c from Session__c where Name in :sessionName];       
        for(Session__c item: requestedSessions){
            flag = 0;
            for(Session__c oldItem: ssn){
                if(item.Name == oldItem.Name){
                    flag = 1;
                    item.addError('Session is already exist!');
                }
            }
            if(flag == 0){
                if(item.Date_and_Time__c < Date.TODAY().addDays(1))
                    item.addError('Session date is not valid!');
                else if(item.Status__c != 'Upcoming')
                    item.addError('Session status should be upcoming!');
            }
        }
                
    }
    
    public static void validateUpdateRecords(List<Session__c> updateReq){
        List<String> sessionName = new List<String>();
        for(Session__c item: updateReq)
            sessionName.add(item.Name);
        List<Session__c> ssn = [select Name, Date_and_Time__c, Status__c, Duration__c 
                                    from Session__c where Name in :sessionName];
        for(Session__c item: updateReq){
            for(Session__c oldItem: ssn){
                if(item.Name == oldItem.Name){
                    if(oldItem.Status__c == 'Upcoming' && item.Status__c == 'End'){
                        if(DateTime.Now() <= oldItem.Date_and_Time__c.addHours(Integer.valueOf(oldItem.Duration__c.substring(0,1)))){
                            item.addError('Incomplete session can not be updated to End!');
                        }
                    }
                    else{
                        item.addError('Invalid status for updating!');
                    }
                }
            }
        }
    }

}