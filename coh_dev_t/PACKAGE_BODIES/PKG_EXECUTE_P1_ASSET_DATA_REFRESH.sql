--------------------------------------------------------
--  DDL for Package Body PKG_EXECUTE_P1_ASSET_DATA_REFRESH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_EXECUTE_P1_ASSET_DATA_REFRESH" AS

    PROCEDURE start_data_refresh IS
    BEGIN
        pkg_load_p1a_master_data.start_data_refresh;
        pkg_load_p1b_unq_asset_data_initial.start_data_refresh;
        pkg_load_p1c_unq_asset_data_final.start_data_refresh;
        pkg_load_p1d_common_asset_data_initial.start_data_refresh;
        pkg_load_p1e_common_asset_data_final.start_data_refresh;
    END;

END;

/
