/**
 * Created by justincronkhite on 1/5/23.
 */

public with sharing class PlaceOrder {

    private static Id oppId;
    private static List <OpportunityLineItem> itemsToShip = new List <OpportunityLineItem>();

    //Get the opportunity Line items from the Opportunity
    public static void getLineItems(List <Opportunity> Opps){
        //Get the Opportunity Id
        for (Opportunity opp : Opps) {
            oppId = opp.Id;
        }
        itemsToShip = [SELECT Id, Product2Id, ProductCode, OpportunityId,
                 Product2.Inventory__c, Quantity, Product2.Name
            FROM OpportunityLineItem
            WHERE OpportunityId = :oppId];
        checkInventory();
    }

    public static void checkInventory() {
        List <OpportunityLineItem> inStock = new List <OpportunityLineItem>();
        //Check inventory of products
        for (OpportunityLineItem item : itemsToShip){
            if (item.Product2.Inventory__c >= item.Quantity){
                inStock.add(item);
                 //Do I need to do a Boolean here? Set some Variable to True?  Maybe add to another list of things that are in stock?
            }else{
                new InventoryException('There are not enough '+ item.Product2.Name+' in Stock');
            }
    //Call The HTTP Request feeding in the inStock List
        }
    }
}


