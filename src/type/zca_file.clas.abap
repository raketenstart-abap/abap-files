CLASS zca_file DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA ms_file_props TYPE zst_file_props READ-ONLY .

    METHODS constructor
      IMPORTING
        !props TYPE zst_file_props OPTIONAL .
    METHODS converter
      RETURNING
        VALUE(result) TYPE REF TO zif_file_converter .
    METHODS downloader
      RETURNING
        VALUE(result) TYPE REF TO zif_file_downloader .
    METHODS utils
      RETURNING
        VALUE(result) TYPE REF TO zif_file_utils .
protected section.
private section.
ENDCLASS.



CLASS ZCA_FILE IMPLEMENTATION.


  METHOD constructor.

    ms_file_props = props.

  ENDMETHOD.


  METHOD converter.

    CREATE OBJECT result TYPE zcl_file_converter
      EXPORTING
        props = ms_file_props.

  ENDMETHOD.


  METHOD downloader.

    CREATE OBJECT result TYPE zcl_file_downloader
      EXPORTING
        props = ms_file_props.

  ENDMETHOD.


  METHOD utils.

    CREATE OBJECT result TYPE zcl_file_utils
      EXPORTING
        io_file = me
        props   = ms_file_props.

  ENDMETHOD.
ENDCLASS.
