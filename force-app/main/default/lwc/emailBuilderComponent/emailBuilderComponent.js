import { LightningElement, api, wire } from 'lwc';
//import getContactName from '@salesforce/apex/GoToWebinarController.getContactName';

export default class EmailBuilderComponent extends LightningElement {
    //@api contactFirstName;

    //@api webinarList;
    //webinarListJson;
    //renderJson = false;
    //hasRendered = false;
    //msg = 'Please select a webinar';
    @api webinarInfo;//delete this
    @api
    set htmlValue(value) {
        if (this.customHtml) {
            this.customHtml.innerHTML = value;
        }
        this._htmlValue = value;
    }
    get htmlValue() {
        return this._htmlValue;
    }
    


    renderedCallback() {
        this.customHtml = this.template.querySelector('div[ishtmlcontainer=true]');
        this.customHtml.innerHTML = this.htmlValue;
    }
}