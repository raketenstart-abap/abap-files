CLASS zca_file DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA ms_file_props TYPE zst_file_props READ-ONLY .
    CLASS-DATA sv_default_filename TYPE string .

    CLASS-METHODS class_constructor .
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
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCA_FILE IMPLEMENTATION.


  METHOD class_constructor.

    sv_default_filename = TEXT-000.

  ENDMETHOD.


  METHOD constructor.

    ms_file_props = props.

*   " fallback
    IF ms_file_props-name IS INITIAL.
      ms_file_props-name = |{ sv_default_filename }{ ms_file_props-extension }|.
    ENDIF.

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
