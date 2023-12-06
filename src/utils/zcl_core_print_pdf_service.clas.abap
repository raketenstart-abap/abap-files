CLASS zcl_core_print_pdf_service DEFINITION
  PUBLIC
  INHERITING FROM zca_core_print_service
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_core_print_pdf_service .

    METHODS constructor
      IMPORTING
        !io_pdf_wrap  TYPE REF TO zif_core_pdf_wrap OPTIONAL
        !io_scms_wrap TYPE REF TO zif_core_scms_wrap OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mo_pdf_wrap TYPE REF TO zif_core_pdf_wrap .
    DATA mo_scms_wrap TYPE REF TO zif_core_scms_wrap .
ENDCLASS.



CLASS ZCL_CORE_PRINT_PDF_SERVICE IMPLEMENTATION.


  METHOD constructor.

    super->constructor( ).

    IF io_pdf_wrap IS BOUND.
      mo_pdf_wrap = io_pdf_wrap.
    ELSE.
      CREATE OBJECT mo_pdf_wrap TYPE zcl_core_pdf_wrap.
    ENDIF.

    IF io_scms_wrap IS BOUND.
      mo_scms_wrap = io_scms_wrap.
    ELSE.
      CREATE OBJECT mo_scms_wrap TYPE zcl_core_scms_wrap.
    ENDIF.

  ENDMETHOD.


  METHOD zif_core_print_pdf_service~download.

    DATA(lt_data_pdf) = mo_pdf_wrap->convert_otf_to_pdf( it_data ).

    download(
      iv_file_extension = zcl_core_pdf_file=>file_extension
      iv_file_name      = iv_filename
      iv_file_filter    = zcl_core_pdf_file=>file_filter
      it_data           = lt_data_pdf
    ).

  ENDMETHOD.


  METHOD zif_core_print_pdf_service~download_sfp.

    TRY.
        DATA(ls_data_pdf) = mo_scms_wrap->scms_xstring_to_binary( iv_data ).

        download(
          iv_file_extension = zcl_core_pdf_file=>file_extension
          iv_file_name      = iv_filename
          it_data           = ls_data_pdf-binary_tab
        ).

      CATCH zcx_core_scms_wrap.
        RAISE EXCEPTION TYPE zcx_core_pdf_wrap
          EXPORTING
            textid = zcx_core_pdf_wrap=>conversion_failed.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
