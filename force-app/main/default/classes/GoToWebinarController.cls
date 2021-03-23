public with sharing class GoToWebinarController {
    public static String getWebinarList(String accountKey){
        return getWebinarList(accountKey, '2020-03-13T10:00:00Z', '2022-03-13T22:00:00Z');
    }
    //Make API call to GoToWebinar
    //for accountKey, read the readme.md file
    //If authentication token expires then We need to go to Named Credentials, edit GTW credentials and save it to kick off reauthenticaiton process
    //This is because, Unfortunately, GTW does not have a correct implementation to send proper error code and salesforce doesn't understand that it needs to get refresh token
    public static String getWebinarList(String accountKey, String fromTime, String toTime){
        String webinarJson = null;
        try{
            HttpRequest req = new HttpRequest();
            
            req.setEndpoint('callout:GoToWebinar_EmailBuilder_PoC/G2W/rest/v2/accounts/'+accountKey+'/webinars?fromTime='+fromTime+'&toTime='+toTime);
            req.setMethod('GET');
            //System.debug(req);
            Http http = new Http();
            HTTPResponse res = http.send(req);
            webinarJson = res.getBody();
            //System.debug(webinarJson);

        }catch(Exception e){
            System.debug('Exception:GoToWebinarController:getWebinarList(): ' + e.getMessage());
        }

        return webinarJson;
    }
/*
    @AuraEnabled
    public static string getContactName(String contactFirstName){
        System.debug('contactFirstName: ' + contactFirstName);
        return contactFirstName;
    }
    */
}