public with sharing class GuitarSelect {
    Public static List<Schema.PicklistEntry> getPicklistValues(Schema.sObjectField pick){
// Retrieves active picklist values for a given object and field

     List<Schema.PicklistEntry> entries = pick.getDescribe().getPickListValues();
    // Only return active picklist values
    List<Schema.PicklistEntry> activeEntries = new List<Schema.PicklistEntry>();
    for (Schema.PicklistEntry entry : entries) {
        if (entry.isActive()) {
            activeEntries.add(entry);
        }
    }
    return activeEntries;
}
}