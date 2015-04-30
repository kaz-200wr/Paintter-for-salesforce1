public class PaintterController {
    Private Integer MAXLENGTH = 130000;

    Public Transient String parentId{set;get;}
    Public Transient String headerId{set;get;}
    Public Transient String imageData{set;get;}

    public PaintterController(){
    }

    public void postChatter(){
        FeedItem f = new FeedItem(ParentId=parentId, Type='ContentPost');
        f.ContentData = EncodingUtil.base64Decode(imageData.split(',', 2)[1]);
        f.ContentFileName = 'Paint_By_' + system.UserInfo.getLastname() + '. jpeg';
        f.Title = 'Paint_By_' + system.UserInfo.getLastname();
        Insert f;
    }

    public void saveImage(){
        Delete [Select Id from Attachment where ParentId =: headerId];
        Delete [select Id from PaintterData__c where Paintter__c =:headerId];

        Paintter__c updatePaintter = [Select Id, Name, ImageId__c from Paintter__c where Id =: headerId limit 1][0];

        //save to attachment
        Attachment att = new Attachment();
        att.ParentId = headerId;
        att.Body =  EncodingUtil.base64Decode(imageData.split(',', 2)[1]);  // data
        att.ContentType = 'image/png';
        att.Name = 'Paint_' + updatePaintter.Name + '_By_' + system.UserInfo.getLastname() + '.png';
        Insert att;

        //update  Paintter__c object
        updatePaintter.ImageId__c = att.Id;
        Update updatePaintter;

        //save to PaintterData__c
        Integer n = 1;
        if(imageData.length() <= MAXLENGTH){
            n = 1;
        }else{
            n = (imageData.length() / MAXLENGTH) + 1;
        }
        
        String tempStringData = imageData;
        List<PaintterData__c> imageDataList = new List<PaintterData__c>();

        for(Integer i = 0; i < n; i++){
            Integer tempMax = tempStringData.length() > MAXLENGTH ? MAXLENGTH: tempStringData.length();
            PaintterData__c tempData = new PaintterData__c(
                Paintter__c = headerId,
                Base64Data__c = tempStringData.substring(0, tempMax)
            );
            imageDataList.add(tempData);

            if(i + 1 < n){
                tempStringData = tempStringData.substring(tempMax, tempStringData.length());
            }
        }
        Insert imageDataList;
    }
    
}