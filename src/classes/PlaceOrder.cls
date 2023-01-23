/**
 * Created by justincronkhite on 1/5/23.
 */

public with sharing class PlaceOrder {
    private static Cache.OrgPartition orgPart = Cache.Org.getPartition('local.DefaultPartition');
    private static String accessToken = (String) orgPart.get('token');
    private static Datetime expires = (Datetime) orgPart.get('expires');
    private static List <Opportunity> opportunities = new List <Opportunity>();
    public static Id oppId;
    public static Boolean stockCheck = true;
    public static void startTransaction(List<Opportunity> opps) {

        for (Opportunity opp : opps) {
            oppId = opp.Id;
        }
       //stockCheck = PrepareItemsToShip.getLineItems(oppId);
        System.debug('oppid'+ oppId);

        opportunities = opps;
         checkAuthentication();

        if (stockCheck == true ){

        }
        ShipHTTP.sendItemsToPenny(oppId);

    }

    public static void checkAuthentication() {

        if (String.isBlank(accessToken) || expires == null || expires < System.now()) {
            ShipAuth.run();
        }

    }



}



