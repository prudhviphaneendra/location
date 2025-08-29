@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Entity for Policy for the Location'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_GRC_LOCATION_POLICY as select from ZR_GRC_POLICY
{
//    @UI.lineItem: [{ position:10, 
//    label: 'Policy Name' } ]
   key  PolicyUuid,
    Insured,
    @UI.lineItem: [{ position:20, 
    type: #WITH_INTENT_BASED_NAVIGATION,
      semanticObject: 'zgrc_policy',
      semanticObjectAction: 'get',
      value: 'PolicyName', label: 'Policy Name' } ]
    PolicyName,
    @UI.lineItem: [{ position:30, label: 'Policy Number' }]
    PolicyNumber,
    @UI.lineItem: [{ position:40, label: 'Policy Status' }]
    PolicyStatus,
    @UI.lineItem: [{ position:50, label: 'Insurer' }]
    Insurer
}
