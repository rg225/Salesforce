({
    doSave: function(component, event, helper) {
        var action = component.get("c.createContact");

        // To validate inputs
        var validContact = component.find('contactform').reduce(function(validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);

        if (validContact) {
            // Create the new contact
            var contactList = component.get("v.contactList");
            action.setParams({ 'contObj': component.get('v.contactObj') });
            action.setCallback(this, function(data) {
                component.set('v.contactName', data.getReturnValue())
                contactList.splice(0, 0, component.get('v.contactObj'));
                component.set("v.contactList", contactList);
            });
            $A.enqueueAction(action);
        }
    },

    // To fetch contact list and add into Contact array
    showContacts: function(component, event, helper) {
        var action = component.get("c.retrieveContacts");
        action.setCallback(this, function(data) {
            component.set('v.contactList', data.getReturnValue())
        });
        $A.enqueueAction(action);
    }
})