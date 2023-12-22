CLASS zcl_file_pdf_wrap DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_file_pdf_wrap .

    METHODS constructor
      IMPORTING
        !io_file_scms_wrap TYPE REF TO zif_file_scms_wrap OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mo_file_scms_wrap TYPE REF TO zif_file_scms_wrap .
    DATA sc_otf TYPE char3 VALUE 'OTF' ##NO_TEXT.
ENDCLASS.



CLASS zcl_file_pdf_wrap IMPLEMENTATION.


  METHOD constructor.

    IF io_file_scms_wrap IS BOUND.
      mo_file_scms_wrap = io_file_scms_wrap.
    ELSE.
      CREATE OBJECT mo_file_scms_wrap TYPE zcl_file_scms_wrap.
    ENDIF.

  ENDMETHOD.


  METHOD zif_file_pdf_wrap~convert_otf_to_pdf.

    DATA lt_lines TYPE tline_tab.

    CALL FUNCTION 'CONVERT_OTF_2_PDF'
      TABLES
        otf                    = data
        doctab_archive         = doctab
        lines                  = lt_lines
      EXCEPTIONS
        err_conv_not_possible  = 1
        err_otf_mc_noendmarker = 2
        OTHERS                 = 3.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_file_pdf_wrap
        EXPORTING
          textid = zcx_file_pdf_wrap=>conversion_failed.
    ENDIF.

    result = lt_lines.

  ENDMETHOD.


  METHOD zif_file_pdf_wrap~convert_otf_to_pdf_hexadecimal.

    DATA lv_transfer_bin TYPE sx_boolean.
    DATA lt_text_tab     TYPE soli_tab.
    DATA lt_hexa_tab     TYPE solix_tab.
*    DATA lt_objhead      TYPE soli_tab.
    DATA lv_length       TYPE int4.

    lt_text_tab = text_tab.

    CALL FUNCTION 'SX_OBJECT_CONVERT_OTF_PDF'
      EXPORTING
        format_src      = sc_otf
        format_dst      = zcl_file_pdf=>file_type
      CHANGING
        transfer_bin    = lv_transfer_bin
        content_txt     = lt_text_tab
        content_bin     = lt_hexa_tab
*       objhead         = lt_objhead
        len             = lv_length
      EXCEPTIONS
        err_conv_failed = 1
        OTHERS          = 2.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_file_pdf_wrap
        EXPORTING
          textid = zcx_file_pdf_wrap=>conversion_to_hex_failed.
    ENDIF.

    result-length = lv_length.
    result-raw    = mo_file_scms_wrap->scms_binary_to_xstring(
      it_data   = lt_hexa_tab
      iv_length = lv_length
    ).

  ENDMETHOD.
ENDCLASS.
