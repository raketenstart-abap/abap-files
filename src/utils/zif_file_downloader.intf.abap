INTERFACE zif_file_downloader
  PUBLIC .


  METHODS local
    RAISING
      zcx_file_wrap
      zcx_file_scms_wrap .
ENDINTERFACE.
