--------------------------------------------------------
--  DDL for Package Body PKG_EXECUTE_P7_ASSET_CALCULATIONS_REFRESH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_EXECUTE_P7_ASSET_CALCULATIONS_REFRESH" AS

    PROCEDURE start_data_refresh IS
    BEGIN
        pkg_load_1_asset_info.start_data_refresh;
        pkg_load_2_asset_condition_q_info.start_data_refresh;
        pkg_load_3_asset_performance_info.start_data_refresh;
        pkg_load_4_asset_amc_info.start_data_refresh;
        pkg_load_5_asset_cof_info.start_data_refresh;
        pkg_load_6_asset_perf_cond_lof_info.start_data_refresh;
        pkg_load_7_asset_brr_info.start_data_refresh;
        pkg_load_8_asset_cpal_info.start_data_refresh;
        pkg_load_1_cmn_asset_info.start_data_refresh;
        pkg_load_2_cmn_asset_condition_q_info.start_data_refresh;
        pkg_load_3_cmn_asset_performance_info.start_data_refresh;
        pkg_load_4_cmn_asset_amc_info.start_data_refresh;
        pkg_load_5_cmn_asset_cof_info.start_data_refresh;
        pkg_load_6_cmn_asset_perf_cond_lof_info.start_data_refresh;
        pkg_load_7_cmn_asset_brr_info.start_data_refresh;
        pkg_load_8_cmn_asset_cpal_info.start_data_refresh;
    END;

END pkg_execute_p7_asset_calculations_refresh;

/
