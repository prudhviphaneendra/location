CLASS lhc_zr_tgrc_location DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrTgrcLocation
        RESULT result,
      get_instance_features FOR INSTANCE FEATURES
            IMPORTING keys REQUEST requested_features FOR ZrTgrcLocation RESULT result,
      validateDate FOR VALIDATE ON SAVE
            IMPORTING keys FOR ZrTgrcLocation~validateDate,
       validateNodeLevel FOR VALIDATE ON SAVE
            IMPORTING keys FOR ZrTgrcLocation~validateNodeLevel,
       setLocationStatus FOR DETERMINE ON MODIFY
            IMPORTING keys FOR ZrTgrcLocation~setLocationStatus,
      copy FOR MODIFY
            IMPORTING keys FOR ACTION ZrTgrcLocation~copy,
      get_instance_authorizations FOR INSTANCE AUTHORIZATION
            IMPORTING keys REQUEST requested_authorizations FOR ZrTgrcLocation RESULT result,
      get_global_features FOR GLOBAL FEATURES
            IMPORTING REQUEST requested_features FOR ZrTgrcLocation RESULT result.

    METHODS precheck_create FOR PRECHECK
      IMPORTING entities FOR CREATE ZrTgrcLocation.
    METHODS validateParentLevel FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZrTgrcLocation~validateParentLevel.
    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE ZrTgrcLocation.
    METHODS setparentlevel FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZrTgrcLocation~setparentlevel.
    METHODS setLocationID FOR DETERMINE ON SAVE
      IMPORTING keys FOR ZrTgrcLocation~setLocationID.
ENDCLASS.

CLASS lhc_zr_tgrc_location IMPLEMENTATION.
  METHOD get_global_authorizations.
*   zbp_r_tgrc_location=>lv_location_control = abap_true.
*if 1 = 2.
    IF requested_authorizations-%create = if_abap_behv=>mk-on.
      AUTHORITY-CHECK OBJECT 'ZGRC_LOC_O'
            ID 'ACTVT' FIELD '01'
            ID 'ZGRC_LOC_F' DUMMY.
      IF sy-subrc <> 0.
        result-%create = if_abap_behv=>auth-unauthorized.
        APPEND VALUE #( %msg      = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'operation not authorized!' ) )
                        TO reported-zrtgrclocation.
      ENDIF.
    ENDIF.
*endif.
*if requested_authorizations-%update = if_abap_behv=>mk-on.
*AUTHORITY-CHECK OBJECT 'ZGRC_LOC_O'
*      ID 'ACTVT' FIELD '02'
*      ID 'ZGRC_LOC_F' DUMMY.
*if sy-subrc <> 0.
*result-%update = if_abap_behv=>auth-unauthorized.
*endif.
*endif.
*if requested_authorizations-%delete = if_abap_behv=>mk-on.
*AUTHORITY-CHECK OBJECT 'ZGRC_LOC_O'
*      ID 'ACTVT' FIELD '06'
*      ID 'ZGRC_LOC_F' DUMMY.
*if sy-subrc <> 0.
*result-%delete = if_abap_behv=>auth-unauthorized.
*endif.
*endif.
*
*ENDIF.
  ENDMETHOD.
  METHOD get_instance_features.
*    zbp_r_tgrc_location=>lv_location_control = abap_true.
   READ ENTITIES OF zr_tgrc_location IN LOCAL MODE
      ENTITY ZrTgrcLocation
       ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_parent_node).

    " Loop at each requested key and set the control feature
    result = VALUE #( FOR ls_parentnode IN lt_parent_node
                      LET lv_disable_status = COND #( WHEN ls_parentnode-RecordType = 500013
                                                      THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )
                      IN
                      ( %tky              = ls_parentnode-%tky
                        %field-ParentNode = lv_disable_status
                      ) ).

  ENDMETHOD.
  METHOD validateDate.
    READ ENTITIES OF zr_tgrc_location IN LOCAL MODE
    ENTITY ZrTgrcLocation
