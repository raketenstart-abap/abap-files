*&---------------------------------------------------------------------*
*& Report ZTEST_SAP_DOWNLOAD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_sap_download.

CLASS lcl DEFINITION
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS
      get_instance
        RETURNING VALUE(result) TYPE REF TO lcl.

    METHODS
      create_sap_file
        RETURNING VALUE(result) TYPE REF TO zca_file.

ENDCLASS.

CLASS lcl IMPLEMENTATION.

  METHOD get_instance.
    CREATE OBJECT result.
  ENDMETHOD.

  METHOD create_sap_file.

    DATA(lv_sap_string) = '[System]'
      && 'Name=S4D'
      && 'Description=Development'.

    DATA(ls_file_meta) = VALUE zst_file_props(
      name = 'test.sap'
      data = lv_sap_string
    ).

    result = NEW zcl_file_sap( ls_file_meta
      )->utils( )->as_raw( ).

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  lcl=>get_instance( )->create_sap_file( )->downloader( )->local( ).
