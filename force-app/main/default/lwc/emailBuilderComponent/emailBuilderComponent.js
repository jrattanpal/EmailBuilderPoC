import { LightningElement, api, wire } from 'lwc';
//import getContactName from '@salesforce/apex/GoToWebinarController.getContactName';

export default class EmailBuilderComponent extends LightningElement {
    //@api contactFirstName;

    //@api webinarList;
    //webinarListJson;
    //renderJson = false;
    //hasRendered = false;
    //msg = 'Please select a webinar';
    
    @api
    set webinarInfo(value) {
        if (this.customHtml) {
            this.customHtml.innerHTML = value;
        }
        this._htmlValue = value;
    }
    get webinarInfo() {
        return this._htmlValue;
    }
    


    renderedCallback() {
        this.customHtml = this.template.querySelector('div[ishtmlcontainer=true]');
        this.customHtml.innerHTML = this.webinarInfo;
        /*
        if(this.hasRendered === false){
            if(typeof(this.webinarList) != 'undefined'){
                var webinarList = '{' + this.webinarList + '}';
                this.webinarListJson = JSON.parse(webinarList);
                
                if(typeof(this.webinarListJson.regUrl) != 'undefined'){
                    //If true then show Webinar information
                    this.renderJson = true;
                    //we should mark this as rendred to avoid loop
                    this.hasRendered = true;
                }else{
                    this.msg = this.webinarListJson.msg;
                    console.log('this.webinarListJson: undefined' );
                }
            }else{
                console.log('this.webinarList: undefined' );
            }
           
        }
        */
    }
}