*    FIELDS ( DateActive DateInactive )
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_locations).
    LOOP AT lt_locations INTO DATA(ls_location).
      IF ls_location-dateactive IS INITIAL AND
         ls_location-dateinactive IS INITIAL.
        APPEND VALUE #( %tky = ls_location-%tky ) TO failed-ZrTgrcLocation.
        APPEND VALUE #( %tky = keys[ 1 ]-%tky
        %msg = new_message_with_text(
        severity = if_abap_behv_message=>severity-error
        text = 'Date Active and Date Inactive both cannot be blank at the same time' ) ) TO reported-zrtgrclocation.
      ELSEIF ls_location-dateactive IS NOT INITIAL AND
             ls_location-DateInactive IS NOT INITIAL.
        APPEND VALUE #( %tky = keys[ 1 ]-%tky
        %msg = new_message_with_text(
        severity = if_abap_behv_message=>severity-error
        text = 'Date Active and Date Inactive both cannot be populated at the same time' ) ) TO reported-zrtgrclocation.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  METHOD validateNodeLevel.
    READ ENTITIES OF zr_tgrc_location IN LOCAL MODE
      ENTITY ZrTgrcLocation
*      FIELDS ( ParentLevel ParentNode NodeLevel )
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_locations).
    DATA(lv_message) = |Must provide a parent level value for any parent node at level 4 or below. |.
    LOOP AT lt_locations INTO DATA(ls_location).
      IF ls_location-NodeLevel IS INITIAL.
        APPEND VALUE #( %tky = ls_location-%tky  %update = if_abap_behv=>mk-on  ) TO failed-ZrTgrcLocation.
        APPEND VALUE #( %tky = keys[ 1 ]-%tky
        %msg = new_message_with_text(
        severity = if_abap_behv_message=>severity-error
        text = 'Please provide a value for Node Level' ) ) TO reported-zrtgrclocation.

      ENDIF.
      IF ls_location-ParentNode IS INITIAL AND ls_location-RecordType <> 500013  .
        APPEND VALUE #( %tky = ls_location-%tky ) TO failed-ZrTgrcLocation.
        APPEND VALUE #( %tky = keys[ 1 ]-%tky
        %msg = new_message_with_text(
        severity = if_abap_behv_message=>severity-error
        text = 'Please provide a value for Parent Node' ) ) TO reported-zrtgrclocation.

      ENDIF.
      IF ( ls_location-ParentLevel IS INITIAL AND ls_location-RecordType <> 500013 ).
*         ( ls_location-ParentLevel IS INITIAL AND ls_location-NodeLevel <> 5 ).
        APPEND VALUE #( %tky = ls_location-%tky ) TO failed-ZrTgrcLocation.
        APPEND VALUE #( %tky = keys[ 1 ]-%tky
        %msg = new_message_with_text(
        severity = if_abap_behv_message=>severity-error
        text = 'Please provide a value for Parent level' ) ) TO reported-zrtgrclocation.

      ENDIF.
    ENDLOOP.
*
  ENDMETHOD.
