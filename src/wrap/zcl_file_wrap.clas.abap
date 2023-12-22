CLASS zcl_file_wrap DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_file_wrap .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_file_wrap IMPLEMENTATION.


  METHOD zif_file_wrap~read_extension.

    DATA(lv_filename) = CONV char100( filename ).
    DATA lv_extension TYPE char100.

    CALL FUNCTION 'TRINT_FILE_GET_EXTENSION'
      EXPORTING
        filename  = lv_filename
        uppercase = uppercase
      IMPORTING
        extension = lv_extension.

    result = lv_extension.

  ENDMETHOD.


  METHOD zif_file_wrap~read_filename.

    CALL FUNCTION 'SO_SPLIT_FILE_AND_PATH'
      EXPORTING
        full_name     = filename
      IMPORTING
        stripped_name = result-name
        file_path     = result-path
      EXCEPTIONS
        x_error       = 1
        OTHERS        = 2.

    IF sy-subrc <> 0.
*     Implement suitable error handling here
    ENDIF.

  ENDMETHOD.
ENDCLASS.
