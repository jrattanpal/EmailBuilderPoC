global with sharing class  GoToWebinarPickList extends VisualEditor.DynamicPickList{
    
    global override Boolean isValid(Object attributeValue){
        return true;
    }


    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('Select a Webinar', '<h2>Select a Webinar</h1>');
        return defaultValue;
    }
    //We need to send JSON string back. However, due to a bug in AppBuilder (EmailBuilder), DynamicPickList components do not work on save because of {} (curly bracket)
    //We will add this bracket on LWC side for now as a workaround
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
            String msg = '<h2>Error Invalid Token. Authenticate again in Named Credentials</h2>';
            VisualEditor.DataRow value = new VisualEditor.DataRow(errCode, msg);
            myValues.addRow(value);
            return myValues;
        }
        for(GoToWebinarJson.Webinars w: r.x_embedded.Webinars){
            //System.debug('w: ' + w);
            w.description = w.description.replaceAll('\r\n|\n|\r',' ');


            //String webinarInfoJson = 'Webinar Info';

            String webinarInfo = '<lightning-card>' +
                    '<h2 >' + w.subject +'</h2>' + 
                    '<p >' + w.description + '<br/><br/>' +
                    'Start ' + w.times[0].startTime  + '<br/><br/>' +
                    'End ' +  w.times[0].endTime  + '<br/><br/>' +
                '</p>' + 
                '<div >Register ' + w.registrationUrl + '</div>'+ 
            '</lightning-card>';

            webinarInfo = '<lightning-card><h2>'+w.subject+'</h2></lightning-card>';
            
            /*
            String webinarInfoJson = '' + 
                '"regUrl":"' + String.valueOf(w.registrationUrl) + '",' + 
                '"subject":"' + String.valueOf(w.subject) + '",' + 
                '"description":"' + String.valueOf(w.description) + '",' + 
                '"startTime":"' + String.valueOf(w.times[0].startTime) + '",' + 
                '"endTime":"' + String.valueOf(w.times[0].endTime) + '",' + 
                '"timeZone":"' + w.timeZone + '"' + 
            '';
            */            
            VisualEditor.DataRow value1 = new VisualEditor.DataRow(String.valueOf(w.subject), webinarInfo);
            myValues.addRow(value1);
        }
        return myValues;
        /* */
    }
}
