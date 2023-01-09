global class receiveParametersShip{
    webservice static String updateInventory(Integer inv, String productCode){
        List <Product2> invent = [SELECT Name, Id, Inventory__c, ProductCode FROM Product2 WHERE ProductCode = :productCode];
        for (Product2 i : invent){
        i.Inventory__c = inv;
        update invent;
            
    
    }return 'Success';
}
}