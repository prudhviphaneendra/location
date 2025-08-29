@Metadata.allowExtensions: true
@EndUserText.label: '   '
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_TGRC_LOCATION
  provider contract transactional_query
  as projection on ZR_TGRC_LOCATION
{
  key LocationUuid,
  Level1Id,
  AddressLine1,
  AddressLine2,
  @UI.hidden: #(HideAllowAgreedValueInput)
  AllowAgreedValueInput,
   @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideAllowAgreedValueInput :abap_boolean, 
    @UI.hidden: #(HideBim)
  Bim,
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideBim :abap_boolean, 
   @UI.hidden: #(HideBimDate)
  BimDate,
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideBimDate :abap_boolean, 
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_HIDE_FIELDS'
//  virtual testField :abap_boolean,
   @UI.hidden: #(HideBrand)
     @Consumption.valueHelpDefinition: [{ entity: { name: 'ZR_LOCATION_LOOKUP', element: 'Location_Name' }, useForValidation: true}]
  Brand,
   @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideBrand :abap_boolean, 
 
//  @ObjectModel.text.element: [ 'Value' ]
//  @ObjectModel.text.association: '_Picklist'
//  @UI.textArrangement: #TEXT_ONLY  
//  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZGR_GRC_Business_Area_PL', element: 'Id' } }]
//  @Search.defaultSearchElement: true
//      @Search.fuzzinessThreshold: 0.8
//  @ObjectModel.text.element: [ 'Value' ]
//  @ObjectModel.text.association: '_Picklst'
//  @UI.textArrangement: #TEXT_ONLY    
//   @Consumption.valueHelpDefinition: [{ entity: { name: 'ZR_GRC_PICKLIST', element: 'ListValue' } ,
//   additionalBinding: [{ element: 'ListId' ,    
//                               localConstant: '100023', usage: #FILTER }]
//                               , distinctValues: true
//                               }]
 @UI.hidden: #(HideBusinessArea)
@ObjectModel.text.element:  ['BusinessArea_PL']
          @UI.textArrangement: #TEXT_ONLY
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZR_BUSINESS_AREA_PL', element: 'Id' }, useForValidation: true      
          }]      
  BusinessArea,
 _BusinessArea_PL.Business_Area as BusinessArea_PL,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
 virtual HideBusinessArea :abap_boolean, 
  _Picklist.ListValue as Value,
// _Picklst.ListValue as Value,
   @UI.hidden: #(HideLevel2Id)
  Level2Id,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideLevel2Id :abap_boolean, 
   
//   @UI.hidden: #(HideLevel4Id)
    @Consumption.valueHelpDefinition: [{ entity: { name: 'ZR_LOCATION_LOOKUP', element: 'Location_Name' },useForValidation: true}]
  Level4Id,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideLevel4Id :abap_boolean, 
   
   @UI.hidden: #(HideBusinessUnitOnlAndOthers)
    @Consumption.valueHelpDefinition: [{ entity: { name: 'ZR_LOCATION_LOOKUP', element: 'Location_Name' },useForValidation: true}]
  BusinessUnitOnlAndOthers,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideBusinessUnitOnlAndOthers :abap_boolean, 
   
   @UI.hidden: #(HideCellPhoneNumber)
  CellPhoneNumber,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideCellPhoneNumber :abap_boolean, 
   
//   @UI.hidden: #(HideChiefFinancialOfficer)
//  ChiefFinancialOfficer,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideChiefFinancialOfficer :abap_boolean, 
   
//   @UI.hidden: #(HideChiefFinancialOfficerName)
  ChiefFinancialOfficerName,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideChiefFinancialOfficerName :abap_boolean, 
   
//   @UI.hidden: #(HideChiefOperatingOfficer)
//  ChiefOperatingOfficer,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideChiefOperatingOfficer :abap_boolean, 
   
//   @UI.hidden: #(HideChiefOperatingOfficerName)
//  ChiefOperatingOfficerName,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideChiefOperatingOfficerName :abap_boolean, 
   
   @UI.hidden: #(HideCity)
  City,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideCity :abap_boolean, 
   
   @UI.hidden: #(HideLevel5Id)
  Level5Id,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideLevel5Id :abap_boolean, 
   
   @UI.hidden: #(HideCountryOnl)
  CountryOnl,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideCountryOnl :abap_boolean, 
   
   @UI.hidden: #(HideCountry)
     @ObjectModel.text.element: [ 'CountryName' ]
      @Consumption.valueHelpDefinition: [{entity: { name: 'I_CountryVH', element: 'Country' },useForValidation: true }]
      @Semantics.address.country: true
  Country,
_Country._Text.CountryName as CountryName : localized,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideCountry :abap_boolean, 
   
   @UI.hidden: #(HideCurrency)
   @ObjectModel.text.element:  ['Currency_PL']
          @UI.textArrangement: #TEXT_ONLY
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZR_CURRENCY_PL', element: 'Id' },useForValidation: true }]      
  Currency,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideCurrency :abap_boolean, 
   _Currency_PL.Currency as Currency_PL,
   
   @UI.hidden: #(HideDateActive)
  DateActive,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideDateActive :abap_boolean, 
   
   @UI.hidden: #(HideDateInactive)
  DateInactive,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideDateInactive :abap_boolean, 
   
