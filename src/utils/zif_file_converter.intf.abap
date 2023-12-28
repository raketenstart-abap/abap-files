interface ZIF_FILE_CONVERTER
  public .


  methods TO_PDF
    importing
      value(FILENAME) type STRING optional
    returning
      value(RESULT) type ref to ZCL_FILE_PDF .
endinterface.
