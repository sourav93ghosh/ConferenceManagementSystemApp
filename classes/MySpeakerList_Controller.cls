public class MySpeakerList_Controller{

    List<Speaker__c> speakers;
    String speakerName;
    List<Speaker_Session__c> sessionsByName;
    //String errMsg;
    Boolean flag;
    Integer listSize = 5;
    Integer counter = 0;
    Boolean disabledNext;
    Boolean disabledPrev;
    Integer totalCount;
    String spNumber;
    List<Speaker__c> result;
    Boolean ren;
    
    public MySpeakerList_Controller(){
        totalCount = [select count() from Speaker__c];
    }
    
    public List<Speaker__c> getResult(){
        //String q = 'select Name, First_Name__c, Last_Name__c, Email__c from Speaker__c where Name like %' + spNumber + '%';
        //result = Database.query(q);        
        String temp = '%' + spNumber + '%';
        result = [select Name, First_Name__c, Last_Name__c, Email__c from Speaker__c where Name like :temp];
        return result;
    }
    
    public String getSpNumber(){
        return spNumber;
    }
    
    public void setSpNumber(String s){
        spNumber = s;
    }
    
    public Boolean getRen(){
        return ren;
    }
    
    public void setRen(Boolean r){
        ren = r;
    }
    
    public PageReference searchAction(){
        //setSpNumber(ApexPages.CurrentPage().getParameters().get('sp'));
        if(getResult().size() > 0)
            setFlag(true);
        else
            setFlag(false);
        setRen(true);
      //  else
      //      setRen(false);
        return null;
    }
   
    public Boolean getDisabledPrev(){
        if(counter == 0)
            return true;
        else
            return false;
    }
    public Boolean getDisabledNext(){
        if(totalCount - counter <= listSize)
            return true;
        else
            return false;
    }
    
    public PageReference nextPage(){
       /* if(speakerName != null){
            setSpeakerName(null);
            setFlag(false);
        }
        if(errMsg != null)
            setErrMsg(null);*/
        counter = counter + listSize;
        //setRen(false);
        return null;
    }
    
    public PageReference previousPage(){
        /*if(speakerName != null){
            setSpeakerName(null);
            setFlag(false);
        }
        if(errMsg != null)
            setErrMsg(null);*/
        counter = counter - listSize;
        //setRen(false);
        return null;
    }
    
    public void setFlag(Boolean f){
        flag = f;
    }
    
    public Boolean getFlag(){
        return flag;
    }
    
  /*  public void setErrMsg(String err){
        errMsg = err;
    }
    
    public String getErrMsg(){
        return errMsg;
    }*/
    
    public List<Speaker__c> getSpeakers(){
        speakers = [select Name, First_Name__c, Last_Name__c, Email__c from Speaker__c limit :listSize offset :counter];
        return speakers;
    }

    public void setSpeakerName(String spName){
        speakerName = spName;
    }
    
    public List<Speaker_Session__c> getSessionsByName(){
        sessionsByName = [select Session__r.Name, Speaker__r.Name, Session__r.Date_and_Time__c from Speaker_Session__c where Speaker__r.Name = :speakerName];
        return sessionsByName;
    }
    
   /* public PageReference assignSpeakerName(){
        speakerName = ApexPages.CurrentPage().getParameters().get('param');
        setSpeakerName(speakerName);
        List<Speaker_Session__c> s = getSessionsByName();
        if(s.size() != 0){
            setFlag(true);
            setErrMsg('');
        }
        else{
            setFlag(false);
            setErrMsg('Nothing Found!');
        }
        return null;
    }*/

}