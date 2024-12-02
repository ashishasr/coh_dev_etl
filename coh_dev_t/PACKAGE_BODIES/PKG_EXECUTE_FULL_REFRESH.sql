--------------------------------------------------------
--  DDL for Package Body PKG_EXECUTE_FULL_REFRESH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_EXECUTE_FULL_REFRESH" AS

    PROCEDURE start_data_refresh IS
    BEGIN
        pkg_execute_p1_asset_data_refresh.start_data_refresh;
        pkg_execute_p4_unq_asset_cond_q_map.start_data_refresh;
        pkg_execute_p5_common_asset_cond_q_map.start_data_refresh;
        pkg_execute_p7_asset_calculations_refresh.start_data_refresh;
        pkg_execute_p9_load_results.start_data_refresh;
    END;

END;

/
