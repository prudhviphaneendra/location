@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Entity for Business Area Picklist'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGR_GRC_Business_Area_PL as select from ZR_GRC_PICKLST_P
{
    @UI.hidden: true
     key _Child.ValueId as Id,
    _Child.ListValue
}
where ListId = '100003';
