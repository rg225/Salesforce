({
    handleSuccess: function(component, event, helper) {
        component.find('notifLib').showToast({
            "variant": "success",
            "title": "Contact Created",
            "message": "Record ID: " + event.getParam("id")
        });
        window.open('../r/Contact/' + event.getParam("id") + '/view', '_top')
    },
    handleError: function(component, event, helper) {
        component.find('notifLib').showToast({
            "variant": "error",
            "title": "Error",
            "message": "Something has gone wrong!"
        });
    },

})