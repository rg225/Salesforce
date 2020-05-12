global class ContactInboundEmailXML implements Messaging.InboundEmailHandler {
    
    // To fetch the XML from mail and insert contact list
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.InboundEnvelope envelope) {
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        
        // List of all contacts 
        List<Contact> completeContactList = new List<Contact>();
               
        // Save attachments, if any
        if(email.textAttachments != null) {
            
            // Iterate the all xml files
            for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
                if(tAttachment.filename.endsWith('.xml')){
                    List<Contact> contactList = new List<Contact>();
                    contactList = XmlParse.parseXml(tAttachment.body);
                    completeContactList.addAll(contactList);
                }
            }
        }
        
        try {
            if(!completeContactList.isEmpty()){
                insert completeContactList;
                result.message = 'Contacts inserted successfuly';
            }
            result.success = true;
        } catch(DmlException e) {
            result.success = false;
            result.message = 'The following exception has occurred: ' + e.getMessage();
        }
        return result;
    }
}