*   METHOD validateNodeLevel.
*    READ ENTITIES OF zr_tgrc_location IN LOCAL MODE
*      ENTITY ZrTgrcLocation
*      FIELDS ( ParentLevel ParentNode  )
*      WITH CORRESPONDING #( keys )
*      RESULT DATA(lt_locations).
*      DATA(lv_message) = |Must provide a parent level value for any parent node at level 4 or below. |.
*    LOOP AT lt_locations INTO DATA(ls_location).
*     IF ( ls_location-ParentNode IS INITIAL OR ls_location-ParentNode BETWEEN 0 AND 5 ) OR ls_location-ParentLevel IS INITIAL.
*       APPEND VALUE #( %tky = ls_location-%tky ) to failed-ZrTgrcLocation.
*       APPEND VALUE #( %tky = keys[ 1 ]-%tky
*       %msg = new_message(
*                id       = 'ZCL_GRC_MESSAGES'
*                number   = '002'
*                severity = if_abap_behv_message=>severity-error
*              ) ) to reported-zrtgrclocation.
*           %msg = new_message(
*                id       = 'ZCL_GRC_MESSAGES'
*                number   = '002'
*               severity = if_abap_behv_message=>severity-error
*               v1 = 'This is very very very very very very very very very'
*               v2 = 'very very very very very very very very very long text' ) ) TO reported-zrtgrclocation.
*
*     ENDIF.
*    ENDLOOP.
*
*  ENDMETHOD.

  METHOD setLocationStatus.
    DATA: lc_status_active   TYPE zgrc_formula_text VALUE 'ACTIVE',
          lc_status_inactive TYPE zgrc_formula_text VALUE 'INACTIVE',
          lt_location        TYPE TABLE FOR UPDATE zr_tgrc_location.

    READ ENTITIES OF zr_tgrc_location IN LOCAL MODE
     ENTITY ZrTgrcLocation
     FIELDS ( DateActive LocationStatus )
     WITH CORRESPONDING #( keys )
     RESULT DATA(lt_locations).
    LOOP AT lt_locations ASSIGNING FIELD-SYMBOL(<lfs_location>).
      IF <lfs_location> IS ASSIGNED.
        IF <lfs_location>-DateActive IS NOT INITIAL.
          MODIFY ENTITIES OF zr_tgrc_location IN LOCAL MODE
          ENTITY ZrTgrcLocation
          UPDATE FIELDS ( LocationStatus )
          WITH VALUE #( FOR ZrTgrcLocation IN lt_locations ( %tky = ZrTgrcLocation-%tky
                                                               LocationStatus = lc_status_active ) ).
        ELSE.
          MODIFY ENTITIES OF zr_tgrc_location IN LOCAL MODE
          ENTITY ZrTgrcLocation
          UPDATE FIELDS ( LocationStatus )
          WITH VALUE #( FOR ZrTgrcLocation IN lt_locations ( %tky = ZrTgrcLocation-%tky
                                                              LocationStatus = lc_status_inactive ) ).
        ENDIF.
      ENDIF.
    ENDLOOP.
    "   MOVE-CORRESPONDING lt_locations TO lt_location.
    "     MODIFY ENTITIES OF zr_trmis_location IN LOCAL MODE
    "      ENTITY ZrTrmisLocation
    "      UPDATE FIELDS ( LocationStatus )
    "      WITH VALUE #( FOR ZrTrmisLocation IN lt_locations ( %tky = ZrTrmisLocation-%tky
    "                                                      LocationStatus = COND zrmis_formula_text(
    "                                                      WHEN ZrTrmisLocation-DateActive IS NOT INITIAL THEN lc_status_active
    "                                                      ELSE  lc_status_inactive ) ) ).
    "(   if ls_location-dateactive is not initial then lc_status_active
    "                  else lc_status_inactive ) ) ).

  ENDMETHOD.
  METHOD copy.
    DATA: lt_locations       TYPE TABLE FOR CREATE zr_tgrc_location\\ZrTgrcLocation.


    READ TABLE keys WITH KEY %cid = '' INTO DATA(key_with_inital_cid).
    ASSERT key_with_inital_cid IS INITIAL.

    READ ENTITIES OF zr_tgrc_location IN LOCAL MODE
      ENTITY ZrTgrcLocation
       ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_location)
    FAILED failed.

    LOOP AT lt_location ASSIGNING FIELD-SYMBOL(<lfs_location>).
      "Fill travel container for creating new travel instance
*      APPEND VALUE #( %cid     = keys[ %tky = <lfs_policy>-%tky ]-%cid
*                      %data    = CORRESPONDING #( <lfs_policy> ) )
*        TO lt_policy ASSIGNING FIELD-SYMBOL(<new_policy>).

      APPEND VALUE #( %cid = keys[ %tky = <lfs_location>-%tky ]-%cid
                    %data = CORRESPONDING #( <lfs_location> )
     ) TO lt_locations ASSIGNING FIELD-SYMBOL(<lfs_newlocation>).

    ENDLOOP.

    MODIFY ENTITIES OF zr_tgrc_location IN LOCAL MODE
         ENTITY ZrTgrcLocation
             CREATE FIELDS (
   AddressLine1
   AddressLine2
   AllowAgreedValueInput
   Bim
   BimDate
   Brand
   BusinessArea
   Level2Id
   Level4Id
   BusinessUnitOnlAndOthers
   CellPhoneNumber
*   ChiefFinancialOfficer
   ChiefFinancialOfficerName
*   ChiefOperatingOfficer
*   ChiefOperatingOfficerName
   City
   Level5Id
   CountryOnl
   Country
   Currency
   DateActive
   DateInactive
   CfoEmail
*   CooEmail
*   HseEmail
*   MaintanceManEmail
*   ManagingDirectorEmail
*   LchEmail
*   Lch2Email
   LocationStatus
   FaxNumber
   Former
   GrmClaimUseOnly
   HermesCode
   HqfmCode
*   HseManger
*   HseMangerName
   IncludeInRenewalCollection
   Latitude
*   LeadClaimsHandler
*   LeadClaimsHandler2
*   LeadClaimsHandler2Name
*   LeadClaimsHandlerName
   LegalClassification
   LegalEntityName
   LocalTerminalName
   NodeCode
   Longitude
*   MaintenanceManager
*   MaintenanceManagerName
*   ManagingDirector
*   ManagingDirectorName
   NodeDesc
   NodeKey
   NodeLevel
   Notes
   Office
   Organisation1
   Ownership
   ParentCode
   ParentDesc
   ParentLevel
   ParentNode
   PhoneNumber
   PortAuthority
   PostalCode
   PrimaryContact
   Region
   RenewalContact
   States
   StateOnl
   SubBrand
   Level3Id
   TerminalNameLocal
   VendorPortalTerminal
   Warehouse
   Createdby
   Createdat
   Lastchangedby
   Lastchangedat
   Locallastchangedat
   ) WITH lt_locations
   MAPPED DATA(lt_maplocation).
    mapped-zrtgrclocation = lt_maplocation-zrtgrclocation.
  ENDMETHOD.
  METHOD get_instance_authorizations.

