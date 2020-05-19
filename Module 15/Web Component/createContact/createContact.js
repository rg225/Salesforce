import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_SCHEMA from './constants';

export default class ContactComponent extends NavigationMixin(LightningElement) {
    contactRecord = CONTACT_SCHEMA;

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: "Contact Created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(evt);

        // To redirect on the contact record page
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                objectApiName: 'Contact',
                actionName: 'view',
            },
        });

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
