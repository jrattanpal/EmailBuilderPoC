global with sharing class  GoToWebinarPickList extends VisualEditor.DynamicPickList{
    
    global override Boolean isValid(Object attributeValue){
        return true;
    }


    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('Select a Webinar', '{"msg":"Select a Webinar","errCode":"selectWebinar"}');
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        VisualEditor.DynamicPickListRows  myValues = new VisualEditor.DynamicPickListRows();

        //Make API call to GoToWebinar and get a list of webinars
        Map<String, String>  configMap = ConfigurationController.viewEmailBuilderAppSettings();
        String json = GotoWebinarController.getWebinarList(configMap.get('accountKey'));
        GoToWebinarJson r = GoToWebinarJson.parse(json);

        if(r.x_embedded == null && !String.isBlank(r.int_err_code) && !String.isBlank(r.msg)){
            //If authentication to GoToWebinar has expired then show error message
            //We also need to go to Named Credentials, edit GTW credentials and save it to kick off reauthenticaiton process
            //This is because, Unfortunately, GTW does not have a correct implementation to send proper error code and salesforce doesn't understand that it needs to get refresh token
            String errCode = r.int_err_code;
            String msg = '{"msg":"' + r.msg +'","errCode":"invalidToken"}';
            VisualEditor.DataRow value = new VisualEditor.DataRow(errCode, msg);
            myValues.addRow(value);
            return myValues;
        }
        for(GoToWebinarJson.Webinars w: r.x_embedded.Webinars){
            System.debug('w: ' + w);
            w.description = w.description.replaceAll('\r\n|\n|\r',' ');

            String webinarInfoJson = '{' + 
                '"regUrl":"' + String.valueOf(w.registrationUrl) + '",' + 
                '"subject":"' + String.valueOf(w.subject) + '",' + 
                '"description":"' + String.valueOf(w.description) + '",' + 
                '"startTime":"' + String.valueOf(w.times[0].startTime) + '",' + 
                '"endTime":"' + String.valueOf(w.times[0].endTime) + '",' + 
                '"timeZone":"' + w.timeZone + '"' + 
            '}';
            System.debug('webinarInfoJson: ' + webinarInfoJson);
            //String webinarInfo = 'Register: ' + String.valueOf(w.registrationUrl) + ' <br> Test ';
            String subject = String.valueOf(w.subject);
            VisualEditor.DataRow value1 = new VisualEditor.DataRow(subject, webinarInfoJson);
            myValues.addRow(value1);
        }
        return myValues;
        /* */
    }
}
