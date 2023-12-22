interface ZIF_FILE_UTILS
  public .


  methods AS_RAW
    importing
      !RAW type ZDE_FILE_RAWSTRING optional
    returning
      value(RESULT) type ref to ZCA_FILE .
  methods AS_STRING
    importing
      !DATA type STRING optional
    returning
      value(RESULT) type ref to ZCA_FILE .
  methods READ_FILE_METADATA
    returning
      value(RESULT) type ZST_FILE_PROPS .
endinterface.
