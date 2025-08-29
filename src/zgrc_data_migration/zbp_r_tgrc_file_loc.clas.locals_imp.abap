CLASS lhc_XLHead DEFINITION INHERITING FROM cl_abap_behavior_handler.


  PRIVATE SECTION.

    METHODS uploadExcelData FOR MODIFY
      IMPORTING keys FOR ACTION XLHead~uploadExcelData RESULT result.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR XLHead RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR XLHead RESULT result.



ENDCLASS.

CLASS lhc_XLHead IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.



  METHOD uploadExcelData.

*TYPES: BEGIN OF ty_excel,
*         record_type         TYPE string,
*         recordtype_id       TYPE string,
*         coverage_major      TYPE string,
*         coverage_major_id   TYPE string,
*         coverage_minor      TYPE string,
*         coverage_minor_id   TYPE string,
*         main_event          TYPE string,
*         main_event_id       TYPE string,
*         crew_rank           TYPE string,
*         crew_rank_id        TYPE string,
*         main_casualty       TYPE string,
*         main_casualty_id    TYPE string,
*         main_cause          TYPE string,
*         main_cause_id       TYPE string,
*         crew_nationality    TYPE string,
*         crew_nationality_id TYPE string,
*       END OF ty_excel.


    TYPES: BEGIN OF gty_gr_xl,

             level_1_id                    TYPE string,
             address_line1                 TYPE string,
             address_line2                 TYPE string,
             allow_agreed_value_input      TYPE string,
             bim                           TYPE string,
             bim_date                      TYPE string,
             brand                         TYPE string,
             business_area                 TYPE string,
             level_2_id                    TYPE string,
             level_4_id                    TYPE string,
             business_unit_onl_and_others  TYPE string,
             cell_phone_number             TYPE string,
             chief_financial_officer       TYPE string,
             chief_financial_officer_name  TYPE string,
             chief_operating_officer       TYPE string,
             chief_operating_officer_name  TYPE string,
             city                          TYPE string,
             level_5_id                    TYPE string,
             country_onl                   TYPE string,
             country                       TYPE string,
             currency                      TYPE string,
             date_active                   TYPE string,
             date_inactive                 TYPE string,
             cfo_email                     TYPE string,
             coo_email                     TYPE string,
             hse_email                     TYPE string,
             maintance_man_email           TYPE string,
             managing_director_email       TYPE string,
             lch_email                     TYPE string,
             lch2_email                    TYPE string,
             location_status               TYPE string,
             fax_number                    TYPE string,
             former                        TYPE string,
             grm_claim_use_only            TYPE string,
             hermes_code                   TYPE string,
             hqfm_code                     TYPE string,
             hse_manger                    TYPE string,
             hse_manger_name               TYPE string,
             include_in_renewal_collection TYPE string,
             latitude                      TYPE string,
             lead_claims_handler           TYPE string,
             lead_claims_handler_2         TYPE string,
             lead_claims_handler_2_name    TYPE string,
             lead_claims_handler_name      TYPE string,
             legal_classification          TYPE string,
             legal_entity_name             TYPE string,
             local_terminal_name           TYPE string,
             node_code                     TYPE string,
             longitude                     TYPE string,
             maintenance_manager           TYPE string,
             maintenance_manager_name      TYPE string,
             managing_director             TYPE string,
             managing_director_name        TYPE string,
             node_desc                     TYPE string,
             node_key                      TYPE string,
             node_level                    TYPE string,
             notes                         TYPE string,
             office                        TYPE string,
             organisation_1                TYPE string,
             ownership                     TYPE string,
             parent_code                   TYPE string,
             parent_desc                   TYPE string,
             parent_level                  TYPE string,
             parent_node                   TYPE string,
             phone_number                  TYPE string,
             port_authority                TYPE string,
             postal_code                   TYPE string,
             primary_contact               TYPE string,
             record_type                   TYPE string,
             region                        TYPE string,
             renewal_contact               TYPE string,
             states                        TYPE string,
             state_onl                     TYPE string,
             sub_brand                     TYPE string,
             level_3_id                    TYPE string,
             terminal_name_local           TYPE string,
             vendor_portal_terminal        TYPE string,
             warehouse                     TYPE string,
             createdby                     TYPE string,
             createdat                     TYPE string,
             lastchangedby                 TYPE string,
             lastchangedat                 TYPE string,
             locallastchangedat            TYPE string,
             location_uuid                 TYPE string,
             linenum                       TYPE string,
           END OF gty_gr_xl.

    DATA: lt_rows         TYPE STANDARD TABLE OF string,
          lv_content      TYPE string,
          lo_table_descr  TYPE REF TO cl_abap_tabledescr,
          lo_struct_descr TYPE REF TO cl_abap_structdescr,
          lt_excel        TYPE STANDARD TABLE OF gty_gr_xl,
          lt_data         TYPE TABLE FOR CREATE zr_tgrc_file_loc\_XLData,
          lv_index        TYPE sy-index.

