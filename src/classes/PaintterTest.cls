@isTest
private class PaintterTest {
    static Id createPainterData() {
        Paintter__c paintter = new Paintter__c(
            ParentId__c = system.UserInfo.getUserId()
        );
        Insert paintter;
        return paintter.Id;
    }

    static testMethod void saveImageTest(){
        PaintterController pcon = new PaintterController();
        pcon.parentId = system.UserInfo.getUserId();
        pcon.headerId = createPainterData();
        pcon.imageData = 'data:image/png;base64,iVBORw0KGgoAA';
        Test.startTest();
        pcon.saveImage();
        Test.stopTest();
    }

    static testMethod void postChatterTest(){
        PaintterController pcon = new PaintterController();
        pcon.parentId = system.UserInfo.getUserId();
        pcon.imageData = 'data:image/png;base64,iVBORw0KGgoAA';
        Test.startTest();
        pcon.postChatter();
        Test.stopTest();
    }
}