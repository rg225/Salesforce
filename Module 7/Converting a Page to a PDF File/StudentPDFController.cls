public class StudentPDFController {
	public Student__c studentRecord;
    private ApexPages.StandardController setController;
    
    // Constructor
    public StudentPDFController(ApexPages.StandardController setController){
        this.setController = setController;
        this.studentRecord = (Student__c)setController.getRecord();
    }
    
    // To upsert attachment
    public void updateAttachment(){
        PageReference pdfPage = Page.StudentDetail; 
        pdfPage.getParameters().put('id',studentRecord.id);
   
        Blob pdfBlob;
        try{
            pdfBlob = pdfPage.getContentAsPDF();
        }catch(VisualforceException e) {
            pdfBlob = Blob.valueOf('Error');
        }
        
        // To add attachment
        Attachment attachment = new Attachment();       
        attachment.Body = pdfBlob;
        attachment.Name = 'Detail PDF'+Datetime.now().format('yyyy-MM-dd HH:mm');
        attachment.ParentId = studentRecord.Id;
        List<Attachment> attachmentList = [SELECT Id, ParentId FROM Attachment WHERE ParentId = :studentRecord.Id];
        if(attachmentList.size() > 0)
        {
            delete attachmentList[0];
        }
        insert attachment;
    }
}