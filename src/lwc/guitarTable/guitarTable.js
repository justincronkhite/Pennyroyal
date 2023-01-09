import { LightningElement, wire, api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { updateRecord } from 'lightning/uiRecordApi';
import PICKUPS_FIELD from '@salesforce/schema/Product2.Pickups__c';
import HEADSTOCK_FIELD from '@salesforce/schema/Product2.Headstock__c';
import PRODUCT_FIELD from '@salesforce/schema/Product2.Name';
import SCALE_LENGTH from '@salesforce/schema/Product2.ScaleLength__c';
import MANUFACTURER_FIELD from '@salesforce/schema/Product2.Manufacturer__c';
import PRODUCT2_OBJECT from '@salesforce/schema/Product2';
import GUITAR_PICS from '@salesforce/resourceUrl/guitarSelect';
import getGuitars from '@salesforce/apex/DataHandler.getGuitars';

const COLS = [
    {
        label: 'Manufacturer',
        fieldName:  MANUFACTURER_FIELD.fieldApiName,
        editable: true
    }, 
    {
        label: 'Model',
        fieldName: PRODUCT_FIELD.fieldApiName,
        editable: true
    },
    {
        label: 'Pickups',
        fieldName: PICKUPS_FIELD.fieldApiName,
        editable: true
    },
    { 
        label: 'Headstock Style', 
        fieldName: HEADSTOCK_FIELD.fieldApiName, 
        editable: true }
   
];



export default class GuitarTable extends LightningElement {
      @api recordId;
    availableStrat;
    error;
    columns = COLS;
    @api plpickup = '';
    @api plmanufacturer = '';
    @api plheadstock = '';

    
  handleClick(){
    plpickup = 'None';
    plmanufacturer = 'None';
    plheadstock = 'None';
  }
@wire(getGuitars, {pickup: '$plpickup' ,manufacturer: '$plmanufacturer', headstock:'$plheadstock'})
    guitar;

//   ,manufacturer: '', headstock:''
}