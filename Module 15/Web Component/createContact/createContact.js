import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_SCHEMA from './constants';

export default class ContactComponent extends LightningElement {
    contactRecord = CONTACT_SCHEMA;

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: "Contact created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(evt);
        window.open('../r/Contact/' + event.detail.id + '/view', '_top');
    }
    handleError(event) {
        const evt = new ShowToastEvent({
            title: "Contact creation Failed",
            message: "Failed ",
            variant: "error"
        });
        this.dispatchEvent(evt);
    }
}