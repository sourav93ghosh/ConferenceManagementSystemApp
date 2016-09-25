public class NewSession_Ext{

    Session__c snObj;
    String errMsg = null;
    
    public NewSession_Ext(ApexPages.StandardController std){
        snObj = (Session__c)std.getRecord();
    }
    
    public void setErrMsg(String e){
        errMsg = e;
    }
    
    public String getErrMsg(){
        return errMsg;
    }
    
    public PageReference saveSession(){
        //ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Age should be atleast 22 years!');
        try{
            insert snObj;
            setErrMsg('Successfully Saved!');
        }catch(Exception e){
            //ApexPages.addMessage(errMsg);
            setErrMsg('Error: ' + e);
        }
        return null;
    }
    
}