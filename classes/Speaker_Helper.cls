/* Helper class for speaker object */
public class Speaker_Helper{

    /* Method to validate date of birth of speakers */
    public static void validateDOB(List<Speaker__c> speakers){
    
        //ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Age should be atleast 22 years!');
        for(Speaker__c sp: speakers){
            if(Date.TODAY().addYears(-22) < sp.Date_Of_Birth__c)
                sp.addError('Age should be atleast 22 years!');
                //ApexPages.addMessage(msg);
        }
        
    }
    
}