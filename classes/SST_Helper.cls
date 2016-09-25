/* Helper class for SpeakerSessionTrigger */
public class SST_Helper {

    private static List<ID> speakerSessionIds = new List<ID>();
    private static List<Speaker_Session__c> speakerSessionList;
    private static Set<ID> speakerIds = new Set<ID>();
    private static List<Session__c> sessionTSD = new List<Session__c>();
    private static Map<ID, DateTime> requestBooking= new Map<ID, DateTime>();
    private static Map<ID, String> requestBookingStatus= new Map<ID, String>();
    private static Map<ID, Integer> requestBookingDuration= new Map<ID, Integer>();
    
    public static void setEmailContent_AND_Send (List<Speaker_Session__c> seps){
        
        /* Fetching the Speaker Session record Ids */
        for(Speaker_Session__c item: seps){
            speakerSessionIds.add(item.ID);
        }
        
        /* To get the details of all records */
        speakerSessionList = [select Speaker__r.First_Name__c, Speaker__r.Email__c,
                            Session__r.Name, Session__r.Date_and_Time__c, Session__r.Description__c 
                            from Speaker_Session__c where ID in :speakerSessionIds];
        
        /* Set email content & send email */                  
        if(speakerSessionList.size() > 0){
            for(Speaker_Session__c item: speakerSessionList){
                if(item.Speaker__r.Email__c != null){
                    String address = item.Speaker__r.Email__c;
                    String subject = 'Regarding: Speaker Confirmation';
                    String body = 'Hi ' + item.Speaker__r.First_Name__c + ',\n' +
                                'Greetings. \n' +
                                'Please find the detail for the Session for which you have been assigned below: \n' +
                                'Session Name: ' + item.Session__r.Name + '\n' +
                                'Date & Time: ' + item.Session__r.Date_and_Time__c + '\n' +
                                'Description: ' + item.Session__r.Description__c + '\n' +
                                'Thanks,\n' +
                                'Admin';
                    ConferenceUtil.sendEmail(address, subject, body);
                }
            }
        }
        
    }
    
    public static void validateDuplicateBooking(List<Speaker_Session__c> seps){
        
        /* To get the new Speaker Ids */
        for(Speaker_Session__c item: seps){
            speakerIds.add(item.Speaker__c);
            requestBooking.put(item.Session__c, null);
            requestBookingStatus.put(item.Session__c, null);
            requestBookingDuration.put(item.Session__c, null);
        }
        
        /* To get the time for Session */
        sessionTSD = [select ID, Date_and_Time__c, Status__c, Duration__c
                          from Session__c where ID in :requestBooking.keySet()];
        
        /* Create Map for sessionTime */
        for(Session__c ssn: sessionTSD){
            requestBooking.put(ssn.ID, ssn.Date_and_Time__c);
            requestBookingStatus.put(ssn.ID, ssn.Status__c);
            requestBookingDuration.put(ssn.ID, Integer.valueOf(ssn.Duration__c.substring(0,1)));
        }
        
        /* To get the details of all old records */
        speakerSessionList = [select Speaker__c, Session__r.Date_and_Time__c, Session__r.Duration__c
                                    from Speaker_Session__c where Speaker__c in :speakerIds];
        
        /* Checking whether the speaker is booked or not */
        for(Speaker_Session__c item: seps){
            if(requestBookingStatus.get(item.Session__c) == 'End'){
                    item.addError('Can not choose a complete session!');
            }else{
            for(Speaker_Session__c oldItem: speakerSessionList){                                
                if(item.Speaker__c == oldItem.Speaker__c && 
                    (requestBooking.get(item.Session__c) >= oldItem.Session__r.Date_and_Time__c &&
                        requestBooking.get(item.Session__c) <= oldItem.Session__r.Date_and_Time__c.addHours(Integer.valueOf(oldItem.Session__r.Duration__c.substring(0,1))))
                       || 
                       (requestBooking.get(item.Session__c).addHours(requestBookingDuration.get(item.Session__c)) >= oldItem.Session__r.Date_and_Time__c &&
                        requestBooking.get(item.Session__c).addHours(requestBookingDuration.get(item.Session__c)) <= oldItem.Session__r.Date_and_Time__c.addHours(Integer.valueOf(oldItem.Session__r.Duration__c.substring(0,1))))
                       ){
                    item.addError('Speaker is already booked');
                }
            }  }        
        }
        
    }
    
}