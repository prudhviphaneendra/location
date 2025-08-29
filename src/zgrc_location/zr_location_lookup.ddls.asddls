@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Entity for Location Lookup'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_LOCATION_LOOKUP as select from ZR_TGRC_LOCATION
{
  @EndUserText.label: 'Locations'
   key Level1Id as Location_Name,
   @EndUserText.label: 'Node Level'
    NodeLevel as Node_Level
}
