@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Entity for Property for the Location'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_GRC_LOCATION_PROPERTY as select from ZR_GRC_PROPERTY
{
    
   key PropertyNo,
    @UI.lineItem: [{ position:10, 
    type: #WITH_INTENT_BASED_NAVIGATION,
      semanticObject: 'zgrc_property',
      semanticObjectAction: 'get',
      value: 'PropertyName', label: 'Property Name' }]
    PropertyName,
    InsuredName,
    @UI.lineItem: [{ position:20, label: 'Address' }]
    AddressLine1,
    @UI.lineItem: [{ position:30, label: 'City' }]
    City,
    @UI.lineItem: [{ position:40, label: 'Country' }]
    Country,
    @UI.lineItem: [{ position:50, label: 'Property ID' }]
    PropertyId,
    @UI.lineItem: [{ position:60, label: 'State' }]
    State
}
