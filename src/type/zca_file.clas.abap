class ZCA_FILE definition
  public
  abstract
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !PROPS type ZST_FILE_PROPS optional .
  methods DOWNLOADER
    returning
      value(RESULT) type ref to ZIF_FILE_DOWNLOADER .
  methods UTILS
    returning
      value(RESULT) type ref to ZIF_FILE_UTILS .
  PROTECTED SECTION.

    DATA ms_file_props TYPE zst_file_props .
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCA_FILE IMPLEMENTATION.


  METHOD constructor.

    ms_file_props = props.

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
