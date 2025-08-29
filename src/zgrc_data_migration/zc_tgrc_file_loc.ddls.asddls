@Metadata.allowExtensions: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view for ZR_TGRC_FILE_LOC'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TGRC_FILE_LOC 
  provider contract transactional_query
as projection on ZR_TGRC_FILE_LOC
{
    key FileId,
    FileStatus,
     @Semantics.largeObject:
            { mimeType: 'Mimetype',
            fileName: 'Filename',
            acceptableMimeTypes: [ 'application/vnd.ms-excel','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ],
            contentDispositionPreference: #INLINE }     
    Attachment,
    Mimetype,
    Filename,
    updateMainTable,
    LocalCreatedBy,
    LocalCreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    LastChangedAt,
    /* Associations */
    _XLData : redirected to composition child ZC_TGRC_LOCATION_MIG
}