//   @UI.hidden: #(HideCfoEmail)
  CfoEmail,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideCfoEmail :abap_boolean, 
   
//   @UI.hidden: #(HideCooEmail)
//  CooEmail,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideCooEmail :abap_boolean, 
   
//   @UI.hidden: #(HideHseEmail)
//  HseEmail,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideHseEmail :abap_boolean, 
   
//   @UI.hidden: #(HideMaintanceManEmail)
//  MaintanceManEmail,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideMaintanceManEmail :abap_boolean, 
   
//   @UI.hidden: #(HideManagingDirectorEmail)
//  ManagingDirectorEmail,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideManagingDirectorEmail :abap_boolean, 
   
//   @UI.hidden: #(HideLchEmail)
//  LchEmail,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideLchEmail :abap_boolean, 
   
//   @UI.hidden: #(HideLch2Email)
//  Lch2Email,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideLch2Email :abap_boolean, 
   
  @UI.hidden: #(HideLocationStatus)
  LocationStatus,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideLocationStatus :abap_boolean, 
   
  FaxNumber,
 
  @UI.hidden: #(HideFormer)
  Former,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideFormer :abap_boolean, 
   
    @UI.hidden: #(HideGrmClaimUseOnly)
    GrmClaimUseOnly,
   @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideGrmClaimUseOnly :abap_boolean,
  
  @UI.hidden: #(HideHermesCode)
  HermesCode,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideHermesCode :abap_boolean,
  
  
  @UI.hidden: #(HideHQFMCode)
  HqfmCode,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
  virtual HideHQFMCode :abap_boolean,
   
//  HseManger,
  
//   @UI.hidden: #(HideHseMangerName)
//  HseMangerName,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideHseMangerName :abap_boolean, 
   
   @UI.hidden: #(HideIncludeInRenewalCollection)
  IncludeInRenewalCollection,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideIncludeInRenewalCollection :abap_boolean, 
   
   @UI.hidden: #(HideLatitude)
  Latitude,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideLatitude :abap_boolean, 
   
//   @UI.hidden: #(HideLeadClaimsHandler)
//  LeadClaimsHandler,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideLeadClaimsHandler :abap_boolean, 
   
//   @UI.hidden: #(HideLeadClaimsHandler2)
//  LeadClaimsHandler2,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideLeadClaimsHandler2 :abap_boolean, 
//   
////   @UI.hidden: #(HideLeadClaimsHandler2Name)
//  LeadClaimsHandler2Name,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideLeadClaimsHandler2Name :abap_boolean, 
//   
//   @UI.hidden: #(HideLeadClaimsHandlerName)
//  LeadClaimsHandlerName,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideLeadClaimsHandlerName :abap_boolean, 
   
  @UI.hidden: #(HideLegalClassification)
     @ObjectModel.text.element:  ['LegalClass_PL']
          @UI.textArrangement: #TEXT_ONLY
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZR_LEGAL_CLASS_PL', element: 'Id' },useForValidation: true }] 
  LegalClassification,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideLegalClassification :abap_boolean,
   _LegalClass_PL.Legal_class as LegalClass_PL,
   
  @UI.hidden: #(HideLegalEntityName)
  LegalEntityName,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideLegalEntityName :abap_boolean,
   
  LocalTerminalName,
  
   @UI.hidden: #(HideNodeCode)
  NodeCode,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideNodeCode :abap_boolean, 
   
   @UI.hidden: #(HideLongitude)
  Longitude,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideLongitude :abap_boolean, 
   
//   @UI.hidden: #(HideMaintenanceManager)
//  MaintenanceManager,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideMaintenanceManager :abap_boolean, 
   
//   @UI.hidden: #(HideMaintenanceManagerName)
//  MaintenanceManagerName,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideMaintenanceManagerName :abap_boolean, 
   
//   @UI.hidden: #(HideManagingDirector)
//  ManagingDirector,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideManagingDirector :abap_boolean, 
//   
//   @UI.hidden: #(HideManagingDirectorName)
//  ManagingDirectorName,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HideManagingDirectorName :abap_boolean, 
   
   @UI.hidden: #(HideNodeDesc)
  NodeDesc,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideNodeDesc :abap_boolean, 
   
   @UI.hidden: #(HideNodeKey)
  NodeKey,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideNodeKey :abap_boolean, 
   
   @UI.hidden: #(HideNodeLevel)
  NodeLevel,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideNodeLevel :abap_boolean, 
   
  @UI.hidden: #(HideNotes)
  Notes,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideNotes :abap_boolean,
   
    @UI.hidden: #(HideOffice)
  Office,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideOffice :abap_boolean, 
   
    @UI.hidden: #(HideOrganisation1)
    @Consumption.valueHelpDefinition: [{ entity: { name: 'ZR_LOCATION_LOOKUP', element: 'Location_Name' },useForValidation: true}]
  Organisation1,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideOrganisation1 :abap_boolean, 
  
   @UI.hidden: #(HideOwnership)
  Ownership,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideOwnership :abap_boolean, 
   
   @Consumption.valueHelpDefinition: [{ entity: { name: 'ZR_GRC_USER_MASTER', element: 'UserDescription' },useForValidation: true }]
   Owner,
   
   @UI.hidden: #(HideParentCode)
  ParentCode,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideParentCode :abap_boolean, 
   
   @UI.hidden: #(HideParentDesc)
  ParentDesc,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideParentDesc :abap_boolean, 
   
   @UI.hidden: #(HideParentLevel)  
  ParentLevel,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideParentLevel :abap_boolean, 
   
   @UI.hidden: #(HideParentNode)
   @Consumption.valueHelpDefinition: [{ entity: { name: 'ZR_LOCATION_LOOKUP', element: 'Location_Name'}, useForValidation: true }]
  ParentNode,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideParentNode :abap_boolean, 
   