*  if 1 = 2.
    IF requested_authorizations-%update EQ if_abap_behv=>mk-on OR
       requested_authorizations-%delete EQ if_abap_behv=>mk-on.
      READ ENTITIES OF zr_tgrc_location IN LOCAL MODE
                ENTITY ZrTgrcLocation
                  FIELDS ( RecordType )
                  WITH CORRESPONDING #( keys )
                RESULT DATA(lt_rectyp)
                FAILED failed.

      CHECK lt_rectyp IS NOT INITIAL.
      LOOP AT lt_rectyp INTO DATA(ls_rectyp).
        IF requested_authorizations-%update EQ if_abap_behv=>mk-on.
          AUTHORITY-CHECK OBJECT 'ZGRC_LOC_O'
          ID 'ACTVT' FIELD '02'
          ID 'ZGRC_LOC_F' FIELD ls_rectyp-RecordType.
          IF sy-subrc = 0.
            DATA(lv_update) = abap_true.
          ENDIF.

        ENDIF.
        IF requested_authorizations-%delete EQ if_abap_behv=>mk-on.
          AUTHORITY-CHECK OBJECT 'ZGRC_LOC_O'
          ID 'ACTVT' FIELD '06'
          ID 'ZGRC_LOC_F' FIELD ls_rectyp-RecordType.
          IF sy-subrc = 0.
            DATA(lv_delete) = abap_true.
          ENDIF.

        ENDIF.
        APPEND VALUE #(  %tky    = ls_rectyp-%tky
                           %update = COND #( WHEN lv_update = abap_false
                                             THEN if_abap_behv=>auth-unauthorized
                                             ELSE if_abap_behv=>auth-allowed )
                           %action = VALUE #( edit = COND #( WHEN lv_update = abap_false
                                             THEN if_abap_behv=>auth-unauthorized
                                             ELSE if_abap_behv=>auth-allowed ) )
                           %delete = COND #( WHEN lv_delete = abap_false
                                             THEN if_abap_behv=>auth-unauthorized
                                             ELSE if_abap_behv=>auth-allowed )
                                              )  TO result.

      ENDLOOP.

    ENDIF.
  ENDMETHOD.

  METHOD get_global_features.
    IF 1 = 2.

    ENDIF.
*if requested_features-%create = if_abap_behv=>mk-on.
*AUTHORITY-CHECK OBJECT 'ZGRC_LOC_O'
*      ID 'ACTVT' FIELD '01'
*      ID 'ZGRC_LOC_F' DUMMY.
*if sy-subrc <> 0.
*result-%create = if_abap_behv=>fc-o-disabled.
*endif.
*endif.

  ENDMETHOD.

  METHOD precheck_create.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).
      AUTHORITY-CHECK OBJECT 'ZGRC_LOC_O'
            ID 'ACTVT' FIELD '01'
            ID 'ZGRC_LOC_F' FIELD <fs_entity>-RecordType.
      IF sy-subrc <> 0.
        "Return Error Message to Frontend.
        APPEND VALUE #(  %cid =  <fs_entity>-%cid ) TO failed-zrtgrclocation.
        APPEND VALUE #(  %cid =  <fs_entity>-%cid
                         %msg = new_message_with_text(
                            severity = if_abap_behv_message=>severity-error
                            text = |No Autorization to create location for RecType{  <fs_entity>-RecordType }|
                          )  ) TO reported-zrtgrclocation.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  METHOD precheck_update.
