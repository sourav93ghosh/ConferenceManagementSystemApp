public class MySessionList_Controller{

    List<Session__c> sessions;
    Integer listSize = 5;
    Integer counter = 0;
    Boolean disabledNext;
    Boolean disabledPrev;
    Integer totalCount;
    String errMsg;
    String sName;

    public MySessionList_Controller(){
        totalCount = [select count() from Session__c];
    }
    
    public void setErrMsg(String err){
        errMsg = err;
    }
    
    public String getErrMsg(){
        return errMsg;
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
        counter = counter + listSize;
        if(errMsg != null)
            setErrMsg('');
        return null;
    }
    
    public PageReference previousPage(){
        counter = counter - listSize;
        if(errMsg != null)
            setErrMsg('');
        return null;
    }
    
    public List<Session__c> getSessions(){
        sessions= [select Name, Date_and_Time__c, Description__c, Duration__c, Level__c, Status__c 
                        from Session__c limit :listSize offset :counter];
        return sessions;
    }
    
    public PageReference updateReq(){
        sName = ApexPages.CurrentPage().getParameters().get('prm');                                                                                                                                                                                                                                                                                               
        try{
            for(Session__c s: sessions){
                if(s.Name == sName){
                    update s;
                    break;
                }
            }       
            setErrMsg('Successfully updated!');
        }
        catch(Exception e){
            setErrMsg('Error: ' + e);
        }
        return null;
    }

}