//   @UI.hidden: #(HidePhoneNumber)
  PhoneNumber,
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
//   virtual HidePhoneNumber :abap_boolean, 
   
   @UI.hidden: #(HidePortAuthority)
  PortAuthority,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HidePortAuthority :abap_boolean, 
   
   @UI.hidden: #(HidePostalCode)
  PostalCode,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HidePostalCode :abap_boolean, 
   
   @UI.hidden: #(HidePrimaryContact)
  PrimaryContact,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HidePrimaryContact :abap_boolean, 
   
//  @ObjectModel.text.element: [ 'RecordtypeValue' ]
//  @ObjectModel.text.association: '_Picklst'
//  @UI.textArrangement: #TEXT_ONLY
//  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZR_GRC_RECORD_TYPE_PL', element: 'Id' } }]
//      @Search.defaultSearchElement: true
//      @Search.fuzzinessThreshold: 0.8
//      @ObjectModel.text.element: [ 'RecordtypeValue' ]
//      @ObjectModel.text.association: '_Picklst'
//      @UI.textArrangement: #TEXT_ONLY    
//      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZR_GRC_PICKLIST', element: 'ListValue' } ,
//      additionalBinding: [{ element: 'ListId' ,    
//                         localConstant: '100024', 
//                         usage: #FILTER }],
//      distinctValues: true }]  
                @ObjectModel.text.element:  ['LocRecType']
//                 @ObjectModel.text.association: '_LocRecType'
          @UI.textArrangement: #TEXT_ONLY
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZR_LOCATION_RECTYPE_PL', element: 'Id' },useForValidation: true }]
  RecordType,
//   _Picklst.ListValue as RecordtypeValue,
 _LocRecType.Location_RecType as LocRecType,
  @UI.hidden: #(HideRegion)
    @Consumption.valueHelpDefinition: [{ entity: { name: 'ZR_LOCATION_LOOKUP', element: 'Location_Name' },useForValidation: true}]
  Region,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideRegion :abap_boolean, 
   
   @UI.hidden: #(HideRenewalContact)
  RenewalContact,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideRenewalContact :abap_boolean, 
   
   @UI.hidden: #(HideStates)
  States,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideStates :abap_boolean, 
   
   @UI.hidden: #(HideStateOnl)
  StateOnl,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideStateOnl :abap_boolean, 
   
   @UI.hidden: #(HideSubBrand)
        @ObjectModel.text.element:  ['SubBrand_PL']
          @UI.textArrangement: #TEXT_ONLY
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZR_SUB_BRAND_PL', element: 'Id' },useForValidation: true }] 
  SubBrand,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideSubBrand :abap_boolean, 
   _SubBrand_PL.Sub_Brand as SubBrand_PL,
   
   @UI.hidden: #(HideLevel3Id)
  Level3Id,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideLevel3Id :abap_boolean, 
   
   @UI.hidden: #(HideTerminalNameLocal)
  TerminalNameLocal,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideTerminalNameLocal :abap_boolean, 
   
   @UI.hidden: #(HideVendorPortalTerminal)
  VendorPortalTerminal,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideVendorPortalTerminal :abap_boolean, 
   
   @UI.hidden: #(HideWarehouse)
  Warehouse,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_GRC_LOC_CONTROL_FIELDS'
   virtual HideWarehouse :abap_boolean, 
   LocationID,
  @ObjectModel.text.element: [ 'CreatedUser' ]
  @UI.textArrangement: #TEXT_ONLY
  Createdby,
  _Createdby.UserDescription as CreatedUser,
  Createdat,
   @ObjectModel.text.element: [ 'ChangedUser' ]
  @UI.textArrangement: #TEXT_ONLY
  Lastchangedby,
  _Lastchangedby.UserDescription as ChangedUser,
  Lastchangedat,
  Locallastchangedat,
  _Asset,
  _Claim,
  _Property,
  _Policy,
   _Picklist,
   _LocRecType,
     _BusinessArea_PL,
  _Currency_PL,
  _LegalClass_PL,
  _SubBrand_PL,
    _Createdby,
  _Lastchangedby,
  _Country
//   _Recordtype
//  _Picklst
  
}
