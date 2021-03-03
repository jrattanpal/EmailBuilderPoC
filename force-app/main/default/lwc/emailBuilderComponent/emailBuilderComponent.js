import { LightningElement, api } from 'lwc';
export default class EmailBuilderComponent extends LightningElement {
    @api webinarList;
    webinarListJson;
    renderJson = false;
    hasRendered = false;
    msg = 'Please select a webinar';
    
    renderedCallback() {
        if(this.hasRendered === false){
            if(typeof(this.webinarList) != 'undefined'){
                this.webinarListJson = JSON.parse(this.webinarList);
                
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
        //this.attachmentPoint = this.template.querySelector('div[innerhost=true]');
        //this.attachmentPoint.innerHTML = this.webinarList;
    }
    /** */
}