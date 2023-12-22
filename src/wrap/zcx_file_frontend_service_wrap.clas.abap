CLASS zcx_file_frontend_service_wrap DEFINITION
  PUBLIC
  INHERITING FROM zcx_root
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF save_failed,
        msgid TYPE symsgid VALUE 'ZCORE_FILE',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE 'MV_FILENAME',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF save_failed .
    CONSTANTS:
      BEGIN OF download_failed,
        msgid TYPE symsgid VALUE 'ZCORE_FILE',
        msgno TYPE symsgno VALUE '006',
        attr1 TYPE scx_attrname VALUE 'MV_FILENAME',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF download_failed .
    CONSTANTS:
      BEGIN OF open_failed,
        msgid TYPE symsgid VALUE 'ZCORE_FILE',
        msgno TYPE symsgno VALUE '007',
        attr1 TYPE scx_attrname VALUE 'MV_MESSAGE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF open_failed .
    CONSTANTS:
      BEGIN OF upload_failed,
        msgid TYPE symsgid VALUE 'ZCORE_FILE',
        msgno TYPE symsgno VALUE '008',
        attr1 TYPE scx_attrname VALUE 'MV_FILENAME',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF upload_failed .
    DATA mv_filename TYPE string .
    DATA mv_message TYPE string .

    METHODS constructor
      IMPORTING
        !textid      LIKE if_t100_message=>t100key OPTIONAL
        !previous    LIKE previous OPTIONAL
        !mv_filename TYPE string OPTIONAL
        !mv_message  TYPE string OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_file_frontend_service_wrap IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    me->mv_filename = mv_filename .
    me->mv_message = mv_message .
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
