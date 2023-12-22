CLASS zcl_file_frontend_service_wrap DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_file_frontend_service_wrap .

    CONSTANTS:
      BEGIN OF sc_file_open_dialog .
    CONSTANTS cancel TYPE i VALUE '9'.
    CONSTANTS: END OF sc_file_open_dialog .
    CONSTANTS:
      BEGIN OF sc_file_type .
    CONSTANTS bin TYPE char10 VALUE 'BIN'.
    CONSTANTS asc TYPE char10 VALUE 'ASC'.
    CONSTANTS END OF sc_file_type .

    METHODS constructor
      IMPORTING
        !io_file_scms_wrap TYPE REF TO zif_file_scms_wrap OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mo_file_scms_wrap TYPE REF TO zif_file_scms_wrap .
ENDCLASS.



CLASS zcl_file_frontend_service_wrap IMPLEMENTATION.


  METHOD constructor.

    IF io_file_scms_wrap IS BOUND.
      mo_file_scms_wrap = io_file_scms_wrap.
    ELSE.
      CREATE OBJECT mo_file_scms_wrap TYPE zcl_file_scms_wrap.
    ENDIF.

  ENDMETHOD.


  METHOD zif_file_frontend_service_wrap~file_open_dialog.

    DATA lt_file_table TYPE filetable.

    cl_gui_frontend_services=>file_open_dialog(
      EXPORTING
        window_title            = iv_window_title
*        default_extension       =
*        default_filename        =
        file_filter             = iv_file_filter
*        with_encoding           =
        initial_directory       = iv_initial_directory
        multiselection          = iv_multiselection
      CHANGING
        file_table              = lt_file_table
        rc                      = result-return_code
        user_action             = result-user_action
        file_encoding           = result-file_encoding
      EXCEPTIONS
        file_open_dialog_failed = 1
        cntl_error              = 2
        error_no_gui            = 3
        not_supported_by_gui    = 4
        OTHERS                  = 5 ).

    IF sy-subrc <> 0.
      DATA(ls_bapiret) = zcl_core_bapiret_utils=>build_bapiret_from_syst( ).
      RAISE EXCEPTION TYPE zcx_file_frontend_service_wrap
        EXPORTING
          textid     = zcx_file_frontend_service_wrap=>open_failed
          mv_message = CONV #( ls_bapiret-message ).
    ENDIF.

    MOVE-CORRESPONDING lt_file_table[] TO result-file_table.

  ENDMETHOD.


  METHOD zif_file_frontend_service_wrap~file_save_dialog.

    cl_gui_frontend_services=>file_save_dialog(
      EXPORTING
        default_extension = iv_extension
        default_file_name = iv_filename
        file_filter       = iv_filter
      CHANGING
        filename          = result-filename
        path              = result-filepath
        fullpath          = result-fullpath
        user_action       = result-user_action
      EXCEPTIONS
        cntl_error                = 1
        error_no_gui              = 2
        not_supported_by_gui      = 3
        invalid_default_file_name = 4
        OTHERS                    = 5
    ).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_file_frontend_service_wrap
        EXPORTING
          textid = zcx_file_frontend_service_wrap=>save_failed.
    ENDIF.

  ENDMETHOD.


  METHOD zif_file_frontend_service_wrap~get_computer_name.

    DATA lv_computer_name TYPE string.

    cl_gui_frontend_services=>get_computer_name(
      CHANGING
        computer_name = lv_computer_name
      EXCEPTIONS
        cntl_error           = 1
        error_no_gui         = 2
        not_supported_by_gui = 3
    ).

    IF sy-subrc <> 0.
      CLEAR result.
      RETURN.
    ENDIF.

    result = lv_computer_name.

  ENDMETHOD.


  METHOD zif_file_frontend_service_wrap~get_ip.

    DATA lv_ip_address TYPE string.

    cl_gui_frontend_services=>get_ip_address(
      RECEIVING
        ip_address = lv_ip_address
      EXCEPTIONS
        cntl_error           = 1
        error_no_gui         = 2
        not_supported_by_gui = 3
    ).

    IF sy-subrc <> 0.
      CLEAR result.
      RETURN.
    ENDIF.

    result = lv_ip_address.

  ENDMETHOD.


  METHOD zif_file_frontend_service_wrap~gui_download.

    FIELD-SYMBOLS <fs_data_tab>    TYPE ANY TABLE.
    FIELD-SYMBOLS <fs_data_tab_in> TYPE ANY TABLE.

    DATA lt_data_tab_txt TYPE tline_tab.
    DATA lt_data_tab_hex TYPE solix_tab.
    DATA lr_data         TYPE REF TO data.

    DATA(lo_typedescr) = cl_abap_typedescr=>describe_by_data( it_data ).
    IF lo_typedescr->absolute_name CS 'TLINE'.
      lt_data_tab_txt[] = it_data[].
      ASSIGN lt_data_tab_txt TO <fs_data_tab>.
    ELSEIF lo_typedescr->absolute_name CS 'SOLIX'.
      lt_data_tab_hex[] = it_data[].
      ASSIGN lt_data_tab_hex TO <fs_data_tab>.
    ELSE.
      ASSIGN it_data TO <fs_data_tab_in>.

      CREATE DATA lr_data LIKE it_data.
      ASSIGN lr_data->* TO <fs_data_tab>.

      <fs_data_tab> = <fs_data_tab_in>.
    ENDIF.

    cl_gui_frontend_services=>gui_download(
      EXPORTING
        bin_filesize             = iv_filesize
        filename                 = iv_filename
        filetype                 = iv_filetype
        write_bom                = iv_write_bom
      CHANGING
        data_tab                 = <fs_data_tab>
      EXCEPTIONS
        file_write_error          = 1
        no_batch                  = 2
        gui_refuse_filetransfer   = 3
        invalid_type              = 4
        no_authority              = 5
        unknown_error             = 6
        header_not_allowed        = 7
        separator_not_allowed     = 8
        filesize_not_allowed      = 9
        header_too_long           = 10
        dp_error_create           = 11
        dp_error_send             = 12
        dp_error_write            = 13
        unknown_dp_error          = 14
        access_denied             = 15
        dp_out_of_memory          = 16
        disk_full                 = 17
        dp_timeout                = 18
        file_not_found            = 19
        dataprovider_exception    = 20
        control_flush_error       = 21
        not_supported_by_gui      = 22
        error_no_gui              = 23
        OTHERS   = 24 ).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_file_frontend_service_wrap
        EXPORTING
          textid      = zcx_file_frontend_service_wrap=>download_failed
          mv_filename = iv_filename.
    ENDIF.

  ENDMETHOD.


  METHOD zif_file_frontend_service_wrap~gui_upload.

    DATA lv_file_length TYPE int4.
    DATA lt_data_tab    TYPE ztt_file_raw.

    cl_gui_frontend_services=>gui_upload(
      EXPORTING
        filename                = iv_filename
        filetype                = iv_filetype
*        has_field_separator     = SPACE
*        header_length           = 0
*        read_by_line            = 'X'
*        dat_mode                = SPACE
*        codepage                = SPACE
*        ignore_cerr             = ABAP_TRUE
*        replacement             = '#'
*        virus_scan_profile      =
      IMPORTING
        filelength              = lv_file_length
*        header                  =
      CHANGING
        data_tab                = lt_data_tab
*        isscanperformed         = SPACE
      EXCEPTIONS
        file_open_error         = 1
        file_read_error         = 2
        no_batch                = 3
        gui_refuse_filetransfer = 4
        invalid_type            = 5
        no_authority            = 6
        unknown_error           = 7
        bad_data_format         = 8
        header_not_allowed      = 9
        separator_not_allowed   = 10
        header_too_long         = 11
        unknown_dp_error        = 12
        access_denied           = 13
        dp_out_of_memory        = 14
        disk_full               = 15
        dp_timeout              = 16
        not_supported_by_gui    = 17
        error_no_gui            = 18
        OTHERS                  = 19
    ).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_file_frontend_service_wrap
        EXPORTING
          textid      = zcx_file_frontend_service_wrap=>upload_failed
          mv_filename = iv_filename.
    ENDIF.

    result-name   = iv_filename.
    result-length = lv_file_length.

    result-raw = mo_file_scms_wrap->scms_binary_to_xstring(
      iv_length = lv_file_length
      it_data   = lt_data_tab
    ).

  ENDMETHOD.
ENDCLASS.
