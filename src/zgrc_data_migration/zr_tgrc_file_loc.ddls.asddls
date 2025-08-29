@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View entity for ztgrc_file_locn'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
// @ObjectModel.sapObjectNodeType.name: 'ZTGRC_FILE_LOCN'

define root view entity ZR_TGRC_FILE_LOC
  as select from ztgrc_file_locn
   composition [0..*] of ZR_TGRC_LOCATION_MIG as _XLData
{

//  key end_user as EndUser,
  key file_id as FileId,
  file_status as FileStatus,
  attachment as Attachment,
  mimetype as Mimetype,
  filename as Filename,
  update_main_table as updateMainTable,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  _XLData
  
}
