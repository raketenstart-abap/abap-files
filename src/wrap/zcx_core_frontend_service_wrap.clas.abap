class ZCX_CORE_FRONTEND_SERVICE_WRAP definition
  public
  inheriting from ZCX_ROOT
  create public .

public section.

  constants:
    begin of SAVE_FAILED,
      msgid type symsgid value 'ZCORE_FILE',
      msgno type symsgno value '005',
      attr1 type scx_attrname value 'MV_FILENAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of SAVE_FAILED .
  constants:
    begin of DOWNLOAD_FAILED,
      msgid type symsgid value 'ZCORE_FILE',
      msgno type symsgno value '006',
      attr1 type scx_attrname value 'MV_FILENAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of DOWNLOAD_FAILED .
  constants:
    begin of OPEN_FAILED,
      msgid type symsgid value 'ZCORE_FILE',
      msgno type symsgno value '007',
      attr1 type scx_attrname value 'MV_MESSAGE',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of OPEN_FAILED .
  constants:
    begin of UPLOAD_FAILED,
      msgid type symsgid value 'ZCORE_FILE',
      msgno type symsgno value '008',
      attr1 type scx_attrname value 'MV_FILENAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of UPLOAD_FAILED .
  data MV_FILENAME type STRING .
  data MV_MESSAGE type STRING .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MV_FILENAME type STRING optional
      !MV_MESSAGE type STRING optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_CORE_FRONTEND_SERVICE_WRAP IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->MV_FILENAME = MV_FILENAME .
me->MV_MESSAGE = MV_MESSAGE .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
