/**
 * Created by justi on 1/9/2023.
 */
//Use asset IDs to assign to Inventory line items
//Patch assets with Address, Customer, Ext Opp name, Ext Opp Id 18 digit, purchase date,
global with sharing class ShipHTTP {
    private static  Cache.OrgPartition orgPart = Cache.Org.getPartition('local.DefaultPartition');
    private static String accessToken = (String)orgPart.get('token');
    //private static Datetime expires = (Datetime)orgPart.get('expires');


    private static  String getProductCodes(List <OpportunityLineItem> items){
     String codes = '';
        for(OpportunityLineItem a : items){
            codes += '"'+a.ProductCode+'",';
        }
        //codes = codes.removeEnd(',');
        return codes;
    }
    @Future(Callout=true)
        global static void sendItemsToPenny(Id opportunityId){
        List <OpportunityLineItem> incomingOrders = new List <OpportunityLineItem>();
        String prodCodes = '';
        incomingOrders = [SELECT Id, Product2Id, ProductCode, Opportunity.Case_Safe_Id__c,
                Product2.Inventory__c, Quantity, Product2.Name, Opportunity.Account.Address__c, Opportunity.Name, Opportunity.Account.Name
        FROM OpportunityLineItem
        WHERE OpportunityId = :opportunityId];
        system.debug('Incoming Orders'+incomingOrders);
        prodCodes = getProductCodes(incomingOrders);
        System.debug('ProdCodes'+prodCodes);
        prodCodes = prodCodes.removeEnd(',');
        System.debug('ProdCodes after remove end'+prodCodes);

        System.debug('HTTP Callout ShipHTTP Runing');


        System.debug('ProductCodes'+prodCodes.removeEnd(','));
        String endpoint = 'https://ship4cheap-dev-ed.develop.my.salesforce.com/services/apexrest/Asset';
        HttpRequest request = new HttpRequest();
        Http http = new Http();
        HttpResponse response;

        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type','application/json;charset=UTF-8');
        request.setHeader('Authorization','Bearer '+accessToken);
        request.setBody('{"customer" : "'+incomingOrders[0].Opportunity.Account.Name+'",' + '    "address" : "'+incomingOrders[0].Opportunity.Account.Address__c+'",' + '    "extOppName" : "'+incomingOrders[0].Opportunity.Name+'",' + '    "caseSafeOppId" : "'+incomingOrders[0].Opportunity.Case_Safe_Id__c+'",' + '    "productCodes"  : ['+prodCodes+']}');
        system.debug('THis is the request' +request);
        response = http.send(request);

        System.debug('HTTP request sent');
        System.debug('body: ' + response.getBody());

    }

}