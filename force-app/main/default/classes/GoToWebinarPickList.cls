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

        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        /* */


        return myValues;
        
    /*

        HttpRequest req = new HttpRequest();
            
            req.setEndpoint('callout:GoToWebinar_EmailBuilder_PoC/G2W/rest/v2/accounts/'+accountKey+'/webinars?fromTime='+fromTime+'&toTime='+toTime);
            req.setMethod('GET');
            System.debug(req);
            Http http = new Http();
            HTTPResponse res = http.send(req);
            webinarJson = res.getBody();
        //VisualEditor.DataRow value ;

        
        Map<String, String>  configMap = ConfigurationController.viewEmailBuilderAppSettings();
        String json = GotoWebinarController.getWebinarList(configMap.get('accountKey'));
        GoToWebinarJson r = GoToWebinarJson.parse(json);

        System.debug(r);
        if(r.x_embedded == null){
            return myValues;
        }
        if(!String.isBlank(r.int_err_code) && !String.isBlank(r.msg)){
            String errCode = 'Invalid Token';//r.int_err_code;
            String msg = 'https://attendee.gotowebinar.com/register/6684463761998315009';//r.msg;
            VisualEditor.DataRow value = new VisualEditor.DataRow(errCode, msg);
            myValues.addRow(value);
        }
        for(GoToWebinarJson.Webinars w: r.x_embedded.Webinars){
            System.debug('w.registrationUrl: ' + w.registrationUrl);
            System.debug('w.subject: ' + w.subject);
            String webinarInfo = String.valueOf(w.registrationUrl);
            String subject = String.valueOf(w.subject);
            subject = 'Test';
            webinarInfo = 'Test 2';
            VisualEditor.DataRow value1 = new VisualEditor.DataRow(subject, webinarInfo);
            myValues.addRow(value1);
        }
        return myValues;
        /* */
    }
}
