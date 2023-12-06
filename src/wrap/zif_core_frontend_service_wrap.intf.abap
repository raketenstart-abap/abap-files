interface ZIF_CORE_FRONTEND_SERVICE_WRAP
  public .


  methods FILE_OPEN_DIALOG
    importing
      !IV_WINDOW_TITLE type STRING optional
      !IV_INITIAL_DIRECTORY type STRING optional
      !IV_FILE_FILTER type STRING default CL_GUI_FRONTEND_SERVICES=>FILETYPE_ALL
      !IV_MULTISELECTION type ABAP_BOOL default ABAP_FALSE
    returning
      value(RESULT) type ZST_CORE_FILE_OPEN_DIALOG
    raising
      ZCX_CORE_FRONTEND_SERVICE_WRAP .
  methods FILE_SAVE_DIALOG
    importing
      !IV_EXTENSION type STRING default 'txt'
      !IV_FILENAME type STRING default SPACE
      !IV_FILTER type STRING optional
    returning
      value(RESULT) type ZST_CORE_FILE_SAVE_DIALOG
    raising
      ZCX_CORE_FRONTEND_SERVICE_WRAP .
  methods GET_COMPUTER_NAME
    returning
      value(RESULT) type STRING .
  methods GET_IP
    returning
      value(RESULT) type STRING .
  methods GUI_DOWNLOAD
    importing
      !IV_FILENAME type STRING
      !IV_FILETYPE type CHAR10 default 'BIN'
      !IV_FILESIZE type I optional
      !IV_WRITE_BOM type ABAP_BOOL default ABAP_FALSE
      !IT_DATA type STANDARD TABLE
    raising
      ZCX_CORE_FRONTEND_SERVICE_WRAP .
  methods GUI_UPLOAD
    importing
      !IV_FILENAME type STRING
      !IV_FILETYPE type CHAR10 default 'BIN'
    returning
      value(RETURN) type ZST_CORE_FILE_BINFILE
    raising
      ZCX_CORE_FRONTEND_SERVICE_WRAP .
endinterface.
