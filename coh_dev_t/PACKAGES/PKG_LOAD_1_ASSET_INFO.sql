--------------------------------------------------------
--  DDL for Package PKG_LOAD_1_ASSET_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "COH_DEV_T"."PKG_LOAD_1_ASSET_INFO" AS
    PROCEDURE start_data_refresh;

    FUNCTION get_min_system_commision_yr (
        in_commission_date DATE
    ) RETURN NUMBER;
    


END pkg_load_1_asset_info;

/
