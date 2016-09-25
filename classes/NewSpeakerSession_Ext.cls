public class NewSpeakerSession_Ext{

    Speaker_Session__c spsObj;
    String errMsg = null;
    
    public NewSpeakerSession_Ext(ApexPages.StandardController std){
        spsObj = (Speaker_Session__c)std.getRecord();
    }
    
    public void setErrMsg(String e){
        errMsg = e;
    }
    
    public String getErrMsg(){
        return errMsg;
    }
    
    public PageReference saveAssignee(){
        //ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Age should be atleast 22 years!');
        try{
            insert spsObj;
            setErrMsg('Successfully Saved!');
        }catch(Exception e){
            //ApexPages.addMessage(errMsg);
            setErrMsg('Error: ' + e);
        }
        return null;
    }
    
}