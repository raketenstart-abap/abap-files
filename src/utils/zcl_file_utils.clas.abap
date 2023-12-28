class ZCL_FILE_UTILS definition
  public
  create public .

public section.

  interfaces ZIF_FILE_UTILS .

  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR
    importing
      !IO_FILE type ref to ZCA_FILE optional
      !IO_FILE_FACTORY type ref to ZCL_FILE_FACTORY optional
      !IO_FILE_SCMS_WRAP type ref to ZIF_FILE_SCMS_WRAP optional
      !PROPS type ZST_FILE_PROPS .
  PROTECTED SECTION.
private section.

  class-data SV_DEFAULT_FILENAME type STRING .
  data MO_FILE type ref to ZCA_FILE .
  data MO_FILE_FACTORY type ref to ZCL_FILE_FACTORY .
  data MO_FILE_SCMS_WRAP type ref to ZIF_FILE_SCMS_WRAP .
  data MS_FILE_PROPS type ZST_FILE_PROPS .
ENDCLASS.



CLASS ZCL_FILE_UTILS IMPLEMENTATION.


  METHOD class_constructor.

    sv_default_filename = TEXT-000.

  ENDMETHOD.


  METHOD constructor.

    IF io_file IS BOUND.
      mo_file = io_file.
    ENDIF.

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


  METHOD zif_file_utils~as_pdf.

    IF raw IS INITIAL.
      IF ms_file_props-data IS NOT INITIAL AND
         ms_file_props-raw  IS INITIAL.
        ms_file_props-raw = mo_file_scms_wrap->scms_string_to_xstring(
          iv_data = ms_file_props-data
        ).
      ELSE.
*       " not supported yet
      ENDIF.
    ELSE.
      ms_file_props-raw = raw.
    ENDIF.

    ms_file_props-type = zcl_file_pdf=>file_type.

    result = mo_file_factory->create( ms_file_props ).

  ENDMETHOD.


  METHOD zif_file_utils~as_raw.

    IF raw IS INITIAL.
      IF ms_file_props-data IS NOT INITIAL AND
         ms_file_props-raw  IS INITIAL.
        ms_file_props-raw = mo_file_scms_wrap->scms_string_to_xstring(
          iv_data = ms_file_props-data
        ).
      ELSE.
*       " not supported yet
      ENDIF.
    ELSE.
      ms_file_props-raw = raw.
    ENDIF.

    CLEAR ms_file_props-data.

    result = mo_file_factory->create( ms_file_props ).

  ENDMETHOD.


  METHOD zif_file_utils~as_string.

    IF data IS INITIAL.
      IF ms_file_props-raw IS NOT INITIAL.
        mo_file_scms_wrap->scms_base64_encode_str(
          iv_xstring = ms_file_props-raw
        ).
      ELSE.
*       " not supported yet
      ENDIF.
    ELSE.
      ms_file_props-data = data.
    ENDIF.

    CLEAR ms_file_props-raw.

    result = mo_file_factory->create( ms_file_props ).

  ENDMETHOD.


  METHOD zif_file_utils~read_file_metadata.

    result = ms_file_props.

*   " fallback
    IF result-name IS INITIAL.
      result-name = |{ sv_default_filename }{ ms_file_props-extension }|.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
