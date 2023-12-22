CLASS zcl_file_pdf DEFINITION
  PUBLIC
  INHERITING FROM zca_file
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS file_extension TYPE string VALUE '.pdf' ##NO_TEXT.
    CONSTANTS file_filter TYPE string VALUE '*.pdf' ##NO_TEXT.
    CONSTANTS file_type TYPE string VALUE 'PDF' ##NO_TEXT.

    METHODS constructor
      IMPORTING
        !props TYPE zst_file_props OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FILE_PDF IMPLEMENTATION.


  METHOD constructor.

    DATA ls_props TYPE zst_file_props.

    MOVE-CORRESPONDING props TO ls_props.

    ls_props-extension = file_extension.
    ls_props-filter    = file_filter.
    ls_props-type      = file_type.

    super->constructor( props = ls_props ).

  ENDMETHOD.
ENDCLASS.
