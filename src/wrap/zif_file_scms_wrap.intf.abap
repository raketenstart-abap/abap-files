INTERFACE zif_file_scms_wrap
  PUBLIC .


  METHODS scms_base64_encode_str
    IMPORTING
      !iv_xstring   TYPE xstring
    RETURNING
      VALUE(result) TYPE string .
  METHODS scms_binary_to_xstring
    IMPORTING
      !iv_length     TYPE i
      VALUE(it_data) TYPE STANDARD TABLE
    RETURNING
      VALUE(result)  TYPE xstring .
  METHODS scms_string_to_xstring
    IMPORTING
      !iv_data      TYPE string
      !iv_mimetype  TYPE c DEFAULT space
      !iv_encoding  TYPE abap_encoding OPTIONAL
    RETURNING
      VALUE(result) TYPE xstring .
  METHODS scms_xstring_to_binary
    IMPORTING
      !iv_buffer    TYPE zde_file_rawstring
    RETURNING
      VALUE(result) TYPE zst_file_wrap_scms_binary
    RAISING
      zcx_file_scms_wrap .
ENDINTERFACE.