*
*    DATA: lt_rows         TYPE STANDARD TABLE OF string,
*          lv_content      TYPE string,
*          lo_table_descr  TYPE REF TO cl_abap_tabledescr,
*          lo_struct_descr TYPE REF TO cl_abap_structdescr,
*          lt_excel        TYPE STANDARD TABLE OF ty_excel,
*          lt_data         TYPE TABLE FOR CREATE zr_tgrc_file_loc\_XLData,
*          lv_index        TYPE sy-index.

    FIELD-SYMBOLS: <lfs_col_header> TYPE string.

    DATA(lv_user) = cl_abap_context_info=>get_user_technical_name( ).
*
    READ ENTITIES OF zr_tgrc_file_loc IN LOCAL MODE
    ENTITY XLHead
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_file_entity).

    DATA(lv_attachment) = lt_file_entity[ 1 ]-attachment.
    CHECK lv_attachment IS NOT INITIAL.




*
* BEGIN OF TEST BY ARN033

    DATA(lo_doc_mgmt) = new zcl_doc_mgmt_rolodex( ).

    TRY.
        lo_doc_mgmt->upload_file(
          EXPORTING
            iv_file_name   = CONV string( lt_file_entity[ 1 ]-filename )
            iv_file_data   = lv_attachment
            iv_app_name    = 'LOCATION'
          IMPORTING
            es_status      = data(ls_status)
            ev_status_text = data(lv_status_text)
        ).
      CATCH cx_web_http_client_error.
        "handle exception
    ENDTRY.
* end of test by ARN033



