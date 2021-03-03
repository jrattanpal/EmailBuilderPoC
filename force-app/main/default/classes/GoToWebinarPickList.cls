global with sharing class  GoToWebinarPickList extends VisualEditor.DynamicPickList{
    
    global override Boolean isValid(Object attributeValue){
        return true;
    }


    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('Select a Webinar', 'Select a Webinar');
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        VisualEditor.DynamicPickListRows  myValues = new VisualEditor.DynamicPickListRows();

        //Make API call to GoToWebinar and get a list of webinars
        Map<String, String>  configMap = ConfigurationController.viewEmailBuilderAppSettings();
        String json = GotoWebinarController.getWebinarList(configMap.get('accountKey'));
        GoToWebinarJson r = GoToWebinarJson.parse(json);

        if(r.x_embedded == null){
            return myValues;
        }
        if(!String.isBlank(r.int_err_code) && !String.isBlank(r.msg)){
            //If authentication to GoToWebinar has expired then show error message
            //We also need to go to Named Credentials, edit GTW credentials and save it to kick off reauthenticaiton process
            //This is because, Unfortunately, GTW does not have a correct implementation to send proper error code and salesforce doesn't understand that it needs to get refresh token
            String errCode = r.int_err_code;
            String msg = r.msg;
            VisualEditor.DataRow value = new VisualEditor.DataRow(errCode, msg);
            myValues.addRow(value);
        }
        for(GoToWebinarJson.Webinars w: r.x_embedded.Webinars){
            System.debug('w.registrationUrl: ' + w.registrationUrl);
            System.debug('w.subject: ' + w.subject);
            String webinarInfo = 'Register: ' + String.valueOf(w.registrationUrl);
            String subject = String.valueOf(w.subject);
            VisualEditor.DataRow value1 = new VisualEditor.DataRow(subject, webinarInfo);
            myValues.addRow(value1);
        }
        return myValues;
        /* */
    }
}
