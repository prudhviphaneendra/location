@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
// @ObjectModel.sapObjectNodeType.name: 'ZTGRC_loc_migr'
define view entity ZR_TGRC_mias_migr
as select from ztgrc_mias_mig
association to parent ZR_TGRC_FILE_mias as _XLUser on $projection.FileId = _XLUser.FileId
{
key ztgrc_mias_mig.file_id as FileId,
key ztgrc_mias_mig.linenum as Linenum ,
key ztgrc_mias_mig.claim_reg_uuid as ClaimRegUuid ,
ztgrc_mias_mig.record_type as RecordType ,
ztgrc_mias_mig.record_typ_desc as RecordTypDesc ,
ztgrc_mias_mig.claim_reg_ext_id as ClaimRegExtId ,
ztgrc_mias_mig.asset_location as AssetLocation ,
ztgrc_mias_mig.brand_bu as BrandBu ,
ztgrc_mias_mig.close_date as CloseDate ,
ztgrc_mias_mig.date_of_loss as DateOfLoss ,
ztgrc_mias_mig.ibner_formula as IbnerFormula ,
ztgrc_mias_mig.ibner_adjustment as IbnerAdjustment ,
ztgrc_mias_mig.ibner as Ibner ,
ztgrc_mias_mig.insurer_claim_number as InsurerClaimNumber ,
ztgrc_mias_mig.insurer_claim_number_2 as InsurerClaimNumber2 ,
ztgrc_mias_mig.loss_description as LossDescription ,
ztgrc_mias_mig.mias_gross_incurred_formula as MiasGrossIncurredFormula ,
ztgrc_mias_mig.mias_gross_incurred as MiasGrossIncurred ,
ztgrc_mias_mig.mias_paid as MiasPaid ,
ztgrc_mias_mig.mias_gross_reserved_excl_ibner as MiasGrossReservedExclIbner ,
ztgrc_mias_mig.mias_net_reserved_excl_ibner as MiasNetReservedExclIbner ,
ztgrc_mias_mig.mias_net_reserved_incl_ibner_f as MiasNetReservedInclIbnerF ,
ztgrc_mias_mig.mias_policy_year as MiasPolicyYear ,
ztgrc_mias_mig.mias_share as MiasShare ,
ztgrc_mias_mig.subtype as Subtype ,
ztgrc_mias_mig.description as Description ,
ztgrc_mias_mig.r_i_1st_bracket as RI1StBracket ,
ztgrc_mias_mig.r_i_total_recieved as RITotalRecieved ,
ztgrc_mias_mig.r_i_total_share as RITotalShare ,
ztgrc_mias_mig.r_i_share_of_gross_reserve as RIShareOfGrossReserve ,
ztgrc_mias_mig.reinsurance_receivables as ReinsuranceReceivables ,
ztgrc_mias_mig.status as Status ,

@Semantics.user.createdBy: true
ztgrc_mias_mig.createdby as Createdby,
@Semantics.systemDateTime.createdAt: true
ztgrc_mias_mig.createdat as Createdat,
@Semantics.user.localInstanceLastChangedBy: true
ztgrc_mias_mig.lastchangedby as Lastchangedby,
@Semantics.systemDateTime.lastChangedAt: true
ztgrc_mias_mig.lastchangedat as Lastchangedat,
@Semantics.systemDateTime.localInstanceLastChangedAt: true
_XLUser
}