*    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity_up>).
*     IF <fs_entity_up>-NodeLevel IS INITIAL.
*             APPEND VALUE #( %tky = <fs_entity_up>-%tky )
*         TO failed-zrtgrclocation.
*         APPEND VALUE #( %tky = <fs_entity_up>-%tky
*          %msg = new_message_with_text(
*       severity = if_abap_behv_message=>severity-error
*
*       text = 'Please provide a value for Node level' ) ) to reported-zrtgrclocation.
*     ENDIF.
*     ENDLOOP.
  ENDMETHOD.

  METHOD validateParentLevel.
*    READ ENTITY IN LOCAL MODE zr_tgrc_location
*    FIELDS ( NodeLevel )
*    WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_parentlevel).
*
*    LOOP AT lt_parentlevel ASSIGNING FIELD-SYMBOL(<ls_parentlevel>).
*      IF <ls_parentlevel>-NodeLevel IS INITIAL.
*        APPEND VALUE #( %tky = <ls_parentlevel>-%tky )
*         TO failed-zrtgrclocation.
*        APPEND VALUE #( %tky = <ls_parentlevel>-%tky
*         %msg = new_message_with_text(
*      severity = if_abap_behv_message=>severity-error
*
*      text = 'Please provide a value for Node level' ) ) TO reported-zrtgrclocation.
*
*      ENDIF.
*    ENDLOOP.
  ENDMETHOD.



  METHOD setparentlevel.
    READ ENTITY IN LOCAL MODE zr_tgrc_location
 FIELDS ( ParentNode )
 WITH CORRESPONDING #( keys )
 RESULT DATA(lt_parentnode).

    IF lt_parentnode IS NOT INITIAL.

      SELECT location_uuid, level_1_id, node_level, parent_node
      FROM ztgrc_locationx
      FOR ALL ENTRIES IN @lt_parentnode
      WHERE level_1_id = @lt_parentnode-ParentNode
      INTO TABLE @DATA(lt_nodes).

      IF sy-subrc = 0.
        LOOP AT lt_nodes ASSIGNING FIELD-SYMBOL(<lf_nodes>).
         READ TABLE lt_parentnode INTO DATA(ls_parentnode) WITH KEY ParentNode = <lf_nodes>-level_1_id.
           IF sy-subrc = 0.
              MODIFY ENTITIES OF zr_tgrc_location IN LOCAL MODE
           ENTITY ZrTgrcLocation
           UPDATE FIELDS ( ParentLevel )
           WITH VALUE #( ( %tky = ls_parentnode-%tky  ParentLevel = <lf_nodes>-node_level ) ).
           ENDIF.
        ENDLOOP.
      ENDIF.

    ENDIF.
  ENDMETHOD.

  METHOD setLocationID.
***     DATA(random) = cl_abap_random_int=>create( min = 1 max = 100 ).
***    MODIFY ENTITIES OF demo_sales_cds_so_2 IN LOCAL MODE
***      ENTITY SalesOrder
***      UPDATE FROM VALUE #( FOR sales IN keys
***                         ( SoKey = sales-%key-SoKey
***                           SalesOrderId = random->get_next(  )
***                           %control-SalesOrderId   = if_abap_behv=>mk-on ) ).
 IF 1 = 2.
    READ ENTITY IN LOCAL MODE zr_tgrc_location
    FIELDS ( LocationID )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_parentnode).

   IF lt_parentnode IS NOT INITIAL.
     LOOP AT lt_parentnode ASSIGNING FIELD-SYMBOL(<lf_nodes>) WHERE LocationID IS INITIAL.
       TRY.
           cl_numberrange_runtime=>number_get(
      EXPORTING nr_range_nr = '01'
                object      = 'ZGRC_LOC_N'
      IMPORTING number      = DATA(ld_number)
                returncode  = DATA(ld_rcode) ).
         CATCH cx_root.

       ENDTRY.
       IF ld_number IS NOT INITIAL.
         MODIFY ENTITIES OF zr_tgrc_location IN LOCAL MODE
        ENTITY ZrTgrcLocation
        UPDATE FIELDS ( LocationID )
        WITH VALUE #( ( %tky = <lf_nodes>-%tky  LocationID = ld_number
                        %control-LocationID = if_abap_behv=>mk-on ) ).
       ENDIF.
       CLEAR:ld_number.
     ENDLOOP.
   ENDIF.
 ENDIF.
  ENDMETHOD.

ENDCLASS.
