public class CSVToObject_Controller{

    public Blob csvFileBody{get;set;}
    public string csvAsString{get;set;}
    public String[] csvFileLines{get;set;}
    public String[] csvFileColumns{get;set;}
    Integer fn;
    Integer ln;
    Integer email;
    public List<Speaker__c> speakerList{get;set;}
    
    public  CSVToObject_Controller(){
        csvFileLines = new String[]{};
        csvFileColumns = new String[]{};
        speakerlist = New List<Speaker__c>(); 
    }
  
    public void importData(){
       try{
           csvAsString = csvFileBody.toString();
           csvFileLines = csvAsString.split('\n'); 
           csvFileColumns = csvFileLines[0].split(',');
           for(Integer i=0;i<csvFileColumns.size();i++){
               if(csvFileColumns[i] == 'First Name')
                   fn = i;
               if(csvFileColumns[i] == 'Last Name')
                   ln = i;
               if(csvFileColumns[i] == 'Email')
                   email = i;   
           }
           
           for(Integer i=1;i<csvFileLines.size();i++){
               Speaker__c spObj = new Speaker__c();
               string[] csvRecordData = csvFileLines[i].split(',');
               spObj.First_Name__c = csvRecordData[2];             
               spObj.Last_Name__c = csvRecordData[3];
               spObj.Email__c = csvRecordData[5];                                                                           
               speakerList.add(spObj);   
           }
        insert speakerList;
        }
        catch (Exception e)
        {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');
            ApexPages.addMessage(errorMessage);
        }
       // return null;  
  }

}