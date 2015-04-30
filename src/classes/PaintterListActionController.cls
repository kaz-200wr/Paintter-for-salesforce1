public with sharing class PaintterListActionController {
    public List<Paintter__c> plist{set;get;}

	public PaintterListActionController() {
		if(System.currentPageReference().getParameters().get('Id') != ''){
	        plist = [
		        Select Id, Name, ParentId__c, LastModifiedDate, CreatedDate, (Select Id from Attachments limit 1) 
		        From Paintter__c 
		        Where ParentId__c =:System.currentPageReference().getParameters().get('Id') 
		        ORDER BY LastModifiedDate DESC
	        ];
		}
	}
}