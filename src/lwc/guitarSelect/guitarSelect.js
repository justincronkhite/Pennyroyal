import { LightningElement, wire, api} from 'lwc';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import HEADSTOCK_FIELD from '@salesforce/schema/Product2.Headstock__c';
import PICKUPS_FIELD from '@salesforce/schema/Product2.Pickups__c'
import MANUFACTURER_FIELD from '@salesforce/schema/Product2.Manufacturer__c';
import PRODUCT2_OBJECT from '@salesforce/schema/Product2';
import GUITAR_PICS from '@salesforce/resourceUrl/guitarSelect';




export default class GuitarSelect extends LightningElement {
    d18 = {pic: GUITAR_PICS + '/guitarSelect/D18.png',manufacturer:'Martin', pickup: 'Humbuckers', headStock: '3+3', getClass: this.template.querySelector("d18")}
    dot = {pic: GUITAR_PICS + '/guitarSelect/Dot.png',manufacturer:'Epiphone', pickup:'Humbuckers', headStock: '3+3', getClass: function () {return this.template.querySelector(".dot")}}
    explorer = {pic: GUITAR_PICS + '/guitarSelect/Explorer.png',manufacturer:'Gibson', pickup:'Humbuckers', headStock: 'Inline', getClass: function () {return this.template.querySelector(".explorer")}}
    iceman = {pic: GUITAR_PICS + '/guitarSelect/Iceman.png',manufacturer:'Ibanez', pickup:'Humbuckers', headStock: 'Inline', getClass: function () {return this.template.querySelector(".iceman")}}
    jaguar = {pic:GUITAR_PICS + '/guitarSelect/Jaguar.png',manufacturer:'Fender', pickup:'Single Coil', headStock: 'Inline', getClass: function () {return this.template.querySelector(".jaguar")}}
    jazzMaster = {pic: GUITAR_PICS + '/guitarSelect/JazzMaster.png',manufacturer:'Fender', pickup:'Single Coil', headStock: 'Inline', getClass: function () {return this.template.querySelector(".jazzMaster")}}
    kH2 = {pic: GUITAR_PICS + '/guitarSelect/KH2.png',manufacturer:'ESP', pickup:'Humbuckers', headStock: 'Inline', getClass: function () {return this.template.querySelector(".kH2")}}
    lesPaul = {pic: GUITAR_PICS + '/guitarSelect/LesPaul.png',manufacturer:'Gibson', pickup:'Humbuckers', headStock: '3+3', getClass: function () {return this.template.querySelector(".lesPaul")}}
    lPCustom = {pic: GUITAR_PICS + '/guitarSelect/LPCustom.png',manufacturer:'Gibson', pickup:'Humbuckers', headStock: '3+3', getClass: function () {return this.template.querySelector(".lPCustom")}}
    lPStandard = {pic: GUITAR_PICS + '/guitarSelect/LPStandard.png',manufacturer:'Gibson', pickup:'Humbuckers', headStock: '3+3',getClass: function () {return this.template.querySelector(".lPStandard")}}
    rampage = {pic: GUITAR_PICS + '/guitarSelect/Rampage.png',manufacturer:'G&L', pickup:'Humbuckers', headStock: 'Inline', getClass:function () {return this.template.querySelector(".rampage")}}
    s100 = {pic: GUITAR_PICS + '/guitarSelect/S100.png',manufacturer:'Guild', pickup:'Humbuckers', headStock: '3+3', getClass: function () {return this.template.querySelector(".s100")}}
    tele = {pic: GUITAR_PICS + '/guitarSelect/Tele.png',manufacturer:'Fender', pickup:'Single Coil', headStock: 'Inline', getClass: function () {return this.template.querySelector(".tele")}}

    //Set variables for picklists
    @api selectedHeadstock = ''
    @api selectedPickups = ''
    @api selectedManufacturer = ''
    headstockOptions=[]
    pickupsOptions=[]
    manufacturerOptions=[]
 
//Get the object info for the product2 object
    @wire(getObjectInfo,{objectApiName: PRODUCT2_OBJECT})
    objectInfo

    generatePicklist(data){
            return data.values.map(item=> ({label: item.label, value: item.value}))
    }  

 //Get picklist values for the Pickups field  
 @wire(getPicklistValues, {recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: PICKUPS_FIELD})
 pickupsPicklist({data, error}){
     if(data){
         console.log(data)

         this.pickupsOptions = [...this.generatePicklist(data)]
     }
     if(error){
         console.error(error)
     }
 }
 handlePickupsChange(e) {
     this.selectedPickups = e.detail.value;
     console.log(this.selectedPickups)
   

 }



  //Get picklist values for the Manufacturer field  
  @wire(getPicklistValues, {recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: MANUFACTURER_FIELD})
  manufacturerPicklist({data, error}){
      if(data){
          console.log(data)

          this.manufacturerOptions = [...this.generatePicklist(data)]
      }
      if(error){
          console.error(error)
      }
  }
  handleManufacturerChange(e) {
      this.selectedManufacturer = e.detail.value;
    console.log(typeof this.selectedManufacturer)
     
  }


    //Get the picklist values for the Fretboard Radius Field
    @wire(getPicklistValues, {recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: HEADSTOCK_FIELD})
        fretboardPicklist({data, error}){
            if(data){
                console.log(data)

                this.headstockOptions = [...this.generatePicklist(data)]
            }
            if(error){
                console.error(error)
            }
        }
        handleHeadstockChange(e) {
            this.selectedHeadstock = e.detail.value;
            console.log(this.selectedHeadstock)
     
    
        
}
}