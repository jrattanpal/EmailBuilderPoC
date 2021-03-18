import { LightningElement, api, wire } from 'lwc';

export default class EmailBuilderComponent extends LightningElement {
    @api
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
    


    renderedCallback() {
        this.customHtml = this.template.querySelector('div[ishtmlcontainer=true]');
        this.customHtml.innerHTML = this.htmlValue;
    }
}