*&---------------------------------------------------------------------*
*& Report ZTEST_XML_DOWNLOAD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_xml_download.

CLASS lcl DEFINITION
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS
      get_instance
        RETURNING VALUE(result) TYPE REF TO lcl.

    METHODS
      create_xml_file
        RETURNING VALUE(result) TYPE REF TO zca_file.

ENDCLASS.

CLASS lcl IMPLEMENTATION.

  METHOD get_instance.
    CREATE OBJECT result.
  ENDMETHOD.

  METHOD create_xml_file.

    DATA(lv_xml_string) = '<?xml version="1.0" encoding="UTF-8"?>'
      && '<sample>'
      && '<data>test</data>'
      && '</sample>'.

    DATA(ls_file_meta) = VALUE zst_file_props(
      name = 'test.xml'
      data = lv_xml_string
    ).

    result = NEW zcl_file_xml( ls_file_meta
      )->utils( )->as_raw( ).

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  lcl=>get_instance( )->create_xml_file( )->downloader( )->local( ).
