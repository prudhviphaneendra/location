@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Entity for Claims for the Location'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_GRC_LOCATION_CLAIM as select from ZR_TGRC_CLAIM
{
//   @UI.lineItem: [{ position:10,
//    type: #WITH_INTENT_BASED_NAVIGATION,
//      semanticObject: 'claim0807',
//      semanticObjectAction: 'get',
//      value: 'ClaimUuid', label: 'Claim Name' }]
  key ClaimUuid,
     InsuredName,
     @UI.lineItem: [{ position:20, 
     type: #WITH_INTENT_BASED_NAVIGATION,
      semanticObject: 'zgrc_claims',
      semanticObjectAction: 'get',
      value: 'ClaimName', label: 'Claim Name' }]
     ClaimName,
     @UI.lineItem: [{ position:30, label: 'Asset' }]
     Asset,
     @UI.lineItem: [{ position:40, label: 'Date of Loss' }]
     DateOfLoss,
     @UI.lineItem: [{ position:50, label: 'Status' }]
     Status,
    
    @UI.lineItem: [{ position:60, label: 'Record Type' }]
    @ObjectModel.text.element:  ['RecType']
    @UI.textArrangement: #TEXT_ONLY
    ClaimRecType,
    _ClaimRecType_PL.Claim_RecType as RecType,
    
    
   _ClaimRecType_PL
}
