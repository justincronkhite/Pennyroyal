public with sharing class DataHandler {
        @AuraEnabled(cacheable=true)
    public static List<Product2> getGuitars(String manufacturer, String pickup, String headstock) {
if ((manufacturer == '') || (manufacturer == 'None')){
    manufacturer ='%';
}
if ((pickup == '') || (pickup =='None')){
    pickup = '%';
}
if ((headstock == '')|| (headstock =='None')){
    headstock = '%';
}


        return[
            SELECT id, Manufacturer__c, Name, Pickups__c, Headstock__c FROM Product2 
            WHERE Manufacturer__c LIKE :manufacturer
            AND Pickups__c LIKE :pickup
            AND Headstock__c LIKE :headstock
            WITH SECURITY_ENFORCED
        ];
    }
}