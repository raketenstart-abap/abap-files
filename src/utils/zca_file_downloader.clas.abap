CLASS zca_file_downloader DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !io_file_frontend_service_wrap TYPE REF TO zif_file_frontend_service_wrap OPTIONAL
        !io_file_scms_wrap             TYPE REF TO zif_file_scms_wrap OPTIONAL
        !props                         TYPE zst_file_props .
    METHODS set_props
      IMPORTING
        !props TYPE zst_file_props .
  PROTECTED SECTION.

    DATA mo_file_scms_wrap TYPE REF TO zif_file_scms_wrap .
    DATA ms_file_props TYPE zst_file_props .

    METHODS download
      IMPORTING
        !iv_file_extension TYPE string OPTIONAL
        !iv_file_name      TYPE string
        !iv_file_filter    TYPE string DEFAULT '*.*'
        !it_data           TYPE STANDARD TABLE
      RAISING
        zcx_file_frontend_service_wrap .
  PRIVATE SECTION.

    DATA mo_file_frontend_service_wrap TYPE REF TO zif_file_frontend_service_wrap .
ENDCLASS.



CLASS zca_file_downloader IMPLEMENTATION.


  METHOD constructor.

    IF io_file_frontend_service_wrap IS BOUND.
      mo_file_frontend_service_wrap = io_file_frontend_service_wrap.
    ELSE.
      CREATE OBJECT mo_file_frontend_service_wrap TYPE zcl_file_frontend_service_wrap.
    ENDIF.

    IF io_file_scms_wrap IS BOUND.
      mo_file_scms_wrap = io_file_scms_wrap.
    ELSE.
      CREATE OBJECT mo_file_scms_wrap TYPE zcl_file_scms_wrap.
    ENDIF.

    ms_file_props = props.

  ENDMETHOD.


  METHOD download.

    DATA(ls_file_save_dialog) = mo_file_frontend_service_wrap->file_save_dialog(
      iv_extension = iv_file_extension
      iv_filename  = iv_file_name
      iv_filter    = iv_file_filter
    ).

    IF ls_file_save_dialog-user_action = cl_gui_frontend_services=>action_cancel.
      MESSAGE s000(zcore).
      RETURN.
    ENDIF.

    mo_file_frontend_service_wrap->gui_download(
      iv_filename = ls_file_save_dialog-fullpath
      it_data     = it_data
    ).

  ENDMETHOD.


  METHOD set_props.
    ms_file_props = props.
  ENDMETHOD.
ENDCLASS.