*    "Move Excel Data to Internal Table
*    DATA(lo_xlsx) = xco_cp_xlsx=>document->for_file_content( iv_file_content = lv_attachment )->read_access( ).
*
*
*    DATA(lo_worksheet) = lo_xlsx->get_workbook( )->worksheet->at_position( 1 ).
*
*
*    DATA(lo_selection_pattern) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to( )->get_pattern( ).
*
*
*    DATA(lo_execute) = lo_worksheet->select(  lo_selection_pattern
*                                           )->row_stream( )->operation->write_to( REF #( lt_excel ) ).
*
*    lo_execute->set_value_transformation( xco_cp_xlsx_read_access=>value_transformation->string_value )->if_xco_xlsx_ra_operation~execute( ).
*
*
*    "Validate Header record
*
*    DELETE lt_excel INDEX 1.
*
*DATA : lt_final TYPE TABLE OF ztgrc_claim_depd.
*
*lt_final[] = CORRESPONDING #(  lt_excel ).
*
*LOOP AT lt_final ASSIGNING FIELD-SYMBOL(<lf_final>).
*
*      TRY.
*          DATA(lv_line_id) = cl_system_uuid=>create_uuid_x16_static( ).
*        CATCH cx_uuid_error.
*      ENDTRY.
*
*      <lf_final>-uuid = lv_line_id.
*
*ENDLOOP.
*
*
*INSERT ztgrc_claim_depd FROM TABLE @lt_final.

*    LOOP AT lt_excel ASSIGNING FIELD-SYMBOL(<lfs_excel>).
*      TRY.
*          DATA(lv_line_id) = cl_system_uuid=>create_uuid_x16_static( ).
*        CATCH cx_uuid_error.
*      ENDTRY.
*      <lfs_excel>-location_uuid     = lv_line_id.
*      <lfs_excel>-linenum = sy-tabix.
*    ENDLOOP.
*
*    "Prepare Data for  Child Entity (XLData)
*    lt_data = VALUE #(
*        (   %cid_ref  = keys[ 1 ]-%cid_ref
*            %is_draft = keys[ 1 ]-%is_draft
*            FileId    = keys[ 1 ]-FileId
*            %target   = VALUE #(
*                FOR lwa_excel IN lt_excel (
*                      %cid                  = keys[ 1 ]-%cid_ref
*                      %is_draft             = keys[ 1 ]-%is_draft
*                      %data                 = VALUE #(
*                                              FileId                    = keys[ 1 ]-FileId
*                                              LocationUuid          = lwa_excel-location_uuid
*                                              LineNum               = lwa_excel-linenum
*                                              level1id              =  lwa_excel-level_1_id
*                                              addressline1                   =  lwa_excel-address_line1
*                                              addressline2                   =  lwa_excel-address_line2
*                                              allowagreedvalueinput        =  lwa_excel-allow_agreed_value_input
*                                              bim                             =  lwa_excel-bim
*                                              bimdate                        =  lwa_excel-bim_date
*                                              brand                           =  lwa_excel-brand
*                                              businessarea                   =  lwa_excel-business_area
*                                              level2id                      =  lwa_excel-level_2_id
*                                              level4id                      =  lwa_excel-level_4_id
*                                              businessunitonlandothers    =  lwa_excel-business_unit_onl_and_others
*                                              cellphonenumber               =  lwa_excel-cell_phone_number
*                                              chieffinancialofficer         =  lwa_excel-chief_financial_officer
*                                              chieffinancialofficername    =  lwa_excel-chief_financial_officer_name
*                                              chiefoperatingofficer         =  lwa_excel-chief_operating_officer
*                                              chiefoperatingofficername    =  lwa_excel-chief_operating_officer_name
*                                              city                            =  lwa_excel-city
*                                              level5id                      =  lwa_excel-level_5_id
*                                              countryonl                     =  lwa_excel-country_onl
*                                              country                         =  lwa_excel-country
*                                              currency                        =  lwa_excel-currency
*                                              dateactive                     =  lwa_excel-date_active
*                                              dateinactive                   =  lwa_excel-date_inactive
*                                              cfoemail                       =  lwa_excel-cfo_email
*                                              cooemail                       =  lwa_excel-coo_email
*                                              hseemail                       =  lwa_excel-hse_email
*                                              maintancemanemail             =  lwa_excel-maintance_man_email
*                                              managingdirectoremail         =  lwa_excel-managing_director_email
*                                              lchemail                       =  lwa_excel-lch_email
*                                              lch2email                      =  lwa_excel-lch2_email
*                                              locationstatus                 =  lwa_excel-location_status
*                                              faxnumber                      =  lwa_excel-fax_number
*                                              former                          =  lwa_excel-former
*                                              grmclaimuseonly              =  lwa_excel-grm_claim_use_only
*                                              hermescode                     =  lwa_excel-hermes_code
*                                              hqfmcode                       =  lwa_excel-hqfm_code
*                                              hsemanger                      =  lwa_excel-hse_manger
*                                              hsemangername                 =  lwa_excel-hse_manger_name
*                                              includeinrenewalcollection   =  lwa_excel-include_in_renewal_collection
*                                              latitude                        =  lwa_excel-latitude
*                                              leadclaimshandler             =  lwa_excel-lead_claims_handler
*                                              leadclaimshandler2           =  lwa_excel-lead_claims_handler_2
*                                              leadclaimshandler2name      =  lwa_excel-lead_claims_handler_2_name
*                                              leadclaimshandlername        =  lwa_excel-lead_claims_handler_name
*                                              legalclassification            =  lwa_excel-legal_classification
*                                              legalentityname               =  lwa_excel-legal_entity_name
*                                              localterminalname             =  lwa_excel-local_terminal_name
*                                              nodecode                       =  lwa_excel-node_code
*                                              longitude                       =  lwa_excel-longitude
*                                              maintenancemanager             =  lwa_excel-maintenance_manager
*                                              maintenancemanagername        =  lwa_excel-maintenance_manager_name
*                                              managingdirector               =  lwa_excel-managing_director
*                                              managingdirectorname          =  lwa_excel-managing_director_name
*                                              nodedesc                       =  lwa_excel-node_desc
*                                              nodekey                        =  lwa_excel-node_key
*                                              nodelevel                      =  lwa_excel-node_level
*                                              notes                           =  lwa_excel-notes
*                                              office                          =  lwa_excel-office
*                                              organisation1                  =  lwa_excel-organisation_1
*                                              ownership                       =  lwa_excel-ownership
*                                              parentcode                     =  lwa_excel-parent_code
*                                              parentdesc                     =  lwa_excel-parent_desc
*                                              parentlevel                    =  lwa_excel-parent_level
*                                              parentnode                     =  lwa_excel-parent_node
*                                              phonenumber                    =  lwa_excel-phone_number
*                                              portauthority                  =  lwa_excel-port_authority
*                                              postalcode                     =  lwa_excel-postal_code
*                                              primarycontact                 =  lwa_excel-primary_contact
*                                              recordtype                     =  lwa_excel-record_type
*                                              region                          =  lwa_excel-region
*                                              renewalcontact                 =  lwa_excel-renewal_contact
*                                              states                          =  lwa_excel-states
*                                              stateonl                       =  lwa_excel-state_onl
*                                              subbrand                       =  lwa_excel-sub_brand
*                                              level3id                      =  lwa_excel-level_3_id
*                                              terminalnamelocal             =  lwa_excel-terminal_name_local
*                                              vendorportalterminal          =  lwa_excel-vendor_portal_terminal
*                                              warehouse                       =  lwa_excel-warehouse
*                                              createdby                       =  lwa_excel-createdby
*                                              createdat                       =  lwa_excel-createdat
*                                              lastchangedby                   =  lwa_excel-lastchangedby
*                                              lastchangedat                   =  lwa_excel-lastchangedat
*                                              locallastchangedat              =  lwa_excel-locallastchangedat
*
*                    )
*                    %control = VALUE #(
*                        FileId          = if_abap_behv=>mk-on
*                        LocationUuid          = if_abap_behv=>mk-on
*                        LineNum      = if_abap_behv=>mk-on
*level1id                      =  if_abap_behv=>mk-on
*  addressline1                   =  if_abap_behv=>mk-on
*  addressline2                   =  if_abap_behv=>mk-on
*  allowagreedvalueinput        =  if_abap_behv=>mk-on
*  bim                             =  if_abap_behv=>mk-on
*  bimdate                        =  if_abap_behv=>mk-on
*  brand                           =  if_abap_behv=>mk-on
*  businessarea                   =  if_abap_behv=>mk-on
*  level2id                      =  if_abap_behv=>mk-on
*  level4id                      =  if_abap_behv=>mk-on
*  businessunitonlandothers    =  if_abap_behv=>mk-on
*  cellphonenumber               =  if_abap_behv=>mk-on
*  chieffinancialofficer         =  if_abap_behv=>mk-on
*  chieffinancialofficername    =  if_abap_behv=>mk-on
*  chiefoperatingofficer         =  if_abap_behv=>mk-on
*  chiefoperatingofficername    =  if_abap_behv=>mk-on
*  city                            =  if_abap_behv=>mk-on
*  level5id                      =  if_abap_behv=>mk-on
*  countryonl                     =  if_abap_behv=>mk-on
*  country                         =  if_abap_behv=>mk-on
*  currency                        =  if_abap_behv=>mk-on
*  dateactive                     =  if_abap_behv=>mk-on
*  dateinactive                   =  if_abap_behv=>mk-on
*  cfoemail                       =  if_abap_behv=>mk-on
*  cooemail                       =  if_abap_behv=>mk-on
*  hseemail                       =  if_abap_behv=>mk-on
*  maintancemanemail             =  if_abap_behv=>mk-on
*  managingdirectoremail         =  if_abap_behv=>mk-on
*  lchemail                       =  if_abap_behv=>mk-on
*  lch2email                      =  if_abap_behv=>mk-on
*  locationstatus                 =  if_abap_behv=>mk-on
*  faxnumber                      =  if_abap_behv=>mk-on
*  former                          =  if_abap_behv=>mk-on
*  grmclaimuseonly              =  if_abap_behv=>mk-on
*  hermescode                     =  if_abap_behv=>mk-on
*  hqfmcode                       =  if_abap_behv=>mk-on
*  hsemanger                      =  if_abap_behv=>mk-on
*  hsemangername                 =  if_abap_behv=>mk-on
*  includeinrenewalcollection   =  if_abap_behv=>mk-on
*  latitude                        =  if_abap_behv=>mk-on
*  leadclaimshandler             =  if_abap_behv=>mk-on
*  leadclaimshandler2           =  if_abap_behv=>mk-on
*  leadclaimshandler2name      =  if_abap_behv=>mk-on
*  leadclaimshandlername        =  if_abap_behv=>mk-on
*  legalclassification            =  if_abap_behv=>mk-on
*  legalentityname               =  if_abap_behv=>mk-on
*  localterminalname             =  if_abap_behv=>mk-on
*  nodecode                       =  if_abap_behv=>mk-on
*  longitude                       =  if_abap_behv=>mk-on
*  maintenancemanager             =  if_abap_behv=>mk-on
*  maintenancemanagername        =  if_abap_behv=>mk-on
*  managingdirector               =  if_abap_behv=>mk-on
*  managingdirectorname          =  if_abap_behv=>mk-on
*  nodedesc                       =  if_abap_behv=>mk-on
*  nodekey                        =  if_abap_behv=>mk-on
*  nodelevel                      =  if_abap_behv=>mk-on
*  notes                           =  if_abap_behv=>mk-on
*  office                          =  if_abap_behv=>mk-on
*  organisation1                  =  if_abap_behv=>mk-on
*  ownership                       =  if_abap_behv=>mk-on
*  parentcode                     =  if_abap_behv=>mk-on
*  parentdesc                     =  if_abap_behv=>mk-on
*  parentlevel                    =  if_abap_behv=>mk-on
*  parentnode                     =  if_abap_behv=>mk-on
*  phonenumber                    =  if_abap_behv=>mk-on
*  portauthority                  =  if_abap_behv=>mk-on
*  postalcode                     =  if_abap_behv=>mk-on
*  primarycontact                 =  if_abap_behv=>mk-on
*  recordtype                     =  if_abap_behv=>mk-on
*  region                          =  if_abap_behv=>mk-on
*  renewalcontact                 =  if_abap_behv=>mk-on
*  states                          =  if_abap_behv=>mk-on
*  stateonl                       =  if_abap_behv=>mk-on
*  subbrand                       =  if_abap_behv=>mk-on
*  level3id                      =  if_abap_behv=>mk-on
*  terminalnamelocal             =  if_abap_behv=>mk-on
*  vendorportalterminal          =  if_abap_behv=>mk-on
*  warehouse                       =  if_abap_behv=>mk-on
*  createdby                       =  if_abap_behv=>mk-on
*  createdat                       =  if_abap_behv=>mk-on
*  lastchangedby                   =  if_abap_behv=>mk-on
*  lastchangedat                   =  if_abap_behv=>mk-on
*  locallastchangedat              =  if_abap_behv=>mk-on
*
*                    )
*                )
*            )
*        )
*    ).
*
*    "Delete Existing entry for user if any
*    READ ENTITIES OF zr_tgrc_file_loc IN LOCAL MODE
*    ENTITY XLHead BY \_XLData
*    ALL FIELDS WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_existing_XLData).
*    IF lt_existing_XLData IS NOT INITIAL.
*      MODIFY ENTITIES OF zr_tgrc_file_loc IN LOCAL MODE
*      ENTITY XLData DELETE FROM VALUE #(
*        FOR lwa_data IN lt_existing_XLData (
*          %key        = lwa_data-%key
*          %is_draft   = lwa_data-%is_draft
*        )
*      )
*      MAPPED DATA(lt_del_mapped)
*      REPORTED DATA(lt_del_reported)
*      FAILED DATA(lt_del_failed).
*    ENDIF.
*
*    "Add New Entry for XLData (association)
*    MODIFY ENTITIES OF zr_tgrc_file_loc IN LOCAL MODE
*    ENTITY XLHead CREATE BY \_XLData
*    AUTO FILL CID WITH lt_data.
*
*    "Modify Status
*    MODIFY ENTITIES OF zr_tgrc_file_loc IN LOCAL MODE
*    ENTITY XLHead
*    UPDATE FROM VALUE #(  (
*        %tky        = lt_file_entity[ 1 ]-%tky "keys[ 1 ]-%tky
*        FileStatus  = 'File Uploaded'
*        %control-FileStatus = if_abap_behv=>mk-on
*        %control-FileId = if_abap_behv=>mk-on
*        ) )
*    MAPPED DATA(lt_upd_mapped)
*    FAILED DATA(lt_upd_failed)
*    REPORTED DATA(lt_upd_reported).
*
*    "Read Updated Entry
*    READ ENTITIES OF zr_tgrc_file_loc IN LOCAL MODE
*    ENTITY XLHead ALL FIELDS WITH CORRESPONDING #( Keys )
*    RESULT DATA(lt_updated_XLHead).
*
*    "Send Status back to front end
*    result = VALUE #(
*      FOR lwa_upd_head IN lt_updated_XLHead (
*        %tky    = lwa_upd_head-%tky
*        %param  = lwa_upd_head
*      )
*    ).



  ENDMETHOD.



