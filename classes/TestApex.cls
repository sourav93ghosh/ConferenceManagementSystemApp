public class TestApex{
    /*String testVar;
    public void setTestVar(String t){
        testVar = t;
    }
    public String getTestVar(){
        return testVar;
    }
    public PageReference doSomething(){
        testVar = ApexPages.CurrentPage().getParameters().get('prm');
        setTestVar(testVar);
        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Message: ' + testVar));
        return null;
    }*/
    
   /* public static void send(String emailRecipient, String emailSubject, String emailBody){

        SendGrid sendgrid = new SendGrid('ghoshs10', '7Justchl');
        SendGrid.Email email = new SendGrid.Email();
        email.addTo(emailRecipient);
        email.setFrom('admin@self.com');
        //email.setFromName(user.Name);
        email.setSubject(emailSubject);
        email.setText(emailBody);
        //email.setHtml(emailBody.trim());
        //email.addAttachmentStream(“attachment.pdf”, att);
        sendgrid.send(email);
    }*/
    
    //Boolean flag;
    String text;   
    public void setText(String t){
        text = t;
    }
    public String getText(){
        return text;
    }
    public PageReference test(){
        setText(ApexPages.CurrentPage().getParameters().get('prm'));
        //setText('Hello');
        return null;
    } 
    
}