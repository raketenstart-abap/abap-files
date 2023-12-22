INTERFACE zif_file_wrap
  PUBLIC .


  METHODS read_extension
    IMPORTING
      !filename     TYPE string
      !uppercase    TYPE abap_bool DEFAULT abap_true
    RETURNING
      VALUE(result) TYPE string .
  METHODS read_filename
    IMPORTING
      !filename     TYPE string
    RETURNING
      VALUE(result) TYPE zst_file_wrap_read_filename .
ENDINTERFACE.