ENDCLASS.

CLASS lsc_XLHead DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.
ENDCLASS.


CLASS lsc_XLHead IMPLEMENTATION.

  METHOD save_modified.
    DATA : lt_grc_locationx TYPE STANDARD TABLE OF ztgrc_locationx.
    DATA : lt_tgrc_migr TYPE STANDARD TABLE OF ztgrc_loc_migr.
*    IF create-xldata IS NOT INITIAL.

      IF create-xlhead IS NOT INITIAL.
        DATA(ls_xlhead) = create-xlhead[ 1 ].
*        lt_tgrc_migr[] = CORRESPONDING #( create-xldata[] ).
            READ ENTITIES OF zr_tgrc_file_loc IN LOCAL MODE
            ENTITY XLHead BY \_XLData
            ALL FIELDS WITH VALUE #( ( %tky-fileid = ls_xlhead-fileid  ) )
            RESULT DATA(lt_temp_loc_migr).
      ELSEIF update-xlhead IS NOT INITIAL.
        ls_xlhead = VALUE #( update-xlhead[ 1 ] OPTIONAL ).
            READ ENTITIES OF zr_tgrc_file_loc IN LOCAL MODE
            ENTITY XLHead BY \_XLData
            ALL FIELDS WITH VALUE #( ( %tky-fileid = ls_xlhead-fileid  ) )
            RESULT lt_temp_loc_migr.

