public class SpeakerDetail_Controller{


    ID speakerId;
    //Speaker__c speakerInfo;
    Boolean ren;
    List<Speaker_Session__c> sessionsByName;
    
    public SpeakerDetail_Controller(ApexPages.StandardController controller){}

    public void setSpeakerId(ID spId){
        speakerId = spId;
    }
    
    public void setRen(Boolean r){
        ren = r;
    }
    
    public Boolean getRen(){
        return ren;
    }
   
    public List<Speaker_Session__c> getSessionsByName(){
        sessionsByName = [select Session__r.Name, Speaker__r.Name, Session__r.Date_and_Time__c, Session__r.Status__c
                            from Speaker_Session__c where Speaker__r.ID = :speakerId];
        return sessionsByName;
    }
    
   /** public Speaker__c getSpeakerInfo(){
        speakerInfo = [select Name, First_Name__c, Last_Name__c, Email__c, Date_Of_Birth__c from Speaker__c where ID = :speakerId];
        return speakerInfo;
    }**/
    
    public PageReference assignSpeakerName(){
        speakerId = ApexPages.CurrentPage().getParameters().get('id');
        setSpeakerId(speakerId);
        if(getSessionsByName().size() > 0)
            setRen(true);
        else
            setRen(false);
        return null;
    }

}