public with sharing class ConfigurationController {
    public static Map<String, String> viewEmailBuilderAppSettings() {

        Map<String, String> mapEmailBuilderAppSettings = new Map<String, String>(); 

        List<EmailBuilderAppSettings__mdt> emailBuilderAppSettings =  new List<EmailBuilderAppSettings__mdt>();
        
        try{
            emailBuilderAppSettings = [SELECT MasterLabel, QualifiedApiName, GTWFieldValue__c FROM EmailBuilderAppSettings__mdt WITH SECURITY_ENFORCED];
        
            for (EmailBuilderAppSettings__mdt customSetting : emailBuilderAppSettings) {
                mapEmailBuilderAppSettings.put(customSetting.MasterLabel, customSetting.GTWFieldValue__c);
            }
        }catch(Exception e){
            System.debug('Exception:ConfigurationController:viewEmailBuilderAppSettings(): ' + e.getMessage());
        }
        return mapEmailBuilderAppSettings;
    }
}