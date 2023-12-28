class ZCL_FILE definition
  public
  inheriting from ZCA_FILE
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !PROPS type ZST_FILE_PROPS optional .
protected section.
private section.
ENDCLASS.



CLASS ZCL_FILE IMPLEMENTATION.


  method CONSTRUCTOR.

    DATA ls_props TYPE zst_file_props.

    MOVE-CORRESPONDING props TO ls_props.

    ls_props-extension = space.
    ls_props-filter    = space.
    ls_props-type      = space.

    super->constructor( props = ls_props ).

  endmethod.
ENDCLASS.
