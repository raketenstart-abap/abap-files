class ZCL_CORE_PRINT_FILE_SERVICE definition
  public
  inheriting from ZCA_CORE_PRINT_SERVICE
  create public .

public section.

  methods DOWNLOAD_TO_LOCAL_PC
    importing
      !FILE_PROPS type ZST_CORE_FILE_PROPS
    raising
      ZCX_CORE_FILE_WRAP .
protected section.
private section.
ENDCLASS.



CLASS ZCL_CORE_PRINT_FILE_SERVICE IMPLEMENTATION.


  METHOD download_to_local_pc.

    TRY.
        DATA(ls_data_pdf) = mo_core_scms_wrap->scms_xstring_to_binary( file_props-raw ).

        download(
          iv_file_extension = file_props-extension
          iv_file_name      = file_props-name
          iv_file_filter    = file_props-filter
          it_data           = ls_data_pdf-binary_tab
        ).

      CATCH zcx_core_frontend_service_wrap INTO DATA(lx_core_frontend_service_wrap).
        RAISE EXCEPTION TYPE zcx_core_file_wrap
          EXPORTING
            previous = lx_core_frontend_service_wrap.

      CATCH zcx_core_scms_wrap.
        RAISE EXCEPTION TYPE zcx_core_file_wrap
          EXPORTING
            textid = zcx_core_file_wrap=>conversion_failed.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
