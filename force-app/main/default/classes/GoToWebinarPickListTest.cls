@isTest
private class GoToWebinarPickListTest {
    @isTest static void testGetWebinars() {
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GoToWebinarCalloutTest');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
// Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        
        GoToWebinarPickList test1 = new GoToWebinarPickList();
        test1.getValues();
        test1.getDefaultValue();
    }
    @isTest static void testGetWebinarsError() {
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GoToWebinarCalloutTestError');
        mock.setStatusCode(403);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
// Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        
        GoToWebinarPickList test1 = new GoToWebinarPickList();
        test1.getValues();
        test1.getDefaultValue();
    }
    
}