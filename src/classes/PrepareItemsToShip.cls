/**
 * Created by justincronkhite on 1/22/23.
 */

public with sharing class PrepareItemsToShip {
    private static List <OpportunityLineItem> itemsToShip = new List <OpportunityLineItem>();

    public static Boolean getLineItems(Id opp){


        itemsToShip = [SELECT Id, Product2Id, ProductCode, Opportunity.Case_Safe_Id__c,
                Product2.Inventory__c, Quantity, Product2.Name, Opportunity.Account.ShippingAddress
        FROM OpportunityLineItem
        WHERE OpportunityId = :opp];
        return checkInventory();

    }
    public static Boolean checkInventory() {
        List <OpportunityLineItem> inStock = new List <OpportunityLineItem>();
         Boolean areAvailable = false;
        //Check inventory of products
        for (OpportunityLineItem item : itemsToShip) {
            if (item.Product2.Inventory__c >= item.Quantity) {
                inStock.add(item);
            } else {
                new InventoryException('There are not enough ' + item.Product2.Name + ' in Stock');
            }
        }
        if (itemsToShip.size() == inStock.size()){
            areAvailable = true;
        }
        return areAvailable;
    }
}