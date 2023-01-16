/**
 * Created by justi on 1/9/2023.
 */
//Use asset IDs to assign to Inventory line items
//Patch assets with Address, Customer, Ext Opp name, Ext Opp Id 18 digit, purchase date,
public with sharing class ShipHTTP {
    private static  Cache.OrgPartition orgPart = Cache.Org.getPartition('local.DefaultPartition');
    private static String accessToken = (String)orgPart.get('token');
    private static Datetime expires = (Datetime)orgPart.get('expires');

    private static Id oppId;
    private static List <OpportunityLineItem> incomingOrders;
    private static String query = 'SELECT+ProductCode,+Status+FROM+Asset+WHERE+Status=\'In+Stock\'+AND+(';

//problem to solve: how to get the first loop to just have +item.ProductCode and subsequent be prefaced with Or then to end with an )

    public static void sendItemsToShippingOrg(List <OpportunityLineItem> toOrder ) {
        incomingOrders = toOrder;
        System.debug('This is the toOrder Variable'+toOrder);
        System.debug('This is the incomingOrders Variable'+incomingOrders);
        if(String.isBlank(accessToken)|| expires == null || expires < System.now()){
            ShipAuth.run();
        }
        System.debug('Access Token from SHipHTTP cache '+accessToken);
        //
      query();
    }

    //Build a query out of the OpportunityLineItems passed in.  Pull out the product Codes.  Also Get the opportunity Id.

    private static void query(){
//        https://ship4cheap-dev-ed.develop.my.salesforce.com/services/data/v54.0/
//        query?q=SELECT+ProductCode,+Status+FROM+Asset+WHERE+
//        Status='In Stock'+AND+
//        (ProductCode='A000005'+OR+ProductCode='A000016'+OR+ProductCode='B000003'+OR+ProductCode='G000006')
        oppId = incomingOrders[0].Opportunity.Case_Safe_Id__c;
        System.debug('This si the Case safe ID'+oppId);

        for(OpportunityLineItem item : incomingOrders) {
            query += 'ProductCode='+'\''+item.ProductCode+'\''+'+OR+';
        }
        query = query.removeEnd('+OR+');
        query += ')';

        System.debug('This is the Query'+query);
        getAvailableProductsHTTP(query);
    }

//    Use the Above Query to Query the shipping org and get the ids of available assets using the productCode
    @Future(Callout=true)
        private static void getAvailableProductsHTTP(String completeQuery ){
        System.debug('HTTP Callout Runing');
        String endpoint = 'https://ship4cheap-dev-ed.develop.my.salesforce.com/services/data/v54.0/query?q='+completeQuery;
        System.debug('HttpMethod Query is '+query);
//        String body = '';
        HttpRequest request = new HttpRequest();
        Http http = new Http();
        HttpResponse response;
        request.setEndpoint(endpoint);
        request.setMethod('GET');

        request.setHeader('Content-Type','application/json;charset=UTF-8');

        request.setHeader('Authorization','Bearer '+accessToken);
//        request.setBody(body);
        response = http.send(request);
        System.debug('HTTP request sent');
        System.debug('body: ' + response.getBody());

    }
    //Parse the return from the above query



    //HTTP get inventory ID of each inventory product
//    private static void track(String accessToken, String trackingNumber, id opp) {
//
//    }
}