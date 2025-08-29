@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_TGRC_LOCATION
  as select from ztgrc_locationx
  association[0..*] to ZR_GRC_LOCATION_ASSET as _Asset
  on $projection.Level1Id = _Asset.HierarchyNode
  association[0..*] to ZR_GRC_LOCATION_CLAIM as _Claim
  on $projection.Level1Id = _Claim.InsuredName
  association[0..*] to ZR_GRC_LOCATION_PROPERTY as _Property
  on $projection.Level1Id = _Property.InsuredName
  association[0..*] to ZR_GRC_LOCATION_POLICY as _Policy
  on $projection.Level1Id = _Policy.Insured
   association[0..1] to ZR_GRC_PICKLST_C as _Picklist on
  $projection.BusinessArea = _Picklist.ValueId
 association[0..1] to ZR_LOCATION_RECTYPE_PL as _LocRecType on
  $projection.RecordType = _LocRecType.Id
   association[0..1] to ZR_BUSINESS_AREA_PL as _BusinessArea_PL on
  $projection.BusinessArea = _BusinessArea_PL.Id
    association[0..1] to ZR_CURRENCY_PL as _Currency_PL on
  $projection.Currency = _Currency_PL.Id
   association[0..1] to ZR_LEGAL_CLASS_PL as _LegalClass_PL on
  $projection.LegalClassification = _LegalClass_PL.Id
  association[0..1] to ZR_SUB_BRAND_PL as _SubBrand_PL on
  $projection.SubBrand = _SubBrand_PL.Id
  association[0..1] to I_User as _Createdby
    on $projection.Createdby = _Createdby.UserID
    association[0..1] to I_User as _Lastchangedby
    on $projection.Lastchangedby = _Lastchangedby.UserID
   association[0..1] to I_Country as _Country
    on $projection.Country = _Country.Country
{
  key location_uuid as LocationUuid,
   level_1_id as Level1Id,
  address_line1 as AddressLine1,
  address_line2 as AddressLine2,
  allow_agreed_value_input as AllowAgreedValueInput,
  bim as Bim,
  bim_date as BimDate,
  brand as Brand,
  business_area as BusinessArea,
  level_2_id as Level2Id,
  level_4_id as Level4Id,
  business_unit_onl_and_others as BusinessUnitOnlAndOthers,
  cell_phone_number as CellPhoneNumber,
//  chief_financial_officer as ChiefFinancialOfficer,
  chief_financial_officer_name as ChiefFinancialOfficerName,
//  chief_operating_officer as ChiefOperatingOfficer,
//  chief_operating_officer_name as ChiefOperatingOfficerName,
  city as City,
  level_5_id as Level5Id,
  country_onl as CountryOnl,
  country as Country,
  currency as Currency,
  date_active as DateActive,
  date_inactive as DateInactive,
  cfo_email as CfoEmail,
//  coo_email as CooEmail,
//  hse_email as HseEmail,
//  maintance_man_email as MaintanceManEmail,
//  managing_director_email as ManagingDirectorEmail,
//  lch_email as LchEmail,
//  lch2_email as Lch2Email,
  location_status as LocationStatus,
  fax_number as FaxNumber,
  former as Former,
  grm_claim_use_only as GrmClaimUseOnly,
  hermes_code as HermesCode,
  hqfm_code as HqfmCode,
//  hse_manger as HseManger,
//  hse_manger_name as HseMangerName,
  include_in_renewal_collection as IncludeInRenewalCollection,
  latitude as Latitude,
//  lead_claims_handler as LeadClaimsHandler,
//  lead_claims_handler_2 as LeadClaimsHandler2,
//  lead_claims_handler_2_name as LeadClaimsHandler2Name,
//  lead_claims_handler_name as LeadClaimsHandlerName,
  legal_classification as LegalClassification,
  legal_entity_name as LegalEntityName,
  local_terminal_name as LocalTerminalName,
  node_code as NodeCode,
  longitude as Longitude,
//  maintenance_manager as MaintenanceManager,
//  maintenance_manager_name as MaintenanceManagerName,
//  managing_director as ManagingDirector,
//  managing_director_name as ManagingDirectorName,
  node_desc as NodeDesc,
  node_key as NodeKey,
  node_level as NodeLevel,
  notes as Notes,
  office as Office,
  organisation_1 as Organisation1,
  ownership as Ownership,
  owner as Owner,
  parent_code as ParentCode,
  parent_desc as ParentDesc,
  parent_level as ParentLevel,
  parent_node as ParentNode,
  phone_number as PhoneNumber,
  port_authority as PortAuthority,
  postal_code as PostalCode,
  primary_contact as PrimaryContact,
  record_type as RecordType,
  region as Region,
  renewal_contact as RenewalContact,
  states as States,
  state_onl as StateOnl,
  sub_brand as SubBrand,
  level_3_id as Level3Id,
  terminal_name_local as TerminalNameLocal,
  vendor_portal_terminal as VendorPortalTerminal,
  warehouse as Warehouse,
  location_id as LocationID,
  @Semantics.user.createdBy: true
  createdby as Createdby,
  @Semantics.systemDateTime.createdAt: true
  createdat as Createdat,
  @Semantics.user.localInstanceLastChangedBy: true
  lastchangedby as Lastchangedby,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  lastchangedat as Lastchangedat,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  locallastchangedat as Locallastchangedat,
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
//  _Recordtype
// _Picklst
  
}
