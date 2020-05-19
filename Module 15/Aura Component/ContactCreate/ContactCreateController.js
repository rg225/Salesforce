({
    handleSuccess: function(component, event, helper) {
        component.find('notifLib').showToast({
            "variant": "success",
            "title": "Contact Created",
            "message": "Record ID: " + event.getParam("id")
        });
        var navEvt = $A.get("e.force:navigateToSObject");
		
		// To redirect on the contact record page
        navEvt.setParams({
            "recordId": event.getParam("id"),
            "slideDevName": "related"
        });
        navEvt.fire();
    },
    handleError: function(component, event, helper) {
        component.find('notifLib').showToast({
            "variant": "error",
            "title": "Error",
            "message": "Something has gone wrong!"
        });
    },

})
