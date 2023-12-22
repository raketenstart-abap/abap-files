CLASS zcl_file_scms_wrap DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_file_scms_wrap .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_file_scms_wrap IMPLEMENTATION.


  METHOD zif_file_scms_wrap~scms_base64_encode_str.

    DATA lv_base64 TYPE string.

    CALL FUNCTION 'SCMS_BASE64_ENCODE_STR'
      EXPORTING
        input  = iv_xstring
      IMPORTING
        output = lv_base64
      EXCEPTIONS
        OTHERS = 4.

    result = lv_base64.

  ENDMETHOD.


  METHOD zif_file_scms_wrap~scms_binary_to_xstring.

    DATA lv_buffer TYPE xstring.

    CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'
      EXPORTING
        input_length = iv_length
*       FIRST_LINE   = 0
*       LAST_LINE    = 0
      IMPORTING
        buffer       = lv_buffer
      TABLES
        binary_tab   = it_data
      EXCEPTIONS
        failed       = 1
        OTHERS       = 2.

    IF sy-subrc <> 0.
*     Implement suitable error handling here
      RETURN.
    ENDIF.

    result = lv_buffer.

  ENDMETHOD.


  METHOD zif_file_scms_wrap~scms_string_to_xstring.

    DATA lv_buffer TYPE xstring.

    CALL FUNCTION 'SCMS_STRING_TO_XSTRING'
      EXPORTING
        text     = iv_data
        mimetype = iv_mimetype
        encoding = iv_encoding
      IMPORTING
        buffer   = lv_buffer
      EXCEPTIONS
        failed   = 1
        OTHERS   = 2.

    IF sy-subrc <> 0.
*     Implement suitable error handling here
      RETURN.
    ENDIF.

    result = lv_buffer.

  ENDMETHOD.


  METHOD zif_file_scms_wrap~scms_xstring_to_binary.

    DATA lv_length     TYPE i.
    DATA lt_binary_tab TYPE solix_tab.

    CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
      EXPORTING
        buffer        = iv_buffer
      IMPORTING
        output_length = lv_length
      TABLES
        binary_tab    = lt_binary_tab.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_file_scms_wrap
        EXPORTING
          textid = zcx_file_scms_wrap=>xstring_to_binary_failed.
    ENDIF.

    result-length     = lv_length.
    result-binary_tab = lt_binary_tab.

  ENDMETHOD.
ENDCLASS.