*        lt_tgrc_migr[] = CORRESPONDING #( lt_temp_loc_migr[] ).
      ENDIF.

*IF ( ( create-xlhead IS NOT INITIAL AND lt_tgrc_migr[] IS NOT INITIAL ) OR
*     ( update-xlhead IS NOT INITIAL AND lt_temp_loc_migr IS NOT INITIAL ) ) AND
IF ( create-xlhead IS NOT INITIAL OR update-xlhead IS NOT INITIAL ) AND
   lt_temp_loc_migr IS NOT INITIAL AND
   ls_xlhead-updateMainTable EQ abap_true.
*if lt_temp_loc_migr IS NOT INITIAL AND
*   ls_xlhead-updateMainTable EQ abap_true.
*      lt_grc_location = CORRESPONDING #(  lt_tgrc_migr ).

lt_grc_locationx = VALUE #(
                    FOR ls_grc_location IN lt_temp_loc_migr
                    (
                        location_uuid                  = ls_grc_location-LocationUuid
                        level_1_id                     = ls_grc_location-Level1Id
                        address_line1                  = ls_grc_location-AddressLine1
                        address_line2                  = ls_grc_location-AddressLine2
                        allow_agreed_value_input       = ls_grc_location-AllowAgreedValueInput
                        bim                            = ls_grc_location-Bim
                        bim_date                       = ls_grc_location-BimDate
                        brand                          = ls_grc_location-Brand
                        business_area                  = ls_grc_location-BusinessArea
                        level_2_id                     = ls_grc_location-Level2Id
                        level_4_id                     = ls_grc_location-Level4Id
                        business_unit_onl_and_others   = ls_grc_location-BusinessUnitOnlAndOthers
                        cell_phone_number              = ls_grc_location-CellPhoneNumber
                        chief_financial_officer        = ls_grc_location-ChiefFinancialOfficer
                        chief_financial_officer_name   = ls_grc_location-ChiefFinancialOfficerName
                        chief_operating_officer        = ls_grc_location-ChiefOperatingOfficer
                        chief_operating_officer_name   = ls_grc_location-ChiefOperatingOfficerName
                        city                           = ls_grc_location-City
                        level_5_id                     = ls_grc_location-Level5Id
                        country_onl                    = ls_grc_location-CountryOnl
                        country                        = ls_grc_location-Country
                        currency                       = ls_grc_location-Currency
                        date_active                    = ls_grc_location-DateActive
                        date_inactive                  = ls_grc_location-DateInactive
                        cfo_email                      = ls_grc_location-CfoEmail
                        coo_email                      = ls_grc_location-CooEmail
                        hse_email                      = ls_grc_location-HseEmail
                        maintance_man_email            = ls_grc_location-MaintanceManEmail
                        managing_director_email        = ls_grc_location-ManagingDirectorEmail
                        lch_email                      = ls_grc_location-LchEmail
                        lch2_email                     = ls_grc_location-Lch2Email
                        location_status                = ls_grc_location-LocationStatus
                        fax_number                     = ls_grc_location-FaxNumber
                        former                         = ls_grc_location-Former
                        grm_claim_use_only             = ls_grc_location-GrmClaimUseOnly
                        hermes_code                    = ls_grc_location-HermesCode
                        hqfm_code                      = ls_grc_location-HqfmCode
                        hse_manger                     = ls_grc_location-HseManger
                        hse_manger_name                = ls_grc_location-HseMangerName
                        include_in_renewal_collection  = ls_grc_location-IncludeInRenewalCollection
                        latitude                       = ls_grc_location-Latitude
                        lead_claims_handler            = ls_grc_location-LeadClaimsHandler
                        lead_claims_handler_2          = ls_grc_location-LeadClaimsHandler2
                        lead_claims_handler_2_name     = ls_grc_location-LeadClaimsHandler2Name
                        lead_claims_handler_name       = ls_grc_location-LeadClaimsHandlerName
                        legal_classification           = ls_grc_location-LegalClassification
                        legal_entity_name              = ls_grc_location-LegalEntityName
                        local_terminal_name            = ls_grc_location-LocalTerminalName
                        node_code                      = ls_grc_location-NodeCode
                        longitude                      = ls_grc_location-Longitude
                        maintenance_manager            = ls_grc_location-MaintenanceManager
                        maintenance_manager_name       = ls_grc_location-MaintenanceManagerName
                        managing_director              = ls_grc_location-ManagingDirector
                        managing_director_name         = ls_grc_location-ManagingDirectorName
                        node_desc                      = ls_grc_location-NodeDesc
                        node_key                       = ls_grc_location-NodeKey
                        node_level                     = ls_grc_location-NodeLevel
                        notes                          = ls_grc_location-Notes
                        office                         = ls_grc_location-Office
                        organisation_1                 = ls_grc_location-Organisation1
                        ownership                      = ls_grc_location-Ownership
                        parent_code                    = ls_grc_location-ParentCode
                        parent_desc                    = ls_grc_location-ParentDesc
                        parent_level                   = ls_grc_location-ParentLevel
                        parent_node                    = ls_grc_location-ParentNode
                        phone_number                   = ls_grc_location-PhoneNumber
                        port_authority                 = ls_grc_location-PortAuthority
                        postal_code                    = ls_grc_location-PostalCode
                        primary_contact                = ls_grc_location-PrimaryContact
                        record_type                    = ls_grc_location-RecordType
                        region                         = ls_grc_location-Region
                        renewal_contact                = ls_grc_location-RenewalContact
                        states                         = ls_grc_location-States
                        state_onl                      = ls_grc_location-StateOnl
                        sub_brand                      = ls_grc_location-SubBrand
                        level_3_id                     = ls_grc_location-Level3Id
                        terminal_name_local            = ls_grc_location-TerminalNameLocal
                        vendor_portal_terminal         = ls_grc_location-VendorPortalTerminal
                        warehouse                      = ls_grc_location-Warehouse
                        createdby                      = ls_grc_location-Createdby
                        createdat                      = ls_grc_location-Createdat
                        lastchangedby                  = ls_grc_location-Lastchangedby
                        lastchangedat                  = ls_grc_location-Lastchangedat
                        locallastchangedat             = ls_grc_location-Locallastchangedat ) ).


      IF  lt_grc_locationx IS NOT INITIAL.

        MODIFY ztgrc_locationx FROM TABLE @lt_grc_locationx.
      ENDIF.

    ENDIF.

  ENDMETHOD.

ENDCLASS.
CLASS lhc_XLData DEFINITION INHERITING FROM cl_abap_behavior_handler.


  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR XLData RESULT result.

    METHODS processData FOR MODIFY
      IMPORTING keys FOR ACTION XLData~processData RESULT result.

ENDCLASS.

CLASS lhc_XLData IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD processData.
  ENDMETHOD.


ENDCLASS.
