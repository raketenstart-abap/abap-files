interface ZIF_CORE_PDF_WRAP
  public .


  methods CONVERT_OTF_TO_PDF
    importing
      !IT_DATA type TSFOTF
      !IT_DOCTAB type ZTT_CORE_FILE_PDF_DOCS optional
    returning
      value(RESULT) type TLINE_TAB
    raising
      ZCX_CORE_PDF_WRAP .
  methods CONVERT_OFT_TO_PDF_HEXADECIMAL
    importing
      !IT_TEXT_TAB type SOLI_TAB
    returning
      value(RESULT) type ZCORE_HEXADECIMAL
    raising
      ZCX_CORE_PDF_WRAP .
endinterface.
