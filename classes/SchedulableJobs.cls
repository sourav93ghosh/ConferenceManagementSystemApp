global class SchedulableJobs implements Schedulable{

    global void execute(SchedulableContext sc){
        automateBirthdayNotification();
    }
    
    /* Automate the Birthday notification */
    public void automateBirthdayNotification(){
        
        String address;
        String subject;
        String body;
        List<Speaker__c> speakers = [select First_Name__c, Last_Name__c, Email__c, Date_Of_Birth__c
                                        from Speaker__c where Date_Of_Birth__c != null];
        for(Speaker__c sp: speakers){
            if(Date.TODAY() == sp.Date_Of_Birth__c){
                address = sp.Email__c;
                subject = 'Birthday Wish!';
                body = 'Hi ' + sp.First_Name__c + ' ' + sp.Last_Name__c + ',\n' +
                            'Wish you a very happy Birthday. God bless you. Enjoy! :-) \n' +
                            'Thanks, \n' +
                            'Admin';
                ConferenceUtil.sendEmail(address, subject, body);
            }
        }                                
        
    }

}