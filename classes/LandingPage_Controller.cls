public class LandingPage_Controller{

    PageReference p;

    public PageReference ProfileToPageMapping(){
        ID profileId = UserInfo.getProfileId();
        String profileName = [select Name from Profile where Id = :profileId].Name;
        if(profileName == 'Conference User'){
            p = new PageReference('/apex/MySpeakerList');
        }
        /*else if(profileName == 'Standard Speaker'){
            p = new PageReference('/apex/SpeakerDetail?id=' + UserInfo.getUserId());
        }*/
        return p;   
    }

}