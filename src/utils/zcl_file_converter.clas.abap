CLASS zcl_file_converter DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_file_converter .

    METHODS constructor
      IMPORTING
        !io_file_factory   TYPE REF TO zcl_file_factory OPTIONAL
        !io_file_scms_wrap TYPE REF TO zif_file_scms_wrap OPTIONAL
        !props             TYPE zst_file_props .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mo_file_factory TYPE REF TO zcl_file_factory .
    DATA mo_file_scms_wrap TYPE REF TO zif_file_scms_wrap .
    DATA ms_file_props TYPE zst_file_props .
ENDCLASS.



CLASS ZCL_FILE_CONVERTER IMPLEMENTATION.


  METHOD constructor.

    IF io_file_factory IS BOUND.
      mo_file_factory = io_file_factory.
    ELSE.
      CREATE OBJECT mo_file_factory.
    ENDIF.

    IF io_file_scms_wrap IS BOUND.
      mo_file_scms_wrap = io_file_scms_wrap.
    ELSE.
      CREATE OBJECT mo_file_scms_wrap TYPE zcl_file_scms_wrap.
    ENDIF.

    ms_file_props = props.

  ENDMETHOD.


  METHOD zif_file_converter~to_pdf.

    IF ms_file_props-raw IS INITIAL.
      IF ms_file_props-data IS NOT INITIAL.
        ms_file_props-raw = mo_file_scms_wrap->scms_string_to_xstring(
          iv_data = ms_file_props-data
        ).
      ELSE.
*       " not supported yet
      ENDIF.
    ENDIF.

    ms_file_props-type = zcl_file_pdf=>file_type.

    DATA(lo_file_pdf) = mo_file_factory->create( ms_file_props ).
    result ?= lo_file_pdf.

  ENDMETHOD.
ENDCLASS.
