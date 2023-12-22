INTERFACE zif_file_frontend_service_wrap
  PUBLIC .


  METHODS file_open_dialog
    IMPORTING
      !iv_window_title      TYPE string OPTIONAL
      !iv_initial_directory TYPE string OPTIONAL
      !iv_file_filter       TYPE string DEFAULT cl_gui_frontend_services=>filetype_all
      !iv_multiselection    TYPE abap_bool DEFAULT abap_false
    RETURNING
      VALUE(result)         TYPE zst_file_wrap_dialog_open
    RAISING
      zcx_file_frontend_service_wrap .
  METHODS file_save_dialog
    IMPORTING
      !iv_extension TYPE string DEFAULT 'txt'
      !iv_filename  TYPE string DEFAULT space
      !iv_filter    TYPE string OPTIONAL
    RETURNING
      VALUE(result) TYPE zst_file_wrap_dialog_save
    RAISING
      zcx_file_frontend_service_wrap .
  METHODS get_computer_name
    RETURNING
      VALUE(result) TYPE string .
  METHODS get_ip
    RETURNING
      VALUE(result) TYPE string .
  METHODS gui_download
    IMPORTING
      !iv_filename  TYPE string
      !iv_filetype  TYPE char10 DEFAULT 'BIN'
      !iv_filesize  TYPE i OPTIONAL
      !iv_write_bom TYPE abap_bool DEFAULT abap_false
      !it_data      TYPE STANDARD TABLE
    RAISING
      zcx_file_frontend_service_wrap .
  METHODS gui_upload
    IMPORTING
      !iv_filename  TYPE string
      !iv_filetype  TYPE char10 DEFAULT 'BIN'
    RETURNING
      VALUE(result) TYPE zst_file_props
    RAISING
      zcx_file_frontend_service_wrap .
ENDINTERFACE.
