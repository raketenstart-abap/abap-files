CLASS zcl_core_pdf_wrap DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_core_pdf_wrap .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA sc_otf TYPE char3 .
    DATA sc_pdf TYPE char3 .
ENDCLASS.



CLASS ZCL_CORE_PDF_WRAP IMPLEMENTATION.


  METHOD zif_core_pdf_wrap~convert_oft_to_pdf_hexadecimal.

    DATA lt_text_tab     TYPE soli_tab.
    DATA lt_objhead      TYPE soli_tab.
    DATA lv_transfer_bin TYPE sx_boolean.

    lt_text_tab = it_text_tab.

    CALL FUNCTION 'SX_OBJECT_CONVERT_OTF_PDF'
      EXPORTING
        format_src      = sc_otf
        format_dst      = sc_pdf
      CHANGING
        transfer_bin    = lv_transfer_bin
        content_txt     = lt_text_tab
        content_bin     = result-hex_tab
        objhead         = lt_objhead
        len             = result-length
      EXCEPTIONS
        err_conv_failed = 1
        OTHERS          = 2.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_core_pdf_wrap
        EXPORTING
          textid = zcx_core_pdf_wrap=>convert_to_hex_failed.
    ENDIF.

  ENDMETHOD.


  METHOD zif_core_pdf_wrap~convert_otf_to_pdf.

    DATA lt_lines TYPE tline_tab.

    CALL FUNCTION 'CONVERT_OTF_2_PDF'
      TABLES
        otf                    = it_data
        doctab_archive         = it_doctab
        lines                  = lt_lines
      EXCEPTIONS
        err_conv_not_possible  = 1
        err_otf_mc_noendmarker = 2
        OTHERS                 = 3.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_core_pdf_wrap
        EXPORTING
          textid = zcx_core_pdf_wrap=>conversion_failed.
    ENDIF.

    result = lt_lines.

  ENDMETHOD.
ENDCLASS.
