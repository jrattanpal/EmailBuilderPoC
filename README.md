## How to setup this component
- Sign up LogMeIn Developer account
- Setup AUth Provider and named credentials with following information
Used https://salesforce.stackexchange.com/questions/252277/named-credential-for-gotowebinar-app-oauth-v2-0
  - Using Client ID and Secret from LogMeIn
- Add remote site for "https://api.getgo.com"

- To get accountKey
- Go to https://myaccount.logmeininc.com/
- Login
- Click on "Go to the Admin Center"
- Get account from URL like below where "################" = accountKey
  - https://admin.logmeininc.com/portal/#accounts/################/users?filterType=usertype

- Enable "Manage list custom settings type " under "Schema Settings"


- Push source code to the org

## For packaging

- Package Components
  - Auth Provider
  - Named Credentials
  - Custom Metadata Type: EmailBuilderAppSetting
    - Create a record with "accountKey" label
  - Add Classes and LWCs





    EmailBuilderAppSettings__mdt custMeta;
EmailBuilderAppSettings__mdt[] emailBuilderAppSettings = [SELECT MasterLabel, QualifiedApiName, GTWFieldValue__c FROM EmailBuilderAppSettings__mdt];

Map<String, String> mapEmailBuilderAppSettings = new Map<String, String>(); 
for (EmailBuilderAppSettings__mdt customSetting : emailBuilderAppSettings) {
    mapEmailBuilderAppSettings.put(customSetting.MasterLabel, customSetting.GTWFieldValue__c);
    System.debug(customSetting);
}
/*
HttpRequest req = new HttpRequest();
req.setEndpoint('callout:GoToWebinar_EmailBuilder_PoC/G2W/rest/v2/accounts/5301080222163102605/webinars?fromTime=2020-03-13T10:00:00Z&toTime=2022-03-13T22:00:00Z');
req.setMethod('GET');
System.debug(req);
Http http = new Http();
HTTPResponse res = http.send(req);
System.debug(res.getBody());

*/