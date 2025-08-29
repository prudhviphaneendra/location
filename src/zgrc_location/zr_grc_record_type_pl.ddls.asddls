@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Record Type Picklist'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_GRC_RECORD_TYPE_PL as select from ZR_GRC_PICKLST_P
{
     key _Child.ValueId as Id,
    _Child.ListValue
}
where ListId = '100023';
