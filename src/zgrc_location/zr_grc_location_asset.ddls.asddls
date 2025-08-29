@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Entity for Assets for the Location'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_GRC_LOCATION_ASSET as select from ZR_TGRC_ASSET
{
// @UI.lineItem: [{ position:10,
//    type: #WITH_INTENT_BASED_NAVIGATION,
//      semanticObject: 'claim0807',
//      semanticObjectAction: 'get',
//      value: 'AssetUuid', label: 'Asset Name' }]
  key AssetUuid,
  @UI.lineItem: [{ position:10, 
   type: #WITH_INTENT_BASED_NAVIGATION,
      semanticObject: 'zgrc_asset',
      semanticObjectAction: 'get',
      value: 'AssetName', label: 'Asset Name' }]
   AssetName,
   HierarchyNode,
   @UI.lineItem: [{ position:20, label: 'Type' }]
   AssetTypeP,
   @UI.lineItem: [{ position:30, label: 'Sub Type' }]
   Subtype,
   @UI.lineItem: [{ position: 40, label: 'Year Built' }]
   YearBuilt   
}
