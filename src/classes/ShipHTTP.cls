/**
 * Created by justi on 1/9/2023.
 */
//Use asset IDs to assign to Inventory line items
//Patch assets with Address, Customer, Ext Opp name, Ext Opp Id 18 digit, purchase date,
public with sharing class ShipHTTP {

    private static Id oppId;
    private static List <OpportunityLineItem> incomingOrders;
    private static String query = 'SELECT+ProductCode,+Status+FROM+Asset+WHERE+Status=\'In Stock\'+AND(';
//problem to solve: how to get the first loop to just have +item.ProductCode and subsequent be prefaced with Or then to end with an )
    public static void sendItemsToShippingOrg(List <OpportunityLineItem> toOrder ) {
        incomingOrders = toOrder;
        System.debug('This is the toOrder Variable'+toOrder);
        system.debug('This is the incomingOrders Variable'+incomingOrders);
//        String accessToken = ShipAuth.run();
      query();
    }

    //Build a query out of the OpportunityLineItems passed in.  Pull out the product Codes.  Also Get the opportunity Id.
    private static void query(){
        oppId = incomingOrders[0].Opportunity.Case_Safe_Id__c;
        System.debug('This si the Case safe ID'+oppId);

        List <String> productCode;
        for(OpportunityLineItem item : incomingOrders) {
            system.debug('This is the item'+item);
            productCode.add(item.ProductCode);
        }
//        for(String pc : productCode){
//            query += pc;
//        }
        System.debug('This is the list of productCodes'+productCode);
        system.debug('This is the Query'+query);
    }

    //Use the Above Query to Query the shipping org and get the ids of available assets using the productCode
//    private static void getAvailableProductsHTTP(String accToken){
//        String endpoint = 'https://ship4cheap-dev-ed.develop.my.salesforce.com/services/data/v54.0/query?q='+query;
//        String body = '';
//        HttpRequest request = new HttpRequest();
//        Http http = new Http();
//        HttpResponse response;
//        request.setEndpoint(endpoint);
//        request.setMethod('GET');
//
//        request.setHeader('Content-Type','application/json;charset=UTF-8');
//
//        request.setHeader('Authorization','Bearer ' + accToken);
//        request.setBody(body);
//        response = http.send(request);
//        System.debug('body: ' + response.getBody());
//
//    }
    //Parse the return from the above query



    //HTTP get inventory ID of each inventory product
//    private static void track(String accessToken, String trackingNumber, id opp) {
//
//    }
}