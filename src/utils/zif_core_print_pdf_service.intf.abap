interface ZIF_CORE_PRINT_PDF_SERVICE
  public .


  methods DOWNLOAD
    importing
      !IV_FILENAME type STRING
      !IT_DATA type TSFOTF
    raising
      ZCX_CORE_PDF_WRAP
      ZCX_CORE_FRONTEND_SERVICE_WRAP .
  methods DOWNLOAD_SFP
    importing
      !IV_FILENAME type STRING
      !IV_DATA type FPCONTENT
    raising
      ZCX_CORE_PDF_WRAP
      ZCX_CORE_FRONTEND_SERVICE_WRAP .
endinterface.
