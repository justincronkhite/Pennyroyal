/**
 * Created by justincronkhite on 1/5/23.
 */

public with sharing class CheckOppStage {
    public static Boolean stageChangedToPlaced(List <Opportunity> opp){
        system.debug('CheckOppstage');
        Id stageId;
        Boolean stageName = false;

        for(Opportunity record : opp){
            stageId = record.Id;
        }
         Opportunity check = [SELECT Id, StageName FROM Opportunity WHERE Id = :stageId LIMIT 1];
        if(check.StageName == 'Order Placed'){
            stageName = true;
        }
        return stageName;
    }
}