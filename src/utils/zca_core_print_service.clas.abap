CLASS zca_core_print_service DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !io_core_frontend_service_wrap TYPE REF TO zif_core_frontend_service_wrap OPTIONAL
        !io_core_scms_wrap             TYPE REF TO zif_core_scms_wrap OPTIONAL .
protected section.

  data MO_CORE_SCMS_WRAP type ref to ZIF_CORE_SCMS_WRAP .

  methods DOWNLOAD
    importing
      !IV_FILE_EXTENSION type STRING optional
      !IV_FILE_NAME type STRING
      !IV_FILE_FILTER type STRING default '*.*'
      !IT_DATA type STANDARD TABLE
    raising
      ZCX_CORE_FRONTEND_SERVICE_WRAP .
private section.

  data MO_CORE_FRONTEND_SERVICE_WRAP type ref to ZIF_CORE_FRONTEND_SERVICE_WRAP .
ENDCLASS.



CLASS ZCA_CORE_PRINT_SERVICE IMPLEMENTATION.


  METHOD constructor.

    IF io_core_frontend_service_wrap IS BOUND.
      mo_core_frontend_service_wrap = io_core_frontend_service_wrap.
    ELSE.
      CREATE OBJECT mo_core_frontend_service_wrap TYPE zcl_core_frontend_service_wrap.
    ENDIF.

    IF io_core_scms_wrap IS BOUND.
      mo_core_scms_wrap = io_core_scms_wrap.
    ELSE.
      CREATE OBJECT mo_core_scms_wrap TYPE zcl_core_scms_wrap.
    ENDIF.

  ENDMETHOD.


  METHOD download.

    DATA(ls_file_save_dialog) = mo_core_frontend_service_wrap->file_save_dialog(
      iv_extension = iv_file_extension
      iv_filename  = iv_file_name
      iv_filter    = iv_file_filter
    ).

    IF ls_file_save_dialog-user_action = cl_gui_frontend_services=>action_cancel.
      MESSAGE s000(zcore).
      RETURN.
    ENDIF.

    mo_core_frontend_service_wrap->gui_download(
      iv_filename = ls_file_save_dialog-fullpath
      it_data     = it_data
    ).

  ENDMETHOD.
ENDCLASS.
