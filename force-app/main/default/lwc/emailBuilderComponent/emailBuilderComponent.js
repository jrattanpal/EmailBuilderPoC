import { LightningElement, api, wire } from 'lwc';

export default class EmailBuilderComponent extends LightningElement {
    renderJson = false;
    hasRendered = false;
    msg = 'Please select a webinar';
    webinarListJson;

    @api htmlValue;
    /*
    set htmlValue(value) {
        if (this.customHtml) {
            console.log('value::', value);
            this.customHtml.innerHTML = value;
        }
        this._htmlValue = value;
    }
    get htmlValue() {
        return this._htmlValue;
    }
    /**/
    


    renderedCallback() {
        //this.customHtml = this.template.querySelector('div[ishtmlcontainer=true]');
        //this.customHtml.innerHTML = this.htmlValue;

        if(this.hasRendered === false){
            if(typeof(this.htmlValue) != 'undefined'){
                //var webinarList = '{' + this.webinarList + '}';
                this.webinarListJson = JSON.parse(this.htmlValue );
                
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
    }
}