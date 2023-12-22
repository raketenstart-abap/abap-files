CLASS zcl_file_downloader DEFINITION
  PUBLIC
  INHERITING FROM zca_file_downloader
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_file_downloader .

    METHODS constructor
      IMPORTING
        !props TYPE zst_file_props OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_file_downloader IMPLEMENTATION.


  METHOD constructor.

    super->constructor( props = props ).

  ENDMETHOD.


  METHOD zif_file_downloader~local.

    TRY.
        DATA(ls_data_binary) = mo_file_scms_wrap->scms_xstring_to_binary(
          iv_buffer = ms_file_props-raw
        ).

        download(
          iv_file_extension = ms_file_props-extension
          iv_file_name      = ms_file_props-name
          iv_file_filter    = ms_file_props-filter
          it_data           = ls_data_binary-binary_tab
        ).

      CATCH zcx_file_scms_wrap.
        RAISE EXCEPTION TYPE zcx_file_scms_wrap
          EXPORTING
            textid = zcx_file_scms_wrap=>xstring_to_binary_failed.

      CATCH zcx_file_frontend_service_wrap.
        RAISE EXCEPTION TYPE zcx_file_wrap
          EXPORTING
            textid = zcx_file_wrap=>conversion_failed.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
