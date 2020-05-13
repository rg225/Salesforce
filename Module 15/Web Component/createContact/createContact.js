import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import FAX_FIELD from '@salesforce/schema/Contact.Fax';

export default class LdsCreateRecord extends LightningElement {
    firstName = '';
    lastName = '';
    email = '';
    phone = '';
    fax = '';

    // Handle when input value changes
    handleFirstNameChange(event) {
        this.firstName = event.target.value;
    }
    handleLastNameChange(event) {
        this.lastName = event.target.value;
    }
    handleEmailChange(event) {
        this.email = event.target.value;
    }
    handlePhoneChange(event) {
        this.phone = event.target.value;
    }
    handleFaxChange(event) {
        this.fax = event.target.value;
    }


    // Create record 
    createContact() {
        const fields = {};
        fields[FIRSTNAME_FIELD.fieldApiName] = this.firstName;
        fields[LASTNAME_FIELD.fieldApiName] = this.lastName;
        fields[EMAIL_FIELD.fieldApiName] = this.email;
        fields[PHONE_FIELD.fieldApiName] = this.phone;
        fields[FAX_FIELD.fieldApiName] = this.fax;
        const recordInput = { apiName: CONTACT_OBJECT.objectApiName, fields };
        createRecord(recordInput)
            .then(contact => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact created',
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }
}