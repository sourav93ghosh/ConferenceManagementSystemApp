public class NewSpeaker_Ext{

    Speaker__c spObj;
    String errMsg = null;
    
    public NewSpeaker_Ext(ApexPages.StandardController std){
        spObj = (Speaker__c)std.getRecord();
    }
    
    public void setErrMsg(String e){
        errMsg = e;
    }
    
    public String getErrMsg(){
        return errMsg;
    }
    
    public PageReference saveSpeaker(){
        //ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Age should be atleast 22 years!');
        try{
            insert spObj;
            setErrMsg('Successfully Saved!');
        }catch(Exception e){
            //ApexPages.addMessage(errMsg);
            setErrMsg('Error: Age should be atleast 22 years!');
        }
        return null;
    }
    
}