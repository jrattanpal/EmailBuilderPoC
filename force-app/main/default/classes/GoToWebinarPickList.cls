global with sharing class  GoToWebinarPickList extends VisualEditor.DynamicPickList{
    
    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('Select a Webinar', 'Select a Webinar');
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        VisualEditor.DynamicPickListRows  myValues = new VisualEditor.DynamicPickListRows();


        String subject1 = 'Sample Webinar 1';
        String description1 = 'https://1attendee.gotowebinar.com/register/6684463761998315009';
        VisualEditor.DataRow value = new VisualEditor.DataRow(subject1, description1);
        myValues.addRow(value);

        Map<String, String>  configMap = ConfigurationController.viewEmailBuilderAppSettings();
        String json = GotoWebinarController.getWebinarList(configMap.get('accountKey'));
        GoToWebinarJson r = GoToWebinarJson.parse(json);

        if(r.x_embedded == null){
            return myValues;
        }
        if(!String.isBlank(r.int_err_code) && !String.isBlank(r.msg)){
            String errCode = 'Invalid Token';//r.int_err_code;
            String msg = 'https://attendee.gotowebinar.com/register/6684463761998315009';//r.msg;
            value = new VisualEditor.DataRow(errCode, msg);
            myValues.addRow(value);
        }
        for(GoToWebinarJson.Webinars w: r.x_embedded.Webinars){
            String webinarInfo = String.valueOf(w.registrationUrl);
            String subject = String.valueOf(w.subject);
            value = new VisualEditor.DataRow(subject, webinarInfo);
            myValues.addRow(value);
        }
        return myValues;
        /* */
    }
}
