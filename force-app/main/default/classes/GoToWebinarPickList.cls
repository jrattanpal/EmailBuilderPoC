global with sharing class  GoToWebinarPickList extends VisualEditor.DynamicPickList{
    
    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('Select a Webinar', 'webinar');
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        Map<String, String>  configMap = ConfigurationController.viewEmailBuilderAppSettings();
        System.debug(configMap);
        String json = GotoWebinarController.getWebinarList(configMap.get('accountKey'));
        System.debug(json);
        GoToWebinarJson r = GoToWebinarJson.parse(json);

        VisualEditor.DynamicPickListRows  myValues = new VisualEditor.DynamicPickListRows();
        if(!String.isBlank(r.int_err_code) && !String.isBlank(r.msg)){
            VisualEditor.DataRow defaultValue = new VisualEditor.DataRow(r.int_err_code, r.msg);
            myValues.addRow(defaultValue);
        }else{
            String webinarInfo;
            for(GoToWebinarJson.Webinars w: r.x_embedded.Webinars){
                webinarInfo = 'Registration URL: ' + w.registrationUrl + '<br/>==\n**';
                VisualEditor.DataRow value = new VisualEditor.DataRow(w.subject, webinarInfo);
                myValues.addRow(value);
            }
        }
        return myValues;
    }
}
