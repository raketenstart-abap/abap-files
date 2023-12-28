CLASS zcl_file DEFINITION
  PUBLIC
  INHERITING FROM zca_file
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !props TYPE zst_file_props OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FILE IMPLEMENTATION.


  METHOD constructor.

    DATA ls_props TYPE zst_file_props.

    MOVE-CORRESPONDING props TO ls_props.

    ls_props-extension = space.
    ls_props-filter    = space.
    ls_props-type      = space.

    super->constructor( props = ls_props ).

  ENDMETHOD.
ENDCLASS.
