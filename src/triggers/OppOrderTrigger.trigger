trigger OppOrderTrigger on Opportunity (after update) {
    //Check to see if the Stage field is changed to "Order Placed"
    if (CheckOppStage.stageChangedToPlaced(Trigger.new)){
        System.debug('Stage Placed Was True');
       PlaceOrder.checkInventory(Trigger.new);
    }
	
}