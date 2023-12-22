interface ZIF_FILE_PDF_WRAP
  public .


  methods CONVERT_OTF_TO_PDF
    importing
      !DATA type TSFOTF
      !DOCTAB type ZST_FILE_PDF_DOCS_TAB optional
    returning
      value(RESULT) type TLINE_TAB
    raising
      ZCX_FILE_PDF_WRAP .
  methods CONVERT_OTF_TO_PDF_HEXADECIMAL
    importing
      !TEXT_TAB type SOLI_TAB
    returning
      value(RESULT) type ZST_FILE_PROPS
    raising
      ZCX_FILE_PDF_WRAP .
endinterface.
