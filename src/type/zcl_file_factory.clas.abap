class ZCL_FILE_FACTORY definition
  public
  create public .

public section.

  methods CREATE
    importing
      !PROPS type ZST_FILE_PROPS
    returning
      value(RESULT) type ref to ZCA_FILE .
protected section.
private section.
ENDCLASS.



CLASS ZCL_FILE_FACTORY IMPLEMENTATION.


  METHOD create.

    DATA lv_class_name TYPE classname.

    IF props-type IS NOT INITIAL.
      lv_class_name = |ZCL_FILE_{ props-type }|.

      CREATE OBJECT result TYPE (lv_class_name)
        EXPORTING
          props = props.

    ELSE.
      CREATE OBJECT result TYPE zcl_file
        EXPORTING
          props = props.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
